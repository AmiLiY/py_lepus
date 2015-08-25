#!/bin/evn python26
#--coding:utf-8--
import psutil
import time,datetime
import urllib,urllib2

url = "http://192.168.1.90:8001/insert"
def bytes2human(n):
    symbols = ('K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y')
    prefix = {}
    for i, s in enumerate(symbols):
        prefix[s] = 1 << (i+1)*10
    for s in reversed(symbols):
        if n >= prefix[s]:
            value = int(float(n) / prefix[s])
            return '%s%s' % (value, s)
    return "%sB" % n

def timestamp2str(timestamp):
	time1 = time.ctime(timestamp)
	Y,m,d,h,M,S = time.strptime(time1, "%a %b %d %H:%M:%S %Y")[:6]
	create_time = datetime.datetime(Y,m,d,h,M,S).strftime("%Y-%m-%d %H:%M:%S")
	return create_time

psinfos = []
pids = psutil.pids()
#if 1:
#	pid = 3129
for pid in pids:
	try:
	    Ps = psutil.Process(pid)
	except:
		continue
	#print Ps.cmdline()
	psinfo = Ps.as_dict()
	cpu = Ps.cpu_percent()
	memory = Ps.memory_info().rss
	#memory = bytes2human(Ps.memory_info().rss)
	times = psinfo["cpu_times"]
	cpu_times = times.system + times.user
	ppid = psinfo["ppid"]
	username = psinfo["username"]
	create_time = timestamp2str(psinfo["create_time"])
	cmd = psinfo["name"]
	cmdline =" ".join(psinfo["cmdline"])
	status = psinfo["status"]
	tty = psinfo["terminal"]
	num_threads = psinfo["num_threads"]
	psinfos.append([pid,cpu,memory,cpu_times,ppid,username,create_time,cmd,cmdline,status,tty,num_threads])

data = urllib.urlencode({"tablename":"process","data":str(psinfos)})
req = urllib2.Request(url, data)
response = urllib2.urlopen(req)
print response.read()


	

