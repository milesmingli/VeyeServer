<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>UpLoadPersonalInformation.jsp</title>
	
    <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta name="content-type" content="text/html; charset=gb2312">
    <script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
    <script type="text/javascript">
	var randomconut = Math.floor(Math.random() * 1000);
	var alldata=null;
	var user=null;
	var result=null;
    window.onload=function(){
    	
		user = $.cookie('user_cookie');
		
    	$.ajax({

    		url : "./NickNameServlet?user="
    				+ user+"&randomconut="+randomconut,
    		dataType : "json",
    		contentType : "application/x-www-form-urlencoded; charset=utf-8",
    		error : function(request, error) {
    			alert(error);
    		},

    		success : function(data) {
    			document.getElementById("userid").value = data[0].id;
    			document.getElementById("realname").value = data[0].realname;
    			document.getElementById("birthday").value = data[0].birthday;
    			document.getElementById("gender").value = data[0].gender;
    			document.getElementById("address").value = data[0].address;
    			document.getElementById("email").value = data[0].email;
    			document.getElementById("phone").value = data[0].phone;
    			document.getElementById("portrait").value = data[0].portrait;
    	

    		}
    	});
		var input = document.getElementById("demo_input");
		result = document.getElementById("result");
		var img_area = document.getElementById("img_area");

		if (typeof (FileReader) === 'undefined') {
			result.innerHTML = "抱歉，你的浏览器不支持 FileReader，请使用chrome浏览器操作！";
			input.setAttribute('disabled', 'disabled');
		} else {
			input.addEventListener('change', readFile, false);
		}
    	
    }
    var imgs = new Image();
	function readFile() {

		var file = this.files[0];
		
	
		var filetype = "jpg,jpeg,png,JPG,JPEG,PNG";

		if (filetype.indexOf(file.type.split("/")[1]) < 0) {
			alert("不支持的文件格式，请上传格式为,jpg,jpeg,类型的图片");

			return false;
		}

		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e) {
			result.innerHTML = this.result.split(",")[1];
			imgs.src = this.result;
			var imgh=(300*imgs.height)/imgs.width
			img_area.innerHTML = '<div class="sitetip" ></div><img  src="'+this.result+'" alt="" id="imgs" width="300px" height="'+imgh+'" style="border:#AAAAAB 2px solid;"/>';
			
	
		}

	}
	var artistid=decodeURI(<%="'"+request.getParameter("artistid")+"'"%>);

	function Submit(){
		var idcard=document.getElementById("idcard").value;
		var RsStream=document.getElementById("result").value;
		document.getElementById("artistid").value=artistid;
	
		
		if(idcard==null || idcard==""){
			alert("请输入身份证号号码");
			return;
		}else if(RsStream==null || RsStream=="" ){
			alert("请上传身份证正面照片");
			return;
		}
		
		 document.form1.submit();
		 document.getElementById("submitbutton").disabled=true;

	
		
	}
	
	
    </script>

  </head>
  
  <body style="font-family: 微软雅黑">
   <div style="text-align: center;">
   <h1>个人艺术家</h1>
   </div>
   <div style="text-align: center;margin-top: 150px">
   
   <p style="margin-left:-240px">实名认证（上传身份证）：</p>
   &nbsp;&nbsp;&nbsp;
   <form action="./UpdateAccountInformation"  name="form1"  method="post">
   <input type="text"style="width: 300px" id="idcard" name="idcard"/>&nbsp;&nbsp;&nbsp;请输入身份证号码
   <br>
   <br>
   <br>
   	<input type="file" value="" id="demo_input"accept="image/png, image/jpeg" style="margin-left: -130px"/>
	<textarea id="result" rows=30 cols=300 name="RsStream" style="display: none"></textarea>
	<p id="img_area"></p>
	<input type="text" id="artistid" name="artistid" value="" style="display: none;"/>
	<input type="text" id="userid" name="userid" value="" style="display: none;"/>
	<input type="text" id="realname" name="realname" value="" style="display: none;"/>
	<input type="text" id="birthday" name="birthday" value="" style="display: none;"/>
	<input type="text" id="gender" name="gender" value="" style="display: none;"/>
	<input type="text" id="address" name="address" value="" style="display: none;"/>
	<input type="text" id="email" name="email" value="" style="display: none;"/>
	<input type="text" id="phone" name="phone" value="" style="display: none;"/>
	<input type="text" id="portrait" name="portrait" value="" style="display: none;"/>
	
	
	<input type="button" value="提交" id="submitbutton" onclick="Submit()" style="margin-left: -140px;margin-top: 60px"/>
	</form>
   </div>
  </body>
</html>
