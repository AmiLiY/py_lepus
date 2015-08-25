from base import BaseHandler
import tornado.web
from models.tools import user_map,get_menu,op_cursor,DatetimeEncoder
from language.zh_hans.mtop_menu_lang import lang
import json
from config.sqlmap import *

class TableHandler(BaseHandler):

    def __init__(self,*request,**kwargs):
        super(TableHandler,self).__init__(request[0], request[1])
        rpath = request[1].path[1:].replace("/",'_')
        rdslist = op_cursor.execute(globals()[ rpath + '_sql' ])
        self.hide = globals().get( rpath + '_hide' ,[])
        self.headers = [c[0] for c in op_cursor.description]
        self.rdsinfo = op_cursor.fetchall()

    @tornado.web.authenticated
    def get(self):
        username = self.get_secure_cookie("user")
        curpath = self.request.path
        title = lang.get(curpath[1:],curpath[1:])
        self.render('datalist.html',page=curpath,lang=lang,menus=get_menu(username),headers=self.headers,hide=self.hide,title=title)

    @tornado.web.authenticated
    def post(self):
        username = self.get_secure_cookie("user")
        self.write(json.dumps(self.getDatalist(),cls=DatetimeEncoder))

    def getDatalist(self):
        datalist=[]
        for i in self.rdsinfo:
            datadirt=dict(zip(self.headers,i))
            datalist.append(datadirt)
        return datalist


class Executemany(BaseHandler):
    def post(self):
        ip=self.request.remote_ip
        insertSql = 'replace into `%s`.`%s` values(%s)'
        dbname = "operations"
        tablename = self.get_argument("tablename")
        data = eval(self.get_argument("data"))
        #datas = self.request.arguments
        #print datas
        for row in data:
            row.insert(0,ip)
        colss = ",".join(["%s"]*len(data[0]))
        op_cursor.executemany(insertSql %(dbname,tablename,colss),data)
        #op_cursor.executemany(insertSql % (tablename,colss),data)
        self.write("success\n")