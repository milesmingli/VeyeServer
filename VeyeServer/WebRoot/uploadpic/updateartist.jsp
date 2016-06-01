<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


%>	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'updateartist.jsp' starting page</title>
     <base href="<%=basePath%>">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.9.1.min.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jsAddress.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/time.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/component.css" />
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/component.js"></script>
	
	
	<script type="text/javascript" charset="utf-8">
	var result=null;
	var randomconut = Math.floor(Math.random() * 1000);
	var arup=null;
	arup=decodeURI(<%="'"+request.getParameter("arup")+"'"%>);

	window.onload = function(){
		//time();
		//修改成功后返回本页面arup=already 修改成功
		if(arup=="already"){
			
			alert("修改成功");	
		}
		
		$.ajax({

			url : "<%=basePath%>ArtistCategoryServlet?randomconut="
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
		
		
		
		var id=decodeURI(<%="'"+request.getParameter("id")+"'"%>);
		var sql=null;
		
		sql="select * from artist where id='"+id+"'";
		
		sql=encodeURIComponent(sql);
		
		
		$.ajax({

			url : '<%=basePath%>UpdateArtistSql?sql='+sql,

			dataType :"json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				document.getElementById("userid").value = data[0].id;
				document.getElementById("name").value =data[0].name;
			/* 	var birthday=document.getElementById("birthday").options;
					
					for(var i=0;i<birthday.length;i++){
						console.log(birthday[i].value);
						if(birthday[i].value==(data[0].birthday).split(" ")[0]){
						
							birthday[i].selected = 'selected';  
						}
					} */
				
					document.getElementById("birthday").value =(data[0].birthday).split("-")[0];
	
				document.getElementById("brief").value =data[0].brief;
				
				addressInit('cmbProvince', 'cmbCity', 'cmbArea', data[0].prov, data[0].city, data[0].district);
				document.getElementById("phone").value = data[0].phone;
				document.getElementById("telephone").value = data[0].telephone;
				document.getElementById("fax").value = data[0].fax;
				document.getElementById("web").value = data[0].web;
				document.getElementById("email").value = data[0].email;
				document.getElementById("imgid").src = "<%=basePath%>"+data[0].portrait+"?rand"+randomconut;

				var gender= data[0].gender;
				var ridaolen=document.form1.gender.length;
				 for(var i=0;i<ridaolen;i++){
			            if(gender==document.form1.gender[i].value){
			                document.form1.gender[i].checked=true;
			            }
			        }
	
					var artistcategory=document.getElementById("artistcategory").options;
					console.log(data[0].artistcategory);
					
					for(var i=0;i<artistcategory.length;i++){
						
						if(artistcategory[i].value==data[0].artistcategory){
						
							artistcategory[i].selected = 'selected';  
						}
					}
					//document.getElementById("country").value = data[0].country;

					if((data[0].artistcategory).indexOf("国外")>=0){
						document.getElementById("country").value = data[0].country;
						 document.getElementById("country").disabled=false;

					}else{
						
						 document.getElementById("country").disabled=true;
						
					}
					

					
			}
		}); 
		
		
			//id=encodeURI(encodeURI(id));

			$.ajax({
			url : "<%=basePath%>SelectElementServlet?slectname=*"
				+"&tablename=artwork where artistid='"+id+"'"+
				"&randomconut="+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				
				console.log("data:" + JSON.stringify(data));
				
				if(JSON.stringify(data)!="[]"){
					//如果有作品将无法删除
					//document.getElementById("name").disabled=true;
					//alert("改作者名下有作品存在，名字将无法修改");
				}
				 
			}
		});
		
		
	
		
		
		//FileReader
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
			
			/* var RsStream=document.getElementById("result").value; */
			var username=document.getElementById("name").value;
			var birthday=document.getElementById("birthday").value;
			var brief=document.getElementById("brief").value;
			var	gender=document.getElementById("gender").value;
			var city=document.getElementById("cmbProvince").value;
			var phone=document.getElementById("phone").value;
			var email=document.getElementById("email").value;
			
			 if(username== null || username== ""){
					   alert("姓名不能为空");
						return;
				 	}else if(birthday== null || birthday== ""){
						   alert("年代不能为空");
							return;
						   
					   }else if(brief== null || brief== ""){
						   alert("简介不能为空");
							return;
						   
					   }
				   else if(gender== null || gender== ""){
					   alert("性别不能为空");
						return;
					   
				   }else if(city== null || city== ""){
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

		 function updatepic(){
			 document.getElementById("picarea").style.display="none";
			 document.getElementById("piccontent").style.display="block";

			 
			 
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
		 
	</script>

  </head>
  
<body style="font-family: 微软雅黑;font-size: 13px">
   <div style="text-align: center;margin-top: 10px">
	<a href="javascript:history.go(-1);"><input type="button" value=" 返  回 " /></a>

	
	</div>
	<div style="width: 1000px;height:600px;margin-left: 20px">
		
			<form action="${pageContext.request.contextPath}/UpDateNewArtistServlet" method="post" name="form1" id="form1">
				
				<div style="float: left;margin-left: 10px">
		
				<div id="picarea" style="text-align: center;">
					<img alt="" src="" id="imgid" width="260px" height="260px">
					<br>
					<br>
					<input type="button" value="修改图片" onclick="updatepic()">
				</div>
				
				
				<div style="float: left;margin-left: 10px;display: none" id="piccontent">
				
				<input type="file" value="sdgsdg" id="demo_input" accept="image/png, image/jpeg" />
				
				<textarea id="result" rows=30 cols=300 name=RsStream style="display: none" ></textarea>
				<p id="img_area" ></p>
				
					<div class="component" style="width: 300px;height: 300px" >
				
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
				<div style="float: right;margin-top: 60px;margin-right: 10px;">
				I D&nbsp;:<input type="text" id="userid" name="userid"  value="${requestScope.idname}"  readonly="readonly"/>
				<br/>
				姓 名:<input type="text" id="name" name="name" value="" style="margin-top: 5px"/>&nbsp;<font color='red'>*</font>
				<br/>
				<!-- 年 代:<select id="birthday" name="birthday" style="margin-top: 5px;width:200px"></select>&nbsp;<font color='red'>*</font>
				<br/> -->
				年 代:	<input type="text" id="birthday" name="birthday" value="" style="margin-top: 5px"/>&nbsp;<font color='red'>*</font>
				<br/>
				简 介:<textarea  type="text" id="brief" name="brief" value=""  style="margin-top: 5px;width: 300px;height: 130px" ></textarea>&nbsp;<font color='red'>*</font>
				<br/>
				性 别:<input type="radio"  name="gender" id="gender" value="男" style="margin-top: 5px">男
					<input type="radio"  name="gender" id="gender" value="女" style="margin-top: 5px">女&nbsp;<font color='red'>*</font>
				
				<br/>
				城&nbsp;市：<select id="cmbProvince" name="prov"></select>
					：<select id="cmbCity" name="city"></select>
					：<select id="cmbArea" name="dist"></select>&nbsp;<font color='red'>*</font>
					
				<br/>
				<br/>
				作家类型:<select id="artistcategory" name="artistcategory" onchange="CategorycChange(this)"></select>
				<br/>
				 国 家:<input type="text" id="country" name="country" value="" style="margin-top: 5px" disabled="disabled"/>
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
						<input type="button" value="提交"  id="submitbutton" onclick="dosubmit()" class="js-crop"/>
					</div>
				
				</div>
			
				
			</form>
	
		</div>
	
	</div>
  </body>
</html>
