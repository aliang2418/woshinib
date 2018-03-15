<%@ page language="java" pageEncoding="UTF-8"%>  
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
<!DOCTYPE html>  
<html>  
<head>  
<base href="<%=basePath%>">  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">    
</head>  
<body>  
  <form action="" id="ziForm" method="post">
		<input type="hidden" name="id" />
		<p>
			父级类型: <input id="roles" class="easyui-combobox" name="parentId"
    		data-options="valueField:'id',textField:'text',url:'permission/list',panelHeight:'auto',panelMaxHeight:250">
		</p>
		<p>
			子类资源名称:<input type="text" name="text" class="easyui-validatebox" data-options="required:true,missingMessage:'必须填写'" />
		</p>
		<p>
			资源类型(menu,button) :<input type="text" name="type" class="easyui-validatebox" />
		</p>
		<p>
			Available : <input name="available" id="anniu" value="1" class="easyui-switchbutton" data-options="onText:'Yes',offText:'No'">
		</p>
		<p>
			子类资源URL:<input type="text" name="url" class="easyui-validatebox" />
		</p>
	</form>
</body>  
<script type="text/javascript" src="js/jquery.min.js"></script>  
<script type="text/javascript">  
  
</script>  
</html> 