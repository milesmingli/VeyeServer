<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'AddExhibitionGallery.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>
	
	
	<script type="text/javascript">
	

	window.onload = function() {
	//从画廊表里查找所有画廊返回结果添加到页面
	var sql="select * from gallery";
	$.ajax({

		url : "<%=basePath%>/SelectTypeServlet?sql="+sql,

		dataType : 'text',
		contentType : "application/x-www-form-urlencoded; charset=utf-8",

		error : function(request, error) {
			alert(error);
		},

		success : function(data) {
			console.log(data);
			var dataArray = data.split("*");
		
			var select = document.getElementById("gallery");
		

			console.log(dataArray);
			
			for(var i=1;i <dataArray.length; i++){
				
				var opt = document.createElement('option');
				 var optdata=dataArray[i].split(",");
                opt.value =dataArray[i];
                opt.selected = false;
                opt.innerHTML =optdata[0];
                select.appendChild(opt);  
			}

		
	
		}
	}); 
}
	
	
	function dosubmit() {
	

		
		var name=document.getElementById("name").value;
		var starttime=document.getElementById("starttime").value;
		var endtime=document.getElementById("endtime").value;
		var gallery=document.getElementById("gallery").value;
		var email=document.getElementById("email").value;

	
		
	
			
				 if(name== null || name== ""){
					   alert("作品名不能为空");
						return;
				 	}else if(starttime== null || starttime== ""){
					   alert("请设定开始时间");
						return;
					   
				   }else if(endtime== null || endtime== ""){
					   alert("请设定结束时间");
						return;
					   
				   }
				  
				 if(starttime>endtime){
					 
					 alert("开始时间不能大于结束时间");
					 return;
				 }
				 
			 		//正则验证输入邮箱，性别，手机。。。。
			 		
					if(email!= ""){
					
						 var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
						 if (!filter.test(email)){
							 alert('您的电子邮件格式不正确');
							 return;
						 }
					}
					
			 	
					
					
					document.form1.submit();
		
		}
	
	
	</script>
	
	
  </head>
  
   <body>
  
  <div style="width: 100%;text-align: center">
  	<div style="width: 100%;">
  		<h1>添加新展览</h1>
  		</div>
  		
  	<form action="${pageContext.request.contextPath}/InsertExhibitionServlet" method="post" name="form1">
  	
  		<div style="width: 80%;border-color: #D3D3D3;border-style: solid;1px;margin-left: auto;margin-right: auto;">
  		展览id&nbsp;: <input type="text" value="${requestScope.idname}" id="exhibitionid" name="exhibitionid" style="width: 20%;margin-top: 100px"readonly="readonly"/>
  		<br>
  		 展出标题: <input type="text" id="name" name="name" style="width: 20%;margin-top: 10px"/>
  		<br>
  		开始时间:  <input type="text" class="Wdate"  id="starttime" name="starttime" placeholder="请选择日期" onClick="WdatePicker()"  value="" style="margin-top: 10px;width:20%"/>
  		<br>
  		结束时间:  <input type="text" class="Wdate"  id="endtime" name="endtime" placeholder="请选择日期" onClick="WdatePicker()"  value="" style="margin-top: 10px;width:20%"/>
  		<br>
  		参展画廊: <select id="gallery" name="gallery" style="margin-top: 10px;width:20%"></select>
  		<br>
  		联 系 人: <input type="text" id="contactperson" name="contactperson" style="width: 20%;margin-top: 10px"/>
  		<br>
  		联系电话: <input type="text" id="phone" name="phone" style="width: 20%;margin-top: 10px"/>
  		<br>
  		联系邮箱: <input type="text" id="email" name="email" style="width: 20%;margin-top: 10px;margin-bottom: 20px"/>
  		<br>
						<a href="javascript:dosubmit();"> 
						<input type="button" value="提交" style="margin-bottom: 100px;margin-left: 30px" />
						</a>
				
  		</div>
  		
  	</form>
  
  
  </div>
  
  </body>
</html>
