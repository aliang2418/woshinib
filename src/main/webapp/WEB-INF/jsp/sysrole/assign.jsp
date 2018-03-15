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
<script type="text/javascript">  
$(function(){
	$.post("role/getPermissions",{roleId:${roleId }},function(d){
		$("#assignTree").tree({
			loadFilter : function(data){
				$.each(data,function(){
					$.each(this.children,function(){
						if($.inArray(this.id,d) != -1){
							this.checked = true;
						}
					});
				});
				return data;
			}
		});
	});
});
</script> 
  <ul id="assignTree" class="easyui-tree" data-options="url:'permission/list',checkbox:true"></ul>
</body>  


</html> 