from base import BaseHandler
import tornado.web
from models.tools import user_map,get_menu,op_cursor,DatetimeEncoder
from language.zh_hans.mtop_menu_lang import lang
import json
from config.sqlmap import *
import json

class TableHandler(BaseHandler):

    def __init__(self,*request,**kwargs):
        super(TableHandler,self).__init__(request[0], request[1])
        rdslist = op_cursor.execute(globals()[request[1].path[1:].replace("/",'_')+'_sql'])
        self.heads = [c[0] for c in op_cursor.description]
        self.rdsinfo = op_cursor.fetchall()

    @tornado.web.authenticated
    def get(self):
        username = self.get_secure_cookie("user")
        curpath = self.request.path
        title = lang.get(curpath[1:],curpath[1:])
        self.render(curpath[1:] + '.html',page=curpath,lang=lang,menus=get_menu(username),heads=self.heads,urllist=get_menu(username),title=title)

    @tornado.web.authenticated
    def post(self):
        username = self.get_secure_cookie("user")
        self.write(json.dumps(self.getDatalist(),cls=DatetimeEncoder))

    def getDatalist(self):
        datalist=[]
        for i in self.rdsinfo:
            datadirt=dict(zip(self.heads,i))
            datalist.append(datadirt)
        return datalist