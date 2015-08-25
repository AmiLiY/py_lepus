#--coding:utf-8--
mysql_processlist_hide = ["cmdline","SQL"]
mysql_processlist_sql = "SELECT `id`,`USER`,`HOST`,`db`,`command`,`TIME`,`state`,`info` `SQL`,`pid`,`process`,`appname`,`cmdline` FROM `PROCESSLIST`"
projects_2_branches_sql = "SELECT `id`,`USER`,`HOST`,`db`,`command`,`TIME`,`state`,`info` `SQL`,`pid`,`process`,`appname`,`cmdline` FROM `PROCESSLIST`"

ecsinfo_url = [{"id":"/ecs/[[item.id]]/detail"}]
ecsinfo_button = [{"show":"show(id)"}]
ecsinfo_hide = ["id","bindWidth","internetIp","isWin"]
ecsinfo_sql = "SELECT * FROM `ecsinfo` "
appinfo_sql = "SELECT * FROM `applications`"
process_sql = "SELECT * FROM `process`"
process_hide = ["ppid","pid","cmdline","tty","cpu_times"]