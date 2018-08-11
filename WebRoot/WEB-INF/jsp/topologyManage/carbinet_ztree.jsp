<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<link rel="icon" href="favicon.ico" type="image/x-icon" />
	<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/metroStyle.css"/>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.excheck.min.js"></script>
	<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.exedit.min.js"></script>
	
	<!-- 引入CSS和JS文件 -->
	<link rel="stylesheet" href="static/css/bootstrap.min.css" />
	<link rel="stylesheet" href="static/css/bootstrap-table.min.css" />
	<link rel="stylesheet" href="static/css/bootstrap-select.min.css" />
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/bootstrap-table.min.js"></script>
	<script src="static/js/bootstrap-table-zh-CN.min.js"></script>
	<script src="static/js/jquery.tips.js"></script>
	<script src="static/js/bootstrapValidator.min.js"></script>
	<script src="static/js/jquery-ui.js"></script>
	<script src="static/js/jquery.easing.1.3.js"></script>
	<script src="static/js/jquery.contextmenu.js"></script>
	<script src="static/js/bootstrap-select.min.js"></script>
	
	<style type="text/css">
		div#rMenu {
			position: absolute;
			visibility: hidden;
			top: 0;
			text-align: left;
			padding: 4px;
		}
		
		div#rMenu a {
			padding: 3px 15px 3px 15px;
			background-color: #cad4e6;
			vertical-align: middle;
		}
		
	</style>
	
<body>

<table style="width:100%;">
	<tr>
		<td style="width:10%;" valign="top" bgcolor="#F9F9F9">
			<div style="width:15%;margin-top:5px;">
				<button class="btn btn-info btn-xs" style="width:160px;" onclick="refreshCarbinetTreeNodes();">刷新</button>
				<button class="btn btn-info btn-xs" style="width:160px;" onclick="saveDevicePictureInfo();">保存</button>
				<ul id="carbinetLeftTree" class="ztree"></ul>
			</div>
		</td>
		<!-- 右侧结构 -->
		<td style="width:90%;" valign="top" >
			<div id="carbinetPicture" class="row" style="margin:5px 5px 0px 5px;height:500px;border:2px solid green;overflow:scroll;">
				
			</div>
			<table id="alarmTable"></table>	
		</td>
	</tr>
</table>

<!-- 树形结构的右键菜单 -->
<div id="rMenu" class="btn-group-vertical">
    <button class="btn btn-default btn-sm" onclick="addNode();">新增</button>  
    <button class="btn btn-default btn-sm" onclick="updateNode();">修改</button>  
    <button class="btn btn-default btn-sm" onclick="deleteNode();">删除</button> 
</div>

<!--图片的右键菜单  -->
<div class="contextMenu" id="devicePictureMenu">
	<ul>
		<li id="open"><img src="static/images/devicePicture/folder.png" /> Open</li>
		<li id="email"><img src="static/images/devicePicture/email.png" /> Email</li>
		<li id="save"><img src="static/images/devicePicture/disk.png" /> Save</li>
		<li id="delete"><img src="static/images/devicePicture/cross.png" /> Delete</li>
	</ul>
</div>

<!-- 新增的模态对话框 -->
<div id="addModal" class="modal fade" role="dialog" data-backdrop="static">
	<div class="modal-dialog" style="width: 300px;height:100px;">
		<div class="modal-content">
			<!-- 弹出框头部 -->
			<div class="modal-header">
				<h5 class="modal-title">
					<span id="lblAddTitle" style="font-weight: bold">添加节点</span>
				</h5>
			</div>
			<div class="modal-body">
				<select id="inputNodeName" name="inputNodeName" class="selectpicker show-tick form-control" data-live-search="false">
	                <option class="option" value="0">请选择</option>
	                <option class="carbinet" value="1">机框</option>
	                <option class="baseStation" value="2">基站</option>
	                <option class="dataTransferServer" value="3">数传服务器</option>
	                <option class="integrationServer" value="4">综合服务器</option>
	                <option class="timingEquipment" value="5">授时设备</option>
	                <option class="nearMachine" value="6">近端机</option>
	                <option class="remoteMachine" value="7">远端机</option>
                </select>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="addCarbinetNode();">确定</button>
				<button type="button" class="btn green" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<!-- 修改的模态对话框 -->
