var __url = "";


 	function __JisNumberEx(_controlId,_vDefault){
   	 isNum = /^[0-9]*$/;
   	 var _val = $("#"+_controlId).val();
   	 if(isNum.test(_val) === false){
   		alert("只能输入数字");
   		$("#"+_controlId).val(_vDefault);   		
   		return false;
   	  }
   	  return true;
   	}

   	function __JisNumber(_val){
   	 isNum = /^[0-9]*$/;
   	 if(isNum.test(_val) === false){
   		//alert("只能输入数字");
   		return false;
   	  }
   	  return true;
   	}
   	
   	function __JisEmail(_val){
   	    if (/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(_val) === false) {
                   return false;
                }
        return true;
	}
	
	function __JisMobile(_val){
   	    var patrn = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/; 
		if (!patrn.exec(_val))
		{ 
		  return false; 
		} 
		return true;
	}
	
	
   function __JisCardNo(card)  
   {  
     // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X  
      var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;  
      if(reg.test(card) === false)  
      {  
         //alert("身份证输入不合法");  
         return  false;  
      }  
   }  
	
	
	function __Jchecked(_id){
   	  var chk = document.getElementById(_id);  
      var _checked = false;
      if(chk !== null){
          _checked = chk.checked;//$("#"+_id).attr("checked");
      }
   	  return _checked;
   	}
	
	
///

function __Jback(){//默认为500ms

 history.back(0);

}

function __JnewWindow(url){
	  __JshowWindowBlank(url); 
}

function __JshowWindowBlank(url){
	   var newWindow = open(url,'_blank');	   
}


function __Jgo(url){//默认为500ms
    if(url.indexOf('?') > 0)
	  this.location.href  = url +"&rnd=" + Math.random().toString();
	else
	  this.location.href  = url +"?rnd=" + Math.random().toString();
}

function __JgoEx(url){//默认为500ms
    if(url.indexOf('?') > 0)
	  this.location.href  = url ;
	else
	  this.location.href  = url ;
}


