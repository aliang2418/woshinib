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
  <form action="" id="roleForm" method="post">
		<input type="hidden" name="id" />
		<p>
			Name : <input type="text" name="name" class="easyui-validatebox" data-options="required:true,missingMessage:'必须填写'" />
		</p>
		<p>
			Available : <input name="available" id="anniu" value="1" class="easyui-switchbutton" data-options="onText:'Yes',offText:'No'">
		</p>
	</form>
</body>  
<script type="text/javascript" src="js/jquery.min.js"></script>  
<script type="text/javascript">
</script>  
</html> 