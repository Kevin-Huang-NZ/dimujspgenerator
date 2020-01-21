<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>[=tableName]</title>
	<meta name="description" content="">
	<meta name="author" content="templatemo">
@@include("../partials/pop-head.html")
</head>

<!--#
<#list columns as column>
<#if column.type == "1">
<east:service beanName="pmsService.pmsDaoImpl.daoBsDataDic" methodName="getNewsDicClassNameChildrenEx" id="[=column.refClassName]">
	<east:para name="className" value="[=column.refClassName]" type="String" />
</east:service>
</#if>
</#list>
#-->

<!--#
<s:if test="${requestEx.id ne 0}">
	<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="getOneByIdAlwaysWithClass" id="_[=beanName]">
		<east:para name="tnewsid" value="${requestEx.id}" type="String" />
		<east:para name="className" value="[=tableNo]" type="String" />
	</east:service>
</s:if>
<s:else>
	<east:service beanName="pmsService.pmsDaoImpl.daoBsNewsInfo" methodName="createBeanExByClassName" id="_[=beanName]">
		<east:para name="className" value="[=tableNo]" type="String" />
	</east:service>
</s:else>
#-->
<!--#
<JREMOVE>
<s:if test="${requestEx.id ne 0}">
	<east:service beanName="eastUtilService" methodName="setValue" id="defaultStatus">
		<east:para name="_value" value="${_[=beanName].ext.cstatus}" type="Object" />
	</east:service>
</s:if>
<s:else>
	<east:service beanName="eastUtilService" methodName="setValue" id="defaultStatus">
		<east:para name="_value" value="1" type="Object" />
	</east:service>
</s:else>
</JREMOVE>
#-->

