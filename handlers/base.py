#--coding:utf-8--
import tornado.web
import tornado.websocket
import datetime
import time,md5
import logging
import traceback
from models.tools import user_map,get_menu

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

