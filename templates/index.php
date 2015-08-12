{% extends "base.html" %}
{% block content %}
<script src="lib/bootstrap/js/jquery.pin.js"></script>
<div class="header">
    <div class="stats">
    
    <p class="stat"><span class="number"><?php echo $servers_os_count; ?></span>OS</p>
    <p class="stat"><span class="number"><?php echo $servers_redis_count; ?></span>Redis</p>
    <p class="stat"><span class="number"><?php echo $servers_mongodb_count; ?></span>MongoDB</p>
    <p class="stat"><span class="number"><?php echo $servers_oracle_count; ?></span>Oracle</p>
    <p class="stat"><span class="number"><?php echo $servers_mysql_count; ?></span>MySQL</p>
    
    </div>
<h1 class="page-title">{{lang["dashboard"]}}</h1>
</div>
        
<ul class="breadcrumb">
            <li><a href="/">{{lang["home"]}}</a> <span class="divider">/</span></li>
            <li class="active">{{lang["dashboard"]}}</li><span class="divider">/</span></li>
            <span class="right">{{lang["lepus_version"]}}:<?php echo $lepus_status['lepus_version']; ?>&nbsp;&nbsp; {{lang["lepus_status"]}}:<?php if($lepus_status['lepus_running']==1){ ?><span class="label label-success">{{lang["lepus_running"]}}</span><?php }else{?><span class="label label-important">{{lang["lepus_not_run"]}}&nbsp;&nbsp; {{lang["last_check_time"]}}:<?php echo $lepus_status['lepus_checktime']; ?></span>
</ul>

 

<div class="container-fluid">
<div class="row-fluid">
 
<script src="lib/bootstrap/js/bootstrap-switch.js"></script>
<link href="lib/bootstrap/css/bootstrap-switch.css" rel="stylesheet"/>
                    
<div class="ui-state-default ui-corner-all" style="height: 45px;" >
<p><span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-search"></span>                 
<form name="form" class="form-inline" method="get" action="<?php echo site_url('index/index') ?>" >

  
  <select name="db_type" class="input-small" style="width: 120px;">
  <option value="" <?php if($setval['db_type']=='') echo "selected"; ?> >{{lang["db_type"]}}</option>
  <option value="mysql" <?php if($setval['db_type']=='mysql') echo "selected"; ?> >{{lang["mysql"]}}</option>
  <option value="oracle" <?php if($setval['db_type']=='oracle') echo "selected"; ?> >{{lang["oracle"]}}</option>
  <option value="mongodb" <?php if($setval['db_type']=='mongodb') echo "selected"; ?> >{{lang["mongodb"]}}</option>
  <option value="redis" <?php if($setval['db_type']=='redis') echo "selected"; ?> >{{lang["redis"]}}</option>
  
  </select>
  
  <input type="text" id="host"  name="host" value="<?php echo $setval['host']; ?>" placeholder="{{lang["please_input_host"]}}" class="input-medium" >
 <input type="text" id="tags"  name="tags" value="<?php echo $setval['tags']; ?>" placeholder="{{lang["please_input_tags"]}}" class="input-medium" >
  
  
  <select name="order" class="input-small" style="width: 100px;">
  <option value="">{{lang["sort"]}}</option>
  <option value="db_type_sort" <?php if($setval['order']=='db_type_sort') echo "selected"; ?> >{{lang["default"]}}</option>
  <option value="host" <?php if($setval['order']=='host') echo "selected"; ?> >{{lang["host"]}}</option>
  <option value="db_type" <?php if($setval['order']=='db_type') echo "selected"; ?> >{{lang["db_type"]}}</option>
  <option value="tags" <?php if($setval['order']=='tags') echo "selected"; ?> >{{lang["tags"]}}</option>

  </select>
  <select name="order_type" class="input-small" style="width: 70px;">
  <option value="asc" <?php if($setval['order_type']=='asc') echo "selected"; ?> >{{lang["asc"]}}</option>
  <option value="desc" <?php if($setval['order_type']=='desc') echo "selected"; ?> >{{lang["desc"]}}</option>
  </select>

  <button type="submit" class="btn btn-success"><i class="icon-search"></i> {{lang["search"]}}</button>
  <a href="<?php echo site_url('index/index') ?>" class="btn btn-warning"><i class="icon-repeat"></i> {{lang["reset"]}}</a>
  <button id="refresh" class="btn btn-info"><i class="icon-refresh"></i> {{lang["refresh"]}}</button>
</form>                
</div>


<div class="well monitor " style="font-family: 微软雅黑;">
    <table class="table table-hover table-condensed tooltip-lepus">
      
      <thead>
        <tr style="font-size: 13px;">
        <th colspan="4"><center>{{lang["servers"]}}</center></th>
        <th colspan="7"><center>{{lang["db"]}}</center></th>
        <th colspan="7"><center>{{lang["os"]}}</center></th>
        <th ></th>
        </tr>
        <tr style="font-size: 12px;" >
        <th>{{lang["type"]}}</th> 
        <th>{{lang["host"]}}</th>
        <th>{{lang["role"]}}</th> 
        <th>{{lang["tags"]}}</th>
        <th>{{lang["version"]}}</th>
        <th>{{lang["connect"]}}</th>
        <th>{{lang["sessions"]}}</th>
        <th>{{lang["actives"]}}</th>
        <th>{{lang["waits"]}}</th>
        <th>{{lang["repl"]}}</th>
        <th>{{lang["delay"]}}</th>
        <th>{{lang["tbs"]}}</th>
        <th>{{lang["snmp"]}}</th>
        <th>{{lang["process"]}}</th>
        <th>{{lang["load"]}}</th>
        <th>{{lang["cpu"]}}</th>
        <th>{{lang["mem"]}}</th>
        <th>{{lang["net"]}}</th>
        <th>{{lang["disk"]}}</th>
        <th>{{lang["chart"]}}</th>
      </tr>
      </thead>
      <tbody>
 <?php if(!empty($db_status)) {?>
 <?php foreach ($db_status  as $item):?>
    <tr style="font-size: 12px;">
        <td><?php echo check_dbtype($item['db_type']) ?></td>
        <td><?php echo $item['host'] ?>:<?php echo $item['port'] ?></td>
        <td><?php echo check_db_status_role($item['role']) ?></td>
        <td><?php echo $item['tags'] ?></td>
        <td><?php echo check_value($item['version']) ?></td>
        <td><?php echo check_db_status_level($item['connect'],$item['connect_tips']) ?></td>
        <td><?php echo check_db_status_level($item['sessions'],$item['sessions_tips']) ?></td>
        <td><?php echo check_db_status_level($item['actives'],$item['actives_tips']) ?></td>
        <td><?php echo check_db_status_level($item['waits'],$item['waits_tips']) ?></td>
        <td><?php echo check_db_status_level($item['repl'],$item['repl_tips']) ?></td>
        <td><?php echo check_db_status_level($item['repl_delay'],$item['repl_delay_tips']) ?></td>
        <td><?php echo check_db_status_level($item['tablespace'],$item['tablespace_tips']) ?></td>
        <td><?php echo check_db_status_level($item['snmp'],$item['snmp_tips']) ?></td>
        <td><?php echo check_db_status_level($item['process'],$item['process_tips']) ?></td>
        <td><?php echo check_db_status_level($item['load_1'],$item['load_1_tips']) ?></td>
        <td><?php echo check_db_status_level($item['cpu'],$item['cpu_tips']) ?></td>
        <td><?php echo check_db_status_level($item['memory'],$item['memory_tips']) ?></td>
        <td><?php echo check_db_status_level($item['network'],$item['network_tips']) ?></td>
        <td><?php echo check_db_status_level($item['disk'],$item['disk_tips']) ?></td>
        <td><a href="<?php echo site_url('lp_'.$item['db_type'].'/chart/'.$item['server_id']); ?>"><img src="./images/chart.gif"/></a></td>
  </tr>
 <?php endforeach;?>
 <?php }else{  ?>
<tr>
<td colspan="16">
<font color="red">{{lang["no_record"]}}</font>
</td>
</tr>
<?php } ?>      
      </tbody>
    </table>
</div>

 <script type="text/javascript">
    $('#refresh').click(function(){
        document.location.reload(); 
    })
	

     $(function(){
		// tooltip demo
    	$('.tooltip-lepus').tooltip({
      		selector: "a[data-toggle=tooltip]"
    	})
		
	 })
	

$(".thead").pin()
 </script>

{% end %}


