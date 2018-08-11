<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String addressAndPort = request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<base href="<%=path%>">
<base href="<%=addressAndPort%>">

	<!-- jsp文件头和头部 -->
	<%@ include file="top.jsp"%>
	<style type="text/css">
	.commitopacity{
		position:absolute;
		width:100%;
		height:100px;
		background:#7f7f7f;
		filter:alpha(opacity=50);
		-moz-opacity:0.8;
		-khtml-opacity: 0.5;
		opacity: 0.5;
		top:0px;
		z-index:99999;
	}
	.jzts{
		position: fixed;
	    left: 50%;
	    top: 50%;
	    width: 100%;
	    height: 200px;
	    margin: -45px 190px 0px 0px;
	}
	
	* {
		margin: 0;
		padding: 0;
	}
	
	#pop {
		background: #fff;
		width: 260px;
		border: 1px solid #e0e0e0;
		font-size: 12px;
		position: fixed;
		right: 10px;
		bottom: 10px;
	}
	
	#popHead {
		line-height: 32px;
		background: #f6f0f3;
		border-bottom: 1px solid #e0e0e0;
		position: relative;
		font-size: 12px;
		padding: 0 0 0 10px;
	}
	
	#popHead h2 {
		font-size: 14px;
		color: #666;
		line-height: 32px;
		height: 32px;
	}
	
	#popHead #popClose {
		position: absolute;
		right: 10px;
		top: 1px;
	}
	
	#popHead a#popClose:hover {
		color: #f00;
		cursor: pointer;
	}
	
	#popContent {
		padding: 5px 10px;
	}
	
	#popIntro {
		text-indent: 24px;
		line-height: 160%;
		margin: 5px 0;
		color: #666;
	}
	
	#popMore {
		text-align: right;
		border-top: 1px dotted #ccc;
		line-height: 24px;
		margin: 8px 0 0 0;
	}
	
	#popMore a {
		color: #f60;
	}
	
	#popMore a:hover {
		color: #f00;
	}
	
	</style>

	<!-- 弹窗CSS  -->
	<link type="text/css" rel="stylesheet" href="plugins/attention/drag/style.css"  />
	<!-- ace的CSS -->
	<link type="text/css" rel="stylesheet" href="static/ace/css/ace.onpage-help.css" />
	<link type="text/css" rel="stylesheet" href="static/css/bootstrap.min.css" />
	<link type="text/css" rel="stylesheet" href="static/css/font-awesome.css" />
	<link type="text/css" rel="stylesheet" href="static/css/style.css" />
	<link type="text/css" rel="stylesheet" href="static/css/jquery.growl.css" />
	<link type="text/css" rel="stylesheet" href="static/css/toastr.css" />
	
	<script type="text/javascript" src="static/js/jquery.min.js"></script>
	<script type="text/javascript" src="static/js/common/script.js"></script>
	<script type="text/javascript" src="static/js/jquery.growl.js"></script>
	<script type="text/javascript" src="static/js/toastr.js"></script>
	
</head>

<body>
	
	<nav class="navbar navbar-primary" role="navigation">
	    <div class="container-fluid">
		  <div class="navbar-header" style="padding:10px 10px 10px 10px;">
		     <span style="color: white;font-size: 16px;"><i class="fa fa-leaf"></i>设备告警管理系统</span>
		  </div>
		    
		  <div class="content">
		  	<ul class="nav navbar-nav venus-menu" >
		  		<c:forEach items="${menuList}" var="menu1">
		    		<li id="one${menu1.MENU_ID }">
		    			<a href="javascript:void(0)">
		                    <i class="${menu1.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu1.MENU_ICON}"></i>${menu1.MENU_NAME }
		                </a>
		                <c:if test="${'[]' != menu1.subMenu}">
		                	<ul>
		                		<c:forEach items="${menu1.subMenu}" var="menu2">
	                				<li id="two${menu2.MENU_ID }">
	                					<a href="javascript:void(0)" <c:if test="${not empty menu2.MENU_URL && '#' != menu2.MENU_URL}">target="mainFrame" onclick="siMenu('two${menu2.MENU_ID }','one${menu1.MENU_ID }','${menu2.MENU_NAME }','${menu2.MENU_URL }')"</c:if>>
											<i class="${menu2.MENU_ICON == null ? 'menu-icon fa fa-leaf black' : menu2.MENU_ICON}"></i>${menu2.MENU_NAME }
						                </a>
	                				</li>
		                		</c:forEach>
			                 </ul>
		                </c:if>
		    		</li>
		    	 </c:forEach>
			 </ul>
		   </div>
	    </div>
	</nav>	
	
	
	<div class="main-container" id="main-container">
		<!-- 显示内容 -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">	
						<!-- 进度条  -->
						<div id="jzts" style="display:none; width:100%; position:fixed; z-index:99999999;">
							<div class="commitopacity" id="bkbgjz"></div>
							<div class="jzts">
								<div style="float: left;margin-top: 3px;"><img src="static/images/loadingi.gif" /> </div>
								<div style="margin-top: 6px;"><h4 class="lighter block red">&nbsp;加载中 </h4></div>
							</div>
						</div>
						<div>
							<iframe name="mainFrame" id="mainFrame" src="tab.do" style="margin:0 auto;width:100%;height:100%;">
								
							</iframe>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- 页面底部js¨ -->
	<%@ include file="foot.jsp"%>
	
	<!-- ace scripts start -->
	<script src="static/ace/js/ace/elements.scroller.js"></script>
	<script src="static/ace/js/ace/elements.colorpicker.js"></script>
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
	<script src="static/ace/js/ace/elements.typeahead.js"></script>
	<script src="static/ace/js/ace/elements.wysiwyg.js"></script>
	<script src="static/ace/js/ace/elements.spinner.js"></script>
	<script src="static/ace/js/ace/elements.treeview.js"></script>
	<script src="static/ace/js/ace/elements.wizard.js"></script>
	<script src="static/ace/js/ace/elements.aside.js"></script>
	<script src="static/ace/js/ace/ace.js"></script>
	<script src="static/ace/js/ace/ace.ajax-content.js"></script>
	<script src="static/ace/js/ace/ace.touch-drag.js"></script>
	<script src="static/ace/js/ace/ace.sidebar.js"></script>
	<script src="static/ace/js/ace/ace.sidebar-scroll-1.js"></script>
	<script src="static/ace/js/ace/ace.submenu-hover.js"></script>
	<script src="static/ace/js/ace/ace.widget-box.js"></script>
	<script src="static/ace/js/ace/ace.settings.js"></script>
	<script src="static/ace/js/ace/ace.settings-rtl.js"></script>
	<script src="static/ace/js/ace/ace.settings-skin.js"></script>
	<script src="static/ace/js/ace/ace.widget-on-reload.js"></script>
	<script src="static/ace/js/ace/ace.searchbox-autocomplete.js"></script>

	<script type="text/javascript"> ace.vars['base'] = '..'; </script>
	<script src="static/ace/js/ace/elements.onpage-help.js"></script>
	<script src="static/ace/js/ace/ace.onpage-help.js"></script>
	<!-- ace scripts end -->

	<!--引入自定义的js -->
	<script type="text/javascript" src="static/js/myjs/head.js"></script>
	<script type="text/javascript" src="static/js/myjs/index.js"></script>
	
	<!--引入弹窗组件1start-->
	<script type="text/javascript" src="plugins/attention/drag/drag.js"></script>
	<script type="text/javascript" src="plugins/attention/drag/dialog.js"></script>
	<!--引入弹窗组件1end-->
	
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
</body>
</html>