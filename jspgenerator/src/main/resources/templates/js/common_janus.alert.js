  function __Jalert(_txt)
  {
     alertify.alert(_txt);
  }
    
  function __JalertEx(_txt,_time)
  {
    alertify.log(_txt, "info", _time);
  }
  
  function __Jconfirm(_tip,param,_funSuccess)
  {
        var _param = param;
        alertify.confirm(_tip,function (e) {
		    if (e) {
		        _funSuccess(_param);
		        //alertify.log("user clicked ok", "", 5000);
		    } else {
		       
		    }
		});
  }
  
  function __JconfirmEx(_tip,param,_funSuccess,_funFailed)
  {
        var _param = param;
        alertify.confirm(_tip,function (e) {
		    if (e) {
		        _funSuccess(_param);
		        //alertify.log("user clicked ok", "", 5000);
		    } else {
		        //alert("user clicked cancel");
		        //alertify.success("Success notification");
		        _funFailed(_param);
		    }
		});
  }
  
  function __JNotify(_tip,_timeout)
  {
     if(_timeout === 0){
        alertify.log(_tip, "", 5000);
      }
      else{
        alertify.log(_tip, "", _timeout);
      }
  }
  
  
  
  function __Jprompt(_tip,_funSuccess,_defaultVal)
  {
       alertify.prompt(_tip,  _funSuccess ,_defaultVal);
  }
  