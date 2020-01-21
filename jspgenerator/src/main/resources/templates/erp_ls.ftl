<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>[=tableName]</title>
	<meta name="description" content="">
	<meta name="author" content="templatemo">
@@include("../partials/ls-head.html")
</head>
<!--#
<east:service beanName="eastUtilService" methodName="setValue" id="_pageNo">
	<east:para name="_val" value="${requestEx.pageNo}" type="Object" />
	<east:para name="_default_val" value="1" type="Object" />
</east:service>
<east:service beanName="eastUtilService" methodName="setValue" id="_pageSize">
	<east:para name="_val" value="${requestEx.pageSize}" type="Object" />
	<east:para name="_default_val" value="10" type="Object" />
</east:service>
#-->

<!--#
<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="createBeanExByClassName" id="[=tableNo]">
	<east:para name="className" value="[=tableNo]" type="String" />
</east:service>
<east:service beanName="eastUtilService" methodName="setValue" id="tn[=tableNoWithoutCol]">
	<east:para name="_tableName" value="${[=tableNo].externTable}" type="Object" />
	<east:para name="_default" value="t_news" type="Object" />
</east:service>

<s:if test="${requestEx.keyWord ne null && requestEx.keyWord ne ''}">
	<east:service beanName="eastUtilService" methodName="replaceStr" id="requestEx.keyWord">
		<east:para name="_sVal" value="${requestEx.keyWord}" type="String" />
		<east:para name="_sReplaced" value="%" type="String" />
		<east:para name="_sReplaceNew" value="\%" type="String" />
	</east:service>
	<east:service beanName="eastUtilService" methodName="replaceStr" id="requestEx.keyWord">
		<east:para name="_sVal" value="${requestEx.keyWord}" type="String" />
		<east:para name="_sReplaced" value="." type="String" />
		<east:para name="_sReplaceNew" value="\." type="String" />
	</east:service>
	<east:service beanName="eastUtilService" methodName="setValue" id="_whereKeyWord">
		<east:para name="_val" value="AND (t1.${[=tableNo].extKeepName.[=firstColumnName]} LIKE '%${requestEx.keyWord}%'
			OR t1.${[=tableNo].extKeepName.[=secondColumnName]} LIKE '%${requestEx.keyWord}%')" type="Object" />
	</east:service>
</s:if>

<!--#<JREMOVE>
<s:if test="${requestEx.startDate ne null && requestEx.startDate ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="_whereStartDate">
		<east:para name="_val" value="AND t1.${[=tableNo].extKeepName.capplyDate} >= '${requestEx.startDate}'" type="Object" />
	</east:service>
</s:if>

<s:if test="${requestEx.endDate ne null && requestEx.endDate ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="_whereEndDate">
		<east:para name="_val" value="AND t1.${[=tableNo].extKeepName.capplyDate} <= '${requestEx.endDate}'" type="Object" />
	</east:service>
</s:if>

<s:if test="${requestEx.cstatus ne null && requestEx.cstatus ne ''}">
	<east:service beanName="eastUtilService" methodName="setValue" id="_whereStatus">
		<east:para name="_val" value="AND t1.${[=tableNo].extKeepName.cstatus} = '${requestEx.cstatus}'" type="Object" />
	</east:service>
</s:if>
</JREMOVE>#-->


<east:service beanName="eastUtilService" methodName="setValue" id="_fromIndex">
	<east:para name="_val" value="${_pageSize * (_pageNo - 1)}" type="Object" />
</east:service>

<east:service beanName="pmsService" methodName="nativeQuerySqlMap" id="_[=searchResultName]">
	<east:para name="nativeSql" value="SELECT t1.id AS id
<#list columns as column>
			,t1.${[=tableNo].extKeepName.[=column.columnName]} AS [=column.columnName]
</#list>
		FROM ${tn[=tableNoWithoutCol]} t1
		WHERE t1.${[=tableNo].keepName.newsClass} = '[=tableNo]'
			AND t1.column_id=1603
			${_whereKeyWord}
		ORDER BY t1.id DESC
		LIMIT ${_fromIndex},${_pageSize}
		"
		type="String" />
	<east:para name="_out_nodes_name" value="id<#list columns as column>,[=column.columnName]</#list>" type="String" />
	<east:para name="token" value="123qweasd" type="String" />
