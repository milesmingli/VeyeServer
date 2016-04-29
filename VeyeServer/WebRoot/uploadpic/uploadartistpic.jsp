<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>uploadartistpic.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/time.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jsAddress.js"></script>
    
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/component.css" />
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/component.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	
	
		
<script type="text/javascript" charset="utf-8"> 
	var count=0;
	var randomconut = Math.floor(Math.random() * 1000);
	var type=$.cookie('type_cookie');
	var id = $.cookie('userid');
	var allname=null;
	var isaudit=null;
	if(type=="seller_organization"){
		var tablename="artist";
		var slectname="*";
		$.ajax({

			url : "./SelectElementServlet?slectname=*"
					+"&tablename=artist"+
					"&randomconut="+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				alert(error);
			},

			success : function(data) {

				console.log("data:" + JSON.stringify(data));
				
				allname=data;
		
				 
			}
		});
		
	}
	window.onload = function() {
		
		if(type=="veye"){
			
			 document.getElementById("gallerydiv").style.display="block";
			
		}
		var namevalue=document.getElementById("name").value;
		if(namevalue.length>0){
			document.getElementById("demo_input").disabled=false;
		}else{
			document.getElementById("demo_input").disabled=true;

		}
		document.getElementById("id").value=id;

		addressInit('cmbProvince', 'cmbCity', 'cmbArea', '北京', '市辖区', '朝阳区');
		//time();
		var input = document.getElementById("demo_input");
		var result = document.getElementById("result");
		var img_area = document.getElementById("img_area");
		if (typeof (FileReader) === 'undefined') {
			result.innerHTML = "抱歉，你的浏览器不支持 FileReader，请使用chrome浏览器操作！";
			input.setAttribute('disabled', 'disabled');
		} else {
			input.addEventListener('change', readFile, false);
		}
	
		$.ajax({

			url : "./ArtistCategoryServlet?randomconut="
					+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				alert(error);
			},

			success : function(data) {

				console.log("data:" + JSON.stringify(data));
				
				var select = document.getElementById("artistcategory");

				
				for(var i=0;i<data.length;i++){
					
					var opt = document.createElement('option');
					
	                opt.value =data[i].category;
	                opt.selected = false;
	                opt.innerHTML =data[i].category;
	                select.appendChild(opt);  
					
					
				}

				//alldata=data;

			}
		});
	 
		
		
		
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
			alert("不支持的文件格式，请上传格式为,jpg,jpeg,类型的图片");

			return false;
		}
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e) {
			result.innerHTML = this.result.split(",")[1];
			
			img_area.innerHTML = '<div class="sitetip" ></div><img src="'+this.result+'" alt="" width="260px" height="260px" style="border:#AAAAAB 2px solid; display:none" id="imgs"/>';
			document.getElementById("targetimg").src=document.getElementById("imgs").src;
			imgresize();
		
			if (filetype.indexOf(file.type.split("/")[1]) < 0) {
			
				document.getElementById("result").value = "";

			}
	
			
			
			
			
		}
	

	}
	

	
	function dosubmit() {
		var isaudit=$.cookie('isaudit');
		if(isaudit!="null"){
			document.getElementById("isaudit").value=isaudit;
	    	$.cookie('isaudit', null, { expires: 1, path: '/' }); 
		}
	

		var RsStream=document.getElementById("result").value;
		var username=document.getElementById("name").value;
		var birthday=document.getElementById("birthday").value;
		var brief=document.getElementById("brief").value;
		var gender=document.getElementById("gender").value;
		var prov = document.getElementById("cmbProvince").value;
		var phone=document.getElementById("phone").value;
		var email=document.getElementById("email").value;
		
		 if(username== null || username== ""){
				   alert("姓名不能为空");
					return;
			 	}else if(RsStream== null || RsStream== ""){
				   alert("请上传图片");
					return;
				   
			   }else if(birthday== null || birthday== ""){
				   alert("年代不能为空");
					return;
				   
			   }
			 	
			 	else if(brief== null || brief== ""){
				   alert("简介不能为空");
					return;
				   
			   }
			 	 else if(count==0){
					   alert("性别不能为空");
						return;
					   
				   } else if(prov== null || prov== ""){
						alert("请补全城市信息");
						return;
					   
				   }
		 if (birthday != null && birthday != "") {

				var filter =/^\d{4}$/;
				if (!filter.test(birthday)) {
				alert("请输入四位数字日期");
				return;
				}
				
				
		
				
		 }
		 	 document.getElementById("birthday").value=birthday+"-01-01";
			 document.form1.submit();
			 document.getElementById("submitbutton").disabled=true;
	
	}

	
	function GenderChanged(obj){
		
		count++;
			
		}
	

	
	
	function CategorycChange(obj){
	//	alert(obj.value);
	
	if((obj.value).indexOf("国外")>=0){
		
		 document.getElementById("country").disabled=false;
		

	}else{
		 document.getElementById("country").value="";
		 document.getElementById("country").disabled=true;
		
	}
		
	}
	
	function Checkname(){
		var namevalue=document.getElementById("name").value;
		if(namevalue.length>0){
			document.getElementById("demo_input").disabled=false;
		}else{
			document.getElementById("demo_input").disabled=true;

		}
	
		if(type=="seller_organization"){
		

		 var name=document.getElementById("name").value;
		 
		 var name1=null;
			 for(var i=0;i<allname.length;i++){
				
				 if(name==allname[i].name){
					 name1=allname[i].name;
				}
				
				
		 	}
			 
			 if(name==name1){
				name=encodeURI(encodeURI(name));
				alert("艺术家同名，将跳转至同名艺术家界面");
				window.location.href="uploadpic/SameName.jsp?name="+name;
			 } 
		}	
		
	}
	
	
