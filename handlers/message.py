#--coding:utf-8--
import tornado.websocket
import logging
import traceback
import requests
from jenkinsapi.jenkins import Jenkins
import time
import threading
#import json
from models.projects import Projects


#import models.light_merge.light_merge
#from models.light_merge import light_merge
#from models.cmds import do_merge
jenkins_url = 'http://jenkins.hrd800.net'
username='yejunqing'
password='hrdhaone8'

url = 'http://git.hrd800.net/api/v3'
token = 'KaK4UsgHhh6UY8W47N2R'
#token = 'ZzYmxs6UWpA6eqzg6gcK'
headers = {"PRIVATE-TOKEN": token}
target_branch = "light_merge"
mergeRequesMsg = "创建merge request <span style='color:green;'> {0} </span> to <span style='color:green;'> {1} </span>成功，合并请求id：<span style='color:green;'> {2} </span>"
exsitMsg = "创建merge request <span style='color:red;'> {0} </span> to <span style='color:red;'> {1} </span>失败，合并请求已存在"
notFoundMsg = "未找到 <span style='color:red;'> {0} </span> to <span style='color:red;'> {1} </span> merge request"
mergeRequestFailMsg = "创建merge request <span style='color:red;'> {0} </span> to <span style='color:red;'> {1} </span>失败"
mergeSucessMsg = "merge <span style='color:green;'> {0} </span> to <span style='color:green;'> {1} </span> 成功"
mergeFailMsg = "merge <span style='color:red;'> {0} </span> to <span style='color:red;'> {1} </span> 失败,详细信息：{2}"
    
def light_merge(socket_id,project_id,source_branch):
    createMergeRequestUrl = "{url}/projects/{id}/merge_requests".format(url=url,id=project_id)
    createMergeRequestPare = {"id":project_id,"source_branch":source_branch,"target_branch":target_branch,"title":target_branch}
    createMergeRequest = requests.post(createMergeRequestUrl,data=createMergeRequestPare,headers = headers)
    createMergeResult = createMergeRequest.json()
    print "createMerge",createMergeResult,createMergeRequest.status_code
    if createMergeRequest.status_code ==201:
        merge_request_id = createMergeResult["id"]
        ChatSocketHandler.client_map[socket_id].try_write_message(mergeRequesMsg.format(source_branch,target_branch,merge_request_id)) 
    elif createMergeRequest.status_code ==409:
        ChatSocketHandler.client_map[socket_id].try_write_message(exsitMsg.format(source_branch,target_branch)) 
        getMergeRequestUrl = "{url}/projects/{id}/merge_requests?state=opened".format(url=url,id=project_id)
        getMergeRequest = requests.get(getMergeRequestUrl,headers = headers)
        getMergeResult = getMergeRequest.json()
        for merge_request in getMergeResult:
            if merge_request["target_branch"] == target_branch and merge_request["source_branch"] == source_branch:
                merge_request_id = merge_request["id"]
                break
        else:
            ChatSocketHandler.client_map[socket_id].try_write_message(notFoundMsg.format(source_branch,target_branch)) 
            ChatSocketHandler.client_map[socket_id].try_write_message(getMergeResult)
            return
        
    else:
        ChatSocketHandler.client_map[socket_id].try_write_message(mergeRequestFailMsg.format(source_branch,target_branch)) 
        ChatSocketHandler.client_map[socket_id].try_write_message(createMergeResult) 
        return
    
    mergeUrl = "{url}/projects/{id}/merge_request/{merge_request_id}/merge".format(url=url,id=project_id,merge_request_id=merge_request_id)
    mergePare = {"id":project_id,"merge_request_id":merge_request_id}
    mergeResult = requests.put(mergeUrl,data=mergePare,headers = headers)

    if mergeResult.status_code == 200:
        ChatSocketHandler.client_map[socket_id].try_write_message(mergeSucessMsg.format(source_branch,target_branch)) 
    else:
        ChatSocketHandler.client_map[socket_id].try_write_message(mergeFailMsg.format(source_branch,target_branch,mergeResult.text)) 
    print "merge",mergeResult.json(),mergeResult.status_code
    
def getBranchs(project_id):
    r = requests.get("{url}//projects/{id}/repository/branches".format(url=url,id=project_id),headers = headers)
    res = r.json()
    return res
    
def getProjects():
    r = requests.get("{url}/projects".format(url=url),headers = headers)
    res = r.json()
    return res

class EventPool():
    event = {}

