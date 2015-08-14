
import requests

url = 'http://git.hrd800.net/api/v3'
token = 'KaK4UsgHhh6UY8W47N2R'
headers = {"PRIVATE-TOKEN": token}
target_branch = "light_merge"
#target_branch = "newB"

def light_merge(id,source_branch):
    createBranchUrl = "{url}/projects/{id}/repository/branches"
    createBranchPare = {"id":id,"branch_name":target_branch,"ref":'master'}
    createBranch = requests.post(createBranchUrl.format(url=url,id=id),data=createBranchPare,headers = headers)
    createBranchResult = createBranch.json()
    print "createBranch",createBranchResult
    
    createMergeRequestUrl = "{url}/projects/{id}/merge_requests".format(url=url,id=id)
    createMergeRequestPare = {"id":id,"source_branch":source_branch,"target_branch":target_branch,"title":target_branch}
    createMergeRequest = requests.post(createMergeRequestUrl,data=createMergeRequestPare,headers = headers)
    createMergeResult = createMergeRequest.json()
    print "createMerge",createMergeResult
    merge_request_id = createMergeResult["id"]
    
    mergeUrl = "{url}/projects/{id}/merge_request/{merge_request_id}/merge".format(url=url,id=id,merge_request_id=merge_request_id)
    mergePare = {"id":id,"merge_request_id":merge_request_id}
    mergeRequest = requests.put(mergeUrl,data=mergePare,headers = headers)
    print "merge",mergeRequest.text
    
def getBranchs(project_id):
    r = requests.get("{url}//projects/{id}/repository/branches".format(url=url,id=project_id),headers = headers)
    res = r.json()
    return res
    
def getProjects():
    r = requests.get("{url}/projects".format(url=url),headers = headers)
    res = r.json()
    return res
    
if __name__ == "__main__":
    #project_id=19
    #light_merge(project_id,"test1")
    projects = getProjects()
    for project in projects:
        name=project.get("name")
        print name
        project_id = project.get("id")
        branchs = getBranchs(project_id)
        for branch in branchs:
            branch_name = branch.get("name")
            print branch_name
