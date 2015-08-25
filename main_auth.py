#!/bin/evn python26
#--coding:utf-8--
import os.path
import random
import os,time,datetime
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
import md5
from language.zh_hans.mtop_menu_lang import lang
from tornado.options import define, options
from handlers.data import TableHandler,Executemany
from handlers.gitlab import ProjectsHandler,BranchesHandler,LightMergeHandler
from handlers.base import BaseHandler,LoginHandler,LogoutHandler
from handlers.message import ChatSocketHandler
import models
from models.tools import user_map,get_menu,op_cursor

url = 'http://git.hrd800.net/api/v3'
token = 'KaK4UsgHhh6UY8W47N2R'
headers = {"PRIVATE-TOKEN": token}

#from models.user import User
define("port", default=8001, help="run on the given port", type=int)
WORKING_DIR = os.path.dirname(os.path.abspath(__file__))
user_index_sql = "SELECT user_id,username,realname,email,mobile,login_count,last_login_ip,last_login_time FROM `admin_user`"
role_index_sql = "SELECT * FROM `admin_role`"
privilege_index_sql = ("SELECT `privilege_id`,`privilege_title`,am.`menu_url` `action`,`menu_title`,ap.`display_order` "
                        "FROM `admin_privilege` ap,`admin_menu` am "
                        "WHERE ap.`menu_id`=am.`menu_id` "
                        "ORDER BY ap.`display_order`")
settings_index_sql = "select 1"
add_user_sql = "INSERT INTO `operations`.`admin_user` (`username`, `password`, `realname`, `email`, `mobile`,`status`,`create_time`) VALUES ('{username}', '{password}', '{realname}', '{email}', '{mobile}', '{status}', now());"
add_menu_sql = """INSERT INTO `operations`.`admin_menu` (`menu_title`, `menu_level`, `parent_id`, `menu_url`, `menu_icon`, `system`, `status`, `display_order`, `create_time`) 
SELECT '{menu_title}', '{menu_level}', '{parent_id}', '{menu_url}', '{menu_icon}', '0', '1', IFNULL(MAX(`display_order`),0)+1, NOW()
FROM `operations`.`admin_menu` WHERE `parent_id`={parent_id}"""
add_privilege_sql = """
INSERT INTO `operations`.`admin_privilege` (`privilege_title`, `menu_id`, `action`, `display_order`) 
select `menu_title`, `menu_id`, `menu_url`,`display_order`
from `operations`.`admin_menu` where `menu_title`='{menu_title}'; 
"""
add_provilege_to_role_sql = """
INSERT INTO `operations`.`admin_role_privilege` (`role_id`, `privilege_id`)
select 1,`privilege_id` from `operations`.`admin_privilege` where `privilege_title`='{menu_title}';
"""
user_info_sql = "SELECT * FROM `admin_user` WHERE user_id={user_id}"
update_user_sql = "update `admin_user` set `password`='{password}',`realname`='{realname}',`email`='{email}', `mobile`='{mobile}',`status`='{status}' where `user_id`='{user_id}'"
update_user_sql1 = "update `admin_user` set `realname`='{realname}',`email`='{email}', `mobile`='{mobile}',`status`='{status}' where `user_id`='{user_id}'"
delete_user_sql = "delete from `admin_user` where user_id={user_id}"
user_forever_delete_sql = "delete from `admin_user` where user_id={id}"
menu_forever_delete_sql = "delete from `admin_menu` where menu_id={id};"
menu_index_sql = "SELECT * FROM `admin_menu`"
privilege_add_data_sql = "SELECT menu_id,menu_title FROM `admin_menu` WHERE `parent_id`!=0"


class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
        (r"/", IndexHandler),
        (r"/login", LoginHandler),
        (r'/logout', LogoutHandler),
        (r'/settings/index', DataHandler),
        (r'/mysql/processlist', TableHandler),
        (r'/ecsinfo', TableHandler),
        (r'/process', TableHandler),
        (r'/appinfo', TableHandler),
        (r'/user/index', DataHandler),
        (r'/user/add', AddUserHandler),
        (r'/user/edit/(.*)', EditUserHandler),
        (r'/user/forever_delete/(.*)', DeleteHandler),
        (r'/menu/forever_delete/(.*)', DeleteHandler),
        (r'/user/edit', EditUserHandler),
        (r'/role/index', DataHandler),
        (r'/privilege/index', DataHandler),
        (r'/privilege/add', AddHandler),
        (r'/projects/?', ProjectsHandler),
        (r'/projects/(.*)/branches', BranchesHandler),
        (r'/projects/lightmerge', LightMergeHandler),
        (r"/websocket", ChatSocketHandler), 
        (r"/menu/index", DataHandler), 
        (r"/menu/add", AddMenuHandler), 
        (r"/insert", Executemany), 
        ]
        tornado.web.Application.__init__(
            self, handlers, debug=True,
            template_path=os.path.join(os.path.dirname(__file__), "templates"),
            static_path=os.path.join(os.path.dirname(__file__), "static"),
            cookie_secret =  "generate_passwd()",
            login_url = "/login"
            )

class IndexHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        username = self.get_secure_cookie("user")
        curpath =  self.request.path
        self.render('index.html',page=curpath,menus=get_menu(username),lang=lang)

class DataHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        username = self.get_secure_cookie("user")
        curpath =  self.request.path
        #user = User()
        datalist = self.get_user_list()
        self.render(curpath[1:]+'.html',page=curpath,menus=get_menu(username),lang=lang,datalist = datalist)
        
    def get_user_list(self):
        user = op_cursor.execute(globals()[self.request.path[1:].replace("/",'_')+'_sql'])
        users = op_cursor.fetchall()
        head = [c[0] for c in op_cursor.description]
        datalist = []
        for user in users:
            datalist.append(dict(zip(head,user)))
        return datalist

class AddUserHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        username = self.get_secure_cookie("user")
        curpath =  self.request.path
        self.render(curpath[1:]+'.html',page="/user/index",menus=get_menu(username),lang=lang,error_code=0,validation_errors='')
    def post(self):
        #username = self.get_secure_cookie("user")
        curpath =  self.request.path
        newUserName = self.get_argument('username')
        password = self.get_argument('password')
        realname = self.get_argument('realname')
        email = self.get_argument('email')
        mobile = self.get_argument('mobile')
        status = self.get_argument('status')
        op_cursor.execute(add_user_sql.format(username=newUserName,password=password,realname=realname,email=email,mobile=mobile,status=status))
        self.redirect("/user/index")

class EditUserHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self,user_id):
        username = self.get_secure_cookie("user")
        curpath =  self.request.path
        record = self.getrecord(user_id)
        self.render('user/edit.html',page="/user/index",menus=get_menu(username),lang=lang,error_code=0,validation_errors='',record=record)
    def post(self):
        #username = self.get_secure_cookie("user")
        curpath =  self.request.path
        user_id = self.get_argument('user_id')
        password = self.get_argument('password')
        realname = self.get_argument('realname')
        email = self.get_argument('email')
        mobile = self.get_argument('mobile')
        status = self.get_argument('status')
        if password:
            op_cursor.execute(update_user_sql.format(user_id=user_id,password=password,realname=realname,email=email,mobile=mobile,status=status))
        else:
            op_cursor.execute(update_user_sql1.format(user_id=user_id,realname=realname,email=email,mobile=mobile,status=status))
        self.redirect("/user/index")
    def getrecord(sef,user_id):
        op_cursor.execute(user_info_sql.format(user_id=user_id))
        head = [c[0] for c in op_cursor.description]
        userinfo = op_cursor.fetchone()
        record = dict(zip(head,userinfo))
        return record

class DeleteHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self,id):
        username = self.get_secure_cookie("user")
        curpath =  self.request.path
        func = curpath[1:].split("/")[0]
        op_cursor.execute(globals()[ "_".join(curpath[1:].split("/")[:-1]) + '_sql' ].format(id=id))
        self.redirect("/{0}/index".format(func))


class AddMenuHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        username = self.get_secure_cookie("user")
        curpath =  self.request.path
        menu_record_tree = self.menu_record_tree()
        set_value = {}
        self.render(curpath[1:]+'.html',page="/menu/index",menus=get_menu(username),set_value=set_value,menu_record_tree=menu_record_tree,lang=lang,error_code=0,validation_errors='')

    def post(self):
        username = self.get_secure_cookie("user")
        curpath =  self.request.path
        menu_title = self.get_argument('menu_title').encode("utf8")
        menu_url = self.get_argument('menu_url')
        parent_id = int(self.get_argument('parent_id'))
        status = int(self.get_argument('status'))
        if parent_id==0:
            menu_level = 1
            menu_icon = "icon-dashboard"
        else:
            menu_level = 2
            menu_icon = "icon-list"
        op_cursor.execute(add_menu_sql.format(menu_title=menu_title,menu_url=menu_url,parent_id=parent_id,menu_level=menu_level,menu_icon=menu_icon))
        if parent_id!=0:
            op_cursor.execute(add_privilege_sql.format(menu_title=menu_title))
            op_cursor.execute(add_provilege_to_role_sql.format(menu_title=menu_title))
            models.tools.user_menus[username] = models.tools._get_menu(username)

        self.redirect("/menu/index")
        
    def menu_record_tree(self):
        datalist = []
        op_cursor.execute("SELECT menu_id,menu_title FROM `admin_menu` WHERE `parent_id`=0")
        parent_menus = op_cursor.fetchall()
        head = [c[0] for c in op_cursor.description]
        for menus in parent_menus:
            datalist.append(dict(zip(head,menus)))
        return datalist


class AddHandler(BaseHandler):

    def __init__(self,*request,**kwargs):
        super(AddHandler,self).__init__(request[0], request[1])
        self.rpath = "_".join(request[1].path[1:].split("/"))
        func = request[1].path[1:].split("/")[0]
        self.page = "/{0}/index".format(func)

    @tornado.web.authenticated
    def get(self):
        username = self.get_secure_cookie("user")
        curpath =  self.request.path
        datalist = self.getDatalist()
        set_value = {}
        self.render(curpath[1:]+'.html',page=self.page,menus=get_menu(username),set_value=set_value,datalist=datalist,lang=lang,error_code=0,validation_errors='')

    def post(self):
        self.request.arguments 
        op_cursor.execute(globals()[self.rpath + "_sql"].format(menu_title=menu_title,menu_url=menu_url,parent_id=parent_id,menu_level=menu_level,menu_icon=menu_icon))
        self.redirect(self.page)

    def getDatalist(self):
        datalist = []
        op_cursor.execute(globals()[self.rpath + "_data_sql"])
        parent_menus = op_cursor.fetchall()
        head = [c[0] for c in op_cursor.description]
        for menus in parent_menus:
            datalist.append(dict(zip(head,menus)))
        return datalist


def ping_db():
    print 'ping db'
    op_cursor.execute('select 1')

    
if __name__ == '__main__':
    
    tornado.ioloop.PeriodicCallback(ping_db,600*1000).start()
    #op_cursor = get_op_cursor(os.path.join(WORKING_DIR,"../db.ini"))
    #users_sql = "SELECT username,`password` FROM `admin_user` WHERE STATUS=1"
    #op_cursor.execute(users_sql)
    #user_map = dict(op_cursor.fetchall())
    #user_map={'admin':'admin'}
    tornado.options.parse_command_line()
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()