function __JSetTimerRefreshUrl(_url,_timeMS){//默认为500ms
   __url = _url;
   setTimeout("__JLoadUrl()", _timeMS);   
 }


 function __JSetTimerRun(_funx){//默认为500ms
   setTimeout(_funx, 100);   
 }
 
 function __JSetTimerReload(){//默认为500ms
   setTimeout("__JReloadSelf()", 500);   
 }
 function __JwindowClose(){//默认为500ms
    window.close();
 }
 
  /*************************************
  * 外部执行关闭。
  */
  function __JcloseDialogOutside() {
    try{
	   $EditDailogObj.close();
    }catch(ee){
    
    }
    return true;
  }
 
  /*************************************
  *内部执行关闭。
  */
  function __JcloseDialogInside() {
   try{
	  var api = frameElement.api, W = api.opener; 
	  api.close();
    }catch(ee){
    
    }
    return false;
  }
  

 
 function __JSetTimerReloadEx(_timems){//默认为500ms
   setTimeout("__JReloadSelf()", _timems);   
 }
 
 
 function __Jajax_complete_reload(txt){
  alert("操作成功!");  
  __JSetTimerReload();
}  
 
 function __JLoadUrl(){
   var _param = "";//"rnd="+Math.random(); 
   var _temp_url =  __url;
  /* if(__url.indexOf("?") >= 0)
      _temp_url = _temp_url + "&" + _param;
   else
      _temp_url = _temp_url + "?" + _param
      */
   window.location.href = _temp_url;
 }
 
 function __JReloadSelf(){
   window.location.reload();
 }
 
 
  function __JReloadParent(){
   window.parent.location.reload();
 }
 
 
 function __JRefreshParent(_resp){
 
   if(window.parent.__JGcallbackFunVar != null)
   {
   
      window.parent.__JGcallbackFunVar(_resp);
   }
                                 
 }
 function _janus_selectColumn(__columnId,__showType){
     try{
    	  var _actions = "../columnAction_ajaxSelectColumn.do?p1="+__columnId+"&p2="+__showType;
		
		   $AjaxPostSyn(_actions,
			                "",
			               function(__result){
			                  alert("ok"+__result);
			               },
			               function(__result){
			                  alert("error"+__result);
			               });
     }catch(err){
		  return false;
		}
 }
 
 /****************************************************
 *  含回调的应用函数。
 *
 */
 function __JpostFormCallBackEx(formId) {
     var _url_para = $("#"+formId).serialize();
     var _url = $("#"+formId).attr("action");
     $AjaxPostSyn(_url,
	              _url_para,
	              function(_resp){	 
	                                  
	                    if(_resp.indexOf('success') >= 0){
                          //alert("操作成功!刷新后展现！");
                          //要能更新父类。
                          try{
                            
                             if(window.parent.__JGcallbackFunVar != null){//调用父类的回调函数。
                               window.parent.__JGcallbackFunVar(_resp);
                             }else{
                               __JcloseDialogInside();
                            }
                          }catch(ee){
                            
                          }
                        }
	                 }, 
	                 function(_resp){
	                   //alert(_resp);
	                 });  
 }
 
 
 function __JpostFormCallBackReload(formId) {
     var _url_para = $("#"+formId).serialize();
     var _url = $("#"+formId).attr("action");
     $AjaxPostSyn(_url,
	              _url_para,
	              function(_resp){	                 
	                    if(_resp.indexOf('success') >= 0){
                          //alert("操作成功!刷新后展现！");
                          //要能更新父类。
                          //alert("123");
                          __JSetTimerReload();
                        }
	                 }, 
	                 function(_resp){
	                   alert("操作失败!");
	                 });  
 }
 
 function __JajaxPostFormReload(formId) {
   __JpostFormCallBackReload(formId);
 }

  function __JajaxPostFormAjaxCallBack(formId,_fnx) {
    return __JpostFormCallBack(formId,_fnx);
  } 
 
  function __JpostFormAjaxCallBack(formId,_fnx) {
    return __JpostFormCallBack(formId,_fnx);
  }
 
  function __JpostFormCallBack(formId,_fnx) {
     var _url_para = $("#"+formId).serialize();
     var _url = $("#"+formId).attr("action");
     __JGcallbackFunVar = _fnx;
     $AjaxPostSyn(_url,
	              _url_para,
	              function(_resp){	                 
	                    if(_resp.indexOf('success') >= 0){
                          //alert("操作成功!刷新后展现！");
                          //要能更新父类。
                          //alert("123");
                         if(__JGcallbackFunVar != null){//进行提交操作
                           __JGcallbackFunVar(_resp);
                         }else{
                            __JSetTimerReload();
                          }
                        }else{
                            if(__JGcallbackFunVar != null){//进行提交操作
                               __JGcallbackFunVar(_resp);
                           }
                        
                        }
	                 }, 
	                 function(_resp){
	                   alert("操作失败!");
	                 });  
 }
 

 

 
 
 function __JpostFormInside(formId) {
     var _url_para = $("#"+formId).serialize();
     var _url = $("#"+formId).attr("action");
     $AjaxPostSyn(_url,
	              _url_para,
	              function(_resp){	                 
	                    if(_resp.indexOf('success') >= 0){
                               alert("操作成功!确定后刷新！");
                               parent.location.reload(); 
                               __JcloseDialogInside();
                          
                               //要能更新父类。
                        }
	                 }, 
	                 function(_resp){
	                   //alert(_resp);
	                 });  
 
 }
 
 function __JpostFormAndCallBack(formId) {
     var _url_para = $("#"+formId).serialize();
    // alert(_url_para);
     var _url = $("#"+formId).attr("action");
    // alert(_url);
     $AjaxPostSyn(_url/*"ajaxConnect_ajax_order_detail.do"*/,
	                _url_para,
	                function(_resp){	                 
	                if(_resp.indexOf('success') >= 0){
                               //要能更新父类。
                              // alert("1223");
                               if(window.parent.__JGcallbackFunVar != null)
                                 {
                                    window.parent.__JGcallbackFunVar(_resp);
                                 }
                               //alert("12734");
                               __JcloseDialogInside();
                               
                           }
	                 }, 
	                 function(_resp){
	                   //alert(_resp);
	                 });  
 
 }
 
 function __JpostFormAjax(formId){
   return __JpostFormAndCallBack(formId);
 }
 
 
 
 
 function __JpostFormTag(formId,tag) {
     var _url_para = $("#"+formId).serialize();
     var _url = $("#"+formId).attr("action");
     $AjaxPostSyn(_url,
	              _url_para,
	              function(_resp){	                 
	                    if(_resp.indexOf('success') >= 0){
                               alert("操作成功!刷新后展现！");
                               __JcallEastUpdateEx(tag);
                               parent.location.reload(); 
                               __JcloseDialogInside();
                               //要能更新父类。
                        }
	                 }, 
	                 function(_resp){
	                   //alert(_resp);
	                 });  
 
 }

  
  /*****************************************
  *  默认的含按钮的调用。放置到__JGcallbackFunVar 用于全局量回调。
  */
  function __JclickNoButtonWindowEx(_title,_url,_w,_h,_myajax_call_back) {
	__JajaxNoButtonEx(_title, _url, _myajax_call_back,false,null,_w,_h); 
    return false;
  }
  
  function __JclickNoButtonDefaultCallBack(_title,_url,_w,_h) {
	__JajaxNoButtonEx(_title, _url, __Jajax_complete_reload,false,null,_w,_h); 
    return false;
  }
 
  function __JclickNoButtonEx(_title,_url,_w,_h) {
	__JajaxNoButtonEx(_title, _url, __Jajax_edit_complete,false,null,_w,_h); 
    return false;
  }
  
 
 function __JclickNoButton(_url,_w,_h) {
	__JajaxNoButtonEx('列表', _url, __Jajax_edit_complete,false,null,_w,_h); 
    return false;
  }
  /*****************************************
  *  默认的含按钮的调用。其中含有回调函数被使用，内部名称为：__JGcallbackFunVar
  */
  function __JclickButtonEx(_title,_url,_w,_h,_ajax_edit_complete) {	
	__JajaxEditWH(_title, _url, _ajax_edit_complete,false,null,_w,_h); 
    return false;
  }
  /*****************************************
  *  按钮处理过程。
  */
  function __JclickButton(_title,_url,_w,_h) {	
	__JajaxEditWH(_title, _url, __Jajax_edit_complete,false,null,_w,_h); 
    return false;
  }
  
 /************************************
  *用于添加的公共操作。
  */
   function __JclickAddEx(_ext) {
	$ajaxEdit('添加', '../admin/east_column_edit.do?tnews.id=0&'+_ext, __Jajax_edit_complete,false,null); 
    return false;
  }
  /************************************
  *用于添加的公共操作。
  */
   function __JclickModifyEx(_tnewsId,_ext) {
	$ajaxEdit('编辑', '../admin/east_column_edit.do?tnews.id='+_tnewsId+"&"+_ext, __Jajax_edit_complete,false,null); 
	
    return false;
  } 
  
   function __JclickAdd() {
	$ajaxEdit('添加', '../admin/east_column_edit.do?tnews.id=0', __Jajax_edit_complete,false,null); 
    return false;
  } 
  
  function __JclickModify(_tnewsId) {
	$ajaxEdit('编辑', '../admin/east_column_edit.do?tnews.id='+_tnewsId, __Jajax_edit_complete,false,null); 
    return false;
  } 
   
  function   __Jajax_edit_complete(_txt) {
	 if(_txt.indexOf('success') >= 0){
	    alert("操作成功!");
	    //parent.location.reload(); 
	    window.location.reload();	 
	 }
  } 
  
  function   __Jajax_edit_completeNoTip(_txt) {
    // alert(_txt);
	 if(_txt.indexOf('success') >= 0){
	    //alert("操作成功!");
	    window.location.reload();	 
	 }
  } 

 function __JclickDelete(_tnewsId,_title) {
	if(confirm(_title)){
	  __JajaxCallMethod('../admin/east_ajax_do_delete_news.do?tnews.id='+_tnewsId,'',__Jajax_edit_complete);
	}
    return false;
}