<body>
	<div class="" id="" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog">
			<form name="frmSubmit" id="frmSubmit" enctype="multipart/form-data" method="post" action="<%=basePath%>admin/east_ajax_do_add_news_no_pass.do" autocomplete="off">
				<input type="hidden" name="id" value="${requestEx.id}" />
				<div class="">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">[=tableName]</h4>
					</div>
					<div class="modal-body">
					
						<#list columns as column>
						<div>
							<label for="[=column.columnName]">
								<p><b>*</b>[=column.columnCaption]：</p>
							</label>
						<#if column.type == "1">
							<select id="[=column.columnName]" name="[=column.columnName]">
								<option value="">请选择...</option>
								<c:forEach items="${[=column.refClassName]}" var="_oneDic" varStatus="_statusDic">
									<s:if test="${_oneDic.dicVal eq _[=beanName].ext.[=column.columnName]}">
										<option value="${_oneDic.dicVal}" selected="selected">${_oneDic.dicName}</option>
									</s:if>
									<s:else>
										<option value="${_oneDic.dicVal}">${_oneDic.dicName}</option>
									</s:else>
								</c:forEach>
							</select>
						<#else>
							<input type="text" id="[=column.columnName]" name="[=column.columnName]" value="${_[=beanName].ext.[=column.columnName]}" />
						</#if>
						</div>
						</#list>

						<!--#
						<JREMOVE>
						onclick="WdatePicker({isShowClear:true,errDealMode:2,readOnly:true,dateFmt:'yyyy-MM-dd'});return false;" readonly="readonly"
						<div>
							<label for="cmemo">
								<p>备注：</p>
							</label>
							<textarea id="cmemo" name="cmemo">${_[=beanName].ext.cmemo}</textarea>
						</div>
						<div>
							<label for="cimage">
								<p><b>*</b>封面图：</p>
							</label>
							<button type="button" id="btnUpload">上传图片</button>
							<input type="hidden" id="cimage" value="${_[=beanName].ext.cimage}" name="cimage" />
							<s:if test="${_[=beanName].ext.cimage ne null && _[=beanName].ext.cimage ne ''}">
								<a id="displayImage" style="color:#337ab7" href="./${_[=beanName].ext.cimage}" target="_blank">查看图片</a>
							</s:if>
							<s:else>
								<a id="displayImage" style="display:none;color:#337ab7" target="_blank">查看图片</a>
							</s:else>
						</div>

						<div>
							<label for="cmanyImage">
								<p><b>*</b>剧照 ：</p>
							</label>
							<button type="button" id="btnUploadMany">上传剧照</button>
							<input type="hidden" id="cmanyImage" value="${_[=beanName].ext.cmanyImage}" name="cmanyImage" />
							<div style="float: right;width:90%;">
								<ul id="displayManyPhoto" class="list-unstyled">
								</ul>
							</div>
						</div>

						<east:service beanName="eastUtilService" methodName="ProxyCaller.objCall2NV" id="_contentDisp">
							<east:para name="_class" value="com.east.regex.HtmlUtil" type="String" /> 
							<east:para name="_fun" value="fetchBody" type="String" />
							<east:para name="_html" value="${_[=beanName].ext.ccontent}" type="String" />
						</east:service>
						<div>
							<label for="contentDisp">
								<p><b>*</b>内容：</p>
							</label>
							<textarea id="contentDisp" rows="8" cols="54" placeholder="内容" class="text_border80" style="width:24em!important;margin-left: 10em;min-height: 300px;">${_contentDisp}</textarea>
							<input type="hidden" id="ccontent" name="ccontent" />
						</div>
						</JREMOVE>
						#-->

					</div><!--modal-body-->

					<div class="modal-footer">
						<button type="button" class="btn btn-primary" style="margin-right: 45%;" id="btnSave">保存</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!--#
	<JREMOVE>
	<script>
		var _editorContent = null;
		setTimeout(function(){
			_editorContent = CKEDITOR.replace('contentDisp',{width:460,height:300} );
		},200);
	</script>
	</JREMOVE>
	#-->
	<script>
		$(function(){
			$('#btnSave').on("click", function() {
				/*#<JREMOVE>
				if(moment(cendDate,'YYYY-MM-DD').isBefore(moment(cstartDate,'YYYY-MM-DD'))){
					alertify.alert("结束日期不能早于开始日期。");
					return false;
				}
				if(!/^(0|([1-9][0-9]*))(\.[0-9]{1,2})?$/.test(camount)) {
					alertify.alert("请正确填写账户金额,最多2位小数。");
					return false;
				}
				var cphone = $("#cphone").val();
				if(!__JisMobile(cphone)) {
					alertify.alert("请填写正确的手机号。");
					return false;
				}
				</JREMOVE>#*/
				<#list columns as column>
				var [=column.columnName] = $("#[=column.columnName]").val();
				if([=column.columnName] == '') {
					<#if column.type == "1">
					alertify.alert("请选择[=column.columnCaption]。");
					<#else>
					alertify.alert("请填写[=column.columnCaption]。");
					</#if>
					return false;
				}
				</#list>
				/*#<JREMOVE>
				var _content = _editorContent.getData();
				if (_content.length == 0) {
					alertify.alert("内容不能为空！");
					return false;
				} else if(_content.length > (1500000)){
					alertify.alert("内容文字长度过长，无法保存！");
					return false;
				}
				$("#ccontent").val(_content);
				</JREMOVE>#*/
				/*#<JREMOVE>
				if("${requestEx.id}" != "0") {
					$AjaxPostSyn(
						"bs_ajaxIndex![=projectName]![=projectName]_controls_html!common_snap_save.do",
						{
							"ctableName":"[=tableNo]",
							"id":"${requestEx.id}"
						},
						function(_resp){
						},
						function(_resp){}
					);
				}
				</JREMOVE>#*/
				var _url_para = $("#frmSubmit").serialize(),
					_url = "<%=basePath%>bs_ajaxIndex![=projectName]![=projectName]_controls_html![=controlSaveFileName].do";
				$AjaxPostASyn(_url, _url_para,
					function(_resp) {
						var jsonResp = JSON.parse(_resp);
						if(jsonResp.state == 'success') {
							alertify.alert("操作成功!", function(_msg) {
								__JDialogCallbackAndClose();
							});
						} else {
							alertify.alert(jsonResp.msg);
						}
					},
					function(_resp) {});
				return false;
			});// end btnSave
		})
	</script>


	<!--#
	<JREMOVE>
	<script>
		function handleOneImage(sub_lists){
			var _fileId = '';
			for(var k = 0; k < sub_lists.length; k++) {
				_fileId = sub_lists[k].id.trim();
			}
			var _url_para = "fileId=" + _fileId,
				_url = "bs_ajaxIndex![=projectName]![=projectName]_controls_html!common_get_uploaded_image_path.do";
			$AjaxPostASyn(_url, _url_para,
				function(_resp) {
					if(_resp.indexOf('success') >= 0) {
						var jsonResp = JSON.parse(_resp);
						$("#cimage").val(jsonResp.path);
						$("#displayImage").prop("href", "./" + jsonResp.path).show();
					}
				},
				function(_resp) {});
		}
		
		function ajax_multi_complete(responseText, _order) {
			if(responseText.indexOf("success") >= 0) {
				if(responseText.indexOf(".jsp") >= 0 || responseText.indexOf(".exe") >= 0) {
					alert("上传文件不正确!");
					return;
				}

				var __obj = eval("(" + responseText + ")");
				var sub_lists = __obj.data;
				if(sub_lists.length > 0) {
					switch(_order) {
						case '1':
							handleOneImage(sub_lists);
							break;
						//case '2':
						//	handleManyImage(sub_lists);
						//	break;
						default:
							break;
					}
				}
			} else {
				console.log("出现错误!");
			}
		}

		var _bdPopWin = null;
		var _bdTnewsId = 0;
		var _bdP2Num = 0;

		function fileUpdateOkArray(_paramObjs) {
			if(_paramObjs.length > 0) {
				var _captions = "";
				var _fileNames = "";
				for(k = 0; k < _paramObjs.length; k++) {
					if(k > 0) {
						_captions = _captions + ";";
						_fileNames = _fileNames + ";";
					}
					_captions = _captions + _paramObjs[k].orgFileName;
					_fileNames = _fileNames + _paramObjs[k].fileName;
				}

				var orderNum = _bdP2Num,
					_url_para = "p1=t_news&p2=0&p4=" + _captions + "&p3=" + _fileNames + "&p5=" + orderNum + "&p6=UploadFileDir&p7=upload",
					_url = "bs_ajaxIndex!bspms!bspms_controls_html!ajax_save_attachs.do"; //存储到file
				$AjaxPostASyn(_url, _url_para,
					function(_resp) {
						_resp = _resp.trim();

						if(_resp.indexOf('success') >= 0) {

							var _respJson = JSON.parse(_resp);
							try {
								ajax_multi_complete(_resp, _bdP2Num);
							} catch(_ee) {}
							setTimeout(function() {
								_bdPopWin.close();
							}, 300);
						}
					},
					function(_resp) {});
			}
			return false;
		}

		function uploadBdPicXMulti(_newsIdVar, _targetIdVar, _p1Var, _p2Var, _p3Var, _p4Var) {
			_bdTnewsId = _newsIdVar;
			_targetId = _targetIdVar;
			_bdP2Num = _p2Var;
			_bdPopWin = __JdialogEx("上传文件", "bs_ajaxIndex!bspms!bserp_uploaderimagebd_html!pop_image_upload.do", 400, 360,
				function(_resp) {}, 65538,
				function() {});
			return false;
		}

		$(function() {
			$("#btnUpload").on("click", function() {
				uploadBdPicXMulti("${_[=beanName].id}", "cimage", "6", "1", "0", "0");
			});
			
			//$("#btnUploadMany").on("click", function() {
			//	uploadBdPicXMulti("${_[=beanName].id}", "cmanyImage", "6", "2", "0", "0");
			//});
		});
	</script>
	</JREMOVE>
	#-->

	<!--#
	<JREMOVE>
	<script>
		var photoList = new Array();
		/*#
		<east:service beanName="eastUtilService" methodName="splitString" id="oldPhotos">
			<east:para name="_sStr" value="${_[=beanName].ext.cmanyImage}" type="String" />
			<east:para name="_linkLetter" value=";" type="String" />
		</east:service>
		<c:forEach items="${oldPhotos}" var="_one" varStatus="_status">
			photoList.push('${_one}');
		</c:forEach>
		#*/
		function removePhoto(_index) {
			if (_index < photoList.length) {
				photoList.splice(_index, 1);
			}
			redraw();
			return false;
		}
		
		function redraw() {
			var previewLi = new Array();
			for (var i = 0; i < photoList.length; i++) {
				var onePhoto = photoList[i];
				previewLi.push("<li><a style=\"display:block;float:left;color:#337ab7\" href=\"<%=basePath%>/" + onePhoto +"\" target=\"_blank\"><span>"+ onePhoto +"</span></a><a style=\"display:block;float:right;\" onclick=\"removePhoto(" + i + ");\"><img src=\"./[=projectName]_erp_img/close1.png\"/></a></li>");
			}
			$("#displayManyPhoto").empty().append(previewLi.join(''));
			$("#cmanyImage").val(photoList.join(";"));
		}
		setTimeout(function() {
			redraw();
		}, 400);
		
		function handleManyImage(sub_lists){
			var _fileId = '';
			for(var k = 0; k < sub_lists.length; k++) {
				_fileId = sub_lists[k].id.trim();
				var _url_para = "fileId=" + _fileId,
					_url = "bs_ajaxIndex![=projectName]![=projectName]_controls_html!common_get_uploaded_image_path.do";
				$AjaxPostSyn(_url, _url_para,
					function(_resp) {
						if(_resp.indexOf('success') >= 0) {
							var jsonResp = JSON.parse(_resp);
							photoList.push(jsonResp.path);
						}
					},
					function(_resp) {});
			}
			redraw();
		}
	</script>
	</JREMOVE>
	#-->
</body>
</html>