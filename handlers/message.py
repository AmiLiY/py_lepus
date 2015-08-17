#--coding:utf-8--
import tornado.websocket
import logging
import traceback
import requests
from models.projects import Projects


#import models.light_merge.light_merge
#from models.light_merge import light_merge
#from models.cmds import do_merge

url = 'http://git.hrd800.net/api/v3'
token = 'KaK4UsgHhh6UY8W47N2R'
#token = 'ZzYmxs6UWpA6eqzg6gcK'
headers = {"PRIVATE-TOKEN": token}
target_branch = "light_merge"


def do_merge(socket_id,project_id,branches):
    ChatSocketHandler.client_map[socket_id].write_message("project <span style='color:green;'> {id} </span> merge <span style='color:green;'> {b} </span> to light_merge 开始".format(id=project_id,b=",".join(branches))) 
    deleteBranchUrl = "{url}/projects/{id}/repository/branches/{branche}"
    #deleteBranchPare = {"id":project_id,"branch_name":target_branch,"ref":'master'}
    deleteBranch = requests.delete(deleteBranchUrl.format(url=url,id=project_id,branche=target_branch),headers = headers)
    deleteBranchResult = deleteBranch.json()
    if deleteBranch.status_code ==200:
        ChatSocketHandler.client_map[socket_id].write_message("删除<span style='color:green;'> {0} </span>分支成功".format(target_branch)) 
    elif deleteBranch.status_code ==404:
        ChatSocketHandler.client_map[socket_id].write_message("删除<span style='color:red;'> {0} </span>分支失败，<span style='color:red;'> {0} </span>不存在".format(target_branch)) 
    #ChatSocketHandler.client_map[socket_id].write_message(deleteBranchResult) 
    #print "deleteBranchResult:",deleteBranchResult,deleteBranch.status_code
    
    createBranchUrl = "{url}/projects/{id}/repository/branches"
    createBranchPare = {"id":project_id,"branch_name":target_branch,"ref":'master'}
    createBranch = requests.post(createBranchUrl.format(url=url,id=project_id),data=createBranchPare,headers = headers)
    
    createBranchResult = createBranch.json()
    
    print "createBranch",createBranchResult,createBranch.status_code
    if createBranch.status_code ==201:
        ChatSocketHandler.client_map[socket_id].write_message("创建<span style='color:green;'> {0} </span>分支成功".format(target_branch)) 
    else:
        ChatSocketHandler.client_map[socket_id].write_message("创建<span style='color:red;'> {0} </span>分支失败".format(target_branch)) 
        ChatSocketHandler.client_map[socket_id].write_message(createBranchResult) 
        return
    #print branches
    for branche in branches:
        light_merge(socket_id,project_id,branche)
    
    ChatSocketHandler.client_map[socket_id].write_message("project <span style='color:green;'> {id} </span> merge <span style='color:green;'> {b} </span> to light_merge 成功".format(id=project_id,b=",".join(branches))) 
    return 1


cmd_map = {"do_merge":do_merge}
def light_merge(socket_id,project_id,source_branch):
    createMergeRequestUrl = "{url}/projects/{id}/merge_requests".format(url=url,id=project_id)
    createMergeRequestPare = {"id":project_id,"source_branch":source_branch,"target_branch":target_branch,"title":target_branch}
    createMergeRequest = requests.post(createMergeRequestUrl,data=createMergeRequestPare,headers = headers)
    createMergeResult = createMergeRequest.json()
    print "createMerge",createMergeResult,createMergeRequest.status_code
    if createMergeRequest.status_code ==201:
        merge_request_id = createMergeResult["id"]
        ChatSocketHandler.client_map[socket_id].write_message("创建merge request <span style='color:green;'> {0} </span> to <span style='color:green;'> {1} </span>成功，合并请求id：<span style='color:green;'> {2} </span>".format(source_branch,target_branch,merge_request_id)) 
    elif createMergeRequest.status_code ==409:
        ChatSocketHandler.client_map[socket_id].write_message("创建merge request <span style='color:red;'> {0} </span> to <span style='color:red;'> {1} </span>失败，合并请求已存在".format(source_branch,target_branch)) 
        getMergeRequestUrl = "{url}/projects/{id}/merge_requests?state=opened".format(url=url,id=project_id)
        getMergeRequest = requests.get(getMergeRequestUrl,headers = headers)
        getMergeResult = getMergeRequest.json()
        for merge_request in getMergeResult:
            if merge_request["target_branch"] == target_branch and merge_request["source_branch"] == source_branch:
                merge_request_id = merge_request["id"]
                break
        else:
            ChatSocketHandler.client_map[socket_id].write_message("未找到 <span style='color:red;'> {0} </span> to <span style='color:red;'> {1} </span> merge request".format(source_branch,target_branch)) 
            ChatSocketHandler.client_map[socket_id].write_message(getMergeResult)
            return
        
    else:
        ChatSocketHandler.client_map[socket_id].write_message("创建merge request <span style='color:red;'> {0} </span> to <span style='color:red;'> {1} </span>失败".format(source_branch,target_branch)) 
        ChatSocketHandler.client_map[socket_id].write_message(createMergeResult) 
        return
    
    mergeUrl = "{url}/projects/{id}/merge_request/{merge_request_id}/merge".format(url=url,id=project_id,merge_request_id=merge_request_id)
    mergePare = {"id":project_id,"merge_request_id":merge_request_id}
    mergeResult = requests.put(mergeUrl,data=mergePare,headers = headers)
    if mergeResult.status_code == 200:
        ChatSocketHandler.client_map[socket_id].write_message("merge <span style='color:green;'> {0} </span> to <span style='color:green;'> {1} </span> 成功".format(source_branch,target_branch)) 
    else:
        ChatSocketHandler.client_map[socket_id].write_message("merge <span style='color:red;'> {0} </span> to <span style='color:red;'> {1} </span> 失败,详细信息：{2}".format(source_branch,target_branch,mergeResult.text)) 
    print "merge",mergeResult.json(),mergeResult.status_code
    
def getBranchs(project_id):
    r = requests.get("{url}//projects/{id}/repository/branches".format(url=url,id=project_id),headers = headers)
    res = r.json()
    return res
    
def getProjects():
    r = requests.get("{url}/projects".format(url=url),headers = headers)
    res = r.json()
    return res

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
            cmd_map.get(cmd)(id(self),parements[0],parements[1:])
        except:
            #print dir(traceback)
            ChatSocketHandler.client_map[id(self)].write_message(traceback.format_exc())
            