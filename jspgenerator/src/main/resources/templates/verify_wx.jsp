<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.weixin.util.WeixinUtil"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<base href="<%=basePath%>">
		<title></title>
		 <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script>
			//p2 存储回调地址。
			//p1 为当前页面的地址。

			var _url = "";

			function verify_url() {
				window.location.href = _url;
			}

			function setTimeOuter(_verify_url) {
				_url = _verify_url;
				setTimeout(verify_url, 2000);
			}
		</script>

		<script>
			function jsonHttps(_httpsUrl) {
				window.location.href = _httpsUrl;
				//window.location.href
				//取得当前的地址。
				/*  $.jsonp({
				    url: _httpsUrl,
				    success: function (data) {
				      alert(data);
				    },
				    error: function (xOptions, textStatus) {
				        alert(textStatus);
				    }
				});
				  */

			}
		</script>
<style>
      * {
        margin: 0;
        padding: 0;
        border: 0;
      }
      
      *:focus {
        outline: none;
      }
      
      html {
        overflow-x: hidden;
        background-color: rgb(39, 131, 207);
      }
      
      body {
        margin: 0;
        padding: 0;
        border: 0;
        background-color: rgb(39, 131, 207);
      }
      
      .title_div {
        color: white;
        font-size: 3rem;
        text-align: center;
        /*position: absolute;*/
        width: 100%;
        margin-top: 20vh;
      }
      
      .loading_div {
        height: 5rem;
        width: 70%;
        display: flex;
        margin-left: 15%;
        margin-top: 12vh;
        border-radius: 0.5rem;
        border: white 1px solid;
      }
      
      .loading_div_loading {
        height: 4rem;
        width: 4rem;
        background: url(../exfilm_img/loading.gif);
        background-size: cover;
        margin-top: 0.5rem;
        margin-left: 0.5rem;
      }
      .loading_div_text {
        width: 70%;
        line-height: 5rem;
        font-size: 1rem;
        color: white;
        text-align: center;
      }
    </style>
	</head>

	<body>
		<div class="title_div" id="" style="">影券通证</div>
    <div class="loading_div" style="">
      <div class="loading_div_loading" id="" style=""></div>
      <div class="loading_div_text" style="">Loading, please wait...</div>
    </div>

		<%
  String go_url = "";
  String p1 = "http%3A%2F%2Fexfilm.wefindings.com%2Fzhiping%2Fexfilm%2Fverify_wx.jsp";
  
  String p2 = "";
  String  wx_code = "";
  
  Map m=new java.util.HashMap();  
 //可以使用这个map实例来存储取到的信息		
  Enumeration eNames = request.getParameterNames();	
  String key = null;		
  String value = null;		
  while (eNames.hasMoreElements()) {	
		 key = (String) eNames.nextElement();	
		 value = request.getParameter(key);	
		 if (value == null || value.equals("") || value.equals("null")) {
			 	value = "";		
	 } else {		
		 try {			
		// System.out.println(java.net.URLDecoder.decode(value, "UTF-8"));
//servlet中写法					
 value = URLDecoder.decode(value, "UTF-8");  
//页面中的写法				
 } catch (Exception e) {
				 	e.printStackTrace();	
			 }			 }			
 key = key.toLowerCase();		
	 //System.out.println("Key="+key+" value="+value); 
if(key.equals("code")){
  wx_code  = value;
}

if(key.equals("p1")){
  p1  = value;
}

if(key.equals("p2") == true){
    p2 = value;
    try{
	 p2 =  java.net.URLDecoder.decode(p2, "utf-8");//反向解析地址。
	}catch(Exception ee){
	  //ee.printStackTrace();
    }
  session.setAttribute("redirect_url",p2);//设置回调函数。
}



//servlet中的写法			 
    if(1 == 0){//测试关闭。
      out.println("Key="+key+"; value="+value+"<br/>"); //页面中的写法
			 m.put(key, value);
	 }
}

%>

<%

   String  appId      =  "wx0b1792b05a4044dc";
   String  appSecret  = "be2fea841652c0e04012db296382ea8f";
	  
   go_url = "";
   if(wx_code == null || wx_code.equals("") == true){
      go_url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appId+"&redirect_uri="+p1+"&response_type=code&scope=snsapi_base&state=1234#wechat_redirect";
      System.out.println(go_url);
   }else{
      //此处应该单独执行js 然后获取其值。

	  
      String openId = WeixinUtil.getAuthSNSOpenId(appId, appSecret, wx_code);
      //取得之后，直接跳转到p2.
      if(openId != null){
        session.setAttribute("openId",openId);//设置到session中去。
      }
      p2 = (String)session.getAttribute("redirect_url");
      go_url = p2;
    
   }
  
  %>

		<br/>
		<%
 // out.println(go_url);
%>
		<script>
			<%
   if(go_url != null && go_url.equals("") == false){
     out.println("setTimeOuter('"+go_url+"')");
   }     
  %>
		</script>

	</body>

</html>