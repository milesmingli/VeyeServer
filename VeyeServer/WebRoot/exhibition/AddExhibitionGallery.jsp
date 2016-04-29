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
	
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/component.css" />
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/component.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	<script type="text/javascript">
	var type=$.cookie('type_cookie');
	var id = $.cookie('userid');
	var randomconut = Math.floor(Math.random() * 1000);

	window.onload = function() {
	
		if(type=="seller_organization"){
			
			$.ajax({
				
				url : "./SelectElementServlet?slectname=*"
						+"&tablename=user where id="+id+
						"&randomconut="+ randomconut,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				error : function(request, error) {
					alert(error);
				},
		
				success : function(data) {
		
					console.log("data:" + JSON.stringify(data));
					var galleryid=data[0].galleryid;
					var gallery=document.getElementById("gallery");

					$.ajax({
						
						url : "./SelectElementServlet?slectname=*"
								+"&tablename=gallery where id='"+galleryid+"'"+
								"&randomconut="+ randomconut,
						dataType : "json",
						contentType : "application/x-www-form-urlencoded; charset=utf-8",
						error : function(request, error) {
							alert(error);
						},
				
						success : function(data) {
				
							console.log("data:" + JSON.stringify(data));
							gallery.options.add(new Option(data[0].name,(data[0].name+","+data[0].id))); 

								
								
						}
					});
								 
				}
			});
			
			
			
		}else if(type=="veye"){
			
	//从画廊表里查找所有画廊返回结果添加到页面
	var sql="select * from gallery where type='机构'";
	$.ajax({

		url : "<%=basePath%>/SelectTypeServlet?sql="+sql,

		dataType : "json",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",

		error : function(request, error) {
			alert(error);
		},

		success : function(data) {
			var select = document.getElementById("gallery");
		
			
			for(var i=0;i <data.length; i++){
				
				var opt = document.createElement('option');
			
                opt.value =data[i].name+","+data[i].id;
                opt.selected = false;
                opt.innerHTML =data[i].name;
                select.appendChild(opt);  
			}
		
		
	
		}
	});

	}	
	
	var input = document.getElementById("demo_input");
	var result = document.getElementById("result");
	var img_area = document.getElementById("img_area");
	if (typeof (FileReader) === 'undefined') {
		result.innerHTML = "抱歉，你的浏览器不支持 FileReader，请使用chrome浏览器操作！";
		input.setAttribute('disabled', 'disabled');
	} else {
		input.addEventListener('change', readFile, false);
	}	
	
	
}
	function readFile() {
		
		
		var file = this.files[0];
		//这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件 
		if (!/image\/\w+/.test(file.type)) {
			alert("请确保文件为图像类型");
			return false;
		}
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e) {
			result.innerHTML = this.result.split(",")[1];
			
			img_area.innerHTML = '<div class="sitetip" ></div><img src="'+this.result+'" alt="" width="260px" height="260px" style="border:#AAAAAB 2px solid;display:none" id="imgs"/>';
			document.getElementById("targetimg").src=document.getElementById("imgs").src;
			imgresize();
		
			
		}
	

	}
	
	function dosubmit() {
	

		var RsStream=document.getElementById("result").value;
		var name=document.getElementById("name").value;
		var brief=document.getElementById("brief").value;
		var starttime=document.getElementById("starttime").value;
		var endtime=document.getElementById("endtime").value;
		var gallery=document.getElementById("gallery").value;
		var email=document.getElementById("email").value;

	
		
	
				 if(RsStream== null || RsStream== ""){
					   alert("请上传图片");
						return;
					   
				    }else if(name== null || name== ""){
						   alert("作品名不能为空");
							return;
					}else if(brief== null || brief== ""){
							alert("简介不能为空");
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
					 document.getElementById("submitbutton").disabled=true;

		
		}
	
	
	</script>
	
	
  </head>
  <div style="text-align: center;margin-top: 100px">
	
	
	</div>
	<div style="border:#AAAAAB 2px solid;width: 1000px;height:800px;margin-left: 20px">
		<div style="font-size: 14px;margin-top: 30px">
		
			<form action="${pageContext.request.contextPath}/InsertExhibitionServlet" method="post" name="form1">
				
				<div style="float: left;margin-left: 20px">
				<input type="file" value="sdgsdg" id="demo_input" />
				
				<textarea id="result" rows=30 cols=300 name=RsStream style="display: none" ></textarea>
				<p id="img_area"></p>
									  <div class="content">
			
				<div class="component">
				
					<div class="overlay">
						<div class="overlay-inner"></div>
					</div>
					<strong style="color: #49708A">
					<img class="resize-image" src="" id="targetimg" alt="请上传头像" >
					</strong>
				</div>
				<div class="a-tip">
					<p><strong>提示:</strong> 按住 <span>Shift</span>可等比缩放</p>
					<p>头像像素不得超过500x500</p>
				</div>
			</div><!-- /content -->
				</div>
				<div style="float: right;margin-top: 60px;margin-right: 20px;margin-right: 10px;">
				展览id&nbsp;: <input type="text" value="${requestScope.idname}" id="exhibitionid" name="exhibitionid" readonly="readonly"/>				
				<br/>
 				展出标题: <input type="text" id="name" name="name" style="margin-top: 10px"/>&nbsp;&nbsp;<font color='red'>*</font>				
 				<br/>
				展出简介: <textarea type="text" id="brief" name="brief" style="margin-top: 10px;width: 200px;height: 200px"></textarea>&nbsp;<font color='red'>*</font>			
 				<br/>
				开始时间:  <input type="text" class="Wdate"  id="starttime" name="starttime" placeholder="请选择日期" onClick="WdatePicker()"  value="" style="margin-top: 10px;"/>&nbsp;&nbsp;<font color='red'>*</font>
		  		<br>
		  		结束时间:  <input type="text" class="Wdate"  id="endtime" name="endtime" placeholder="请选择日期" onClick="WdatePicker()"  value="" style="margin-top: 10px;"/>&nbsp;&nbsp;<font color='red'>*</font>
		  		<br>
		  		主办单位: <select id="gallery" name="gallery" style="margin-top: 10px;width: 72%;"></select>&nbsp;<font color='red'>*</font>
		  		<br>
		  		联 系 人:  <input type="text" id="contactperson" name="contactperson" style="margin-top: 10px"/>
		  		<br>
		  		联系电话: <input type="text" id="phone" name="phone" style="margin-top: 10px"/>
		  		<br>
		  		 传&nbsp;&nbsp;真&nbsp;&nbsp;&nbsp;&nbsp;: <input type="text" id="fax" name="fax" style="margin-top: 10px"/>
		  		<br>
		  		联系邮箱: <input type="text" id="email" name="email" style="margin-top: 10px;margin-bottom: 20px"/>
		  		<br>
					<div style="margin-left: 120px;margin-top: 15px">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="提交"  id="submitbutton" class="js-crop"/>
						
						</a>
					</div>
				
				</div>
			
				
			</form>
	
		</div>
	</div>
  </body>
</html>
