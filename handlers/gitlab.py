#!/bin/evn python26
#--coding:utf-8--
from base import BaseHandler
import tornado.web
from models.tools import user_map,get_menu,op_cursor,DatetimeEncoder
from language.zh_hans.mtop_menu_lang import lang
import json
from config.sqlmap import *
from models.light_merge import light_merge

class LightMergeHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        project = self.get_argument('project_id')
        branches = self.get_argument('branches')
        username = self.get_secure_cookie("user")
        self.do_merge(project,branches)
        self.write('success')

    def do_merge(self,project_id,branches):
        branches = branches.split(',')
        for branche in branches:
            light_merge(project_id,branche)
        return 1

class BranchesHandler(BaseHandler):

    def __init__(self,*request,**kwargs):
        super(BranchesHandler,self).__init__(request[0], request[1])
        self.heads = ['name','id']
        self.rdsinfo =[["master","1"],["master1","11"]]

    @tornado.web.authenticated
    def get(self,prj_id):
        username = self.get_secure_cookie("user")
        curpath = self.request.path
        print prj_id
        title = lang.get(curpath[1:],curpath[1:])
        self.render('gitlab\processlist.html',page=curpath,lang=lang,menus=get_menu(username),heads=self.heads,urllist=get_menu(username),title=title)

    @tornado.web.authenticated
    def post(self,prj_id):
        username = self.get_secure_cookie("user")
        self.write(json.dumps(self.getDatalist(),cls=DatetimeEncoder))

    def getDatalist(self):
        datalist=[]
        for i in self.rdsinfo:
            datadirt=dict(zip(self.heads,i))
            datalist.append(datadirt)
        return datalist