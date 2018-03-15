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
</head>  
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="easyui/themes/material/easyui.css"/>
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css"/>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
<body> 
  <table id="userTable"  title="Permission List"
        data-options="url:'permission/list',fitColumns:true,striped:true,iconCls:'icon-search'">
    <thead>
        <tr>
            <th data-options="field:'text',width:100,sortable:true">name</th>
            <th data-options="field:'available',width:100,sortable:true">Availabl
            <th data-options="field:'url',width:100">url</th>
        </tr>
    </thead>
</table>
<div id="tb">
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="add_fu();" data-options="iconCls:'icon-add',plain:true">添加父级</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="add_zi();" data-options="iconCls:'icon-add',plain:true">添加子级</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit();" data-options="iconCls:'icon-edit',plain:true">修改</a>
<a href="javascript:void(0)" class="easyui-linkbutton" onclick="delete_permission();" data-options="iconCls:'icon-remove',plain:true">删除</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">导出</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-sum',plain:true">批量导入</a>
</div>
</body>  
<script type="text/javascript">  
	$(function(){
		$("#userTable").treegrid({
			toolbar : "#tb",
			idField : "id",
			treeField:"text",
			animate:true,
			onLoadSuccess : function(){
				$(this).treegrid("collapseAll");
			},
			loadFilter : function(data){
				return data;
			}
		});
	})
	function add_fu(){
		var d = $("<div></div>").appendTo("body");
		d.dialog({
			title : "添加父级",
			iconCls : "icon-add",
			width:300,
			height:200,
			modal:true,
			href : "permission/fufrom",
			onClose:function(){$(this).dialog("destroy"); },
			buttons:[{
				iconCls:"icon-ok",
				text:"确定",
				handler:function(){
					$("#fuForm").form("submit",{
						url : "permission/addfu",
						success : function(data){
							d.dialog("close");
							$("#userTable").treegrid("reload");
						}
					});
				}
			},{
				iconCls:"icon-cancel",
				text:"取消",
				handler:function(){
					d.dialog("close");
				}
			}]
		});
	}
	function add_zi(){
		var d = $("<div></div>").appendTo("body");
		d.dialog({
			title : "添加子级",
			iconCls : "icon-add",
			width:300,
			height:300,
			modal:true,
			href : "permission/zifrom",
			onClose:function(){$(this).dialog("destroy"); },
			buttons:[{
				iconCls:"icon-ok",
				text:"确定",
				handler:function(){
					$("#ziForm").form("submit",{
						url : "permission/addzi",
						success : function(data){
							d.dialog("close");
							$("#userTable").treegrid("reload");
						}
					});
				}
			},{
				iconCls:"icon-cancel",
				text:"取消",
				handler:function(){
					d.dialog("close");
				}
			}]
		});
	}
	function delete_permission(){
		//1. 获取选中的数据，如果没有选中，则提示必须选中数据
		var selRows = $("#userTable").datagrid("getSelections");
		if(selRows.length == 0){
			$.messager.alert("提示","请选择要删除的数据行！","warning");
			return;
		}
		//2. 提示是否删除？是
		$.messager.confirm("提示","确定要删除选中的数据吗？",function(r){
			if(r){
				//3. 发送异步请求，带选中行的编号
				//拼接删除条件
				var postData = "";
				$.each(selRows,function(i){
					postData += "ids="+this.id;
					if(i < selRows.length - 1){
						postData += "&";
					}
				});
				$.post("permission/getById",postData,function(data){
					if(data.children.length == 0){
						//4. 删除成功后，刷新表格 reload
						$.post("permission/batchDelete",postData,function(data){
							if(data.result == true){
								//4. 删除成功后，刷新表格 reload
								$("#userTable").treegrid("reload");
							}
						});
					}else{
						$.messager.alert("提示","该行不可删除，有子类，请先删除子类！","warning");
					}
					
				});
			}
		});
	}
	function edit(){
		var row = $("#userTable").treegrid("getSelected");
		if(row == null){
			$.messager.alert("提示","请选择要修改的数据行！","warning");
		}

		//如果选中了多个，只保留row这个
		$("#userTable").datagrid("clearSelections");
		$("#userTable").datagrid("selectRecord",row.id);
		$.post("permission/getById",{ids:row.id},function(data){
			if(data.children.length == 0){
				//进入子类
				var d = $("<div></div>").appendTo("body");
				d.dialog({
				title : "编辑",
				iconCls : "icon-edit",
				width:300,
				height:400,
				modal:true,
				href : "permission/zifrom",
				onClose:function(){$(this).dialog("destroy"); },
				onLoad:function(){
					//发送异步请求，查询数据
					$.post("permission/getById",{ids:row.id},function(data){
						$("#ziForm").form("load",data);
					});
				},
				buttons:[{
					iconCls:"icon-ok",
					text:"确定",
					handler:function(){
						$("#ziForm").form("submit",{
							url : "permission/editZi",
							success : function(data){
								d.dialog("close");
								$("#userTable").treegrid("reload");
							}
						});
					}
				},{
					iconCls:"icon-cancel",
					text:"取消",
					handler:function(){
						d.dialog("close");
					}
				}]
			});
			}else{
				//进入父类
				var d = $("<div></div>").appendTo("body");
				d.dialog({
				title : "编辑",
				iconCls : "icon-edit",
				width:300,
				height:400,
				modal:true,
				href : "permission/fufrom",
				onClose:function(){$(this).dialog("destroy"); },
				onLoad:function(){
					//发送异步请求，查询数据
					$.post("permission/getById",{ids:row.id},function(data){
						$("#fuForm").form("load",data);
					});
				},
				buttons:[{
					iconCls:"icon-ok",
					text:"确定",
					handler:function(){
						$("#fuForm").form("submit",{
							url : "permission/editFu",
							success : function(data){
								d.dialog("close");
								$("#userTable").treegrid("reload");
							}
						});
					}
				},{
					iconCls:"icon-cancel",
					text:"取消",
					handler:function(){
						d.dialog("close");
					}
				}]
			});
			}
			
		});
	}
</script>  
</html> 