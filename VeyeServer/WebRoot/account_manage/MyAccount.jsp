<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>MyAccount.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/time.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jsAddress.js"></script>
    
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo300.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/component.css" />
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/component.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	<style type="text/css">
	.input_1 {
	font-family: 微软雅黑;
	font-size: 10 px;
	border: 1px;
	color: red;
	width: 330px;
	text-align: center;
	margin-top: 5px;
	}
	
	.input_2 {
		font-family: 微软雅黑;
		font-size: 10 px;
		border: 1px;
		color: #7FFFAA;
		width: 330px;
		text-align: center;
		margin-top: 5px;
	}
		
	
	</style>
	
		
<script type="text/javascript" charset="utf-8"> 

	var count=0;
	var randomconut = Math.floor(Math.random() * 1000);
	var name=null;
	var phone=null;
	var email=null;
	var alldata=null;
	var user=null;
	var user_id = $.cookie('userid');
	var type=null;
	var randomconut = Math.floor(Math.random() * 1000);
	


	
	window.onload = function() {
		$.ajax({
			url : '<%=basePath%>/SelectElementServlet?slectname=*'
				+"&tablename=user where id="+user_id+
				"&randomconut="+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				//alert(error+"1");
			},

			success : function(data) {
				//console.log("data2:" + JSON.stringify(data));
			
				type=data[0].type;
				
				document.getElementById("type").value=type;
				
			}
			
		});
		
		
		
		
		var id="${requestScope.idname}";
		 user = $.cookie('user_cookie');
		$.ajax({

			url : "./CheckAccountServletForOnly?id="+ id
		  	+ "&randomconut=" + randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				alert(error);
			},

			success : function(data) {

				
				alldata=data;
				//console.log("alldata:" + JSON.stringify(alldata));

			}
		});
		
		
		$.ajax({
			
		    url : "./GetAccountByIdServelt?id="+ id
		  	+ "&randomconut=" + randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				alert(error);
			},
	
			success : function(data) {
	
				//console.log("data:" + JSON.stringify(data));
			
				if(data[0].realname!=null && data[0].realname!="" && data[0].realname!=undefined){
					

					
					document.getElementById("name").value=data[0].realname;
					
			
					if(data[0].phone!=null && data[0].phone!="" && data[0].phone!=undefined){
						
						document.getElementById("phone").value=data[0].phone;
					}
					
					if(data[0].nickname!=null && data[0].nickname!="" && data[0].nickname!=undefined){
						
						document.getElementById("nickname").value=data[0].nickname;
					}
					
					
					
					if(data[0].address!=null && data[0].address!="" && data[0].address!=undefined){
						
						//addressInit('cmbProvince', 'cmbCity', 'cmbArea', '北京', '市辖区', '朝阳区');

						var prov=(data[0].address).split(",")[0];
						var city=(data[0].address).split(",")[1];
						var dist=(data[0].address).split(",")[2];

						
						addressInit('cmbProvince', 'cmbCity', 'cmbArea', prov, city, dist);
					
					}
					
					if(data[0].gender!=null && data[0].gender!="" && data[0].gender!=undefined){
						var gender= data[0].gender;
						var ridaolen=document.form1.gender.length;
						 for(var i=0;i<ridaolen;i++){
					            if(gender==document.form1.gender[i].value){
					                document.form1.gender[i].checked=true;
					            }
					        }
			
						}
						
					if(data[0].email!=null && data[0].email!="" && data[0].email!=undefined){
						
						document.getElementById("email").value=data[0].email;
					}
					
					if(data[0].birthday!=null && data[0].birthday!="" && data[0].birthday!=undefined){
						
						document.getElementById("birthday").value=data[0].birthday;
					}
					
					if(data[0].portrait!=null && data[0].portrait!="" && data[0].portrait!=undefined){
						document.getElementById("picarea").style.display="block";
						document.getElementById("imgid").src = "./"+data[0].portrait+"?rand="+randomconut;
						document.getElementById("ispic").value="2";

					}
					
					
						if(user!=null && user!="" && user!="undefined"){			
						
						if(user.indexOf("@")>0){
						 //////console.logole.log(user);
						 name="email";
						 document.getElementById("email").value=user;
						}else{
							 //////console.log(user);
							 name="phone";
							 document.getElementById("phone").value=user;
							}
						
						 	document.getElementById("columnname").value=name;
							phone=document.getElementById("phone").value;
							email=document.getElementById("email").value;
						
						}
					
					
					}else{
			
					if(user!=null && user!="" && user!="undefined"){			
						
						if(user.indexOf("@")>0){
						 //////console.log(user);
						 name="email";
						 document.getElementById("email").value=user;
						 document.getElementById("email").disabled=true;
						}else{
							 //////console.log(user);
							 name="phone";
							 document.getElementById("phone").value=user;
							 document.getElementById("phone").disabled=true;	
							
						}
						
						 	document.getElementById("columnname").value=name;
							phone=document.getElementById("phone").value;
							email=document.getElementById("email").value;
						
				
					 
						
						}
						 document.getElementById("picarea").style.display="none";
						 document.getElementById("piccontent").style.display="block";

					addressInit('cmbProvince', 'cmbCity', 'cmbArea', '北京', '市辖区', '朝阳区');

					
				}
				
				
			}
		});
		
		
		
	
	
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
	var imgs = new Image();
	function readFile() {
		
		
		var file = this.files[0];
		//这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件 
		if (!/image\/\w+/.test(file.type)) {
			alert("请确保文件为图像类型");
			return false;
		}
		var filetype = "jpg,jpeg,png,JPG,JPEG,PNG";

		if (filetype.indexOf(file.type.split("/")[1]) < 0) {
			alert("不支持的文件格式，请上传格式为,jpg,png,类型的图片");

			return false;
		}
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e) {
			result.innerHTML = this.result.split(",")[1];
			
			img_area.innerHTML = '<div class="sitetip" ></div><img src="'+this.result+'" alt="" width="260px" height="260px" style="border:#AAAAAB 2px solid; display:none" id="imgs"/>';
			document.getElementById("targetimg").src=document.getElementById("imgs").src;
			document.getElementById("ispic").value="1";
			imgresize();
		
			if (filetype.indexOf(file.type.split("/")[1]) < 0) {
			
				document.getElementById("result").value = "";

			}
	
			
			
		}
	

	}
	

	function CheckInput(){
		var RsStream=document.getElementById("result").value;
		var username=document.getElementById("name").value;
		var nickname=document.getElementById("nickname").value;
		var birthday=document.getElementById("birthday").value;
		var gender=document.getElementById("gender").value;
		var prov = document.getElementById("cmbProvince").value;
		var phone=document.getElementById("phone").value;
		var email=document.getElementById("email").value;
		var reg =/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
		
		if(nickname!="" && nickname!=null){
			
			if (!reg.test(nickname)) {
				 document.getElementById("tishi1").className = "input_1";
				 document.getElementById("tishi1").value = "仅支持10字节内的中文数字字母下划线组合。";
				 return false;
			 }else if(nickname.replace(/[^\x00-\xff]/g,"aa").length>10){
				 document.getElementById("tishi1").className = "input_1";
				 document.getElementById("tishi1").value = "仅支持10字节内的中文数字字母下划线组合。";
				 return false;
			 } else{
				 document.getElementById("tishi1").className = "input_2";
				 document.getElementById("tishi1").value = "输入正确"; 
				 for(var i=0;i<alldata.length;i++){
					
					 if(nickname==alldata[i].nickname){
						 document.getElementById("tishi1").className = "input_1";
						 document.getElementById("tishi1").value = "该昵称已存在"; 
						 return false;
					 }
					 
				 }
				
				 
			 }
		}
		
		var namereg=/^[a-zA-Z \s\.]+$|^[\u4E00-\u9FA5]+$/;
		if(username!="" && username!=null){
		
			if (!namereg.test(username)) {
				 document.getElementById("tishi2").className = "input_1";
				 document.getElementById("tishi2").value = "请输入正确的姓名";
				 return false;
			}else if(username.replace(/[^\x00-\xff]/g,"aa").length>100){
				 document.getElementById("tishi2").className = "input_1";
				 document.getElementById("tishi2").value = "请输入正确的姓名";
				 return false;
			}else{
				 document.getElementById("tishi2").className = "input_2";
				 document.getElementById("tishi2").value = "输入正确";
				 document.getElementById("name").value = username.replace(/(^\s*\.)|(\s*\.$)/g,'');
				 
			}
		}
	
		if(name=="phone"){
		

			if (email != null && email != "") {

				var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
				if (!filter.test(email)) {
					document.getElementById("tishi5").className = "input_1";
					document.getElementById("tishi5").value = "邮箱格式不正确";
					return false;
				} else {

					document.getElementById("tishi5").className = "input_2";
					document.getElementById("tishi5").value = "输入正确";
					
					 for(var i=0;i<alldata.length;i++){

						 if(email==alldata[i].email){
							 document.getElementById("tishi5").className = "input_1";
							 document.getElementById("tishi5").value = "该邮箱已存在"; 
							 return false;
						 }
					 }
					
				}
			}	if (phone != null && phone != "") {

				var filter = /^1\d{10}$/;
				if (!filter.test(phone)) {
					document.getElementById("tishi4").className = "input_1";
					document.getElementById("tishi4").value = "请输入正确的11位手机号";

					return false;
				} else {

					document.getElementById("tishi4").className = "input_2";
					document.getElementById("tishi4").value = "输入正确";
					
					 for(var i=0;i<alldata.length;i++){

						 if(phone==alldata[i].phone){
							 document.getElementById("tishi4").className = "input_1";
							 document.getElementById("tishi4").value = "该手机号已存在"; 
							 return false;
						 }
					 }
					
					
				}
			}
			
			
		}else if(name=="email"){
			
			if (phone != null && phone != "") {

				var filter = /^1\d{10}$/;
				if (!filter.test(phone)) {
					document.getElementById("tishi4").className = "input_1";
					document.getElementById("tishi4").value = "请输入正确的11位手机号";

					return false;
				} else {

					document.getElementById("tishi4").className = "input_2";
					document.getElementById("tishi4").value = "输入正确";
					
					 for(var i=0;i<alldata.length;i++){

						 if(phone==alldata[i].phone){
							 document.getElementById("tishi4").className = "input_1";
							 document.getElementById("tishi4").value = "该手机号已存在"; 
							 return false;
						 }
					 }
					
					
				}
			}
			
			if (email != null && email != "") {

				var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
				if (!filter.test(email)) {
					document.getElementById("tishi5").className = "input_1";
					document.getElementById("tishi5").value = "邮箱格式不正确";
					//alert(email);
					return false;
				} else {

					document.getElementById("tishi5").className = "input_2";
					document.getElementById("tishi5").value = "输入正确";
					
					 for(var i=0;i<alldata.length;i++){

						 if(email==alldata[i].email){
							 document.getElementById("tishi5").className = "input_1";
							 document.getElementById("tishi5").value = "该邮箱已存在"; 
							 return false;
						 }
					 }
					
				}
			}
			
		}
	}
	
	
	function dosubmit() {
		CheckInput();
	
		var RsStream=document.getElementById("result").value;
		var username=document.getElementById("name").value;
		var nickname=document.getElementById("nickname").value;
		var birthday=document.getElementById("birthday").value;
		var gender=document.getElementById("gender").value;
		var prov = document.getElementById("cmbProvince").value;
		var phone=document.getElementById("phone").value;
		var email=document.getElementById("email").value;
				
				 if(document.getElementById("ispic").value==0){
					 
				   alert("请上传图片");
					return;
				   
			    }else if(username== null || username== ""){
					   alert("姓名不能为空");
						return;
					   
				   }else if(birthday== null || birthday== ""){
					   alert("生日不能为空");
						return;
					   
				   }
				 //ajax提交
				 if(CheckInput()!=false){
					 
					 document.getElementById("replacephone").value=phone;
					 document.getElementById("replaceemail").value=email;
					 document.form1.submit();
					 document.getElementById("submitbutton").disabled=true;
					 var cookivalue=null;
						if(user.indexOf("@")>0){
							 cookivalue= document.getElementById("email").value;
							$.cookie('user_cookie', cookivalue, { expires: 365, path: '/' }); 

							}else{
							cookivalue= document.getElementById("phone").value;
							$.cookie('user_cookie', cookivalue, { expires: 365, path: '/' }); 
							}
					 
					// alert("修改成功");
					 alert("修改成功");
					// parent.location.href="account_manage/AccountMain.html";
			
					
					 
					}
			
			
			
	
	}

	
	/* function GenderChanged(obj){
		
		count++;
		CheckInput();
		} */
	
	 function updatepic(){
		 document.getElementById("picarea").style.display="none";
		 document.getElementById("piccontent").style.display="block";
		 
	 }
	
	
