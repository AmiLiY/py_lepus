import os
import MySQLdb
import ConfigParser
class data():
    @staticmethod
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
op_cursor = data.get_op_cursor(os.path.join(WORKING_DIR,"../config/db.ini"))