class Dispatch(threading.Thread):
    
    def __init__(self,socket_id,msgs):
        threading.Thread.__init__(self)
        self.socket_id=socket_id
        self.cmd = msgs["cmd"]
        self.data = msgs["data"]
        self.cmd_map = {"do_merge":self.do_merge,"do_build":self.do_build,"put_console_log":self.put_console_log}

    def run(self):
        print 'run'
        self.cmd_map.get(self.cmd)(self.socket_id,self.data)
        
    def do_build(self,socket_id,data):
        projects = data.get("projects")
        put_console_log1  = data.get("put_console_log")
        deploy = data.get("deploy")
        startMsg = "start build project <span style='color:green;'> {project_name} </span>"
        endMsg = "build jenkins project <span style='color:green;'> {project_name} </span> {status}"
        server  = Jenkins(jenkins_url, username, password)
        for project_name in projects:
            ChatSocketHandler.client_map[socket_id].try_write_message(startMsg.format(project_name=project_name))
            server.build_job(project_name)
            job = server[project_name]
            while not job.is_running():
                ChatSocketHandler.client_map[socket_id].try_write_message("........")
                time.sleep(1)
            
            ChatSocketHandler.client_map[socket_id].try_write_message("waiting jenkins start building")
            if put_console_log1:
                self.put_console_log(socket_id,data)
            else:
                ChatSocketHandler.client_map[socket_id].try_write_message("wait build finish not put logs")
                while job.is_running():
                    time.sleep(1)
            last_build = job.get_last_build()
            build_status = last_build.get_status()
            ChatSocketHandler.client_map[socket_id].try_write_message(endMsg.format(project_name=project_name,status=build_status))
            if build_status == "SUCCESS" and deploy:
                self.do_deploy(self.socket_id,project_name)
                
    def do_deploy(self,socket_id,project_name):
        deploy_status = "SUCCESS"
        endMsg = "deploy project <span style='color:green;'> {project_name} </span> <span style='color:red;'> {status} </span>"
        ChatSocketHandler.client_map[socket_id].try_write_message(endMsg.format(project_name=project_name,status=deploy_status))

    def put_console_log(self,socket_id,data):
        projects = data.get("projects")
        server  = Jenkins(jenkins_url, username, password)
        for project_name in projects:
            job = server[project_name]
            print project_name,job.is_running()
            if job.is_running():
                last_build = job.get_last_build()
                build_id = last_build.get_number()
                console_url = "{url}/job/{project}/{build_id}/logText/progressiveHtml".format(url=jenkins_url,project=project_name,build_id=build_id)
                self.send_console_log(socket_id,console_url)
                return
            else:
                continue
        else:
            ChatSocketHandler.client_map[socket_id].try_write_message("job not run")
            return
        
    def send_console_log(self,socket_id,console_url):
        size = 0
        while 1:
            postdata = {"start":size}
            resp = requests.post(console_url,data=postdata)
            size = resp.headers.get("x-text-size")
            more_data = resp.headers.get("X-More-Data")
            console_log = resp.text
            if console_log:
                ChatSocketHandler.client_map[socket_id].try_write_message(console_log)
            time.sleep(2)
            if not more_data:
                break
    


    def do_merge(self,socket_id,data):
        project_name = data["project"]
        project_id = Projects.projects.get(project_name,project_name)
        branches = data["branches"]
        startMsg = "project <span style='color:green;'> {project_name} </span> merge <span style='color:green;'> {b} </span> to light_merge 开始"
        ChatSocketHandler.client_map[socket_id].try_write_message(startMsg.format(project_name=project_name,b=",".join(branches))) 
        deleteBranchUrl = "{url}/projects/{id}/repository/branches/{branche}"
        #deleteBranchPare = {"id":project_id,"branch_name":target_branch,"ref":'master'}
        deleteBranch = requests.delete(deleteBranchUrl.format(url=url,id=project_id,branche=target_branch),headers = headers)
        deleteBranchResult = deleteBranch.json()
        if deleteBranch.status_code ==200:
            ChatSocketHandler.client_map[socket_id].try_write_message("删除<span style='color:green;'> {0} </span>分支成功".format(target_branch)) 
        elif deleteBranch.status_code ==404:
            ChatSocketHandler.client_map[socket_id].try_write_message("删除<span style='color:red;'> {0} </span>分支失败，<span style='color:red;'> {0} </span>不存在".format(target_branch)) 
        #ChatSocketHandler.client_map[socket_id].try_write_message(deleteBranchResult) 
        #print "deleteBranchResult:",deleteBranchResult,deleteBranch.status_code
        
        createBranchUrl = "{url}/projects/{id}/repository/branches"
        createBranchPare = {"id":project_id,"branch_name":target_branch,"ref":'master'}
        createBranch = requests.post(createBranchUrl.format(url=url,id=project_id),data=createBranchPare,headers = headers)
        
        createBranchResult = createBranch.json()
        
        print "createBranch",createBranchResult,createBranch.status_code
        if createBranch.status_code ==201:
            ChatSocketHandler.client_map[socket_id].try_write_message("创建<span style='color:green;'> {0} </span>分支成功".format(target_branch)) 
        else:
            ChatSocketHandler.client_map[socket_id].try_write_message("创建<span style='color:red;'> {0} </span>分支失败".format(target_branch)) 
            ChatSocketHandler.client_map[socket_id].try_write_message(createBranchResult) 
            return
        #print branches
        for branche in branches:
            light_merge(socket_id,project_id,branche)
        successMsg = "project <span style='color:green;'> {project_name} </span> merge <span style='color:green;'> {b} </span> to light_merge 成功"
        ChatSocketHandler.client_map[socket_id].try_write_message(successMsg.format(project_name=project_name,b=",".join(branches))) 
        return 1


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
        logging.info(u"客户端断开连接" +str(id(self)))
        
    @classmethod 
    def update_cache(cls, chat): 
        cls.cache.append(chat) 
        if len(cls.cache) > cls.cache_size: 
            cls.cache = cls.cache[-cls.cache_size:] 

    @classmethod 
    def send_updates(cls, chat): 
        if 1:
            try: 
                ChatSocketHandler.client_map[id(cls)].write_message(chat) 
            except: 
                logging.error("Error sending message", exc_info=True) 
        else:
            logging.error("客户端未连接连接")

    def try_write_message(self,message):
        try:
            ChatSocketHandler.client_map[id(self)].write_message(message)
        except:
            logging.error("Error sending message", exc_info=True) 

    def on_message(self, message): 
        logging.info("got message %r", message)
        msgs = eval(message)
        try:
            socket_id = id(self)
            t = Dispatch(socket_id,msgs)
            t.start()
        except:
            #print dir(traceback)
            ChatSocketHandler.client_map[id(self)].try_write_message(traceback.format_exc())





