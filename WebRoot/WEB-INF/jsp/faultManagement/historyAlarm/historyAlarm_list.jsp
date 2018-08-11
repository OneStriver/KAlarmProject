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
	<script type="text/javascript" src="static/js/common/jquery.bootstrap.teninedialog.v3.js"></script>

</head>
<body>

	<table>
		<tr>
			<td width="80%">
				<div style="border: 2px dotted green;margin-top:10px;padding: 0px 10px 10px 10px;">
					<div class="input-group" style="margin-top: 10px;">
						<span class="input-group-addon">开始时间</span>
						<input id="startDatetime" name="startDatetime" style="width: 160px;margin-right: 10px;" type="text" class="form-control">
						<span class="input-group-addon">结束时间</span>
						<input id="endDatetime" name="endDatetime" style="width: 160px;margin-right: 10px;" type="text" class="form-control">
						<span class="input-group-addon">告警级别</span>
						<select id="alarmLevel" name="alarmLevel" class="form-control" style="width: 120px;margin-right: 10px;">
						</select>
						<span class="input-group-addon">是否确认</span>
						<select id="isConfirm" name="isConfirm" class="form-control" style="width: 120px;margin-right: 10px;">
						</select>
						<span class="input-group-addon">是否清除</span>
						<select id="isClear" name="isClear" class="form-control" style="width: 120px;margin-right: 10px;">
						</select>
					</div>
				</div>
			</td>
			<td>
				<div class="input-group" style="margin-left:30px;">
					<span class="input-group-btn">
						<button class="btn btn-info" id="optionQuery">告警条件查询</button>
					</span>
			    </div>
			</td>
		</tr>
	</table>
	
	<div id="toolbar">
        <button class="btn btn-info" onclick="$('#exportAlarmModal').modal('show');"><span class="glyphicon glyphicon-share"></span>导出告警</button>  
        <button class="btn btn-danger" onclick="$('#deleteAlarmModal').modal('show');"><span class="glyphicon glyphicon-remove"></span>删除告警</button>
    </div>
    
    <div id="exportAlarmModal" class="modal fade" role="dialog" data-backdrop="static">
		<div class="modal-dialog" style="width: 400px;height:100px;">
			<div class="modal-content">
				<!-- 弹出框头部 -->
				<div class="modal-header">
					<h5 class="modal-title">
						<span id="lblAddTitle" style="font-weight: bold">导出时间</span>
					</h5>
				</div>
				<div class="modal-body">
					<div style="margin-left: 100px;">
						<select id="exportTime" class="form-control" style="width:130px;">  
			                <option value="1">当前告警</option>  
			                <option value="2">全部告警</option>  
			            </select>
		            </div>
				</div>
				<div class="modal-footer">
					<button id="exportAlarmLog" type="button" class="btn btn-primary">确定</button>
					<button type="button" class="btn green" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="deleteAlarmModal" class="modal fade" role="dialog" data-backdrop="static">
		<div class="modal-dialog" style="width: 400px;height:100px;">
			<div class="modal-content">
				<!-- 弹出框头部 -->
				<div class="modal-header">
					<h5 class="modal-title">
						<span id="lblAddTitle" style="font-weight: bold">删除时间</span>
					</h5>
				</div>
				<div class="modal-body">
					<div style="margin-left: 100px;">
						<select id="deleteTime" class="form-control" style="width:150px;">  
			                <option value="1">一周前告警</option>  
			                <option value="2">一个月前告警</option>  
			                <option value="3">三个月前告警</option>  
			                <option value="4">全部告警</option>  
			            </select>
		            </div>
				</div>
				<div class="modal-footer">
					<button id="deleteAlarmLog" type="button" class="btn btn-primary">确定</button>
					<button type="button" class="btn green" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
    
    <table id="historyAlarmTable"></table>
    
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		
		$(function(){
			//日历显示
			$.datepicker.regional['zh-CN'] = {
                changeMonth: true,
                changeYear: true,
                clearText: '清除',
                clearStatus: '清除已选日期',
                closeText: '关闭',
                closeStatus: '不改变当前选择',
                prevText: '<上月',
                prevStatus: '显示上月',
                prevBigText: '<<',
                prevBigStatus: '显示上一年',
                nextText: '下月>',
                nextStatus: '显示下月',
                nextBigText: '>>',
                nextBigStatus: '显示下一年',
                currentText: '今天',
                currentStatus: '显示本月',
                monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
                monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
                monthStatus: '选择月份',
                yearStatus: '选择年份',
                weekHeader: '周',
                weekStatus: '年内周次',
                dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
                dayNamesShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
                dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'],
                dayStatus: '设置 DD 为一周起始',
                dateStatus: '选择 m月 d日, DD',
                dateFormat: 'yy-mm-dd',
                firstDay: 1,
                initStatus: '请选择日期',
                isRTL: false
            };
			$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
			
			$('#startDatetime').prop("readonly", true).datetimepicker({
                timeText: '时间',
                hourText: '时',
                minuteText: '钟',
                secondText: '秒',
                currentText: '现在',
                closeText: '完成',
                showSecond: true, //显示秒  
                timeFormat: 'HH:mm:ss' //格式化时间  
            });
			
			$('#endDatetime').prop("readonly", true).datetimepicker({
                timeText: '时间',
                hourText: '小时',
                minuteText: '分钟',
                secondText: '秒',
                currentText: '现在',
                closeText: '完成',
                showSecond: true, //显示秒  
                timeFormat: 'HH:mm:ss' //格式化时间  
            });
			
		  	//初始化查询条件数据
			initOptionData();
			
			// 初始化Table
			var oTable = new TableInit();
			oTable.Init();
			
			$("#optionQuery").click(function(){
				$('#historyAlarmTable').bootstrapTable('refreshOptions',{
					pageNumber:1,
					pageSize:10,
					url: '<%=basePath%>historyAlarm/getOptionQueryAlarm.do'
				});
			});
			
			//============导出告警开始====================
			$("#exportAlarmLog").click(function(){
				window.location.href='<%=basePath%>historyAlarm/exportAlarm.do?'
									+'startDatetime='+$("#startDatetime").val()
									+'&endDatetime='+$("#endDatetime").val()
									+'&alarmLevel='+$("#alarmLevel").val()
									+'&deviceType='+$("#deviceType").val()
									+'&isConfirm='+$("#isConfirm").val()
									+'&isClear='+$("#isClear").val()
									+'&keyWord='+$("#keyWord").val()
									+'&exportTime='+$("#exportTime").val();
			});
			//============导出告警结束====================
			
			//============删除告警开始====================
			$("#deleteAlarmLog").click(function(){
				var optionParam = {
						deleteTime: $("#deleteTime").val()
		    	};
				$.ajax({
					type: "GET",
					url: '<%=basePath%>historyAlarm/deleteAlarm.do',
					dataType:"json",
					data: optionParam,
					success: function(data){
						$('#historyAlarmTable').bootstrapTable('refreshOptions',{pageNumber:1,pageSize:10});
				    	$('#historyAlarmTable').bootstrapTable('refresh', {url: '<%=basePath%>historyAlarm/getOptionQueryAlarm.do'});
						if(data=='0'){
							$.teninedialog({
			                    title:'操作提示',
			                    content:'<span style="font-size:15px;color:green;font-weight:bold;">删除告警成功！</span>'
			                });
						}else{
							$.teninedialog({
			                    title:'操作提示',
			                    content:'<span style="font-size:15px;color:red;font-weight:bold;">删除告警失败！</span>'
			                });
						}
					}
				});
			});
			//============删除告警结束====================
			
		});
		
		var TableInit = function() {
			var initObject = new Object();
			// 初始化Table
			initObject.Init = function() {
				$('#historyAlarmTable').bootstrapTable({
					url : '<%=basePath%>historyAlarm/getOptionQueryAlarm.do', 									// 请求后台的URL（*）
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
            				pageSize: params.pageSize,
	    		            startDatetime: $("#startDatetime").val(),
	    		            endDatetime: $("#endDatetime").val(),
	    		            alarmLevel: $("#alarmLevel").val(),
	    		            deviceType: $("#deviceType").val(),
	    		            isConfirm: $("#isConfirm").val(),
	    		            isClear: $("#isClear").val(),
	    		            keyWord: $("#keyWord").val()
		            	};
		    		    return temp;
		            },
					sidePagination : "server", 					// 分页方式：client客户端分页，server服务端分页（*）
					pageNumber : 1, 							// 初始化加载第一页，默认第一页
					pageSize : 10, 								// 每页的记录行数（*）
					pageList : [10,30,50,80,100], 				// 可供选择的每页的行数（*）
					search : false, 								// 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
					showColumns : true, 						// 是否显示所有的列
					showRefresh : false, 						// 是否显示刷新按钮
					minimumCountColumns : 2, 					// 最少允许的列数
					clickToSelect : true, 						// 是否启用点击选中行
					height : 500, 								// 行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
					showToggle : false, 						// 是否显示详细视图和列表视图的切换按钮
					cardView : false, 							// 是否显示详细视图
					detailView : false, 						// 是否显示父子表
					columns : [ 
						{
							field : 'alarmNumber',
							title : '告警序号'
						}, 
						{
							field : 'deviceName',
							title : '设备名称'
						}, 
						{
							field : 'alarmLevel',
							title : '告警级别'
						}, 
						{
							field : 'alarmDescription',
							title : '告警描述'
						},
						{
							field : 'alarmReason',
							title : '告警原因'
						},
						{
							field : 'recommendMeasure',
							title : '建议修复措施'
						},
						{
							field : 'alarmDetail',
							title : '告警详情'
						},
						{
							field : 'alarmHappenTime',
							title : '发生时间'
						},
						{
							field : 'alarmLastChangeTime',
							title : '最后更新时间'
						},
						{
							field : 'alarmAckTime',
							title : '确认时间'
						},
						{
							field : 'alarmAckPerson',
							title : '确认人'
						},
						{
							field : 'alarmClearTime',
							title : '清除时间'
						}, 
						{
							field : 'alarmClearPerson',
							title : '清除人'
						} 
					]
				});
			};
			return initObject;
		};

		//================初始化查询条件数据结开始====================
		function initOptionData(alarmLevel,deviceType,isConfirm,isClear) {
			
			var title	= ['请选择' ,'请选择','请选择','请选择'];
			$.each(title , function(k , v) {
				title[k] = '<option value="">'+v+'</option>';
			});
			
			$('#alarmLevel').append(title[0]);
			$('#deviceType').append(title[1]);
			$('#isConfirm').append(title[2]);
			$('#isClear').append(title[3]);
			
			if (alarmLevel,deviceType,isConfirm,isClear) {
				console.log("待处理的逻辑实现");
			} else {
				//加载告警等级数据
				$("#alarmLevel").append('<option value="1">紧急告警</option>');
				$("#alarmLevel").append('<option value="2">主要告警</option>');
				$("#alarmLevel").append('<option value="3">次要告警</option>');
				$("#alarmLevel").append('<option value="4">警告告警</option>');
				$("#alarmLevel").append('<option value="5">通知告警</option>');
				//加载设备类型数据
				$.ajax({
					type: "GET",
					url: '<%=basePath%>historyAlarm/getDeviceType.do',
					success: function(data){
						var jsonObj = JSON.parse(data); 
						$.each(jsonObj,function(n,obj){
							var option	= '<option value="'+obj.deviceId+'">'+obj.deviceName+'</option>';
							$("#deviceType").append(option);
						});
					}
				});
				//加载是否确认的数据
				$("#isConfirm").append('<option value="1">未确认</option>');
				$("#isConfirm").append('<option value="2">已确认</option>');
				//加载是否清除的数据
				$("#isClear").append('<option value="1">未清除</option>');
				$("#isClear").append('<option value="2">已清除</option>');
			}
		}
		//================初始化查询条件数据结束====================
		
		
	</script>

</body>
</html>