function __JclickDeleteMulti(_ids,_title) {
	if(confirm(_title)){
	  __JajaxCallMethod('../admin/east_ajax_do_delete_news_multi.do?tag='+_ids,'',__Jajax_edit_complete);
	}
    return false;
}

 function __JajaxCommonDelete(_tnewsId,_title)
 {
    return __JclickDelete(_tnewsId,_title);
 }
 function __JajaxDelete(_url,_tip) {
	if(_tip != "" && confirm(_tip)){
	  __JajaxCallMethod(_url,'',__Jajax_edit_complete);
	}
	if(_tip == "")
	   __JajaxCallMethod(_url,'',__Jajax_edit_complete);
    return false;
}
   
   
   
   
   function __JajaxCallMethodASyn(_url,_url_para,_ajax_edit_complete) {
			  $AjaxPostASyn(_url/*"ajaxConnect_ajax_order_detail.do"*/,
			                _url_para,
			                 function(_resp){
			                    //alert(_resp);
			                   _ajax_edit_complete(_resp);
			                 },
			                 function(_resp){
			                   //alert("error"); 无需反馈error
			                 });
   return;
 }
   
/********************************
*
*/

function __JajaxCallMethodEx(_url,_url_para) {
  return __JajaxCallMethod(_url,_url_para,__Jajax_edit_completeNoTip);
}
/********************************
*
*/

