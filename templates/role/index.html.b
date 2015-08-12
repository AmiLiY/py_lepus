{% extends "../base.html" %}
{% block content %}
<div class="header">
<div class="header">  
            <h1 class="page-title">用户 列表</h1>
</div>
     
<ul class="breadcrumb">
            <li><a href="/">{{ lang["home"] }}</a> <span class="divider">/</span></li>
            <li class="active">{{lang["permission_system"]}}</li><span class="divider">/</span></li>
            <li class="active">{{lang["user"]}}</li>
</ul>

<div class="container-fluid">
<div class="row-fluid">
 
<div class="btn-toolbar">
    <a class="btn btn-primary " href="/user/add"><i class="icon-plus"></i> {{lang["add"]}}</a>
  <div class="btn-group"></div>
</div>

<div class="well">
    <table class="table table-hover ">
      <thead>
        <tr>
          <th>#</th>
          <th>{{ lang["username"] }}</th>
          <th>{{ lang["realname"] }}</th>
          <th>{{ lang["email"] }}</th>
          <th>{{ lang["mobile"] }}</th>
          <th>{{ lang["login_count"] }}</th>
          <th>{{ lang["last_login_ip"] }}</th>
          <th>{{ lang["last_login_time"] }}</th>
          <th>{{ lang["role"] }}</th>
          <th style="width: 30px;"></th>
        </tr>
      </thead>
      <tbody>
{% if datalist %}
{% for item in datalist %}
     <tr>
          <td>{{item['user_id'] }}</td>
          <td>{{item['username'] }}</td>
          <td>{{item['realname'] }}</td>
          <td>{{item['email'] }}</td>
          <td>{{item['mobile'] }}</td>
          <td>{{item['login_count'] }}</td>
          <td>{{item['last_login_ip'] }}</td>
          <td>{{item['last_login_time'] }}</td>
          <td><a href="/auth/index/user_id/{{item['user_id']}}" >{{ lang["role_assignments"] }}</a></td>
          <td>
              <a href="/user/edit/{{item['user_id']}}" title="{{ lang["edit"] }}" ><i class="icon-pencil"></i></a>&nbsp;
              <a href="/'user/forever_delete/{{item['user_id']}}" class="confirm_delete" title="{{ lang["forever_delete"] }}" ><i class="icon-remove"></i></a>
          </td>
     </tr>
 {% end %}
<tr>
<td colspan="10">
<font color="#000000">{{ lang["total_record"] }} {{ len(datalist)}}</font>
</td>
</tr>
 {% else %}
<tr>
<td colspan="4">
<font color="red">{{ lang["no_record"] }} </font>
</td>
</tr>
{% end %}   
      </tbody>
    </table>
</div>

<script type="text/javascript">
	$(' .confirm_delete').click(function(){
		return confirm("{{ lang["forever_delete_confirm"] }}");	
	});
</script>

{% end %}