</script>
  </head>
  
  <body>
  

	<div style="border:#AAAAAB 2px solid;width: 1000px;height:800px;margin-left: 20px;margin-top: 100px">
		<div style="font-size: 14px;margin-top: 30px">

			<form action="${pageContext.request.contextPath}/UpdateArtistServlet" method="post" name="form1">
				
				<div style="float: left;margin-left: 10px">
				<input type="file" value="sdgsdg" id="demo_input" accept="image/png, image/jpeg"  disabled="disabled"/>
				
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
				I&nbsp;D&nbsp;&nbsp;:<input type="text" id="userid" name="userid"  value="${requestScope.idname}"  readonly="readonly"/>
				<br/>
				姓 名:<input type="text" id="name" name="name" value="" style="margin-top: 5px" onkeyup=" Checkname()"/>&nbsp;<font color='red'>*</font>
				<br/>
				<!-- 生 日:<input type="text" class="Wdate"  id="birthday" name="birthday" placeholder="请选择日期" onClick="WdatePicker()"  value="" style="margin-top: 5px"/>&nbsp;<font color='red'>*</font>
				<br/> -->
			<!-- 	年 代:<select id="birthday" name="birthday" style="margin-top: 5px;width:200px"></select>&nbsp;<font color='red'>*</font>
				<br/> -->
				
				年 代:	<input type="text" id="birthday" name="birthday" value="" style="margin-top: 5px"/>&nbsp;<font color='red'>*</font>
				<br/>
				简 介:<textarea  type="text" id="brief" name="brief" value=""  style="margin-top: 5px;width: 300px;height: 130px" ></textarea>&nbsp;<font color='red'>*</font>
				<br/>
				性 别:<input type="radio" name="gender" id="gender"  value="男" style="margin-top: 5px" onclick="GenderChanged(this)">男
				<input type="radio" name="gender" id="gender" value="女" style="margin-top: 5px" onclick="GenderChanged(this)">女&nbsp;<font color='red'>*</font>
				<br/>
				居住地:<select id="cmbProvince" name="prov"></select>
					:<select id="cmbCity" name="city"></select>
					:<select id="cmbArea" name="dist"></select>&nbsp;<font color='red'>*</font>
					
				<br/>
				作家类型:<select id="artistcategory" name="artistcategory" onchange="CategorycChange(this)"></select>
				<br/>
				 国 家:<input type="text" id="country" name="country" value="" style="margin-top: 5px" disabled="disabled"/>
				<br/>
				<div style="display: none" id="gallerydiv">
				是否为给改作者建画廊:<input type="radio" name="isgallery" id="isgallery"  value="是" style="margin-top: 5px" >是
				<input type="radio" name="isgallery" id="isgallery" value="否" style="margin-top: 5px"  checked="checked">否&nbsp;<font color='red'>*</font>
				</div>
				<br/>
				手 机:<input type="text" id="phone" name="phone" value="" style="margin-top: 5px"/>
				<br/>
				电 话:<input type="text" id="telephone" name="telephone" value="" style="margin-top: 5px"/>
				<br/>
				传 真:<input type="text" id="fax" name="fax" value="" style="margin-top: 5px"/>
				<br/>
				网 站:<input type="text" id="web" name="web" value="" style="margin-top: 5px"/>
				<br/>
				邮 箱:<input type="text" id="email" name="email" value="" style="margin-top: 5px"/>
				<br/>
					<div style="margin-left: 120px;margin-top: 15px">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="提交"  id="submitbutton" class="js-crop"/>
						</a>
					</div>
				<input type="text" id="isaudit" name="isaudit" value="0" style="margin-top: 5px;display: none"/>
				<input type="text" id="id" name="id" value="" style="margin-top: 5px;display: none"/>
				
				</div>
			
				
			</form>
	
		</div>
	</div>
  </body>
</html>