function __JajaxCallMethod(_url,_url_para,_ajax_edit_complete) {
			  $AjaxPostSyn(_url/*"ajaxConnect_ajax_order_detail.do"*/,
			                _url_para,
			                 function(_resp){
			                    //alert(_resp);
			                   _ajax_edit_complete(_resp);
			                 },
			                 function(_resp){
			                   //alert("error");
			                 });
   return;
 }
 
/*************************************************
*  必须是登陆后的用户才能执行。
*/
function __JcallEastUpdateEx(_url_para) {
   //alert("123");
   return _$callEastUpdate(__Jajax_edit_complete,_url_para);
 }


 function __JcallEastUpdate(_ajax_edit_complete,_url_para) {
   return _$callEastUpdate(_ajax_edit_complete,_url_para);
 }

  function _$callEastUpdate(_ajax_edit_complete,_url_para) {
			 var _url = '../admin/east_ajax_do_update_news.do';
			 
			  $AjaxPostSyn(_url/*"ajaxConnect_ajax_order_detail.do"*/,
			                _url_para,
			                 function(_resp){
			                    //alert(_resp);
			                   _ajax_edit_complete(_resp);
			                 },
			                 function(_resp){
			                   //alert(_resp);
			                 });
  }

  //不再使用。
  function _$outUpdate(_ajax_edit_complete,_url_para) {
		
		 var _url = '../admin/east_ajax_do_update_news.do';
		  $AjaxPostSyn(_url/*"ajaxConnect_ajax_order_detail.do"*/,
		                _url_para,
		                 function(_resp){
		                   _ajax_edit_complete(_resp);
		                   window.parent.location.reload();
		                   window.close();
		                //   $go("../sales/sales_warehouse_out$warehouse$out.do");
		                 },
		                 function(_resp){
		                 });
}


function __Jselect_one_onclick(check_name,obj){  
           var uid = obj.value;  
            var chk = document.getElementsByName(check_name);  
            for(var i=0; i < chk.length; i++){  
                //if(obj == chk[i]) continue;
                chk[i].checked = false; 
                 
            } 
           
            //if(obj.checked == false)
              obj.checked = true;
            //else
            //  obj.checked = false;
 } 
 
 function __Jselect_checked(check_name){  
           //var uid = obj.value;  
            var chk = document.getElementsByName(check_name);  
            for(var i = 0; i < chk.length; i++){  
              if(chk[i].checked == true) return chk[i].value;
            }  
            //alert("请选择!");
            return "";
 }  
 
  function __Jselect_checkedEx(check_name){  
           //var uid = obj.value;  
            var chk = document.getElementsByName(check_name);  
            for(var i = 0; i < chk.length; i++){  
              if(chk[i].checked == true) return chk[i].value;
            }  
            __Jalert("请选择!");
            return "";
 }  
 
 function __Jselect_checked_all(check_name){  
            var _allchecked = ""; 
            var chk = document.getElementsByName(check_name);  
            for(var i = 0; i < chk.length; i++){  
              if(chk[i].checked == true && chk[i].value !== "") {
                if(_allchecked == ""){
                  _allchecked = chk[i].value;
                }else{
                  _allchecked = _allchecked + "," + chk[i].value;
                }
              
              
              }
            }  
            
            return _allchecked;
 }  
 
 
 /*************************************
  * checkElesName    元素对应的名称。
  * checkAllBtnName  选择所有对应的按钮名称。  
  *
  */
 function __JcheckAllquit(checkElesName,checkAllBtnName){
  var i = 0;
  var opt3=document.getElementsByName(checkElesName);
  for( i = 0; i < opt3.length; i++){
  if(opt3[i].checked == false){
           document.getElementById(checkAllBtnName).checked=false;
         };
  }
 
  for(i = 0; i < opt3.length; i++){
     if(opt3[i].checked==true){a+=1;}
	 if(opt3.length==a)
     {
       document.getElementById(checkAllBtnName).checked=true;
     };
  }
 }
 
  function _JRefreshVerify(prefixName,_num_){
    var params = new Object();
    params["s"]   = _num_;
    $.post('../verifyImageGen_ajax_gen.do', params, 
		function (data){//json.
		   try{
		    // alert(data);
		     $("#"+prefixName+_num_).html(data);
		   }catch(err){
             alert(err);
		   }

	   });	

  }
 
  



