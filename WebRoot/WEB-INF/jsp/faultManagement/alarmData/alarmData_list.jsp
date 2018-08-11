<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<link rel="icon" href="favicon.ico" type="image/x-icon" />
	<!-- CSS -->
	<link type="text/css" rel="stylesheet" href="static/css/bootstrap.min.css"/>
	<link type="text/css" rel="stylesheet" href="static/css/font-awesome.css"/>
	<link type="text/css" rel="stylesheet" href="static/css/bootstrap-table.min.css"/>
	<link type="text/css" rel="stylesheet" href="static/css/bootstrap-select.min.css"/>
	<link type="text/css" rel="stylesheet" href="static/css/select2.min.css"/>
	<link type="text/css" rel="stylesheet" href="static/css/jquery-ui.min.css"/>
	<link type="text/css" rel="stylesheet" href="static/css/jquery-ui-timepicker-addon.min.css"/>
	<link type="text/css" rel="stylesheet" href="static/css/fileinput.css"/>
	<link type="text/css" rel="stylesheet" href="static/css/jquery-confirm.min.css"/>
	<!-- JS -->
	<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="static/js/select2.min.js"></script>
	<script type="text/javascript" src="static/js/zh-CN.js"></script>
	<script type="text/javascript" src="static/js/echarts.min.js"></script>
	<script type="text/javascript" src="static/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="static/js/jquery-ui-timepicker-addon.min.js"></script>
	<script type="text/javascript" src="static/js/jquery-ui-timepicker-zh-CN.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/common/jquery.bootstrap.teninedialog.v3.js"></script>
	<script type="text/javascript" src="static/js/fileinput.js"></script>
	<script type="text/javascript" src="static/js/zh.js"></script>
	<script type="text/javascript" src="static/js/jquery-confirm.min.js"></script>

