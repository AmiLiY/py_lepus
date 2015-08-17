#!/bin/evn python26
#--coding:utf-8--
from base import BaseHandler
from handlers.message import ChatSocketHandler
import tornado.web
from models.tools import user_map,get_menu,op_cursor,DatetimeEncoder
from models.projects import Projects
from language.zh_hans.mtop_menu_lang import lang
import json
from config.sqlmap import *
import requests

url = 'http://git.hrd800.net/api/v3'
token = 'KaK4UsgHhh6UY8W47N2R'
#token = 'ZzYmxs6UWpA6eqzg6gcK'
headers = {"PRIVATE-TOKEN": token}

class LightMergeHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        project = self.get_argument('project_id')
        branches = self.get_argument('branches')
        username = self.get_secure_cookie("user")
        do_merge(project,branches)
        self.write('success')

class ProjectsHandler(BaseHandler):
    def __init__(self,*request,**kwargs):
        super(ProjectsHandler,self).__init__(request[0], request[1])
        self.heads = ['id','name']
        #self.rdsinfo =[["master","1"],["master1","11"]]

    @tornado.web.authenticated
    def get(self):
        username = self.get_secure_cookie("user")
        curpath = "/projects"
        title = lang.get(curpath[1:],curpath[1:])
        self.render('gitlab\projects.html',page=curpath,lang=lang,menus=get_menu(username),heads=self.heads,urllist=get_menu(username),title=title)

    @tornado.web.authenticated
    def post(self):
        username = self.get_secure_cookie("user")
        #ChatSocketHandler.send_updates("succece")
        r = requests.get("{url}//projects/".format(url=url),headers = headers)
        res = r.json()
        for i in res:
            Projects.projects[i["name"]] = i["id"]
        self.write(json.dumps(res,cls=DatetimeEncoder))

class BranchesHandler(BaseHandler):

    def __init__(self,*request,**kwargs):
        super(BranchesHandler,self).__init__(request[0], request[1])
        self.heads = ['name']
        #self.rdsinfo =[["master","1"],["master1","11"]]

    @tornado.web.authenticated
    def get(self,prj_name):
        prj_id= Projects.projects.get(prj_name,prj_name)
        username = self.get_secure_cookie("user")
        curpath = "/projects"
        title = lang.get(curpath[1:],curpath[1:])
        self.render(r'gitlab\branches.html',page=curpath,lang=lang,menus=get_menu(username),heads=self.heads,urllist=get_menu(username),title=title)

    @tornado.web.authenticated
    def post(self,prj_name):
        prj_id= Projects.projects.get(prj_name,0)
        if not prj_id:
            r = requests.get("{url}//projects/".format(url=url),headers = headers)
            res = r.json()
            for i in res:
                Projects.projects[i["name"]] = i["id"]
            prj_id= Projects.projects.get(prj_name,0)
        username = self.get_secure_cookie("user")
        #ChatSocketHandler.send_updates("succece")
        r = requests.get("{url}//projects/{id}/repository/branches".format(url=url,id=prj_id),headers = headers)
        res = r.json()
        self.write(json.dumps(res,cls=DatetimeEncoder))