<div id="updateModal" class="modal fade" role="dialog" data-backdrop="static">
	<div class="modal-dialog" style="width: 400px;height:100px;">
		<div class="modal-content">
			<!-- 弹出框头部 -->
			<div class="modal-header">
				<h5 class="modal-title">
					<span id="lblAddTitle" style="font-weight: bold">修改节点</span>
				</h5>
			</div>
			<div class="modal-body">
				<input type="text" id="updateNodeName" class="form-control" placeholder="请输入节点名称">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="updateCarbinetNode();">修改</button>
				<button type="button" class="btn green" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<!-- 删除的模态对话框 -->
<div id="deleteModal" class="modal fade" role="dialog" data-backdrop="static">
	<div class="modal-dialog" style="width: 400px;height:100px;">
		<div class="modal-content">
			<!-- 弹出框头部 -->
			<div class="modal-header">
				<h5 class="modal-title">
					<span id="lblAddTitle" style="font-weight: bold">删除节点</span>
				</h5>
			</div>
			<div class="modal-body">
				<strong style="color:red;">删除该节点会删除该节点下面的所有子节点，确定删除吗？</strong>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="deleteCarbinetNode();">确定</button>
				<button type="button" class="btn green" data-dismiss="modal">取消></button>
			</div>
		</div>
	</div>
