<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>createartwork.jsp</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="<%=basePath%>js/time.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>

<script src="<%=basePath%>/js/caman.full.min.js"></script>
<script src="<%=basePath%>/js/jquery.tagsinput.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>

<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/jquery.tagsinput.css" />

<script type="text/javascript" charset="utf-8"> 


var randomconut = Math.floor(Math.random() * 1000);
var type=$.cookie('type_cookie');
var id = $.cookie('userid');
var artistid=null;
	window.onload = function() {
	
		//time();
		if(type=="seller_organization"){
			
		
		artistid=$.cookie('artistid');
		if(artistid!="null"){
			document.getElementById("artist").value=artistid;
			document.getElementById("choseartists").value=artistid.split(",")[0];
			document.getElementById("demo_input").disabled=false;
		
			console.log(artistid);

			$.cookie('artistid', null, { expires: 1, path: '/' });
			
		}else{
			document.getElementById("choseartists").value="请选择艺术家";
			document.getElementById("demo_input").disabled=true;
			document.getElementById("artist").value="";

		}
		
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
						 document.getElementById("gallery").value=data[0].name+","+data[0].id;
						 console.log(document.getElementById("gallery").value);	
							
							
					}
				});
							 
			}
		});
		
	}else if(type=="seller_artist"){
		document.getElementById("demo_input").disabled=false;

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
				var artistid=data[0].artistid;

				
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
						
						 document.getElementById("choseartists").value=data[0].name;
						 document.getElementById("gallery").value=data[0].name+","+data[0].id;
						 document.getElementById("choseartists").disabled=true;
							
							
							
					}
				});
				
				
				$.ajax({
					
					url : "./SelectElementServlet?slectname=*"
							+"&tablename=artist where id='"+artistid+"'"+
							"&randomconut="+ randomconut,
					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					error : function(request, error) {
						alert(error);
					},
			
					success : function(data) {
			
						console.log("data:" + JSON.stringify(data));
					
						 document.getElementById("artist").value=data[0].name+","+data[0].id;
						
							
							
					}
				});
				
							 
			}
		});
		
	}else if(type=="veye"){
		document.getElementById("demo_input").disabled=false;
		document.getElementById("veyetype").value="veyetype";
		
		document.getElementById("notveyeartist").style.display="none";
		document.getElementById("veyeartist").style.display="block";
		document.getElementById("veyegallery").style.display="block";

		//从艺术家表里查找所有艺术家返回结果添加到页面
		var sql="select * from artist where isaudit=0";
	
		$.ajax({

			url : "<%=basePath%>/SelectTypeServlet?sql="+sql,

			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
			
				var select = document.getElementById("artist1");
			
				
				for(var i=0;i <data.length; i++){
					
					var opt = document.createElement('option');
				
	                opt.value =data[i].name+","+data[i].id;
	                opt.selected = false;
	                opt.innerHTML =data[i].name;
	                select.appendChild(opt);  
				}
			
				
			
				
			}
		});  
		//从画廊表里查找所有画廊返回结果添加到页面
		var sql="select * from gallery";
		$.ajax({

			url : "<%=basePath%>/SelectTypeServlet?sql="+sql,

			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				var select = document.getElementById("gallery1");
			
				
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
		
		//从类别表里查找所有类别返回结果添加到页面
		
		$.ajax({
			url : "<%=basePath%>/ArtworkCategoryServlet?randomconut=" + randomconut,

			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				//console.log(data);

				var select = document.getElementById("category");

				for (var i = 0; i < data.length; i++) {

					var opt = document.createElement('option');
	                opt.value =data[i].value;
	                opt.selected = false;
	                opt.innerHTML =data[i].category;
	                select.appendChild(opt);  

				}

			}
		});
		
		$.ajax({

			url : "ArtWorkTagServlet?randomconut="
					+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				alert(error);
			},

			success : function(data) {

				
			var alltags=document.getElementById("alltags");
			
			for(var i=0;i<data.length;i++){
			
				  var btn = document.createElement('input');
				   btn.type = 'button';
				   btn.value = data[i].tagname;
				   btn.id =i;
				   btn.setAttribute("onclick","addtags(this)");
				   btn.setAttribute("style","margin: 5px");
				   alltags.appendChild(btn);
				//alltags.innerHTML='<input type="button"  value="'+data[i].tagname+'" onclick="addtags(this)">';

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
		
	
		var filetype = "jpg,jpeg,png,JPG,JPEG,PNG";

		if (filetype.indexOf(file.type.split("/")[1]) < 0) {
			alert("不支持的文件格式，请上传格式为,jpg,jpeg,类型的图片");

			return false;
		}

		if (file.type.split("/")[1] == "png"
				|| file.type.split("/")[1] == "PNG") {

			document.getElementById("imagetype").value = "png";

		} else {

			document.getElementById("imagetype").value = "jpg";

		}

		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e) {
			result.innerHTML = this.result.split(",")[1];

			img_area.innerHTML = '<div class="sitetip" ></div><img  src="'+this.result+'" alt="" id="imgs" width="260px" height="260px" style="border:#AAAAAB 2px solid;"/>';
			imgs.src = document.getElementById("imgs").src;
		
			
			if (filetype.indexOf(file.type.split("/")[1]) < 0) {
				document.getElementById("imgs").src = "";
				document.getElementById("result").value = "";

			}

			if(imgs.width<1100){
				/* document.getElementById("imgs").src="";
				document.getElementById("result").value = ""; */
				alert("上传图片的宽度小于1100像素,会影响显示");
				
			}
			document.getElementById("imagesize").value = imgs.width / imgs.height;
		}

	}

	var iscount = 0;
	var ismcount = 0;
	var sh;


	function dosubmit() {
		
		var RsStream = document.getElementById("result").value;
		var name = document.getElementById("name").value;
		var createtime = document.getElementById("birthday").value;
		var brief = document.getElementById("brief").value;
		document.getElementById("size").value = document
				.getElementById("size1").value
				+ "*" + document.getElementById("size2").value + "cm";
		var size = document.getElementById("size").value;
		var price = document.getElementById("price").value;
		var agent = document.getElementById("agent").value;
		var agentphone = document.getElementById("agentphone").value;
		var agentmail = document.getElementById("agentmail").value;
		var issale = document.getElementsByName("issale");
		var ismarker = document.getElementsByName("ismarker");
		var stock = document.getElementById("stock").value;
		var imagesize = document.getElementById("imagesize").value;
		var imgwh=document.getElementById("size1").value;
		var imght=document.getElementById("size2").value;

		if (name == null || name == "") {
			alert("作品名不能为空");
			return;
		} else if (RsStream == null || RsStream == "") {
			alert("请上传图片");
			return;

		} else if (createtime == null || createtime == "") {
			alert("年代不能为空");
			return;

		} else if (brief == null || brief == "") {
			alert("简介不能为空");
			return;

		} else if (size == null || size == "") {
			alert("尺寸不能为空");
			return;

		} else if (price == null || price == "") {
			alert("价格不能为空");
			return;

		} else if (iscount == 0) {
			alert("请选择是否可售");
			return;

		}/*  else if (ismcount == 0) {
			alert("请选择是否作为marker上传");
			return;

		} */


		for (var i = 0; i < issale.length; i++) {

			if (issale[i].checked == true) {
				i++;

				if (issale[--i].value == 1) {
					if (stock == null || stock == "") {
						alert("库存不能为空");
						return;
					}
				}

			}
		}

		 if (createtime != null && createtime != "") {

				var filter =/^\d{4}$/;
				if (!filter.test(createtime)) {
				alert("请输入四位数字日期");
				return;
				}
				
		 }
		
		
		//正则验证输入邮箱，性别，手机。。。。

		if (agentmail != "") {

			var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			if (!filter.test(agentmail)) {
				alert('您的电子邮件格式不正确');
				return;
			}
		}
		
		
	//	alert(imagesize-(imgwh/imght));
		//用来验证输入的长宽与上传图片长宽的像素比是否相差太大
		if (imagesize-(imgwh/imght)>0.15 || imagesize-(imgwh/imght)<-0.15 ) {
		
			alert("输入的尺寸和像素比相差太大请重新输入尺寸");
			return;
		}
		
		
		
	 	 document.getElementById("birthday").value=createtime+"-01-01";
		 document.form1.submit();
		 document.getElementById("submitbutton").disabled=true;

		

	}
	function CheckIsSale() {
		iscount++;

		var type = document.getElementsByName("issale");

		for (var i = 0; i < type.length; i++) {
			if (type[i].checked == true) {
				i++;
				// alert("你选中的是第"+i+"个单选框。值为："+type[--i].value);
				if (type[--i].value == 1) {
					document.getElementById("stock").style.display = "block";
					document.getElementById("stock").value = "1";
				} else {
					document.getElementById("stock").style.display = "none";

				}

			}
		}

	}

/* 	function IsM() {

		ismcount++;

		var type = document.getElementsByName("IsMarker");

		for (var i = 0; i < type.length; i++) {
			if (type[i].checked == true) {
				i++;
				// alert("你选中的是第"+i+"个单选框。值为："+type[--i].value);
				if (type[--i].value == 1) {
					document.getElementById("isupload").value = "1";
					
				} else {
					document.getElementById("isupload").value = "0";

				}

			}
		}

	} */
	
	function IsV() {


		var type = document.getElementsByName("IsVedio");

		for (var i = 0; i < type.length; i++) {
			if (type[i].checked == true) {
				i++;
				// alert("你选中的是第"+i+"个单选框。值为："+type[--i].value);
				if (type[--i].value == 1) {
					document.getElementById("vediodiv").style.display = "block";
					
				} else {
					document.getElementById("vediodiv").style.display = "none";

				}

			}
		}

	}

	function addtags(obj){
		
		if ($('#tags').tagExist(obj.value)) { 
			
			$('#tags').removeTag(obj.value);
			
		}else{
			$('#tags').addTag(obj.value);
			$('#tags').tagsInput();
		}

		}
	

	var MyInterval;
	function SubmitVedio(){
		var vedio= document.getElementById("vedio").value;
		 var file = document.getElementById('vedio').files[0];
		 if(file.size>12582912 || (vedio.indexOf("mp4")<0 && vedio.indexOf("MP4")<0)){
				alert("请上传12M以内的mp4文件");
				document.getElementById("vedio").value=""; 
				return;
		 }

		 document.getElementById("submitbutton").disabled=true;
		 document.getElementById("tishi").value="上传中请稍等";
		 MyInterval=setInterval("CheckUpload()",5000);
		
	}
	
	
	function CheckUpload(){
		
		var sql="select*from status where id='"+"${requestScope.idname}"+"'";
		
		$.ajax({

			url : "<%=basePath%>/SelectTypeServlet?sql="+sql,

			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				
				if(jQuery.isEmptyObject(data)){
				
				}else{
					if(data[0].status==1){
						clearInterval(MyInterval);
						 document.getElementById("tishi").value="上传成功";
						 document.getElementById("message").value="1";
						 document.getElementById("submitbutton").disabled=false;

					}
				}
			
			
				
			}
		}); 

		
	}
	
	function choseartist(){
		if(document.getElementById("choseartists").value=="已选择"){
			history.go(1);

		}else{
			window.location.href="uploadpic/choseartist.jsp";
	
		}
		
	}
	
	
	

</script>
</head>

<body>

	<div
		style="width: 1000px;height:1000px;margin-left: 20px;margin-top: 100px">
		<div style="font-size: 14px;margin-top: 30px">

			<form
				action="${pageContext.request.contextPath}/UploadArtWorkServlet"
				 method="post" name="form1">

				<div style="float: left;margin-left: 100px">
					<input type="file" value="sdgsdg" id="demo_input"
						accept="image/png, image/jpeg" disabled="disabled"/>

					<textarea id="result" rows=30 cols=300 name=RsStream
						style="display: none"></textarea>
					<p id="img_area"></p>
				</div>
				<div
					style="float: right;margin-top: 60px;margin-right: 20px;margin-right: 100px;">
					I&nbsp;D&nbsp;:<input type="text" id="userid" name="userid"
						value="${requestScope.idname}" readonly="readonly"
						style="width:225px" /> <br /> 作品名:<input type="text" id="name"
						name="name" value="" style="margin-top: 5px;width:225px" /> <br/>
						 <br/>
					
					<div id="veyeartist" style="display: none">
					艺术家:<select id="artist1" name="artist1"
						style="margin-top: 5px;width:225px;"></select>
							<input type="text" id="veyetype" name="veyetype" value="" style="display: none">
						
					</div>
						<div id="notveyeartist">
						艺术家:<input type="button" value="请选择艺术家" id="choseartists" onclick="choseartist()"/>
						
					 	<input type="text" id="artist" name="artist" value="" style="display: none">
						</div>
						 <br/>
						<br/>
					<!-- 年 代:<select id="birthday" name="createtime" style="margin-top: 5px;width:200px"></select>&nbsp;<font color='red'>*</font>
					
	 				<br /> -->
	 				年 代:	<input type="text" id="birthday" name="createtime" value="" style="margin-top: 5px"/>&nbsp;<font color='red'>*</font>
						<br/>
	 				 简 介:<textarea type="text" id="brief" name="brief" value=""
						style="margin-top: 5px;width: 230px;height: 80px"></textarea>
					<br />
	 				类&nbsp;别:<select id="category" name="category" style="margin-top: 5px;width:225px">
					</select>
					 <br /> 
					<div id="alltags" style="width: 300px"> 
					</div><br>
					标 签:<input name="tags" id="tags" value="" style="width: 260px" placeholder="请选择标签" readonly="readonly"/>
						<br />
						图&nbsp;高:<input
						type="text" id="size2" name="size2" value=""
						style="margin-top: 5px;width:220px" />cm 
						
						<br />
						 图&nbsp;宽:<input type="text" id="size1" name="size1" value=""
						style="margin-top: 5px;width:220px" />cm 
						
						<br /> 
						
						 价&nbsp;格:<input
						type="text" id="price" name="price" value=""
						style="margin-top: 5px;width:225px" /> <br />
					<div style="display: none" id="veyegallery">
						 画&nbsp;廊:<select
						id="gallery1" name="gallery1" style="margin-top: 5px;width:225px"></select>
						<br /> 
					</div>
						<input type="text" id="gallery" name="gallery" value=""style="display: none" /> 
						
					经纪人:<input type="text" id="agent" name="agent" value=""
						style="margin-top: 5px;width:225px" /> <br /> 电&nbsp;话:<input
						type="text" id="agentphone" name="agentphone" value=""
						style="margin-top: 5px;width:225px" /> <br /> 邮&nbsp;箱:<input
						type="text" id="agentmail" name="agentmail" value=""
						style="margin-top: 5px;width:225px" /> <br /> 可&nbsp;售:<input
						type="radio" name="issale" value="1" style="margin-top: 5px"
						onclick="CheckIsSale()">是 <input type="radio"
						name="issale" value="0" style="margin-top: 5px"
						onclick="CheckIsSale()">否 <br /> 库&nbsp;存:<input
						type="text" id="stock" name="stock" value="0"
						style="margin-top: 5px;width:245px;display: none" /> <br /> <input
						type="text" id="imagetype" name="imagetype" 
						 value="" style="display: none" /> <input
						type="text" id="size" name="size" value=""
						style="margin-top: 5px;width:220px;display: none" />
						<input type="text" id="imagesize" name="imagesize" value="" style="display: none" /> 
						
						<!-- 是否作为marker上传:<input type="radio" name="IsMarker" value="1"
						style="margin-top: 5px" onclick="IsM()">是 <input
						type="radio" name="IsMarker" value="0" style="margin-top: 5px"
						onclick="IsM()">否 <br />  -->
						是否上传mp4文件:<input type="radio" name="IsVedio" value="1"
						style="margin-top: 5px" onclick="IsV()">是 <input
						type="radio" name="IsVedio" value="0" style="margin-top: 5px"
						onclick="IsV()">否 <br /> 
						<input type="text" id="message"
						name="message" value="" style="display: none" />
						<input type="text" id="isupload"
						name="isupload" value="" style="display: none" />
						<input type="text" id="img123"
						name="img123" value="" style="display: none" />
					<div style="margin-left: 120px;margin-top: 15px">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="提交"  id="submitbutton" style="margin-top: 300px;margin-bottom: 20px"/>

						</a>
					</div>

				</div>

			</form>
			
			</div>

		</div>

	</div>
			<div style="float: right;margin-top: -120px;margin-right: -360px;display: none" id="vediodiv">
				<form action="${pageContext.request.contextPath}/VedioUploadServlet" id="vedioform" name="vedioform" enctype="multipart/form-data" method="post" target="ifm" >
					 <input type="file" value="" accept="video/mp4" id="vedio" name="vedio"/>
					 <input  type="submit" value="上传" onclick="SubmitVedio()" style="margin-top: 20px" >
					 <br>
					 <input type="text" id="tishi" value="" style="border: none;background-color: #F3F3F4">
					</form>
					<iframe id='ifm' name='ifm'  style="border: none;width: 300px;height:50px"/>
					</div>
	
</body>
</html>