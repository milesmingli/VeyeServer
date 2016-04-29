<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>creategallery.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jsAddress.js"></script>

	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/component.css" />
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/component.js"></script>

<script type="text/javascript" charset="utf-8"> 


	window.onload = function() {
		addressInit('cmbProvince', 'cmbCity', 'cmbArea', '北京市', '市辖区', '朝阳区');


		
		
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
		var filetype = "jpg,jpeg,png,JPG,JPEG,PNG";

		if (filetype.indexOf(file.type.split("/")[1]) < 0) {
			alert("不支持的文件格式，请上传格式为,jpg,jpeg,类型的图片");

			return false;
		}
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e) {
			result.innerHTML = this.result.split(",")[1];
			
			img_area.innerHTML = '<div class="sitetip" ></div><img src="'+this.result+'" id="imgs"alt="" width="260px" height="260px" style="border:#AAAAAB 2px solid;display:none"/>';
			
			document.getElementById("targetimg").src=document.getElementById("imgs").src;
			imgresize();
			if (filetype.indexOf(file.type.split("/")[1]) < 0) {
				
				document.getElementById("result").value = "";

			}
		}
	

	}
	

	
	function dosubmit() {
	

		var RsStream=document.getElementById("result").value;
		var username=document.getElementById("name").value;
		var brief=document.getElementById("brief").value;
		
		var address=document.getElementById("address").value;
		var contactperson=document.getElementById("contactperson").value;
		var telephone=document.getElementById("telephone").value;
		var email=document.getElementById("email").value;
		var seachprov=document.getElementById("cmbProvince").value;
			
				 if(username== null || username== ""){
					   alert("姓名不能为空");
						return;
				 	}else if(RsStream== null || RsStream== ""){
					   alert("请上传图片");
						return;
					   
				   }else if(brief== null || brief== ""){
					   alert("简介不能为空");
						return;
					   
				   }else if(seachprov== null || seachprov== ""){
					   alert("请补全城市信息");
						return;
					   
				   } else if(address== null || address== ""){
					   alert("请输入街道");
						return;
					   
				   }
				   else if(telephone== null || telephone== ""){
					   alert("电话不能为空");
						return;
					   
				   }/*else if(email== null || email== ""){
					   alert("邮箱不能为空");
						return;
				   }else if(contactperson== null || contactperson== ""){
					    alert("联系人不能为空");
						return;
				   }
				 */
			 		//正则验证输入邮箱，性别，手机。。。。
					if(email!= null || email!= ""){
					
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
  
  <body>
   <div style="text-align: center;margin-top: 100px">
	
	
	</div>
	<div style="border:#AAAAAB 2px solid;width: 1000px;height:600px;margin-left: 20px">
		<div style="font-size: 14px;margin-top: 30px">
		
			<form action="${pageContext.request.contextPath}/UploadGalleryServlet" method="post" name="form1">
				
				<div style="float: left;margin-left: 10px">
				<input type="file" value="sdgsdg" id="demo_input" accept="image/png, image/jpeg" />
				
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
				<div style="float: right;margin-top: 60px;margin-right: 20px;margin-right: 100px;">
				I&nbsp;D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" id="userid" name="userid"  value="${requestScope.idname}"  readonly="readonly" style="width:225px"/>
				<br/>
			
				用户名称&nbsp;:<input type="text" id="name" name="name" value="" style="margin-top: 5px;width:225px"/>&nbsp;<font color='red'>*</font>
				<br/>
				简 介&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<textarea  type="text" id="brief" name="brief" value=""  style="margin-top: 5px;width: 300px;height: 130px" ></textarea>&nbsp;<font color='red'>*</font>
				<br/>
				  	城&nbsp;市&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：<select id="cmbProvince" name="prov"></select>
					：<select id="cmbCity" name="city"></select>
					：<select id="cmbArea" name="dist"></select>&nbsp;<font color='red'>*</font>
				<br/>
				街&nbsp;道&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" id="address" name="address" value="" style="margin-top: 5px;width:225px"/>&nbsp;<font color='red'>*</font>
				<br/>
				电 话&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" id="telephone" name="telephone" value="" style="margin-top: 5px;width:225px"/>&nbsp;<font color='red'>*</font>
				<br/>
				联系人&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" id="contactperson" name="contactperson" value="" style="margin-top: 5px;width:225px"/>
				<br/>
				手&nbsp;机&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" id="phone" name="phone" value="" style="margin-top: 5px;width:225px"/>
				<br/>
			
				传 真&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" id="fax" name="fax" value="" style="margin-top: 5px;width:225px"/>
				<br/>
				网 站&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" id="web" name="web" value="" style="margin-top: 5px;width:225px"/>
				<br/>
				邮&nbsp;箱&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type="text" id="email" name="email" value="" style="margin-top: 5px;width:225px"/>
				<br/>
			
					<div style="margin-left: 120px;margin-top: 15px">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="提交"  id="submitbutton" class="js-crop" />
						</a>
					</div>
				
				</div>
				
			</form>
	
		</div>
	</div>
  </body>
</html>