</div>

	<!-- 引入自定义的CSS文件 -->
	<script src="static/js/myjs/topology/carbinetTopology.js"></script>
	<script type="text/javascript">
		var locat = (window.location+'').split('/'); 

		$(top.hangge());
		//全局参数
		var selectedNode;
	
		//tree 设置
		var rMenu = $("#rMenu");
		var setting = {
		    showLine: true,
		    checkable: false,
		    data: {
		    	simpleData: {
		    		enable: true,
					idKey: "id",
					pIdKey: "pId",
					pictureId:"pictureId",
					pictureName:"pictureName",
					pictureLeft:"pictureLeft",
					pictureTop:"pictureTop",
					rootPId: 0
		    	}
		    }, 
		    callback: {
		    	onRightClick: rightMenuNode,
		    	onDblClick: locationDevicePicture
		    }
		};

		$(function(){
			var allTreeNodes = eval('${carbinetNodes}');
			console.log("获取的节点:"+allTreeNodes);
			$.fn.zTree.init($("#carbinetLeftTree"), setting, allTreeNodes);
			var treeObj = $.fn.zTree.getZTreeObj("carbinetLeftTree");
			treeObj.expandAll(true);
			//初始化路径(执行ajax请求需要的路径)
			if('main'== locat[3]){
				locat =  locat[0]+'//'+locat[2];
			}else{
				locat =  locat[0]+'//'+locat[2]+'/'+locat[3];
			};
			
			//初始化加载图片信息
			initDevicePictureLocation();
		});
		
		
		//双击节点定位右侧图片
		function locationDevicePicture(event, treeId, treeNode){
			console.log(treeNode.id);
			console.log(treeNode.name);
			$('html, body').animate({scrollTop: $('#1518055365413').offset().top}, 1000)
		}
		
		//右键菜单
		function rightMenuNode(event, treeId, treeNode) {
			var treeObj = $.fn.zTree.getZTreeObj("carbinetLeftTree");
			var mX = event.clientX - 30, mY = event.clientY + 10;
			treeObj.selectNode(treeNode);
			showRMenu("node", mX, mY);
			selectedNode = treeNode;
		}

		function showRMenu(type, x, y) {
			$("#rMenu ul").show();
			$("#rMenu").css({
				"top" : y + "px",
				"left" : x + "px",
				"visibility" : "visible"
			});
			$("body").bind("mousedown", onBodyMouseDown);
		}

		function onBodyMouseDown(event) {
			if (!(event.target.id == "rMenu" || $(event.target).parents(
					"#rMenu").length > 0)) {
				$("#rMenu").css({
					"visibility" : "hidden"
				});
			}
		}

		//右键节点添加
		function addNode() {
			$("#rMenu").css({
				"visibility" : "hidden"
			});
			$("#addModal").modal('show');
		}

		//点击模态框添加按钮
		function addCarbinetNode() {
			var selectValue = $("#inputNodeName option:selected").val();
			var selectText = $("#inputNodeName option:selected").text();
			var pictureName = $("#inputNodeName option:selected").attr("class");
			
			//在右侧的设备显示框中添加相应的设备信息
			var deviceNum = $("#carbinetPicture img[name='"+pictureName+"']").length;
			var pictureId = pictureName+(deviceNum+1);
			console.log("需要添加的节点值:"+selectValue+",需要添加的节点文本:"+selectText+",需要添加的图片名:"+pictureName+",需要添加的图片Id:"+pictureId);
			/**
			pictureId是图片的名字，因为可以添加多个同样的设备图片，方便后面的删除操作 
			pictureName 后期添加设备的时候能够命名不同的id
			selectText 该设备的名字
			selectText 该设备的名字
			*/
			var addDeviceLeftDistance = $("#carbinetPicture").offset().left+1;
			var addDeviceTopDistance = $("#carbinetPicture").offset().top+1;
			addDevicePicture(pictureId,pictureName,selectText,addDeviceLeftDistance,addDeviceTopDistance);
			
			//执行添加节点操作,发送ajax请求,将新添加的子节点写入数据库中
			var params = {};
			params.pId = selectedNode.id;
			params.name = selectText;
			params.pictureId = pictureId;
			params.pictureName = pictureName;
			params.pictureLeft = addDeviceLeftDistance;
			params.pictureTop = addDeviceTopDistance;
			$.ajax({
				type : "POST",
				url : locat + '/carbinet/addCarbinetTreeNode.do?tm='+ new Date().getTime(),
				data : params,
				dataType : 'json',
				success : function(data) {
					alert("添加成功!");
					$.fn.zTree.init($("#carbinetLeftTree"), setting, data);
					var treeObj = $.fn.zTree.getZTreeObj("carbinetLeftTree");
					treeObj.expandAll(true);
				},
				error : function(data) {
					alert("添加之后,重新加载树形菜单异常!");
				}
			});
			//当前节点添加新的子节点				
			var treeObj = $.fn.zTree.getZTreeObj("carbinetLeftTree");
			var newNodes = [ {
				pId : selectedNode.id,
				name : selectText,
				
			} ];
			newNodes = treeObj.addNodes(selectedNode, newNodes);
			
			//清空输入框的值,关闭模态框
			$("#inputNodeName").val('');
			$("#addModal").modal('hide');
			treeObj.refresh();
			treeObj.expandAll(true);
		}
		
		//=============初始化所有图片的位置信息开始===========
		function initDevicePictureLocation(){
			$.ajax({
				type : "GET",
				url : locat + '/carbinet/getAllDevicePictureLocation.do?tm=' + new Date().getTime(),
				dataType : 'json',
				success : function(data) {
					$.each(data,function(index,entity){
						console.log("索引:"+index);
						var picId = entity.pictureId;
						var picName = entity.pictureName;
						var treeName = entity.name;
						var picLeft = entity.pictureLeft;
						var picTop = entity.pictureTop;
						addDevicePicture(picId,picName,treeName,picLeft,picTop);
					});
					
				},
				error : function(data) {
					alert("刷新树形菜单异常!");
				}
			});
		}
		
		
		//================添加设备图片开始=====================//
		function addDevicePicture(pictureId,pictureName,selectText,leftDistance,topDistance){
			
			var deviceElement = "<img id='"+pictureId+"' name='"+pictureName+"' style='left:"+leftDistance+"px;top:"+topDistance+"px;position:absolute;' src='static/images/carbinetTopologyImages/"+pictureName+".png'>";
			$("#carbinetPicture").append(deviceElement);
			
			$("#"+pictureId).draggable({
				containment: "parent",
				start: function() {
							
			    },
			    drag: function() {
				
			    },
			    stop: function() {
			    	
			    }
			});
			
			$("#"+pictureId).contextMenu('devicePictureMenu',{
				bindings:{
					'open': function(obj){
						alert(obj.id);
					},
					'email': function(obj){
						alert(obj.id);
					},
					'save': function(obj){
						alert(obj.id);
					},
					'delete': function(obj){
						alert(obj.id);
					}
				}
			});
		}
		//================添加设备图片结束=====================//
		
		
		//================保存设备图片坐标开始================//
		function saveDevicePictureInfo(){
			var pictureArray = [];
			$("#carbinetPicture img").each(function(){
				var pictureId = $(this).attr("id");
				var pictureName = $(this).attr("name");
				var pictureLeft = $("#"+pictureId).position().left;
				console.log("Left:"+pictureLeft);
				var pictureTop = $("#"+pictureId).position().top;
				console.log("Top:"+pictureTop);
				pictureArray.push({"pictureId":pictureId,"pictureName":pictureName,"pictureLeft":pictureLeft,"pictureTop":pictureTop});
			});
			
			$.ajax({  
			    type: "POST",  
			    url: locat + '/carbinet/updateDevicePictureInfo.do?tm=' + new Date().getTime(),  
			    async: false,
			    dataType: "json",  
			    contentType: "application/json", 
			    data: JSON.stringify(pictureArray),  
			    success : function(data) {
					alert("更新位置坐标信息成功!");
					$.fn.zTree.init($("#carbinetLeftTree"), setting, data);
					var treeObj = $.fn.zTree.getZTreeObj("carbinetLeftTree");
					treeObj.expandAll(true);
				},
				error : function(data) {
					alert("更新位置坐标信息异常!");
				}  
			});
		}
		//================保存设备图片坐标结束================//
		
		
		//可以手动刷新树形菜单
		function refreshCarbinetTreeNodes() {
			$.ajax({
				type : "GET",
				url : locat + '/carbinet/refreshCarbinetTree.do?tm=' + new Date().getTime(),
				dataType : 'json',
				success : function(data) {
					$.fn.zTree.init($("#carbinetLeftTree"), setting, data);
					var treeObj = $.fn.zTree.getZTreeObj("carbinetLeftTree");
					treeObj.expandAll(true);
				},
				error : function(data) {
					alert("刷新树形菜单异常!");
				}
			});
		}

		//修改节点信息
		function updateNode() {
			$("#rMenu").css({
				"visibility" : "hidden"
			});
			console.log("选中的节点:" + selectedNode.id + "," + selectedNode.name);
			$("#updateNodeName").val(selectedNode.name);
			$("#updateModal").modal('show');
		}

		function updateCarbinetNode() {
			var zTree = $.fn.zTree.getZTreeObj("carbinetLeftTree");
			//修改发送ajax请求修改数据库中的值
			var params = {};
			params.id = selectedNode.id;
			params.name = $("#updateNodeName").val();
			$.ajax({
				type : "POST",
				url : locat + '/carbinet/updateCarbinetTreeNode.do?tm='
						+ new Date().getTime(),
				data : params,
				dataType : 'json',
				success : function(data) {
					$.fn.zTree.init($("#carbinetLeftTree"), setting, data);
					var treeObj = $.fn.zTree.getZTreeObj("carbinetLeftTree");
					treeObj.expandAll(true);
				},
				error : function(data) {
					alert("修改之后,重新加载树形菜单异常!");
				}
			});
			$("#updateModal").modal('hide');
			zTree.refresh();
			zTree.expandAll(true);
		}

		//删除节点信息
		function deleteNode() {
			$("#rMenu").css({
				"visibility" : "hidden"
			});
			if (selectedNode.pId == 0) {
				alert("不允许顶级节点!!!");
				return false;
			}
			console.log("选中的节点:" + selectedNode.id + "," + selectedNode.name+","+selectedNode.pictureId+","+selectedNode.pictureName);
			$("#deleteModal").modal('show');
		}

		function deleteCarbinetNode() {
			var zTree = $.fn.zTree.getZTreeObj("carbinetLeftTree"), 
						nodes = zTree.getSelectedNodes(), 
						treeNode = nodes[0];
			zTree.removeNode(treeNode);
			//删除DIV下面的图片
			var parent = document.querySelector('#carbinetPicture');
			parent.removeChild(parent.querySelector("#"+selectedNode.pictureId));
			//发送ajax请求删除数据库中的数据
			var params = {};
			params.id = selectedNode.id;
			$.ajax({
				type : "POST",
				url : locat + '/carbinet/deleteCarbinetTreeNode.do?tm=' + new Date().getTime(),
				data : params,
				dataType : 'json',
				success : function(data) {
					$.fn.zTree.init($("#carbinetLeftTree"), setting, data);
					var treeObj = $.fn.zTree.getZTreeObj("carbinetLeftTree");
					treeObj.expandAll(true);
					console.log("删除节点返回的数据:"+data);
					for(j = 0; j < data.length; j++) {
						console.log("循环数据:"+data[j].pictureId);	   
						if(data[j].pictureId==null){
							continue;
						}
						
					}
				},
				error : function(data) {
					alert("删除之后,重新加载树形菜单异常!");
				}
			});
			$("#deleteModal").modal('hide');
			zTree.refresh();
			zTree.expandAll(true);
			
		}
	</script>
	
</body>
</html>
