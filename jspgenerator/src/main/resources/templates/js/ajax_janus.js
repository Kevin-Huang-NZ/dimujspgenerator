
    /***********************************
    * 360 not for second parameters
    */
	function $AjaxPostSyn(__url,__data,__success_function,__fail_function){
	  var bol=false;
	  $.ajax({
	    type:"POST",
	    url:__url,
	    async:false,
	    data:__data,
	    success:function(msg){
	     try{
	        __success_function(msg);	  
	      }catch(ee){	      
	      }  
	   },
	    error:function(msg){
	      try{
	        __fail_function(msg);	  
	      }catch(ee){	        
	      }    
	   },
	   dataType:'text'
	  });
  }
  
  
  	function $AjaxPostSynJson(__url,__data,__success_function,__fail_function){
	  var bol=false;
	  $.ajax({
	    type:"POST",
	    url:__url,
	    async:false,
	    data:__data,
	    success:function(msg){
	     try{
	        __success_function(msg);	  
	      }catch(ee){	      
	      }  
	   },
	    error:function(msg){
	      try{
	        __fail_function(msg);	  
	      }catch(ee){	        
	      }    
	   },
	   dataType:'json'
	  });
  }
  
  
  
  
  function $AjaxPostASyn(__url,__data,__success_function,__fail_function){
	  var bol=false;
	  $.ajax({
	    type:"POST",
	    url:__url,
	    async:true,
	    data:__data,
	    success:function(msg){
	     try{
	        __success_function(msg);	  
	      }catch(ee){	      
	      }  
	   },
	    error:function(msg){
	      try{
	        __fail_function(msg);	  
	      }catch(ee){	        
	      }    
	   },
	   dataType:'text'
	  });
  }
  
  
  function $AjaxPostASynJson(__url,__data,__success_function,__fail_function){
	  var bol=false;
	  $.ajax({
	    type:"POST",
	    url:__url,
	    async:true,
	    data:__data,
	    success:function(msg){
	     try{
	        __success_function(msg);	  
	      }catch(ee){	      
	      }  
	   },
	    error:function(msg){
	      try{
	        __fail_function(msg);	  
	      }catch(ee){	        
	      }    
	   },
	   dataType:'json'
	  });
  }
  
  function $AjaxPost(__url,__data,__success_function,__fail_function){
	  $.ajax({
	    type:"POST",
	    url:__url,
	    async:true,
	    data:__data,
	    success:function(msg){ 
	      __success_function(msg);
	   },
	   error:function(msg){
		   __fail_function(msg);
		 },
		 dataType:'text'
	  });
  }