</head>
<body>
	<!-- 选择导入ZIP资源包的弹出框 -->
	<div id="importAlarmDatas" class="modal fade" role="dialog" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 弹出框头部 -->
				<div class="modal-header">
					<h5 class="modal-title">
						<span style="font-weight:bold;">导入告警数据ZIP包</span>
					</h5>
				</div>
				<div class="modal-body">
					<input type="file" id="alarmDataFile" name="alarmDataFile">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						id="confirmAlarmDataFile">确定</button>
					<button type="button" class="btn green" data-dismiss="modal"
						id="cancelAlarmDataFile">取消</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 选择导出ZIP资源包的弹出框 -->
	<div id="exportAlarmDatas" class="modal fade" role="dialog" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 弹出框头部 -->
				<div class="modal-header">
					<h5 class="modal-title">
						<span style="font-weight:bold;">提示</span>
					</h5>
				</div>
				<div class="modal-body">
					<span style="color:red;font-weight:bold;text-align:center;">确认导出模版数据吗?</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						id="confirmExportAlarmDatas">确定</button>
					<button type="button" class="btn green" data-dismiss="modal"
						id="cancelExportAlarmDatas">取消</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 添加告警数据模态框 -->
	<div class="modal fade" id="addAlarmDataModal" role="dialog" data-backdrop="static">
		<div class="modal-dialog" style="width:550px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						&times;
					</button>
					<span class="modal-title" style="font-weight:bold;">添加告警数据</span>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<td style="padding-right:20px;">
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">设备名称</span>
									<select id="equipType" name="equipType" class="form-control" style="width:150px;">
									</select>
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警级别</span>
									<select id="severity" name="severity" class="form-control" style="width:150px;">
										<option value="1">紧急告警</option>
						            	<option value="2">重要告警</option>
						            	<option value="3">次要告警</option>
						            	<option value="4">警告告警</option>
						            	<option value="5">通知告警</option>
									</select>
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警类型</span>
									<select id="alarmType" name="alarmType" class="form-control" style="width:150px;">
										<option value="1">通讯告警</option>
						            	<option value="2">数据处理告警</option>
						            	<option value="3">环境告警</option>
						            	<option value="4">服务质量告警</option>
						            	<option value="5">设备告警</option>
						            	<option value="6">完整性告警</option>
						            	<option value="7">安全性告警</option>
						            	<option value="8">时区告警</option>
						            	<option value="9">操作告警</option>
						            	<option value="10">物理告警</option>
									</select>
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">自动清除</span>
									<select id="autoClearEnable" name="autoClearEnable" class="form-control" style="width:150px;">
										<option value="1">开启自动清除</option>
						            	<option value="2">关闭自动清除</option>
									</select>
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警抑制</span>
									<select id="suppress" name="suppress" class="form-control" style="width:150px;">
										<option value="1">开启告警抑制</option>
						            	<option value="2">关闭告警抑制</option>
									</select>
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警码</span>
									<input type="text" id="code" name="code" class="form-control" style="width:150px;">
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警描述</span>
									<input type="text" id="desc" name="desc" class="form-control" style="width:150px;">
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">引发原因</span>
									<input type="text" id="cause" name="cause" class="form-control" style="width:150px;">
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">处理方式</span>
									<input type="text" id="treatment" name="treatment" class="form-control" style="width:150px;">
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">附加信息</span>
									<input type="text" id="addition" name="addition" class="form-control" style="width:150px;">
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">超时时间</span>
									<input type="text" id="autoClearTimeout" name="autoClearTimeout" class="form-control" style="width:150px;">
								</div>	
							</td>
							<td>
							
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="addInputAlarmData">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改告警数据模态框 -->
	<div class="modal fade" id="updateAlarmDataModal" role="dialog" data-backdrop="static">
		<div class="modal-dialog" style="width:550px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						&times;
					</button>
					<span class="modal-title" style="font-weight:bold;">修改告警数据</span>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<td style="padding-right:20px;">
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">设备名称</span>
									<select id="updateEquipType" name="updateEquipType" class="form-control" style="width:150px;">
									</select>
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警级别</span>
									<select id="updateSeverity" name="updateSeverity" class="form-control" style="width:150px;">
										<option value="1">紧急告警</option>
						            	<option value="2">重要告警</option>
						            	<option value="3">次要告警</option>
						            	<option value="4">警告告警</option>
						            	<option value="5">通知告警</option>
									</select>
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警类型</span>
									<select id="updateAlarmType" name="updateAlarmType" class="form-control" style="width:150px;">
										<option value="1">通讯告警</option>
						            	<option value="2">数据处理告警</option>
						            	<option value="3">环境告警</option>
						            	<option value="4">服务质量告警</option>
						            	<option value="5">设备告警</option>
						            	<option value="6">完整性告警</option>
						            	<option value="7">安全性告警</option>
						            	<option value="8">时区告警</option>
						            	<option value="9">操作告警</option>
						            	<option value="10">物理告警</option>
									</select>
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">自动清除</span>
									<select id="updateAutoClearEnable" name="updateAutoClearEnable" class="form-control" style="width:150px;">
										<option value="1">开启自动清除</option>
						            	<option value="2">关闭自动清除</option>
									</select>
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警抑制</span>
									<select id="updateSuppress" name="updateSuppress" class="form-control" style="width:150px;">
										<option value="1">开启告警抑制</option>
						            	<option value="2">关闭告警抑制</option>
									</select>
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警码</span>
									<input type="text" id="updateCode" name="updateCode" class="form-control" style="width:150px;">
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">告警描述</span>
									<input type="text" id="updateDesc" name="updateDesc" class="form-control" style="width:150px;">
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">引发原因</span>
									<input type="text" id="updateCause" name="updateCause" class="form-control" style="width:150px;">
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">处理方式</span>
									<input type="text" id="updateTreatment" name="updateTreatment" class="form-control" style="width:150px;">
								</div>
							</td>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">附加信息</span>
									<input type="text" id="updateAddition" name="updateAddition" class="form-control" style="width:150px;">
								</div>
							</td>
						</tr>
						<tr style="height:5px;"></tr>
						<tr>
							<td>
								<div class="input-group">
									<span class="input-group-addon" style="width:80px;">超时时间</span>
									<input type="text" id="updateAutoClearTimeout" name="updateAutoClearTimeout" class="form-control" style="width:150px;">
								</div>	
							</td>
							<td>
							
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="updateInputAlarmData">修改</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 操作按钮 -->
	<div id="toolbar">  
	    <div class="btn-group">  
	        <button class="btn btn-default" data-toggle="modal" data-target="#addAlarmDataModal">  
	            <i class="glyphicon glyphicon-plus"></i>添加  
	        </button>  
	        <button class="btn btn-default" onclick="deleteSelectedAlarmDatas()">  
	            <i class="glyphicon glyphicon-trash"></i>删除  
	        </button>
	        <button class="btn btn-default" onclick="openAlarmSuppression()" value="1">  
	            <i class="glyphicon glyphicon-folder-open"></i>&nbsp;开启告警抑制
	        </button>
	        <button class="btn btn-default" onclick="closeAlarmSuppression()" value="2">  
	            <i class="glyphicon glyphicon-folder-close"></i>&nbsp;关闭告警抑制
	        </button>
	        <button class="btn btn-default" data-toggle="modal" data-target="#importAlarmDatas">  
	            <i class="glyphicon glyphicon-import"></i>模版导入  
	        </button> 
	        <button class="btn btn-default" data-toggle="modal" data-target="#exportAlarmDatas">
	            <i class="glyphicon glyphicon-export"></i>模版导出  
	        </button>   
	    </div>  
	</div>  
	
	<!-- 告警数据管理Table -->
	<table id="alarmDataManageTable"></table>
	
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		
		$(function(){
			
			// 初始化Table
			var oTable = new TableInit();
			oTable.Init();
			
			//======================动态添加设备类型开始=================
			$.ajax({
				type: "GET",
				url:'<%=basePath%>alarmData/getDeviceType.do',
				success: function(data){
					var jsonObj = JSON.parse(data); 
					$.each(jsonObj,function(n,obj){
						var option	= '<option value="'+obj.deviceId+'">'+obj.deviceName+'</option>';
						$("#updateEquipType").append(option);
						$("#equipType").append(option);
					});
				}
			});
			//======================动态添加设备类型结束=================
			
			//=======================模版导入开始====================
			initUploadAlarmDataFile('alarmDataFile','<%=basePath%>alarmData/uploadAlarmDataZipPackage.do');
			$("#confirmAlarmDataFile").click(function(){
		    	var uploadFileName = $("#alarmDataFile").val();
		    	var fileExtension = uploadFileName.endsWith('.zip');
		    	if(fileExtension){
		    		$("#alarmDataFile").fileinput("upload");
		    	}else{
		    		$("#alarmDataFile").tips({
						side : 1,
						msg : '只能上传zip后缀的资源包',
						bg : '#68B500',
						time : 3
					});
		    	}
		    });
			$("#alarmDataFile").on("fileuploaded", function(event, data, previewId, index) {
		        alert("上传成功!");
		        $("#alarmDataImport").modal("hide");
		        //重新刷新当前页面
		        location = '<%=basePath%>alarmData/toAlarmDataPage.do';
		    });
			//=======================模版导入结束====================
				
			//=======================模版导出开始====================
			$("#confirmExportAlarmDatas").click(function(){
				//关闭模态框
				 $('#exportAlarmDatas').modal('hide');
				window.location.href='<%=basePath%>alarmData/exportAllAlarmDatas.do';
			});
			//=======================模版导出结束====================
				
			//=========================添加开始====================	
			$("#addInputAlarmData").click(function(){
				//首先是清空之前填写的数据
				$("#code").val("");
				$("#desc").val("");
				$("#cause").val("");
				$("#treatment").val("");
				$("#addition").val("");
				$("#autoClearTimeout").val("");
				$.ajax({
					type: "POST",
					url: '<%=basePath%>alarmData/saveAlarmData.do',
					data:{
						equipType: $("#equipType").val(),
						code: $("#code").val(),
						severity: $("#severity").val(),
						alarmType: $("#alarmType").val(),
						desc: $("#desc").val(),
						cause: $("#cause").val(),
						treatment: $("#treatment").val(),
						addition: $("#addition").val(),
						autoClearEnable: $("#autoClearEnable").val(),
						autoClearTimeout: $("#autoClearTimeout").val(),
						suppress: $("#suppress").val()
			    	},
					success: function(data){
						 $('#addAlarmDataModal').modal('hide');
						 $('#alarmDataManageTable').bootstrapTable('refresh', {url: '<%=basePath%>alarmData/getAlarmData.do'});
					}
				});
		    });	
			//=========================添加结束====================	

			//============================修改开始=====================
			$("#updateInputAlarmData").click(function(){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>alarmData/updateAlarmData.do',
					data:{
						equipType: $("#updateEquipType").val(),
						code: $("#updateCode").val(),
						severity: $("#updateSeverity").val(),
						alarmType: $("#updateAlarmType").val(),
						desc: $("#updateDesc").val(),
						cause: $("#updateCause").val(),
						treatment: $("#updateTreatment").val(),
						addition: $("#updateAddition").val(),
						autoClearEnable: $("#updateAutoClearEnable").val(),
						autoClearTimeout: $("#updateAutoClearTimeout").val(),
						suppress: $("#updateSuppress").val()
			    	},
					success: function(data){
						$('#updateAlarmDataModal').modal('hide');
						$('#alarmDataManageTable').bootstrapTable('refresh', {url: '<%=basePath%>alarmData/getAlarmData.do'});
					}
				});
			});
			//===========================修改结束=========================
				
		});
		
		//============================删除多选的数据开始=====================
		var sendSelectRows = [];
		function deleteSelectedAlarmDatas(){
			var selectRowDatas = $("#alarmDataManageTable").bootstrapTable('getSelections');
			if(selectRowDatas.length==0){
				$.alert({
				    title: '提示',
				    content: '请选择需要删除的数据!',
				    confirm: function(){
				    }
				});
				return false;
			}
			$.confirm({
                title: '<span style="font-size:14px;">提示</span>',
                content: '<span style="font-size:14px;font-weight:bold;color:red;">确认删除选中的告警数据吗?</span>',
                buttons: {
                    ok: {
                        text: "确定",
                        btnClass: 'btn-primary',
                        keys: ['enter'],
                        action: function(){
                			for(var i=0;i<selectRowDatas.length;i++){
                				sendSelectRows.push(selectRowDatas[i].code);
                			}
                			$.ajax({
                				type: 'POST',
                				url: '<%=basePath%>alarmData/deleteSelectAlarmDatas.do',
                				data: {"sendSelectRows":sendSelectRows},
                				traditional: true,
                				success: function(data){
                					$('#alarmDataManageTable').bootstrapTable('refresh', {url: '<%=basePath%>alarmData/getAlarmData.do'});
                				}
                			});
                        }
                    },
                    cancel: {
                        text: "取消",
                        btnClass: 'btn-default',
                        keys: ['esc'],
                        action:function () {
                        	
                        }
                    }
                }
            });
		}
		//===========================删除多选的数据结束=========================
		
		//============================开启多选的数据告警抑制开始=====================
		var openAlarmControlRows = [];
		function openAlarmSuppression(){
			var selectControlRowDatas = $("#alarmDataManageTable").bootstrapTable('getSelections');
			if(selectControlRowDatas.length==0){
				$.alert({
				    title: '提示',
				    content: '请选择需要开启告警抑制的数据!',
				    confirm: function(){
				    }
				});
				return false;
			}
			$.confirm({
                title: '<span style="font-size:14px;">提示</span>',
                content: '<span style="font-size:14px;font-weight:bold;">确认开启选中数据的告警抑制吗?</span>',
                buttons: {
                    ok: {
                        text: "确定",
                        btnClass: 'btn-primary',
                        keys: ['enter'],
                        action: function(){
                			for(var i=0;i<selectControlRowDatas.length;i++){
                				openAlarmControlRows.push(selectControlRowDatas[i].code);
                			}
                			$.ajax({
                				type: 'POST',
                				url: '<%=basePath%>alarmData/openAlarmSuppression.do',
                				data: {"openAlarmControlRows":openAlarmControlRows},
                				traditional: true,
                				success: function(data){
                					$('#alarmDataManageTable').bootstrapTable('refresh', {url: '<%=basePath%>alarmData/getAlarmData.do'});
                				}
                			});
                        }
                    },
                    cancel: {
                        text: "取消",
                        btnClass: 'btn-default',
                        keys: ['esc'],
                        action:function () {
                        	
                        }
                    }
                }
            });
			
		}
		//===========================开启多选的数据告警抑制结束======================
		
		//============================关闭多选的数据告警抑制开始=====================
		var closeAlarmControlRows = [];
		function closeAlarmSuppression(){
			var selectControlRowDatas = $("#alarmDataManageTable").bootstrapTable('getSelections');
			if(selectControlRowDatas.length==0){
				$.alert({
				    title: '提示',
				    content: '请选择需要关闭告警抑制的数据!',
				    confirm: function(){
				    }
				});
				return false;
			}
			$.confirm({
                title: '<span style="font-size:14px;">提示</span>',
                content: '<span style="font-size:14px;font-weight:bold;">确认关闭选中数据的告警抑制吗?</span>',
                buttons: {
                    ok: {
                        text: "确定",
                        btnClass: 'btn-primary',
                        keys: ['enter'],
                        action: function(){
                        	var selectControlRowDatas = $("#alarmDataManageTable").bootstrapTable('getSelections');
                			for(var i=0;i<selectControlRowDatas.length;i++){
                				closeAlarmControlRows.push(selectControlRowDatas[i].code);
                			}
                			$.ajax({
                				type: 'POST',
                				url: '<%=basePath%>alarmData/closeAlarmSuppression.do',
                				data: {"closeAlarmControlRows":closeAlarmControlRows},
                				traditional: true,
                				success: function(data){
                					$('#alarmDataManageTable').bootstrapTable('refresh', {url: '<%=basePath%>alarmData/getAlarmData.do'});
                				}
                			});
                        }
                    },
                    cancel: {
                        text: "取消",
                        btnClass: 'btn-default',
                        keys: ['esc'],
                        action:function () {
                        	
                        }
                    }
                }
            });
			
		}
		//===========================关闭多选的数据告警抑制结束======================
		
		function operateFormatter(value, row, index) {
			if(row.suppress=='1'){
		        return [
		        '<button id="closeSingleAlarmSupression" type="button" class="btn btn-info  btn-sm" style="margin-right:10px;">关闭告警抑制</button>',
		        '<button id="updateAlarmData" type="button" class="btn btn-info  btn-sm" style="margin-right:10px;">修改</button>',
		        '<button id="deleteAlarmData" type="button" class="btn btn-info  btn-sm">删除</button>'
		        ].join('');
			} else if(row.suppress=='2'){
	        	return [
		        '<button id="openSingleAlarmSupression" type="button" class="btn btn-info  btn-sm" style="margin-right:10px;">开启告警抑制</button>',
		        '<button id="updateAlarmData" type="button" class="btn btn-info  btn-sm" style="margin-right:10px;">修改</button>',
		        '<button id="deleteAlarmData" type="button" class="btn btn-info  btn-sm">删除</button>'
		        ].join('');
			} 
	    }
		window.operateEvents = {
			'click #closeSingleAlarmSupression': function (e, value, row, index) {
				$.confirm({
	                title: '<span style="font-size:14px;">提示</span>',
	                content: '<span style="font-size:14px;font-weight:bold;">确认关闭当前数据的告警抑制吗?</span>',
	                buttons: {
	                    ok: {
	                        text: "确定",
	                        btnClass: 'btn-primary',
	                        keys: ['enter'],
	                        action: function(){
	                        	var closeSingleData = [];
	            				closeSingleData.push(row.code);
	            				$.ajax({
	            					type: 'POST',
	            					url: '<%=basePath%>alarmData/closeAlarmSuppression.do',
	            					data: {"closeAlarmControlRows":closeSingleData},
	            					traditional: true,
	            					success: function(data){
	            						$('#alarmDataManageTable').bootstrapTable('refresh', {url: '<%=basePath%>alarmData/getAlarmData.do'});
	            					}
	            				});
	                        }
	                    },
	                    cancel: {
	                        text: "取消",
	                        btnClass: 'btn-default',
	                        keys: ['esc'],
	                        action:function () {
	                        	
	                        }
	                    }
	                }
	            });
         	},
            'click #openSingleAlarmSupression': function (e, value, row, index) {
            	$.confirm({
	                title: '<span style="font-size:14px;">提示</span>',
	                content: '<span style="font-size:14px;font-weight:bold;">确认开启当前数据的告警抑制吗?</span>',
	                buttons: {
	                    ok: {
	                        text: "确定",
	                        btnClass: 'btn-primary',
	                        keys: ['enter'],
	                        action: function(){
	                        	var openSingleData = [];
	            				openSingleData.push(row.code);
	                        	$.ajax({
	                				type: 'POST',
	                				url: '<%=basePath%>alarmData/openAlarmSuppression.do',
	                				data: {"closeAlarmControlRows":openSingleData},
	                				traditional: true,
	                				success: function(data){
	                					$('#alarmDataManageTable').bootstrapTable('refresh', {url: '<%=basePath%>alarmData/getAlarmData.do'});
	                				}
	                			}); 
	                        }
	                    },
	                    cancel: {
	                        text: "取消",
	                        btnClass: 'btn-default',
	                        keys: ['esc'],
	                        action:function () {
	                        	
	                        }
	                    }
	                }
	            });
         	},
            'click #updateAlarmData': function (e, value, row, index) {
            	$("#updateAlarmDataModal").modal('show');
           	 	$('#updateEquipType').val(row.equipType);
                $('#updateAutoClearEnable').val(row.autoClearEnable);
                $('#updateCode').val(row.code);
                $('#updateCause').val(row.cause);
                $('#updateAddition').val(row.addition);
                $('#updateSeverity').val(row.severity);
                $('#updateAlarmType').val(row.alarmType);
                $('#updateSuppress').val(row.suppress);
                $('#updateDesc').val(row.desc);
                $('#updateTreatment').val(row.treatment);
                $('#updateAutoClearTimeout').val(row.autoClearTimeout);
            	          
         	},
            'click #deleteAlarmData': function (e, value, row, index) {
            	$.confirm({
	                title: '<span style="font-size:14px;">提示</span>',
	                content: '<span style="font-size:14px;font-weight:bold;">确认删除当前数据吗?</span>',
	                buttons: {
	                    ok: {
	                        text: "确定",
	                        btnClass: 'btn-primary',
	                        keys: ['enter'],
	                        action: function(){
	                        	var deleteSingleData = [];
	            				deleteSingleData.push(row.code);
	                        	$.ajax({
	                				type: 'POST',
	                				url: '<%=basePath%>alarmData/deleteSelectAlarmDatas.do',
	                				data: {"sendSelectRows":deleteSingleData},
	                				traditional: true,
	                				success: function(data){
	                					$('#alarmDataManageTable').bootstrapTable('refresh', {url: '<%=basePath%>alarmData/getAlarmData.do'});
	                				}
	                			});
	                        }
	                    },
	                    cancel: {
	                        text: "取消",
	                        btnClass: 'btn-default',
	                        keys: ['esc'],
	                        action:function () {
	                        	
	                        }
	                    }
	                }
	            });
            }
	    };
		
		var TableInit = function() {
			var initObject = new Object();
			// 初始化Table
			initObject.Init = function() {
				//首先是所有的获取设备类型
				var deviceJsonObj;
				$.ajax({
					type: "GET",
					url:'<%=basePath%>alarmData/getDeviceType.do',
					success: function(data){
						deviceJsonObj = JSON.parse(data); 
					}
				});
				$('#alarmDataManageTable').bootstrapTable({
					url : '<%=basePath%>alarmData/getAlarmData.do', 									// 请求后台的URL（*）
					method : 'GET', 							// 请求方式（*）
					toolbar: '#toolbar',                		// 工具按钮用哪个容器
					striped : true, 							// 是否显示行间隔色
					cache : false, 								// 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
					pagination : true, 							// 是否显示分页（*）
					sortable : false, 							// 是否启用排序
					sortOrder : "asc", 							// 排序方式
					dataType : "json",
					queryParamsType:'',
					queryParams : function (params) {
	            		var temp = {   
            				pageNumber: params.pageNumber,
            				pageSize: params.pageSize
		            	};
		    		    return temp;
		            },
					sidePagination : "server", 					// 分页方式：client客户端分页，server服务端分页（*）
					pageNumber : 1, 							// 初始化加载第一页，默认第一页
					pageSize : 10, 								// 每页的记录行数（*）
					pageList : [10,30,50,80,100], 				// 可供选择的每页的行数（*）
					search : false, 							// 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
					showColumns : true, 						// 是否显示所有的列
					showRefresh : false, 						// 是否显示刷新按钮
					minimumCountColumns : 2, 					// 最少允许的列数
					clickToSelect : true, 						// 是否启用点击选中行
					height : 300, 								// 行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
					showToggle : true, 							// 是否显示详细视图和列表视图的切换按钮
					cardView : false, 							// 是否显示详细视图
					detailView : false, 						// 是否显示父子表
					columns : [
						{
		                    checkbox: true,  
		                    visible: true                  		// 是否显示复选框  
		                },
						{
							field : 'equipType',
							title : '设备类型',
							formatter : function (value, row, index) {
								var result;
								$.each(deviceJsonObj,function(n,obj){
									if(obj.deviceId==row.equipType){
										result = obj.deviceName;
										return false;
									}
								});
								return result;
				            }
						}, 
						{
							field : 'code',
							title : '告警码'
						}, 
						{
							field : 'severity',
							title : '告警级别',
							formatter : function (value, row, index) {
				                if (row.severity == "1") {
				                    return '紧急告警';
				                }
				                if (row.severity == "2") {
				                	return '重要告警';
				                }
				                if (row.severity == "3") {
				                	return '次要告警';
				                }
				                if (row.severity == "4") {
				                	return '警告告警';
				                }
				                if (row.severity == "5") {
				                	return '通知告警';
				                }
				                
				            }
						},
						{
							field : 'alarmType',
							title : '告警类型',
							formatter : function (value, row, index) {
				                if (row.alarmType == "1") {
				                    return '通讯告警';
				                }
				                if (row.alarmType == "2") {
				                	return '数据处理告警';
				                }
				                if (row.alarmType == "3") {
				                	return '环境告警';
				                }
				                if (row.alarmType == "4") {
				                	return '服务质量告警';
				                }
				                if (row.alarmType == "5") {
				                	return '设备告警';
				                }
				                if (row.alarmType == "6") {
				                    return '完整性告警';
				                }
				                if (row.alarmType == "7") {
				                	return '安全性告警';
				                }
				                if (row.alarmType == "8") {
				                	return '时区告警';
				                }
				                if (row.alarmType == "9") {
				                	return '操作告警';
				                }
				                if (row.alarmType == "10") {
				                	return '物理告警';
				                }
				                
				            }
						},
						{
							field : 'desc',
							title : '告警描述'
						},
						{
							field : 'cause',
							title : '可能的引发原因'
						},
						{
							field : 'treatment',
							title : '建议的处理方式'
						},
						{
							field : 'addition',
							title : '附加信息格式化表达式'
						},
						{
							field : 'autoClearEnable',
							title : '自动清除',
							formatter : function (value, row, index) {
				                if (row.autoClearEnable == "1") {
				                    return '<span class="label label-success">开启</span>';
				                }
				                if (row.autoClearEnable == "2") {
				                    return '<span class="label label-danger">关闭</span>';
				                }
				            }
						},
						{
							field : 'autoClearTimeout',
							title : '自动清除超时时间'
						},
						{
							field : 'suppress',
							title : '告警抑制',
							formatter : function (value, row, index) {
				                if (row.suppress == "1") {
				                    return '<span class="label label-success">开启</span>';
				                }
				                if (row.suppress == "2") {
				                    return '<span class="label label-danger">关闭</span>';
				                }
				            }
						},
						{
							field : 'operation',
							title : '操作',
							events: operateEvents,
			                formatter: operateFormatter
						}
					]
				});
			};
			return initObject;
		};
		
		//初始化模版导入的弹框
		function initUploadAlarmDataFile(controlName, uploadUrl) {
		    var control = $('#' + controlName);
		    control.fileinput({
		        language: 'zh', //设置语言
		        uploadUrl: uploadUrl, //上传的地址
		        uploadAsync: true, //默认异步上传
		        showCaption: true,//是否显示标题
		        showUpload: false, //是否显示上传按钮
		        maxFileCount: 1,//最大上传文件数限制
		        validateInitialCount:true,
		        fileActionSettings: {
		        	showRemove: false,
		        	showUpload: false
		        },
		        browseClass: "btn btn-primary", //按钮样式
		        allowedFileExtensions: [], //接收的文件后缀
		        previewFileIcon: {
                    'zip': '<i class="glyphicon glyphicon-file"></i>'
                },
		        showPreview: false //是否显示预览
		    });
		}

	</script>

</body>
</html>