</east:service>

<east:service beanName="pmsService" methodName="nativeQuerySqlMap" id="_rsPagination">
	<east:para name="nativeSql" value="SELECT count('1') AS totalRecords
			, CEIL(count('1')/${_pageSize}) AS totalPages
		FROM (
			SELECT t1.id
			FROM ${tn[=tableNoWithoutCol]} t1
			WHERE t1.${[=tableNo].keepName.newsClass} = '[=tableNo]'
				AND t1.column_id=1603
				${_whereKeyWord}
		) pv
		"
		type="String" />
	<east:para name="_out_nodes_name" value="totalRecords,totalPages" type="String" />
	<east:para name="token" value="123qweasd" type="String" />
</east:service>
#-->

<!--#
<MACRO>
	Jsp.call("/[=projectName]_jsp/[=projectName]_module_html/calculate_pagination_for_original_sql.jsp","${_rsPagination}","${_pageNo}");
	Jsp.result("totalRecords","totalPages","pagePrev","pageNext","pageOne","pageTwo","pageThree","pageFour","pageFive","pageSix","pageSeven");
</MACRO>
#-->
<!--#
<#list columns as column>
<#if column.type == "1">
<east:service beanName="pmsService.pmsDaoImpl.daoBsDataDic" methodName="getNewsDicClassNameChildrenEx" id="[=column.refClassName]">
	<east:para name="className" value="[=column.refClassName]" type="String" />
