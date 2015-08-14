import os
import MySQLdb
import ConfigParser

from datetime import datetime,date,timedelta
import json

user_menus = {}

class DatetimeEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.strftime('%Y-%m-%d %H:%M:%S')
        elif isinstance(obj, date):
            return obj.strftime('%Y-%m-%d')
        elif isinstance(obj, timedelta):
            return str(obj)
        return json.JSONEncoder.default(self, obj)
        
def get_menu(_username):
	user_menu = user_menus.get(_username,0)
	if user_menu:
		return user_menu
	else:
		user_menus[_username] = _get_menu(_username)
		return user_menus.get(_username,0)

def _get_menu(_username):
    print "get_menu for {username}".format(username=_username)
    sql = """select admin_menu.* from admin_user, admin_role,admin_user_role,admin_privilege,admin_role_privilege,admin_menu 
    where admin_user.username= "{username}" and 
    admin_user.user_id= admin_user_role.user_id and
    admin_user_role.role_id = admin_role.role_id and 
    admin_role.role_id = admin_role_privilege.role_id and 
    admin_role_privilege.privilege_id = admin_privilege.privilege_id and 
    admin_privilege.menu_id = admin_menu.menu_id and
    admin_menu.status = 1 
    group by admin_menu.menu_id
    order by admin_menu.display_order asc;"""
    op_cursor.execute(sql.format(username=_username))
    sub_menus = op_cursor.fetchall()
    sub_head = [c[0] for c in op_cursor.description]
    parent_ids = set([str(menu[3]) for menu in sub_menus])
    parent_menus_sql = r"""SELECT menu_id,menu_title parent_title,REPLACE(menu_url,'/','') parent_url,menu_icon parent_icon,display_order, p.sub_menus
                           FROM `admin_menu`,(SELECT parent_id,GROUP_CONCAT(menu_url) sub_menus FROM admin_menu GROUP BY parent_id) p
                           WHERE menu_id IN ({_parent_ids}) AND admin_menu.`menu_id`=p.parent_id
                           GROUP BY menu_url ORDER BY display_order""".format(_parent_ids = ",".join(parent_ids))
    op_cursor.execute(parent_menus_sql)
    parent_menus = op_cursor.fetchall()
    head = [c[0] for c in op_cursor.description]
    menus = []
    for parent_menu in parent_menus:
        menu=dict(zip(head,parent_menu))
        sub_menu2 = [sub_menu for sub_menu in sub_menus if sub_menu[3] == parent_menu[0] ]
        sub_menu3 = []
        for sub in sub_menu2:
            sub_menu3.append(dict(zip(sub_head,sub)))
        menu["sub_menu"] = sub_menu3
        menus.append(menu)
    if menus:
        return menus
    else:
        return False

def get_op_cursor(dbconfig):
    cf = ConfigParser.ConfigParser()
    cf.read(dbconfig)
    host= cf.get("dbsource","host")
    user = cf.get("dbsource","user")
    passwd = cf.get("dbsource","passwd")
    port = cf.getint("dbsource","port")
    db = cf.get("dbsource","db")
    conn = MySQLdb.connect(host=host,user=user,passwd=passwd,port=port,db=db,charset='utf8')
    conn.autocommit(1)
    conn.ping()
    return conn.cursor()

WORKING_DIR = os.path.dirname(os.path.abspath(__file__))
op_cursor = get_op_cursor(os.path.join(WORKING_DIR,"../../db.ini"))
users_sql = "SELECT username,`password` FROM `admin_user` WHERE STATUS=1"
op_cursor.execute(users_sql)
user_map = dict(op_cursor.fetchall())
#WORKING_DIR = os.path.dirname(os.path.abspath(__file__))
#op_cursor = data.get_op_cursor(os.path.join(WORKING_DIR,"../config/db.ini"))