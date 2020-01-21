 
    var __varCallBackFun = null;//callback function
 
    function __JdialogEx(__title,__url,_width,_height,_callBackFun,_zIndex,_closeCallBack){
      if(_zIndex == null) _zIndex = 65500;
    var _dialog = $.dialog({
      title: __title,
      id:"openDlg",
      zIndex:_zIndex,
        content:'url:'+__url,
        min:false,
        max:false,
        width:_width,
        height:_height,
        fixed : true,
        resize  : true,
        close:function(){ if(_closeCallBack != null) { _closeCallBack(); }  return true; }
      });
    __dialog = _dialog;
    __varCallBackFun = _callBackFun;
    return _dialog;
  }
    
    
    function __JdialogExButton(__title,__url,_width,_height,_callBackFun,_zIndex,_closeCallBack){
        if(_zIndex == null) _zIndex = 65500;
      var $EditDailogObj = $.dialog({
        title: __title,
        id:"openDlg"+_zIndex,
        zIndex:_zIndex,
        content:'url:'+__url,
        min:false,
        max:false,
        width:_width,
        height:_height,
        fixed : true,
        resize  : true,
        close:function(){ if(_closeCallBack != null) { _closeCallBack(); }  return true; },        
        button  : [
            {
              id: 'sub',
              name: '确定',
                  callback: function() {
                    if(1==0){
                      alert("确定");
                          this.close();
                          return false; 
                            
                    }
                    
                    var _FORM_ID = $($EditDailogObj.content.document).find('form').attr("id");
                      if(_FORM_ID == null || _FORM_ID =='') { alert("form对象id未设置！");  return false;}
                      var formObj = $EditDailogObj.content.document.getElementById(_FORM_ID);
                      if(typeof($EditDailogObj.content.$onJudge) == "function") {//特殊的判断函数。$onJudge 不再使用。替换使用。
                          if($EditDailogObj.content.$onJudge($EditDailogObj) == false) return false;
                      }
                    
                    if(typeof($onJudge) == "function") {//特殊的判断函数。$onJudge 不再使用。替换使用。
                      if($onJudge($EditDailogObj) == false) return false; 
                    }

//                    if(validator(formObj)) {
                        if(true){
                      //屏蔽按钮
                      //jQuery(formObj).find(".ui_buttons :button").attr("disabled", true);
                      //alert("--123");
                      //tar().lhgdialog.tips(this.__doing_msg, 3, "loading.gif");
                      
                      var n = 'edit_result_' + new Date().getTime();
                      var d = '<div id="' + n + '" style="display:none"></div>';
                      $(formObj).append(d);
                      
                      var resultObj = $EditDailogObj.content.document.getElementById(n);
                      
                      $(resultObj).load($(formObj).attr("action"), 
                        $(formObj).serializeArray(),
                        function(responseText) {
                          //alert(responseText);
                          if(responseText.indexOf("success") >= 0){
                            //tar().lhgdialog.tips($ajax_edit.__do_succ_msg, 3 ,"succ.png");
                            
                          }else{
                            //tar().lhgdialog.tips($ajax_edit.__do_fail_msg, 3 ,"fail.png");
                            //jQuery(formObj).find(".ui_buttons :button").attr("disabled", false);
                          }
                          
                         // this.close();
                        if(1==1)
                         {
                          // var api = frameElement.api;  //nop 
                           try{   
                          __varCallBackFun(responseText); 
                        }catch(ee){
                          alert(ee);  
                        }  
                             //api.close();
                         }
                             return true;     
                        
                        } );
                      
                        }
                  }, 
              focus: true 
            },
            {
              id: 'cel',
              name: '取消',
                  callback: function() {
                
                      this.close();
                      return false; 
                  }
            }
            ] 
       
        
        
        
      
        });
      __dialog = $EditDailogObj;
      __varCallBackFun = _callBackFun;
      return __dialog;
    }
    
    

  function __JDialogCallbackAndClose(_resp){  
       var api = frameElement.api;
     W = api.opener;
     W.__varCallBackFun(_resp); 
     api.close();
  }
    
  function __JDialogCallback(_resp){  
       var api = frameElement.api;
     W = api.opener;
     W.__varCallBackFun(_resp); 
  }
  


 //not use any more
 var __dialog = null;
 function __JgetIFrameFromParentByName(__name){
       try{
         var frames = parent.document.getElementsByName(__name)[0];
         return frames;
       }catch(eee){
         return null;
       }
  }
  
  function __JdialogCallBack(_resp){
      var frames = __JgetIFrameFromParentByName("ajax_no_button_dialog");
          //alert(frames);
     frames.contentWindow.__varResp(_resp);  
     frames.contentWindow.__dialog.close();
  
  }
  function __Jdialog(__title,__url,_width,_height){
    var _dialog = $.dialog({
    title: __title,
    id:"openDlg",
    zIndex:66666,
      content:'url:'+__url,
      min:false,
      max:false,
      width:_width,
      height:_height,
      fixed : true,
      resize  : true
      });
    __dialog = _dialog;
    return _dialog;
  }
     
  
  