</east:service>
</#if>
</#list>
#-->
<body>
	<div class="templatemo-flex-row">
		<!--#<JREMOVE>#-->
		<div class="templatemo-sidebar">
			<header class="templatemo-site-header">
				<div class="square"></div>
			</header>
			<div class="mobile-menu-icon">
				<i class="fa fa-bars"></i>
			</div>
			<dl class="templatemo-left-nav bss_leftmenu">
				<dd>
					<a href="../[=projectName]_erp_html/index.html" class="bss_title active" >
						<i class="fa fa-home icon_left"></i>首页
					</a>
				</dd>
				<dd>
					<a class="bss_title">
						<i class="fa fa-cog icon_left"></i>系统设置
					</a>
					<ul style="display: none;" class="bss_menuson">
						<a href="../[=projectName]_erp_html/ls_city.html">城市</a>
					</ul>
				</dd>
			</dl>
		</div>
		<!--#</JREMOVE>#-->
		<!-- Main content -->
		<div class="templatemo-content col-1 light-gray-bg">
			<!--#<JREMOVE>#-->
			<div class="templatemo-top-nav-container">
				<div class="row">
					<nav class="templatemo-top-nav col-lg-12 col-md-12">
						<ul class="text-uppercase">
							<li>
								<a href="../[=projectName]_erp_html/index.html" >
									<i class="fa fa-home fa-4x icon_top"></i>
									<p style="width: 100%;text-align: center;">首页</p>
								</a>
								<i></i>
							</li>
						</ul>
					</nav> 
				</div>
			</div>
			<!--#</JREMOVE>#-->
			<div class="templatemo-content-container">
				<!--#
				<MACRO>
					Jsp.call("/[=projectName]_jsp/[=projectName]_erp_html/frame_title_login_bar.jsp","[=tableName]");
				</MACRO>
				#-->			
				<!--#<JREMOVE>#-->
				<div class="div_top_header">
					<h4>首页
						<div class="dropdown">
							<a data-toggle="dropdown" href="#">个人中心</a>
							<ul class="div_top_user dropdown-menu" role="menu" aria-labelledby="dLabel">
								<li>
									<a data-toggle="modal" data-target="#myModal_03" href="#">
									<i class="fa fa-pencil"></i>个人信息</a>
								</li>
								<li>
									<a data-toggle="modal" data-target="#myModal_04" href="#">
									<i class="fa fa-cogs"></i>修改密码</a>
								</li>
								<li class="li_divider"></li>
								<li>
									<a href="#" id="idLoginOut">
									<i class="fa fa-sign-out" ></i>退出</a>
								</li>
							</ul>
						</div>
						<span>XX，您好</span>
					</h4>
				</div>
				<!--#</JREMOVE>#-->
				<!--内容部分开始-->
				<div class="div_tableList">
					<div style="padding: 20px;width: 70%;float: left;">
						<form id="searchForm" action="../[=projectName]_erp_html/[=listFileName].html" method="post" enctype="multipart/form-data">
							<input type="text" name="keyWord" value="${requestEx.keyWord}" style="width: 100px;float: left;margin-right: 15px;height: 38px;" class="form-control" placeholder="关键字" />
							
							<!--#<JREMOVE>
							<p style="float: left;font-size: 16px;margin: 0;margin-right: 10px;line-height: 38px;">申请日期</p>
							<input type="text" style="width: 120px;float: left;margin-right: 15px;height: 38px;" class="form-control" name="startDate" id="startDate" onclick="WdatePicker({isShowClear:true,errDealMode:2,readOnly:true,dateFmt:'yyyy-MM-dd'});return false;" value="${requestEx.startDate}" readonly="readonly"/>
							<p style="float: left;font-size: 16px;margin: 0 10px;line-height: 38px;">~</p>
							<input type="text" style="width: 120px;float: left;margin-right: 15px;height: 38px;" class="form-control" name="endDate" id="endDate" onclick="WdatePicker({isShowClear:true,errDealMode:2,readOnly:true,dateFmt:'yyyy-MM-dd'});return false;" value="${requestEx.endDate}" readonly="readonly"/>
							
							
							<p style="float: left;font-size: 16px;margin: 0;margin-right: 10px;line-height: 38px;">审核状态</p>
							<select name="ccheckState" id="ccheckState" style="float: left;height: 38px;margin-right: 15px;width: 110px;" class="form-control" >
								<option value="">全部</option>
								<c:forEach items="${dicCheckState}" var="_dicOne" varStatus="_dicStatus">
									<s:if test="${_dicOne.dicVal eq requestEx.ccheckState}">
										<option value="${_dicOne.dicVal}" selected="selected">${_dicOne.dicName}</option>
									</s:if>
									<s:else>
										<option value="${_dicOne.dicVal}">${_dicOne.dicName}</option>
									</s:else>
								</c:forEach>
							</select>
							</JREMOVE>#-->

							<span style="float: left;margin-left: 20px;" class="input-group-btn">
								<a href="#" id="btnSearch" class="btn btn-success" style="padding: 8px 12px;">查找</a>
							</span>
							
							<input type="hidden" name="pageNo" id="pageNo" value="${_pageNo}" />
							<input type="hidden" name="pageSize" id="pageSize" value="${_pageSize}" />
							<input name="totalPage" type="hidden" id="totalPage" value="${totalPages}" />
						</form>
					</div>

					<div style="padding:20px;float: right;">
						<a id="btnNew" class="bs_a_bar_btn bs_color_wihte bs_bk_green_1B">新建</a>
						<a id="btnEdit" class="bs_a_bar_btn bs_color_wihte bs_bk_belu_7E">修改</a>
						<a id="btnDelete" class="bs_a_bar_btn bs_color_wihte bs_bk_red">删除</a>
						<!--#<JREMOVE>
						<a id="btnSnap" class="bs_a_bar_btn bs_color_wihte bs_bk_purple">快照</a>
						</JREMOVE>#-->
					</div>
					<table id="searchResult" cellpadding="6" cellspacing="0">
						<thead>
							<tr>
								<!--#<JREMOVE>
								class="can_order" data-order-by="camount" data-asc-desc="" data-ext-is-number="0"
								</JREMOVE>#-->
								<th style="min-width:20px"></th>
								<th>序号</th>
								<#list columns as column>
								<th>[=column.columnCaption]</th> 
								</#list>
							</tr>
						</thead>
						<tbody>

						<!--#<JREMOVE>
						<east:service beanName="eastUtilService" methodName="htmlRemove" id="_subMemo">
							<east:para name="_html" value="${_one.cmemo}" type="String" />
							<east:para name="_nMaxLen" value="60" type="Integer" />
						</east:service>
						<td title="${_one.cmemo}">${_subMemo}</td>

						<td>
							<c:forEach items="${dicStatus}" var="_dicOne" varStatus="_dicStatus">
								<s:if test="${_dicOne.dicVal eq _one.cstatus}">
									${_dicOne.dicName}
								</s:if>
							</c:forEach>
						</td>
						<td><fmt:formatNumber value="${_one.creservedAmount}"/></td>
						
						<td><img src="<%=basePath%>${_one.cavatar}" style="height:25px;width:30px;"/></td>
						
						<east:service beanName="eastUtilService" methodName="splitString" id="lsImage">
							<east:para name="_sStr" value="${_one.cimage}" type="String" />
							<east:para name="_linkLetter" value=";" type="String" />
						</east:service>
						<td class="td_action">
							<a name="btnPopImage" data-id="${_one.id}">${fn:length(lsImage)}</a>
						</td>
						
						<td class="td_action">
							<a name="btnPopVideo" data-video="${_one.cvideo}">播放</a>
						</td>
						</JREMOVE>#-->
							
						<!--#
						<s:if test="${_[=searchResultName] != null && fn:length(_[=searchResultName]) > 0}">		
							<c:forEach items="${_[=searchResultName]}" var="_one" varStatus="_status">
								<tr id="idTR${_one.id}" data-id="${_one.id}">
									<td><input name="checkboxData" type="checkbox" value="${_one.id}" onclick="onCheckboxId(this);" /></td>
									<td>${(_pageNo - 1) * _pageSize + _status.index + 1}</td>
									<#list columns as column>
									<td>${_one.[=column.columnName]}</td>
									</#list>
								</tr>
							</c:forEach>
						</s:if>
						#-->												
							
							<!--#<JREMOVE>#-->
							<tr>
								<td><input name="checkboxData" type="checkbox" /></td>
								<td>1</td>
							</tr>
							<!--#</JREMOVE>#-->
						</tbody>
					</table>
					<div class="div_bottom">
						<!--#
						<MACRO>
							Jsp.call("/[=projectName]_jsp/[=projectName]_module_html/erp_display_pagination.jsp","${_pageNo}","1","${pagePrev}","${pageOne}","${pageTwo}","${pageThree}","${pageFour}","${pageFive}","${pageSix}","${pageNext}","${totalPages}","${totalRecords}");
						</MACRO>
						#-->
						<!--#<JREMOVE>#-->
						<p>第1页,共20页</p>
						<div>
							<a href="#">第一页</a>
							<a href="#">上一页</a>
							<a href="#" class="a_active">1</a>
							<a href="#">2</a>
							<a href="#">3</a>
							<a href="#">4</a>
							<a href="#">5</a>
							<span>...</span>
							<a href="#">下一页</a>
							<a href="#">最后一页</a>
						</div>
						<!--#</JREMOVE>#-->
					</div>
				</div>
				<!--内容部分结束-->
			</div>
		</div>
	</div>
	
	<!--#<JREMOVE>#-->
	<div class="modal fade" id="myModal_03" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">个人信息</h4>
				</div>
				<div class="modal-body">
					<p>姓名 : 管理高级权限</p>
					<p>电话 : 17896543210</p>
					<p>公司名称 : 官方</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal_04" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改密码</h4>
				</div>
				<div class="modal-body">
					<div>
						<label for="cpass">
							<p><b>*</b>原密码：</p>
						</label>
						<input placeholder="请输入原密码" id="cpass" type="text">
					</div>
					<div>
						<label for="cpassNew">
							<p><b>*</b>新密码：</p>
						</label>
						<input placeholder="密码必须是6-16位字母+数字组合!" id="cpassNew" type="text">
					</div>
					<div>
						<label for="cpassNext" for="cNoticeTitle">
							<p><b>*</b>确认密码：</p>
						</label>
						<input placeholder="确认密码" id="cpassNext" type="text">
					</div>
				</div>
														
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary">提交</button>
				</div>
			</div>
		</div>
	</div>
	<!--#</JREMOVE>#-->
	
	<script>
		var searchForm = $('#searchForm');
		function search() {
			searchForm.submit();
		}
		$(function() {
			$('#btnSearch').on('click', function(){
				$('#pageNo').val('1');
				search();
			});
		});
		function searchByPage(_page_no){
			var intPageNo = parseInt(_page_no),
				intTotalPage = parseInt($('#totalPage').val());
			if (intPageNo > intTotalPage) {
				intPageNo = intTotalPage;
			}
			if (intPageNo < 1) {
				intPageNo = '1';
			}
			$('#pageNo').val(intPageNo);
			search();
			return false;
		}
	</script>
	<script>
		$(function() {
			$('#btnNew').click(function() {
				var id = 0;
				__JdialogEx('[=tableName]','<%=basePath%>bs_ajaxIndex![=projectName]![=projectName]_erp_html![=popFileName].do?id='+id,
					600,450,
					function(_resp){
						search();
					},
					65538,
					function(_resp){}
				);
					return false;
			});// end btnNew
			
			$('#btnEdit').click(function() {
				var id = __Jselect_checkedEx('checkboxData'); 
				if(id == ''){
					return false;
				}
				
				__JdialogEx('[=tableName]','<%=basePath%>bs_ajaxIndex![=projectName]![=projectName]_erp_html![=popFileName].do?id='+id,
					600,450,
					function(_resp){
						search();
					},
					65538,
					function(_resp){}
				);
				return false;
			});// end btnEdit

			$('#btnDelete').click(function() {
				var id = __Jselect_checkedEx('checkboxData'); 
				if(id == ''){
					return false;
				}
				alertify.confirm('确认删除吗?',function (e){ 
					if(e){
						var _url = '<%=basePath%>bs_ajaxIndex![=projectName]![=projectName]_controls_html!common_delete_by_ids.do';
						var _url_para = {
							"ids":id,
							"tableName":"[=tableNo]"
						};
						$AjaxPostASyn(_url,_url_para,
							function(_resp){
								var jsonResp = JSON.parse(_resp);
								if(jsonResp.state == 'success'){
									alertify.alert('处理成功!',function(_msg){
										search();
									});
								} else {
									alertify.alert(jsonResp.msg); 
								}
							},									
							function(_resp){
						}); 
					}
				});	
				return false;
			});//end of btnDelete

			/*#<JREMOVE>				
			$('#btnSnap').click(function() {
				var id = __Jselect_checkedEx('checkboxData'); 
				if(id == ''){
					return false;
				}
				
				__JdialogEx('历史快照','<%=basePath%>bs_ajaxIndex![=projectName]![=projectName]_erp_html!common_pop_snap.do?tableName=[=tableNo]&id='+id,
					800,750,
					function(_resp){
					},
					65538,
					function(_resp){}
				);
				return false;
			});// end btnSnap
			$('#searchResult tbody a[name="btnPopImage"]').on('click', function(){
				var id = $(this).data('id');
				
				__JdialogEx('查看图片','<%=basePath%>bs_ajaxIndex![=projectName]![=projectName]_erp_html!common_show_many_picture.do?tableName=[=tableNo]&columnName=cimage&id='+id,
					560,400,
					function(_resp){
					},
					65538,
					function(_resp){}
				);
				return false;
			}) // end btnPopImage

			$('#searchResult tbody img').on('click', function(){
				var imgFullUrl = encodeURIComponent($(this).prop('src'));
				__JdialogEx('查看图片','<%=basePath%>bsnms_ajaxIndex![=projectName]![=projectName]_erp_html!common_show_picture.do?imgFullUrl='+imgFullUrl,
					560,400,
					function(_resp){
					},
					65538,
					function(_resp){}
				);
				return false;
			});//end of table img

			$('#searchResult tbody a[name="btnPopVideo"]').on('click', function(){
				var videoFullUrl = encodeURIComponent($(this).data('video'));
				
				__JdialogEx('查看视频','<%=basePath%>bs_ajaxIndex![=projectName]![=projectName]_erp_html!common_show_video.do?videoFullUrl='+videoFullUrl,
					560,400,
					function(_resp){
					},
					65538,
					function(_resp){}
				);
				return false;
			}) // end btnPopVideo
			</JREMOVE>#*/
		});
	</script> 
</body>
</html>
