<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; utf-8">
 <base href="<%=basePath%>">
<title>seller_artist.jsp</title>

	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/jquery.tagsinput1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/CheckIe.js"></script>
	
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/jquery.tagsinput1.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/fileinput.css" />

<style type="text/css">


</style>

<script type="text/javascript" charset="utf-8">
var id = $.cookie('userid');
var randomconut = Math.floor(Math.random() * 1000);
var type=$.cookie('type_cookie');
var artistid=null;
var result=null;
var d = new Date();
var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
var random = Math.floor(Math.random() * 10000);
var artwork_id=str+"_"+random;

window.onload=function(){
	
	document.getElementById("userid").value=artwork_id;

		$.ajax({
			url : '<%=basePath%>/SelectElementServlet?slectname=*'
				+"&tablename=user where id="+id+
				"&randomconut="+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				//alert(error+"1");
			},

			success : function(data) {
				//console.log("data2:" + JSON.stringify(data));
				artistid=data[0].artistid;

				
				$.ajax({
					url : '<%=basePath%>/SelectElementServlet?slectname=*'
						+"&tablename=artwork where artistid='"+artistid+
						"'&randomconut="+ randomconut,
					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					error : function(request, error) {
						//alert(error+"1");
					},

					success : function(data) {
						//console.log("data2:" + JSON.stringify(data));
						var linediv=document.getElementById("linediv");
						var pdiv=document.getElementById("pdiv");

						if(JSON.stringify(data)!="[]"){
						
						var picdiv=document.getElementById("picdiv");
						var picpath=null;
					for(var i=0;i<data.length;i++){
						// picpath='<%=basePath%>'+data[i].showpicture;
						 picpath='<%=basePath%>'+data[i].showpicture+'?rand='+randomconut;

						 var img = document.createElement('img');
						 var upadtebtn = document.createElement('input');
						 var deletebtn = document.createElement('input');
						 var br = document.createElement('br');
						 var picv1 = document.createElement('div');
						
						 	
						 
						 	picv1.setAttribute("style","float: left;text-align: center;width:200px;height:200px;position:relative;margin:auto;");
						 	picv1.setAttribute("id",i);
						  	img.src=picpath;
						  	img.setAttribute("style","position:absolute;left:0px;bottom:40px;");
						  	img.setAttribute("id","img"+i);

						  	upadtebtn.type = 'button';
						  	deletebtn.type = 'button';
						  	upadtebtn.value = "修  改";
						  	deletebtn.value = "删  除";
						  
							upadtebtn.setAttribute("style","position:absolute;left:15px;bottom:0px;");
							deletebtn.setAttribute("style","position:absolute;right:65px;bottom:0px;");

							upadtebtn.setAttribute("id",data[i].id+"upadte");
							deletebtn.setAttribute("id",data[i].id+"delete");
							upadtebtn.setAttribute("onclick","Update(this)");
							deletebtn.setAttribute("onclick","Delete(this)");
							
						  	picdiv.appendChild(picv1);
							var picdiv2=document.getElementById(i);
						  	picdiv2.appendChild(img);
						  	picdiv2.appendChild(br);
						  	picdiv2.appendChild(upadtebtn);
						  	picdiv2.appendChild(deletebtn);
							var imgwh=document.getElementById("img"+i);
							var w=imgwh.width;
							var h=imgwh.height;
							
							if((w/h)<1){
								w1=w/(h/150);
								document.getElementById("img"+i).width=w1;
								h1=h/(w/w1);
								document.getElementById("img"+i).height=h1;
								

							}else{
								h1=h/(w/150);
								document.getElementById("img"+i).height=h1;
								w1=w/(h/h1);
								document.getElementById("img"+i).width=w1;
								
							}
							
							pdiv.innerHTML="<div><p style='text-align:center'>"+data[0].artist+"作品<p/> </div>";	


							linediv.innerHTML="<div><img src='images/u21_line.png' style='width:99%;margin-top:50px' /><br><input type='button' value='添加作品' style='margin-left: 70px;margin-top: 50px' onclick='AddArtwork()'/> </div>";	

						
					}

				}else{
					//pdiv.innerHTML="<div><p style='text-align:center'>"+data[0].artist+"作品<p/> </div>";	

					linediv.innerHTML="<div><img src='images/u21_line.png' style='width:99%;margin-top:50px' /><br><input type='button' value='添加作品' style='margin-left: 70px;margin-top: 50px' onclick='AddArtwork()'/> </div>";	
	
				}	
						

					}
				});
				
				
				

			}
		});
		
		
		//添加作品
		
		
		 if(type=="seller_artist"){
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
								 document.getElementById("choseartists").value=data[0].name;
								 document.getElementById("artist").value=data[0].name+","+data[0].id;
								
									
									
							}
						});
						
									 
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
				result = document.getElementById("result");
				var img_area = document.getElementById("img_area");

				if (typeof (FileReader) === 'undefined') {
					result.innerHTML = "抱歉，你的浏览器不支持 FileReader，请使用chrome浏览器操作！";
					input.setAttribute('disabled', 'disabled');
				} else {
					input.addEventListener('change', readFile, false);
				}
		
		
		
		
	
}

