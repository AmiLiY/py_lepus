#--coding:utf-8--
import tornado.web
import tornado.websocket
import datetime
import time,md5
import logging
import traceback
from models.tools import user_map,get_menu
from models.cmds import do_merge
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

class ChatSocketHandler(tornado.websocket.WebSocketHandler): 
    cache = [] 
    client_map = {}
    cache_size = 200 

    def allow_draft76(self): 
        # for iOS 5.0 Safari  
        return True 

    def open(self): 
        ChatSocketHandler.client_map[id(self)] = self
        logging.info(u"新客户端连接" +str(id(self)))

    def on_close(self): 
        #del ChatSocketHandler.client_map[id(self)]
        print '客户端断开连接'
        
    @classmethod 
    def update_cache(cls, chat): 
        cls.cache.append(chat) 
        if len(cls.cache) > cls.cache_size: 
            cls.cache = cls.cache[-cls.cache_size:] 

    @classmethod 
    def send_updates(cls, chat): 
        if 1:
            try: 
                #print cls.client_map
                #print repr(cls.xsrf_token)
                print id(cls)
                ChatSocketHandler.client_map[id(cls)].write_message(chat) 
            except: 
                logging.error("Error sending message", exc_info=True) 
        else:
            logging.error("客户端未连接连接")

    def on_message(self, message): 
        logging.info("got message %r", message)
        cmd,parements = message.split(",")[0],message.split(",")[1:]
        try:
            globals().get(cmd)(id(self),parements[0],parements[1:])
        except:
            print dir(traceback)
            ChatSocketHandler.client_map[id(self)].write_message(traceback.format_exc())
