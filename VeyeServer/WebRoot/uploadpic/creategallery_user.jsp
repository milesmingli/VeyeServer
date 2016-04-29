<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
      <base href="<%=basePath%>">
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>/js/My97DatePicker/WdatePicker.js"></script>
 	<script type="text/javascript" src="<%=basePath%>js/jsAddress.js"></script>
 	
 	 
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/component.css" />
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/component.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	
	
	<script type="text/javascript" charset="utf-8">
	
	
	window.onload = function(){
		addressInit('cmbProvince', 'cmbCity', 'cmbArea', '北京市', '市辖区', '朝阳区');

		var id=document.getElementById("userid").value;

		var sql=null;
		
		sql="select * from gallery where id='"+id+"'";
	
		sql=encodeURIComponent(sql);

		
		
		$.ajax({

			url : '<%=basePath%>/GalleryManage?sql='+sql,

			dataType :"json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				
				if(data[0].name!=null && data[0].name!="" &&data[0].name!=undefined){
					document.getElementById("name").value = data[0].name;
					
	        		$.cookie('type_cookie', "seller_organization", { expires: 365, path: '/' }); 

					parent.document.getElementById("mybackstage").style.display="block"; 
					

				}
				if(data[0].name!=null && data[0].name!="" &&data[0].name!=undefined){
					document.getElementById("name1").value = data[0].name;
				}if(data[0].brief!=null && data[0].brief!="" &&data[0].brief!=undefined){
					document.getElementById("brief").value =data[0].brief;
				}
				
				if(data[0].province!=null && data[0].province!="" &&data[0].province!=undefined){
					
				
				addressInit('cmbProvince', 'cmbCity', 'cmbArea', data[0].province, data[0].city, data[0].district);
				
				}
				if(data[0].address!=null && data[0].address!="" &&data[0].address!=undefined){
					
					document.getElementById("address").value = data[0].address;

				}
				if(data[0].contactperson!=null && data[0].contactperson!="" &&data[0].contactperson!=undefined){
								
								document.getElementById("contactperson").value = data[0].contactperson;
			
							}
				if(data[0].phone!=null && data[0].phone!="" &&data[0].phone!=undefined){
					
					document.getElementById("phone").value = data[0].phone;
			
				}
				if(data[0].telephone!=null && data[0].telephone!="" && data[0].telephone!=undefined){
					
					document.getElementById("telephone").value = data[0].telephone;
			
				}
				if(data[0].fax!=null && data[0].fax!="" &&data[0].fax!=undefined){
					
					document.getElementById("fax").value = data[0].fax;
			
				}
				if(data[0].web!=null && data[0].web!="" &&data[0].web!=undefined){
					
					document.getElementById("web").value = data[0].web;
			
				}
				if(data[0].email!=null && data[0].email!="" &&data[0].email!=undefined){
					
					document.getElementById("email").value = data[0].email;
			
				}
			
				
				
				
				
				if(data[0].portrait!="" && data[0].portrait!=null && data[0].portrait!=undefined){
					document.getElementById("picarea").style.display="block";
					document.getElementById("imgid").src = "<%=basePath%>"+data[0].portrait;

					
				}else{
					 document.getElementById("picarea").style.display="none";
					 document.getElementById("piccontent").style.display="block";
					

				}

				
				
	
			}
		}); 
		
	
		
		//FileReader
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
					
					document.getElementById("imgid").style.display ="none";
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
						
						img_area.innerHTML = '<div class="sitetip" ></div><img src="'+this.result+'" id="imgs" alt="" width="260px" height="260px" style="border:#AAAAAB 2px solid;display:none"/>';
						
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
						if(email!= null && email!= ""){
						
							 var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
							 if (!filter.test(email)){
								 alert('您的电子邮件格式不正确');
								 return;
							 }
						} 
						
					
						
					/* 	if(phone!= null || phone!= ""){
							
							 var filter  = /^1[3|4|5|8][0-9]\d{4,8}$/;
							 if (!filter.test(phone)){
								 alert('不是完整的11位手机号或者正确的手机号前七位');
								 return;
							 }
						} */
					
					document.form1.submit();
					 document.getElementById("submitbutton").disabled=true;
					 alert("修改成功");
		}
		 function updatepic(){
			 document.getElementById("picarea").style.display="none";
			 document.getElementById("piccontent").style.display="block";

			 
			 
		 }


	</script>

  </head>
  
