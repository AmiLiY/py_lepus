from models.light_merge import light_merge
def do_merge(id,project_id,*branches):
    #ChatSocketHandler.client_map[id].write_message("test") 
    for branche in branches:
        light_merge(project_id,branche)
    return 1