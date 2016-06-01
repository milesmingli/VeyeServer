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
	var randomconut = Math.floor(Math.random() * 1000);
	var userid = $.cookie('userid');
	var alldata=null;
	var result=null;
	var sql=null;
	window.onload = function() {
		
		document.getElementById("accountid").value=userid;
		
		$.ajax({
			url : '<%=basePath%>/SelectElementServlet?slectname=*'
				+"&tablename=user where id="+userid+
				"&randomconut="+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				//alert(error+"1");
			},

			success : function(data) {
				console.log("data2:" + JSON.stringify(data));
				alldata=data;
		
			}
		});
		
	
		
		
	
		var id=document.getElementById("userid").value;
		sql="select * from artist where id='"+id+"'";
		
		sql=encodeURIComponent(sql);
		
	
		$.ajax({

			url : '<%=basePath%>UpdateArtistSql?sql='+sql+'&randomconut='+randomconut,

			dataType :"json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				
				
				console.log("data3:" + JSON.stringify(data));

				if(data[0].name!="" && data[0].name!=null && data[0].name!=undefined){
					
					document.getElementById("name").value =data[0].name;
					
	        	

				}else{
				
					document.getElementById("name").value =alldata[0].realname;

				}
		
				if(data[0].birthday!="" && data[0].birthday!=null && data[0].birthday!=undefined){
					document.getElementById("birthday").value =(data[0].birthday).split("-")[0];
				}else{
					
					document.getElementById("birthday").value =(alldata[0].birthday).split("-")[0];

				}
			
				if(data[0].brief!="" && data[0].brief!=null && data[0].brief!=undefined){

					document.getElementById("brief").value =data[0].brief;
					$.cookie('type_cookie', "seller_artist", { expires: 365, path: '/' }); 

					parent.document.getElementById("mybackstage").style.display="block"; 

					
				}
				if(data[0].prov!="" && data[0].prov!=null && data[0].prov!=undefined){
					
					addressInit('cmbProvince', 'cmbCity', 'cmbArea', data[0].prov, data[0].city, data[0].district);
					document.getElementById("address").value =data[0].prov+" "+data[0].city+" "+data[0].district;

					
				}else{
					
					var prov= (alldata[0].address).split(",")[0];
					var city= (alldata[0].address).split(",")[1];
					var district= (alldata[0].address).split(",")[2];
					addressInit('cmbProvince', 'cmbCity', 'cmbArea', prov, city, district);
					
					document.getElementById("address").value =prov+" "+city+" "+district;

					

				}

				if(data[0].phone!="" && data[0].phone!=null && data[0].phone!=undefined){
					
					document.getElementById("phone").value = data[0].phone;
					
				}else{
					
					document.getElementById("phone").value =alldata[0].phone;

				}
				if(data[0].telephone!="" && data[0].telephone!=null && data[0].telephone!=undefined){
					document.getElementById("telephone").value = data[0].telephone;

				}
				if(data[0].fax!="" && data[0].fax!=null && data[0].fax!=undefined){
					document.getElementById("fax").value = data[0].fax;

				}
				if(data[0].web!="" && data[0].web!=null && data[0].web!=undefined){
					document.getElementById("web").value = data[0].web;

				}
			
				if(data[0].email!="" && data[0].email!=null && data[0].email!=undefined){
					document.getElementById("email").value = data[0].email;

				}else{
				
					document.getElementById("email").value =alldata[0].email;

				}
				
				if(data[0].portrait!="" && data[0].portrait!=null && data[0].portrait!=undefined){
					document.getElementById("picarea").style.display="block";
					document.getElementById("imgid").src = "<%=basePath%>"+data[0].portrait;

				}else{
					
					document.getElementById("picarea").style.display="block";
					document.getElementById("imgid").src = "<%=basePath%>"+alldata[0].portrait;
					
					/*  document.getElementById("picarea").style.display="none";
					 document.getElementById("piccontent").style.display="block"; */


				}
				
				
				if(data[0].gender!="" && data[0].gender!=null && data[0].gender!=undefined){
				/* 	var gender= data[0].gender;
					var ridaolen=document.form1.gender.length;
					 for(var i=0;i<ridaolen;i++){
				            if(gender==document.form1.gender[i].value){
				                document.form1.gender[i].checked=true;
				            }
				        } */
				        
					document.getElementById("gender").value = data[0].gender;
 
				        
				        
				}else{
					var gender=null;
					if(alldata[0].gender==0){
						gender="男";
						document.getElementById("gender").value = gender;

					}else if(alldata[0].gender==1){
						gender="女";
						document.getElementById("gender").value = gender;

					}
	
				}
				
				if(data[0].artistcategory!="" && data[0].artistcategory!=null && data[0].artistcategory!=undefined){
					
					var artistcategory=document.getElementById("artistcategory").options;
					
					for(var i=0;i<artistcategory.length;i++){
						
						if(artistcategory[i].value==data[0].artistcategory){
						
							artistcategory[i].selected = 'selected';  
						}
					}
				}
				if(data[0].artistcategory!="" && data[0].artistcategory!=null && data[0].artistcategory!=undefined){
					if((data[0].artistcategory).indexOf("国外")>=0){
						document.getElementById("country").value = data[0].country;
						 document.getElementById("country").disabled=false;

					}else{
						
						 document.getElementById("country").disabled=true;
						
					}
					
					
				
					
					
				}

				
					
					

					
			}
		}); 
		
		
	
		//time();
		var input = document.getElementById("demo_input");
		result = document.getElementById("result");
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
		 
		var RsStream=document.getElementById("result").value;
		var username=document.getElementById("name").value;
		var birthday=document.getElementById("birthday").value;
		var brief=document.getElementById("brief").value;
		var prov = document.getElementById("cmbProvince").value;
	
		
		 if(username== null || username== ""){
				   alert("姓名不能为空");
					return;
			 	}else if(birthday== null || birthday== ""){
				   alert("年代不能为空");
					return;
				   
			   }
			 	
			 	else if(brief== null || brief== ""){
				   alert("简介不能为空");
					return;
				   
			   }
			 	 else if(prov== null || prov== ""){
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
			 alert("修改成功");
	
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
	
	 function updatepic(){
		 document.getElementById("picarea").style.display="none";
		 document.getElementById("piccontent").style.display="block";

		 
		 
	 }
	
</script>
  </head>
  
  <body>
  

	<div style="width: 1000px;height:800px;margin-left: 20px;margin-top: 50px;font-family: 微软雅黑">
	
		<div style="font-size: 14px;margin-top: 30px">

			<form action="${pageContext.request.contextPath}/UpDateNewArtistServletForUser" method="post" name="form1">
				
				<div style="float: left;margin-left: 10px;" >
				
					<div id="picarea" style="text-align: center;display: none">
					<img alt="" src="" id="imgid" width="200px" height="200px">
					<br>
					<br>
				<!-- 	<input type="button" value="修改图片" onclick="updatepic()"> -->
				</div>
				
				<div style="float: left;margin-left: 10px;display: none" id="piccontent">
				<input type="file" value="sdgsdg" id="demo_input" accept="image/png, image/jpeg"  />
				
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
				</div>
				<div style="float: left;margin-top: 20px;margin-left: 90px;">
				I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="userid" name="userid"  value="${requestScope.idname}"  readonly="readonly" style="border: none"/>&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				姓 &nbsp;&nbsp;名&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="name" name="name" value="" style="margin-top: 5px ;border: none" readonly="readonly" />&nbsp;&nbsp;
				<br/>
				<br/>
				<br/>
				年 &nbsp;代&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="birthday" name="birthday" value="" style="margin-top: 5px;border: none" readonly="readonly"/>&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				性 &nbsp;&nbsp;别&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="gender" name="gender" readonly="readonly" style="border: none"/>&nbsp;&nbsp;
				<br/>
				<br/>
				<br/>
				简 &nbsp;介&nbsp;&nbsp;&nbsp;&nbsp;<textarea  type="text" id="brief" name="brief" value="" style="margin-top: 5px;width: 483px;height: 100px;" placeholder="必填项，请输入简介"></textarea>&nbsp;<font color="red">*</font>
				<br/>
				<br/>
				<br/>
				居住地 &nbsp;&nbsp;&nbsp;<input type="text" id="address" name="address" readonly="readonly" style="border: none"/>&nbsp;&nbsp;
				<div style="display: none">
				<select id="cmbProvince" name="prov" ></select>
					:<select id="cmbCity" name="city"></select>
					:<select id="cmbArea" name="dist"></select>&nbsp;<font color='red'>*</font>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;				
				类 &nbsp;&nbsp;型 &nbsp;&nbsp;&nbsp;<select id="artistcategory" name="artistcategory" onchange="CategorycChange(this)" style="width: 155px;height: 25px"></select>
				<br/>
				<br/>
				<br/>
				<div style="display: none">
				<input type="text" name="isgallery" id="isgallery"  value="是" style="margin-top: 5px" onclick="isgalleryChanged(this)">
				</div>
				手  &nbsp;&nbsp;机 &nbsp;&nbsp;&nbsp;<input type="text" id="phone" name="phone" value="" style="margin-top: 5px ;border: none" readonly="readonly" />&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;				
				国  &nbsp;&nbsp;家 &nbsp;&nbsp;&nbsp;<input type="text" id="country" name="country" value="" style="margin-top: 5px" disabled="disabled"/>
				<br/>
				<br/>
				<br/>
				电 &nbsp;&nbsp;话&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="telephone" name="telephone" value="" style="margin-top: 5px"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				传 &nbsp;真&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="fax" name="fax" value="" style="margin-top: 5px"/>
				<br/>
				<br/>
				<br/>
				网 &nbsp;&nbsp;站&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="web" name="web" value="" style="margin-top: 5px"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				邮&nbsp;&nbsp;箱&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="email" name="email" value="" style="margin-top: 5px;border: none"readonly="readonly" />&nbsp;&nbsp;
				<br/>
				<div style="display: none" id="gallerydiv">
				是否为给改作者建画廊:<input type="radio" name="isgallery" id="isgallery"  value="是" style="margin-top: 5px" >是
				<input type="radio" name="isgallery" id="isgallery" value="否" style="margin-top: 5px"  checked="checked">否&nbsp;<font color='red'>*</font>
				</div>
				
				<input type="text" id="accountid" name="accountid" value="" style="margin-top: 5px;display: none"/>
				<br/>
				<br/>
				<br/>
					<div style="margin-left: 240px;margin-top: 15px">
					 
						<input type="button" value="  提  交  "  id="submitbutton" class="js-crop" onclick="dosubmit()"/>
					
					</div>
				
				</div>
			
				
			</form>
	
		</div>
	</div>
  </body>
</html>
