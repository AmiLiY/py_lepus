#!/bin/evn python26
#--coding:utf-8--
from tools import op_cursor
class User():
    user_list_sql = "SELECT user_id,username,realname,email,mobile,login_count,last_login_ip,last_login_time FROM `admin_user`"
    def get_user_list(self):
        user = op_cursor.execute(self.user_list_sql)
        users = op_cursor.fetchall()
        head = [c[0] for c in op_cursor.description]
        datalist = []
        for user in users:
            datalist.append(dict(zip(head,user)))
        return datalist