function Update(obj){
	
	
	var artworkid=(obj.id).split("upadte")[0];
	
	if ("IE" == mb || "ActiveXObject" in window) {
		
		window.location.href="../uploadpic/updateartwork.jsp?id="+artworkid;
	}else {
		
		window.location.href="uploadpic/updateartwork.jsp?id="+artworkid;

	}

	
	
	
}
function Delete(obj){
	
	
	var artworkid=(obj.id).split("delete")[0];
	
	if(confirm("确认删除吗")){
	
		delsql = "delete from artwork where ";
		delsql = delsql + "id='"
				+artworkid+ "'";
		delsql = encodeURIComponent(delsql);
		$.ajax({

			url : '<%=basePath%>/RunOneSql?sql='+ delsql+'&id='+artworkid+'&tablename=artwork',

			dataType : 'text',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				
				alert("删除成功");
				location.reload(); 

			}
		});
		
	}else{
		
		return;
	}
	
	
	
}


function AddArtwork(){
	document.getElementById("AddArtworkDiv").style.display="block";
	linediv.innerHTML="<div><img src='images/u21_line.png' style='width:99%;margin-top:50px' /><br><input type='button' value='取消添加' style='margin-left: 70px;margin-top: 50px' id='RemoveArtwork' onclick='RemoveArtwork()'/> </div>";	
	var artworkid=document.getElementById("userid").value;
	
	$.ajax({

		url : '<%=basePath%>/CreateArtwork_sellerartist?artworkid='+ artworkid+'&randomconut='+randomconut,

		dataType : 'text',
		contentType : "application/x-www-form-urlencoded; charset=utf-8",

		error : function(request, error) {
			alert(error);
		},

		success : function(data) {
			

		}
	});
	
}

function RemoveArtwork(){
	var artworkid=document.getElementById("userid").value;
	document.getElementById("AddArtworkDiv").style.display="none";
	linediv.innerHTML="<div><img src='images/u21_line.png' style='width:99%;margin-top:50px' /><br><input type='button' value='添加作品' style='margin-left: 70px;margin-top: 50px' onclick='AddArtwork()'/> </div>";	
	
<%-- 	$.ajax({

		url : '<%=basePath%>/RemoveArtworkServlet?artworkid='+ artworkid+'&randomconut='+randomconut,

		dataType : 'text',
		contentType : "application/x-www-form-urlencoded; charset=utf-8",

		error : function(request, error) {
			alert(error);
		},

		success : function(data) {
			

		}
	}); --%>
	
}

