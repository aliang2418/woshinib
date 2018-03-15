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
  <form action="" id="fuForm" method="post">
		<input type="hidden" name="id" />
		<p>
			资源名称: <input type="text" name="text" class="easyui-validatebox" data-options="required:true,missingMessage:'必须填写'" />
		</p>
		<p>
			资源类型(menu,button) :<input type="text" name="type" class="easyui-validatebox" />
		</p>
		
	</form>
</body>  
<script type="text/javascript">  
  
</script>  
</html> 