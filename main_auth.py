#!/bin/evn python26
#--coding:utf-8--
import os.path
import MySQLdb
import ConfigParser
import random
import os,time,datetime
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
import md5
from language.zh_hans.mtop_menu_lang import lang
from tornado.options import define, options
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
user_info_sql = "SELECT * FROM `admin_user` WHERE user_id={user_id}"
update_user_sql = "update `admin_user` set `password`='{password}',`realname`='{realname}',`email`='{email}', `mobile`='{mobile}',`status`='{status}' where `user_id`='{user_id}'"
update_user_sql1 = "update `admin_user` set `realname`='{realname}',`email`='{email}', `mobile`='{mobile}',`status`='{status}' where `user_id`='{user_id}'"
delete_user_sql = "delete from `admin_user` where user_id={user_id}"

def get_op_cursor(dbconfig):
    cf = ConfigParser.ConfigParser()
    cf.read(dbconfig)
    host= cf.get("dbsource","host")
    user = cf.get("dbsource","user")
    passwd = cf.get("dbsource","passwd")
    port = cf.getint("dbsource","port")
    db = cf.get("dbsource","db")
    conn = MySQLdb.connect(host=host,user=user,passwd=passwd,port=port,db=db,charset='utf8')
    conn.autocommit(1)
    conn.ping()
    return conn.cursor()

class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
        (r"/", IndexHandler),
        (r"/login", LoginHandler),
        (r'/logout', LogoutHandler),
        (r'/settings/index', DataHandler),
        (r'/user/index', DataHandler),
        (r'/user/add', AddUserHandler),
        (r'/user/edit/(.*)', EditUserHandler),
        (r'/user/forever_delete/(.*)', DeleteUserHandler),
        (r'/user/edit', EditUserHandler),
        (r'/role/index', DataHandler),
        (r'/privilege/index', DataHandler),
        ]
        tornado.web.Application.__init__(
            self, handlers, debug=True,
            template_path=os.path.join(os.path.dirname(__file__), "templates"),
            static_path=os.path.join(os.path.dirname(__file__), "static"),
            cookie_secret =  "generate_passwd()",
            login_url = "/login"
            )

class BaseHandler(tornado.web.RequestHandler):
    def get_current_user(self):
        username = self.get_secure_cookie("user")
        logintime_str = self.get_secure_cookie("logintime")
        if logintime_str:
            Y,m,d,h,M,S = time.strptime(logintime_str, "%Y-%m-%d %H:%M:%S")[0:6]
            logintime = datetime.datetime(Y,m,d,h,M,S)
            times = datetime.datetime.today() - logintime
        else:
            return 0
        if username and times < datetime.timedelta(days=1):
        #if username and times < datetime.timedelta(seconds=1440):
            return username

class LoginHandler(BaseHandler):
    def get(self):
        next=self.get_argument('next', '/')
        if self.get_current_user():
            self.redirect(next)
            return
        self.render('login.html',next=next)

    def post(self):
        username = self.get_argument("username")
        password = md5.new(self.get_argument("password",0)).hexdigest()
        now = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
        if password == user_map.get(username,0):
            self.set_secure_cookie("user", username)
            self.set_secure_cookie("logintime", now)
        self.redirect(self.get_argument('next', '/'))

class LogoutHandler(BaseHandler):
    def get(self):
        self.clear_cookie("user")
        self.redirect("/")

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

class DeleteUserHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self,user_id):
        username = self.get_secure_cookie("user")
        curpath =  self.request.path
        op_cursor.execute(delete_user_sql.format(user_id=user_id))
        self.redirect("/user/index")

def ping_db():
    print 'ping db'
    op_cursor.execute('select 1')

def get_menu(_username):
	user_menu = user_menus.get(_username,0)
	if user_menu:
		return user_menu
	else:
		user_menus[_username] = _get_menu(_username)
		return user_menus.get(_username,0)

def _get_menu(_username):
    print "get_menu for {username}".format(username=_username)
    sql = """select admin_menu.* from admin_user, admin_role,admin_user_role,admin_privilege,admin_role_privilege,admin_menu 
    where admin_user.username= "{username}" and 
    admin_user.user_id= admin_user_role.user_id and
    admin_user_role.role_id = admin_role.role_id and 
    admin_role.role_id = admin_role_privilege.role_id and 
    admin_role_privilege.privilege_id = admin_privilege.privilege_id and 
    admin_privilege.menu_id = admin_menu.menu_id and
    admin_menu.status = 1 
    group by admin_menu.menu_id
    order by admin_menu.display_order asc;"""
    op_cursor.execute(sql.format(username=_username))
    sub_menus = op_cursor.fetchall()
    sub_head = [c[0] for c in op_cursor.description]
    parent_ids = set([str(menu[3]) for menu in sub_menus])
    parent_menus_sql = r"""SELECT menu_id,menu_title parent_title,REPLACE(menu_url,'/','') parent_url,menu_icon parent_icon,display_order, p.sub_menus
                           FROM `admin_menu`,(SELECT parent_id,GROUP_CONCAT(menu_url) sub_menus FROM admin_menu GROUP BY parent_id) p
                           WHERE menu_id IN ({_parent_ids}) AND admin_menu.`menu_id`=p.parent_id
                           GROUP BY menu_url ORDER BY display_order""".format(_parent_ids = ",".join(parent_ids))
    op_cursor.execute(parent_menus_sql)
    parent_menus = op_cursor.fetchall()
    head = [c[0] for c in op_cursor.description]
    menus = []
    for parent_menu in parent_menus:
        menu=dict(zip(head,parent_menu))
        sub_menu2 = [sub_menu for sub_menu in sub_menus if sub_menu[3] == parent_menu[0] ]
        sub_menu3 = []
        for sub in sub_menu2:
            sub_menu3.append(dict(zip(sub_head,sub)))
        menu["sub_menu"] = sub_menu3
        menus.append(menu)
    if menus:
        return menus
    else:
        return False
    
if __name__ == '__main__':
    user_menus = {}
    tornado.ioloop.PeriodicCallback(ping_db,600*1000).start()
    op_cursor = get_op_cursor(os.path.join(WORKING_DIR,"config/db.ini"))
    users_sql = "SELECT username,`password` FROM `admin_user` WHERE STATUS=1"
    op_cursor.execute(users_sql)
    user_map = dict(op_cursor.fetchall())
    #user_map={'admin':'admin'}
    tornado.options.parse_command_line()
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()