</script>
  </head>
  
<body style="font-family: 微软雅黑">  

	<div style="width: 1100px;height:800px;margin-left: 10px;">
		<div style="font-size: 14px;margin-top: 30px">

			<form action="${pageContext.request.contextPath}/UpdateMyAccountServlet" method="post" name="form1">
				
				<div style="float: left;margin-left: -10px">
			
				<div id="picarea" style="text-align: center;display: none;">
					<img alt="" src="" id="imgid" width="200px" height="200px">
					<br>
					<br>
					<input type="button" value="修改图片" onclick="updatepic()">
				</div>
				
			<div style="float: left;margin-left: -10px;display: none" id="piccontent">
				
				<input type="file" value="sdgsdg" id="demo_input" accept="image/png, image/jpeg" style="margin-left: 15px" />
				
				<textarea id="result" rows=30 cols=300 name=RsStream style="display: none" ></textarea>
				<p id="img_area"></p>
				
					
					<div class="content">
				
					<div class="component" style="width: 250px;height: 250px" >
					
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
				
				
				</div>
				<div style="float: left;margin-left: 50px">
				昵 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称 &nbsp;<input type="text" id="nickname" name="nickname" value="" style="margin-top: 5px" onkeyup="CheckInput()"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				姓 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名 &nbsp;<input type="text" id="name" name="name" value="" style="margin-top: 5px" onkeyup="CheckInput()" />&nbsp;<font color='red'>*</font>
				<br/>
				<input id="tishi1" value="" readonly="readonly" class="input_1" disabled="disabled" style="background-color: #fff;">
				<input id="tishi2" value="" readonly="readonly" class="input_1" disabled="disabled" style="background-color: #fff">
				<br/>
			           生 &nbsp; &nbsp; &nbsp;日 &nbsp; <input type="text" class="Wdate"  id="birthday" name="birthday" placeholder="请选择日期" onClick="WdatePicker()"   value="" style="margin-top: 5px" />&nbsp;<font color='red'>*</font>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 别 &nbsp;<input type="radio" name="gender" id="gender"  value="0" style="margin-top: 5px" checked="checked">&nbsp;&nbsp; 男&nbsp;&nbsp; &nbsp;&nbsp; 
				<input type="radio" name="gender" id="gender" value="1" style="margin-top: 5px" >&nbsp;&nbsp; 女&nbsp;<font color='red'>*</font>
				<br/>
				 <input id="tishi6" value="" readonly="readonly" class="input_1" disabled="disabled" style="background-color: #fff">
				
				<input id="tishi3" value="" readonly="readonly" class="input_1" disabled="disabled" style="background-color: #fff">
				<br/>
				<br/>
				手 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机 &nbsp;<input type="text" id="phone" name="phone" value="" style="margin-top: 5px" onkeyup="CheckInput()"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			
				邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 箱 &nbsp;<input type="text" id="email" name="email" value="" style="margin-top: 5px" onkeyup="CheckInput()"/>
				<br/>
				<input id="tishi4" value="" readonly="readonly" class="input_1" disabled="disabled" style="background-color: #fff">
				<input id="tishi5" value="" readonly="readonly" class="input_1" disabled="disabled" style="background-color: #fff">				
				<br/>
				<br/>
				城 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市 &nbsp;<select id="cmbProvince" name="prov" style="width: 153px"></select>
					&nbsp;<select id="cmbCity" name="city" style="width: 180px"></select>
					&nbsp;<select id="cmbArea" name="dist" style="width: 180px"></select>&nbsp;<font color='red'>*</font>
				<input type="text" id="columnname" name="columnname" style="display:none"/>
				<input type="text" id="userid" name="userid" value="${requestScope.idname}" style="display: none"/>
				<input type="text" id="replaceemail" name="replaceemail" style="display:none"/>
				<input type="text" id="replacephone" name="replacephone" style="display:none"/>
				<input type="text" id="ispic" name="ispic" value="0" style="display:none"/>
				 <input type="text" id="type" name="type" value="" style="display:none"/>
				 
				
					<div style="margin-left: 300px;margin-top: 35px">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="  提  交  "  id="submitbutton" class="js-crop"/>
						</a>
					</div>
				
				</div>
			
				
			</form>
	
		</div>
	</div>
  </body>
</html>