<body>
	<div style="width: 1100px;height:800px;margin-left: 0px;margin-top: 50px;font-family: 微软雅黑">
		<div style="font-size: 14px;margin-top: 30px">
		
			<form action="${pageContext.request.contextPath}/UpDateNewGalleryServletForUser" method="post" name="form1">
				<div style="float: left;margin-left: 10px">
		
				<div id="picarea" style="text-align: center;">
					<img alt="" src="" id="imgid" width="200px" height="200px">
					<br>
					<br>
					<input type="button" value="修改图片" onclick="updatepic()">
				</div>
				
				
				<div style="float: left;margin-left: 0px;display: none" id="piccontent">
				
				<input type="file" value="sdgsdg" id="demo_input" accept="image/png, image/jpeg" />
				
				<textarea id="result" rows=30 cols=300 name=RsStream style="display: none" ></textarea>
				<p id="img_area" ></p>
				
				<div class="component" style="width: 250px;height: 250px" >
				
					<div class="overlay">
						<div class="overlay-inner"></div>
					</div>
					<strong style="color: #49708A">
					<img class="resize-image" src="" id="targetimg" alt="" >
					</strong>
				</div>
				<div class="a-tip">
					<p><strong>提示:</strong> 按住 <span>Shift</span>可等比缩放</p>
					<p>头像像素不得超过500x500</p>
					</div>
					
				</div><!-- /content -->
				</div>
				<div style="float: left;margin-top: 0px;margin-left: 20px;">
				I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="userid" name="userid"  value="${requestScope.idname}"  readonly="readonly" style="width:220px"/>
				&nbsp;&nbsp;&nbsp;&nbsp;
				名&nbsp;称&nbsp;&nbsp;<input type="text" id="name" name="name" value="" style="margin-top: 5px;width:220px"/>&nbsp;<font color='red'>请与执照保持一致</font>
				<br/>
				<br/>
				<br/>	
				简&nbsp;&nbsp;介&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea  type="text" id="brief" name="brief" value=""  style="margin-top: 5px;width: 505px;height:90px" placeholder="必填项，请输入简介"></textarea>&nbsp;<font color='red'>*</font>
				<br/>
				<br/>
				<br/>
				城&nbsp;&nbsp;&nbsp;市&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id="cmbProvince" name="prov" style="width: 110px"></select>
					&nbsp;<select id="cmbCity" name="city" style="width: 190px"></select>
					&nbsp;<select id="cmbArea" name="dist" style="width: 190px"></select>&nbsp;<font color='red'>*</font>
				<br/>
				<br/>
				<br/>
				地&nbsp;&nbsp;&nbsp;址&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="address" name="address" value="" style="margin-top: 5px;width:508px"/>&nbsp;<font color='red'>*</font>
				<br/>
				<br/>
				<br/>
				电&nbsp;&nbsp;&nbsp;话&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="telephone" name="telephone" value="" style="margin-top: 5px;width:220px"/>&nbsp;<font color='red'>*</font>
				&nbsp;&nbsp;&nbsp;
				联系人&nbsp;&nbsp;<input type="text" id="contactperson" name="contactperson" value="" style="margin-top: 5px;width:210px"/>
				<br/>
				<br/>
				<br/>
				手&nbsp;&nbsp;&nbsp;机&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="phone" name="phone" value="" style="margin-top: 5px;width:220px"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				传&nbsp;&nbsp;&nbsp;真&nbsp;&nbsp;&nbsp;<input type="text" id="fax" name="fax" value="" style="margin-top: 5px;width:210px"/>
				<br/>
				<br/>
				<br/>
				网 &nbsp;&nbsp;&nbsp;站&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="web" name="web" value="" style="margin-top: 5px;width:220px"/>
				&nbsp;&nbsp;&nbsp;&nbsp;
				邮&nbsp;&nbsp;&nbsp;箱&nbsp;&nbsp;&nbsp;<input type="text" id="email" name="email" value="" style="margin-top: 5px;width:210px"/>
				<br/>
				<br/>
				<br/>
				<input type="text" id="name1" style="display: none"/>
				
					<div style="margin-left: 290px;margin-top: 15px">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="  提  交  "  id="submitbutton"  class="js-crop"/>
						</a>
					</div>
				
				</div>
				
			</form>
	
		</div>
	</div>
  </body>
</html>