//添加作品


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

			img_area.innerHTML = '<div class="sitetip" ></div><img  src="'+this.result+'" alt="" id="imgs" width="260px"  style="border:#AAAAAB 2px solid;"/>';
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
		var uploadtype=document.getElementById("uploadtype").value;

		if(uploadtype=="商品"){
			if (RsStream == null || RsStream == "") {
				alert("请上传图片");
				return;

			}
			
			 else if (name == null || name == "") {
				alert("作品名不能为空");
				return;
			}
			 else if (brief == null || brief == "") {
				alert("简介不能为空");
				return;

			} else if (size== "*cm") {
				alert("尺寸不能为空");
				return;

			}
			
			if (imagesize-(imgwh/imght)>0.15 || imagesize-(imgwh/imght)<-0.15 ) {
			
				alert("输入的尺寸和像素比相差太大请重新输入尺寸");
				return;
			}	
			
	
		
		}else if(uploadtype=="艺术品"){
			if (RsStream == null || RsStream == "") {
				alert("请上传图片");
				return;

			}
			
			 else if (name == null || name == "") {
				alert("作品名不能为空");
				return;
			}
			 else if (brief == null || brief == "") {
				alert("简介不能为空");
				return;

				} else if (size== "*cm") {
				alert("尺寸不能为空");
				return;

			}
			
			else if (createtime == null || createtime == "") {
				alert("年代不能为空");
				return;

			} else if (price == null || price == "") {
				alert("价格不能为空");
				return;

			}else if (stock == null || stock == "") {
				alert("库存不能为空");
				return;

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
			
			
			//alert(imagesize-(imgwh/imght));
			//用来验证输入的长宽与上传图片长宽的像素比是否相差太大
			if (imagesize-(imgwh/imght)>0.15 || imagesize-(imgwh/imght)<-0.15 ) {
			
				alert("输入的尺寸和像素比相差太大请重新输入尺寸");
				return;
			}
			
		 	 document.getElementById("birthday").value=createtime+"-01-01";
		}
		
		
	

		document.form1.submit();
		document.getElementById("submitbutton").disabled=true;
		document.getElementById("RemoveArtwork").disabled=true;

		 
		

	}
	function CheckIsSale() {
		//iscount++;

		var type = document.getElementsByName("issale");
		var border=document.getElementById("stock");
		for (var i = 0; i < type.length; i++) {
			if (type[i].checked == true) {
				i++;
				// alert("你选中的是第"+i+"个单选框。值为："+type[--i].value);
				if (type[--i].value == 1) {
					
					document.getElementById("stock").readOnly = false;
					document.getElementById("stock").style.backgroundColor = "#fff";
					document.getElementById("stock").value = "1";

					
				} else {
					document.getElementById("stock").value = "0";
					document.getElementById("stock").readOnly = true;
					document.getElementById("stock").style.backgroundColor = "#EBEBE4";
					


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
		
		var artworkid=document.getElementById("userid").value;

		var sql="select*from status where id='"+artworkid+"'";
		
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
	


	function SelectOnchange(obj){
		
		if(obj.value=="艺术品"){
			
			document.getElementById("artwork-div").style.display="block";
		}else if(obj.value=="商品"){
			document.getElementById("artwork-div").style.display="none";

		}
		
	}


	

</script>


</head>
<body style="font-family: 微软雅黑">
<div style="width: 100%;height: 100%;margin: 40px;" id="pdiv">


</div>

<div style="width: 100%;height: 100%;margin: 40px;" id="picdiv">

</div>
<div style="width: 100%;margin-top: 50px" id="linediv" >

</div>

<div style="width: 100%;margin-top: 50px;margin-left: 300px;display: none" id="AddArtworkDiv" >

		<div style="font-size: 14px;">

			<form action="${pageContext.request.contextPath}/UploadArtWorkServlet" method="post" name="form1">

				<div style="margin-left: 70px">
					<a href="javascript:;" class="a-upload">
   					 <input type="file" name=""  value="sdgsdg" id="demo_input" accept="image/png, image/jpeg"/>点击上传作品图片</a>
					<textarea id="result" rows=30 cols=300 name=RsStream
						style="display: none;"></textarea>
					<p id="img_area"></p>
				</div>
				
				<div>
						&nbsp;&nbsp;&nbsp;&nbsp;
					I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D&nbsp;&nbsp;<input type="text" id="userid" name="userid"
						value="" readonly="readonly"
						style="width:225px" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						名&nbsp;&nbsp;称&nbsp;&nbsp;<input type="text" id="name" name="name" value="" style="margin-top: 5px;width:225px" />&nbsp;<font color='red'>*</font>
						 <br/>
						 <br/>
							&nbsp;&nbsp;&nbsp;&nbsp;
						
							作&nbsp;&nbsp;者&nbsp;&nbsp;<input type="text" value="请选择艺术家" id="choseartists" onclick="choseartist()" style="width: 225px"/>
					 		<input type="text" id="artist" name="artist" value="" style="display: none">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							类&nbsp;&nbsp;型&nbsp;&nbsp;<select id="uploadtype" name="uploadtype" style="margin-top: 5px;width:225px" onchange="SelectOnchange(this)">
							<option value="商品">商品</option>
							<option value="艺术品">艺术品</option>
							</select>&nbsp;<font color='red'>*</font>							
							<br/>
							<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;
			 				 图&nbsp;&nbsp;高&nbsp;&nbsp;<input type="text" id="size2" name="size2" value="" style="margin-top: 5px;width:220px" placeholder="请勿输入单位"/>cm &nbsp;<font color='red'>*</font>
								&nbsp;&nbsp;
							 图&nbsp;&nbsp;宽&nbsp;&nbsp;<input type="text" id="size1" name="size1" value="" style="margin-top: 5px;width:220px" placeholder="请勿输入单位"/>cm &nbsp;<font color='red'>*</font>
							<br /> 
							<br /> 	
				
						&nbsp;&nbsp;&nbsp;&nbsp;
	 				 简 &nbsp;&nbsp;介&nbsp;&nbsp;<textarea type="text" id="brief" name="brief" value=""
						style="margin-top: 5px;width: 550px;height: 80px"></textarea>&nbsp;<font color='red'>*</font>
					<br />
					<br />
					<div id="artwork-div" style="display: none">	
						
						&nbsp;&nbsp;&nbsp;&nbsp;
	 					年&nbsp;&nbsp;代&nbsp;&nbsp;	<input type="text" id="birthday" name="createtime" value="" style="margin-top: 5px;width: 225px"/>&nbsp;<font color='red'>*</font>
						<br/>
						<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;				
	 				标&nbsp;&nbsp;签&nbsp;&nbsp;<input name="tags" id="tags" value="" style="width: 555px" placeholder="请选择标签" readonly="readonly"/>
	 				 <br /> 
	 				<div id="alltags" style="width: 555px;margin-left: 60px"> </div>
	 				 <br /> 
	 				 <br /> 
	 			
						&nbsp;&nbsp;&nbsp;&nbsp;	 
	 				类&nbsp;&nbsp;别&nbsp;&nbsp;<select id="category" name="category" style="margin-top: 5px;width:225px">
					</select>&nbsp;<font color='red'>*</font>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 价&nbsp;&nbsp;格&nbsp;&nbsp;<input type="text" id="price" name="price" value="" style="margin-top: 5px;width:223px" />&nbsp;<font color='red'>*</font>
					 <br />
					 <br /> 
						&nbsp;&nbsp;&nbsp;&nbsp;	
					<div style="display: none" id="veyegallery">
					 画&nbsp;&nbsp;廊&nbsp;&nbsp;<select id="gallery1" name="gallery1" style="margin-top: 5px;width:225px"></select></div>
						<input type="text" id="gallery" name="gallery" value=""style="display: none" /> 
					经纪人&nbsp;<input type="text" id="agent" name="agent" value="" style="margin-top: 5px;width:225px" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 电&nbsp;&nbsp;话&nbsp;&nbsp;<input type="text" id="agentphone" name="agentphone" value="" style="margin-top: 5px;width:225px" />
					  <br />
					  <br />
					  	&nbsp;&nbsp;&nbsp;&nbsp;	
					 邮&nbsp;&nbsp;箱&nbsp;&nbsp;<input type="text" id="agentmail" name="agentmail" value="" style="margin-top: 5px;width:225px" /> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
					 可&nbsp;&nbsp;售&nbsp;&nbsp;<input type="radio" name="issale" value="1" style="margin-top: 5px" checked="checked" onclick="CheckIsSale()">是 &nbsp;&nbsp;&nbsp;&nbsp;
					 <input type="radio" name="issale" value="0" style="margin-top: 5px" onclick="CheckIsSale()">否 &nbsp;&nbsp;&nbsp;<font color='red'>*</font>
					 <br />
					 <br />
					 	&nbsp;&nbsp;&nbsp;&nbsp;
						  库&nbsp;&nbsp;存&nbsp;&nbsp;<input type="text" id="stock" name="stock" value=""style="margin-top: 5px;width:225px;" /> <font color='red'>*</font>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
					</div> 
					&nbsp;&nbsp;&nbsp;&nbsp;
						是否上传mp4文件:<input type="radio" name="IsVedio" value="1" style="margin-top: 5px" onclick="IsV()">是
						 <input type="radio" name="IsVedio" value="0" style="margin-top: 5px" onclick="IsV()"  checked="checked">否<font color='red'>*</font>
						
					 <input
						type="text" id="imagetype" name="imagetype" 
						 value="" style="display: none" /> <input
						type="text" id="size" name="size" value=""
						style="margin-top: 5px;width:220px;display: none" />
						<input type="text" id="imagesize" name="imagesize" value="" style="display: none" /> 
						<input type="text" id="message"
						name="message" value="" style="display: none" />
						<input type="text" id="isupload"
						name="isupload" value="" style="display: none" />
						<input type="text" id="img123"
						name="img123" value="" style="display: none" /> 
						<input type="text" id="veyetype" name="veyetype" value="seller_artist" style="display: none">
						
					<div style="margin-left: 0px;margin-top: 15px">
					
						<input type="button" value="  提  交  "  id="submitbutton" style="margin-top: 300px;margin-bottom: 20px;margin-left: 180px" onclick="dosubmit()"/>

					</div>

				</div>

			</form>
			
			</div>
			<div style="float: left;margin-top: -300px;margin-left: 60px;display: none" id="vediodiv">
				<form action="${pageContext.request.contextPath}/VedioUploadServlet" id="vedioform" name="vedioform" enctype="multipart/form-data" method="post" target="ifm" >
					 <input type="file" value="" accept="video/mp4" id="vedio" name="vedio"/>
					 <input  type="submit" value="上传" onclick="SubmitVedio()" style="margin-top: 20px" >
					 <br>
					 <input type="text" id="tishi" value="" style="border: none; background-color: #fff" disabled="disabled">
					</form>
					<iframe id='ifm' name='ifm'  style="border: none;width: 300px;height:50px"/>
					</div>

	</div>
			
	

</div>
</body>
</html>