<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id=request.getParameter("id");
request.setAttribute("usersid", id);

%>	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>updateartwork.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>
	<script src="<%=basePath%>/js/jquery.tagsinput.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/jquery.tagsinput.css" />
	

<script type="text/javascript" charset="utf-8"> 

var randomconut=Math.floor(Math.random()*1000);
var vediopath=null;	
var type=$.cookie('type_cookie');
//var id = $.cookie('userid');
var artistid=null;	
var arup=null;
arup=decodeURI(<%="'"+request.getParameter("arup")+"'"%>);


	window.onload=function(){
		//修改成功后返回本页面arup=already 修改成功
		if(arup=="already"){
			
			alert("修改成功");	
		}
		
	
if(type=="veye"){
	document.getElementById("veyetype").value="veyetype";
	document.getElementById("notveyeartist").style.display="none";
	document.getElementById("veyeartist").style.display="block";
	document.getElementById("veyegallery").style.display="block";

	//从艺术家表里查找所有艺术家返回结果添加到页面
	var sql="select * from artist";

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

				console.log("data:" + JSON.stringify(data));
				
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



	
		
			//alert("作品修改");
		var id=decodeURI(<%="'"+request.getParameter("id")+"'"%>);
		var sql=null;
		
		sql="select * from artwork where id='"+id+"'";
			console.log(sql);
		sql=encodeURIComponent(sql);
	
		
		$.ajax({

			url : '<%=basePath%>/ArtWorkMange?sql='+sql+'&randomconut='+randomconut,

			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
		
				
				document.getElementById("userid").value = data[0].id;
				document.getElementById("name").value = data[0].name;
				document.getElementById("artist").value = data[0].artist+","+data[0].artistid;
				document.getElementById("choseartists").value = data[0].artist;
				document.getElementById("uploadtype").value=data[0].type;
				
				if(data[0].type=="商品"){
					//artwork-div
					document.getElementById("artwork-div").style.display="none";

				}
				
				
					if(type=="seller_organization"){
					
						artistid=$.cookie('artistid');
						
							if(artistid!="null"){
						/* 		document.getElementById("artist").value=artistid;
								document.getElementById("choseartists").value=artistid.split(",")[0];
							
								console.log(artistid);
		
								$.cookie('artistid', null, { expires: 1, path: '/' });
								 */
							}
					
					}else if(type=="seller_artist"){
						
						document.getElementById("choseartists").disabled = true;

					}else if(type=="veye"){
						
						var artist=document.getElementById("artist1").options;
						
						
						
						for(var i=0;i<artist.length;i++){
							
							if((artist[i].value).split(",")[0] == data[0].artist){
								artist[i].selected = 'selected';     
							}
					
						}
					}
				
				
				
			
				if(data[0].createtime!=null){

					document.getElementById("createtime").value = (data[0].createtime).split("-")[0];

				}
				
				
				var category=document.getElementById("category").options;
				
				for(var i=0;i<category.length;i++){
					
					if(category[i].value ==data[0].category){
						category[i].selected = 'selected';     
					}
			
				}
				document.getElementById("tags").value="";
				$('#tags').addTag(data[0].tags);
				$('#tags').tagsInput();
		
				
				document.getElementById("brief").value = data[0].brief;


				document.getElementById("size1").value = (data[0].size).split("*")[0];
						
				document.getElementById("size2").value =(data[0].size).split("*")[1].split("cm")[0];
				 
				 if(data[0].price!=null){
				
					 document.getElementById("price").value =data[0].price;

				 }

				
				if(type=="seller_organization" || type=="seller_artist"){
					
					document.getElementById("gallery").value =data[0].gallery+","+data[0].galleryid;

				}else if(type=="veye"){
					
						var gallery=document.getElementById("gallery1").options;
					
					for(var i=0;i<gallery.length;i++){
						if((gallery[i].value).split(",")[0] == data[0].gallery){
							gallery[i].selected = 'selected';     
						}
				
					}
				}

				
		
				 if(data[0].agent!=null){
					 
					document.getElementById("agent").value =  data[0].agent;

				 }
				 if(data[0].agentphone!=null){
				 
					document.getElementById("agentphone").value = data[0].agentphone;

				 }
				
				 if(data[0].agentemail!=null){
				 document.getElementById("agentemail").value = data[0].agentemail;
				 }else{
				  document.getElementById("agentemail").value ="";
				 }
				
				 var issale=null;
				 if(data[0].issale!=null){
					 
					 issale= data[0].issale;
						var ridaolen=document.form1.issale.length;
						 for(var i=0;i<ridaolen;i++){
					            if(issale==document.form1.issale[i].value){
					                document.form1.issale[i].checked=true;
					                
					                
					            }
					            
					        	if(issale==1){
									//document.getElementById("stock").style.display="block";	
									//document.getElementById("stock").value="1";

								}
					        }
				 }
				 
				 if(data[0].stock!=null){
				 
						document.getElementById("stock").value=data[0].stock;

				 }

					document.getElementById("imgid").src ="<%=basePath%>"+data[0].thumbnail+"?rand="+randomconut;
					document.getElementById("imgs").src ="<%=basePath%>"+data[0].originalpicture+"?rand="+randomconut;
					document.getElementById("videoid").value ="<%=basePath%>"+data[0].vedio+"?rand="+randomconut;
			
					
					
					 document.getElementById("isupload").value= data[0].ismarker;

					document.getElementById("targetId").value= data[0].uniqueTargetId;
					var isvedio = data[0].vedio;
					console.log("isvedio="+isvedio);
					if(isvedio==null || isvedio=="" || isvedio==undefined){
						
						document.getElementById("checkdeletevedio").style.display="none";
						document.getElementById("checkvedio").style.display="block";


					}else{
						document.getElementById("checkdeletevedio").style.display="block";
						document.getElementById("checkvedio").style.display="none";
						vediopath=isvedio;
	
					}
				 
				 
				
			}
		}); 
		
	
	}			
			
			
			
			
	function dosubmit() {
	
		
		//var RsStream=document.getElementById("result").value;
		var name=document.getElementById("name").value;
		var createtime=document.getElementById("createtime").value;
		var brief=document.getElementById("brief").value;
		document.getElementById("size").value=document.getElementById("size1").value+"*"+document.getElementById("size2").value+"cm";
		var size=document.getElementById("size").value;
		var price=document.getElementById("price").value;
		var agent=document.getElementById("agent").value;
		var agentphone=document.getElementById("agentphone").value;
		var agentemail=document.getElementById("agentemail").value;
		var issale= document.getElementsByName("issale");
		var stock=document.getElementById("stock").value;
		var img=new Image();
		img=document.getElementById("imgs");
		var imagesize=img.width / img.height;
		
		var imgwh=document.getElementById("size1").value;
		var imght=document.getElementById("size2").value;
		var uploadtype=document.getElementById("uploadtype").value;


		if(uploadtype=="商品"){
			
		 if (name == null || name == "") {
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
		}else if(uploadtype=="艺术品"){
			 if(name== null || name== ""){
				   alert("作品名不能为空");
					return;
			 	}else if(createtime== null || createtime== ""){
				   alert("年代不能为空");
					return;
				   
			   }
			 	else if(brief== null || brief== ""){
				   alert("简介不能为空");
					return;
				   
			   }else if(size== null || size== ""){
				   alert("尺寸不能为空");
					return;
				   
			   }else if(price== null || price== ""){
				   alert("价格不能为空");
					return;
				   
			   }
	
			  for ( var i = 0; i < issale.length; i++) {
				  if (issale[i].checked==true) {
				      i++;
				  
				  		if(issale[--i].value==1){
				  			if(stock== null || stock== ""){
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
		 		
				if(agentemail!= ""){
				
					 var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
					 if (!filter.test(agentemail)){
						 alert('您的电子邮件格式不正确');
						 return;
					 }
				}
		 		
				//用来验证输入的长宽与上传图片长宽的像素比是否相差太大
				if (imagesize-(imgwh/imght)>0.15 || imagesize-(imgwh/imght)<-0.15 ) {
				
					alert('输入的尺寸和像素比相差太大请重新输入尺寸');
					return;
				}
		 		
		
				
			   document.getElementById("createtime").value=createtime+"-01-01";

			
		}
				
					document.form1.submit();
					document.getElementById("submitbutton").disabled=true;
			
		}
	

	function CheckIsSale(){
		
		
		var type= document.getElementsByName("issale");

		  for ( var i = 0; i < type.length; i++) {
			  if (type[i].checked==true) {
			      i++;
			  // alert("你选中的是第"+i+"个单选框。值为："+type[--i].value);
			  		if(type[--i].value==1){
					document.getElementById("stock").style.display="block";	
					document.getElementById("stock").value="1";
			  		}else{
					document.getElementById("stock").style.display="none";	
	
			  		} 
			  
			  }
			  }

		
	}
	
	function addtags(obj){
		
		if ($('#tags').tagExist(obj.value)) { 
			
			$('#tags').removeTag(obj.value);
			console.log( document.getElementById("tags").value);
			
		}else{
			$('#tags').addTag(obj.value);
			$('#tags').tagsInput();
			console.log( document.getElementById("tags").value);
		}

		}
	
	
	function IsDelete() {
	/* 	document.getElementById("checkvedio").style.display = "block";
		document.getElementById("deletevedio").value = "1";
		document.getElementById("checkvedio").style.display = "none";
		document.getElementById("deletevedio").value = "0";
		 */
		

						var id=document.getElementById("userid").value;
							
						$.ajax({
							url : "<%=basePath%>DeleteVedioServlet?id="+id+"&vediopath="+vediopath+"&randomconut="+randomconut,
							dataType : "text",
							contentType : "application/x-www-form-urlencoded; charset=utf-8",

							error : function(request, error) {
								alert(error);
							},

							success : function(data) {
								
								document.getElementById("checkvedio").style.display = "block";
								document.getElementById("checkdeletevedio").style.display = "none";
								document.getElementById("deletevedio").value = "1";
								
							}
						}); 
					
			
			
		
	}
	function UploadNewVedio() {
		
		document.getElementById("checkdeletevedio").style.display = "none";

		var type = document.getElementsByName("NewVedio");

		for (var i = 0; i < type.length; i++) {
			if (type[i].checked == true) {
				i++;
				// alert("你选中的是第"+i+"个单选框。值为："+type[--i].value);
				if (type[--i].value == 1) {
					
					document.getElementById("vediodiv").style.display = "block";

					//document.getElementById("uploadvedio").value = "1";
					
				} else {
					document.getElementById("vediodiv").style.display = "none";

					//document.getElementById("uploadvedio").value = "0";

				}

			}
			
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
		var id=document.getElementById("userid").value;

		var sql="select*from status where id='"+id+"'";
		
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
	function getid(){
	var id=document.getElementById("userid").value;
	return id;
	}
	
	
	function choseartist(){
		
		if(confirm("确认更改艺术家")){
			if(document.getElementById("choseartists").value==""){
					history.go(1);
	
				}else{
					window.location.href="uploadpic/choseartist.jsp";
			
				}
		 }else{
			 return;	  
				
		 }
		
	
		
	}
	
	function downloadvideo(){
		
		var videopath=document.getElementById("videoid").value;
		window.open(videopath,null);
		
		
	}
	
</script>
  </head>
  
  <body>
 

	<div style="margin-left: 20px;font-family: 微软雅黑">
		<div style="text-align:center;font-family: 微软雅黑">
	
		<a href="javascript:history.go(-1);"><input type="button" value=" 返  回 " /></a>
		</div>
		<div style="font-size: 14px;margin-top: 30px">
		
			<form action="${pageContext.request.contextPath}/UpDateNewArtWorkServlet" method="post" name="form1">
				<div style="float: left;margin-top:0px;">
					<img alt="" src="" id="imgid" width="260px">
				
				 <!-- <video  loop="loop" controls="" autoplay="autoplay" width="260px" id="videoid">
 				 <source src="">
 				 </video>  -->
 				 
				
				<img alt="" src="" id="imgs" style="display: none">
				</div>
			
				<div style="float: left;margin-top:0px;margin-left: 100px">
				I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D&nbsp;&nbsp;<input type="text" id="userid" name="userid"  value="${requestScope.idname}"  readonly="readonly" style="width:225px"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				作品名&nbsp;&nbsp;&nbsp;<input type="text" id="name" name="name" value="" style="margin-top: 5px;width:225px"/>
				<br/>
				<br/>
				<!-- <select id="artist" name="artist" style="margin-top: 5px;width:225px"></select>
				<br/> -->
					<div id="veyeartist" style="display: none">
					艺术家&nbsp;&nbsp;&nbsp;<select id="artist1" name="artist1"
						style="margin-top: 5px;width:225px;"></select>
							
							<input type="text" id="veyetype" name="veyetype" value="" style="display: none">
						
					</div>
				
					<div id="notveyeartist">
				
					艺术家&nbsp;&nbsp;&nbsp;<input type="button" value="" id="choseartists" onclick="choseartist()" disabled="disabled"/>
						
					<input type="text" id=artist name="artist" value="" style="display: none">
						</div>
					<br/>
				简&nbsp;&nbsp;&nbsp;介&nbsp;&nbsp;&nbsp;<input type="text" id="brief" name="brief" value="" style="margin-top: 5px;width:225px"/>
				<br/><br/>
				图&nbsp;&nbsp;&nbsp;高&nbsp;&nbsp;&nbsp;<input type="text" id="size2" name="size2" value="" style="margin-top: 5px;width:225px"/>cm
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				图&nbsp;&nbsp;&nbsp;宽&nbsp;&nbsp;&nbsp;<input type="text" id="size1" name="size1" value="" style="margin-top: 5px;width:225px"/>cm
				<br/><br/>
				
				
				
				<!-- 年&nbsp;代:<input type="text" class="Wdate"  id="createtime" name="createtime" placeholder="请选择日期" onClick="WdatePicker()"  value="" style="margin-top: 5px;width:225px"/>
				<br/> -->
				<div id="artwork-div">
				年 &nbsp;&nbsp;&nbsp;代&nbsp;&nbsp;&nbsp;<input type="text" id="createtime" name="createtime" value="" style="margin-top: 5px;width:225px"/>&nbsp;<font color='red'>*</font>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				类&nbsp;&nbsp;&nbsp;别&nbsp;&nbsp;&nbsp;<select id="category" name="category" style="margin-top: 5px;width:229px">
						
						 </select>
				<br/>
				<br/>
					
				<div id="alltags" style="width: 650px"> 
					</div>
					<br>
					标&nbsp;&nbsp;&nbsp;签&nbsp;&nbsp;&nbsp;<input name="tags" id="tags" value=""  placeholder="请选择标签" readonly="readonly"/>
					<br />
			
				价&nbsp;&nbsp;&nbsp;格&nbsp;&nbsp;&nbsp;<input type="text" id="price" name="price" value="" style="margin-top: 5px;width:225px"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<!-- 画&nbsp;廊:<select id="gallery" name="gallery" style="margin-top: 5px;width:225px"></select>
				<br/>	
				 -->
				 	<div style="display: none" id="veyegallery">
						 画&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;廊&nbsp;&nbsp;&nbsp;<select
						id="gallery1" name="gallery1" style="margin-top: 5px;width:225px"></select>
						<br /> <br/>
					</div>
				 
				<input type="text" id="gallery" name="gallery" value=""style="display: none" /> 
				
				经纪人&nbsp;&nbsp;&nbsp;<input type="text" id="agent" name="agent" value="" style="margin-top: 5px;width:225px"/>
				<br/><br/>
				
				电&nbsp;&nbsp;&nbsp;话&nbsp;&nbsp;&nbsp;<input type="text" id="agentphone" name="agentphone" value="" style="margin-top: 5px;width:225px"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				邮&nbsp;&nbsp;&nbsp;箱&nbsp;&nbsp;&nbsp;<input type="text" id="agentemail" name="agentemail" value="" style="margin-top: 5px;width:225px"/>
				<br/><br/>
			
				可&nbsp;&nbsp;&nbsp;售&nbsp;&nbsp;&nbsp;<input type="radio" name="issale" value="1" style="margin-top: 5px" onclick="CheckIsSale()">是
				<input type="radio" name="issale"   value="0" style="margin-top: 5px"  onclick="CheckIsSale()">否
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;
				
				库&nbsp;&nbsp;&nbsp;存&nbsp;&nbsp;&nbsp;<input type="text" id="stock" name="stock" value="" style="margin-top: 5px;width:245px;"/>
				<br/><br/>
				</div>
				
				<div id="checkdeletevedio">
				<!-- <input type="radio" name="VedioDelete" value="1"
						style="margin-top: 5px" onclick="IsDelete()">是 <input
						type="radio" name="VedioDelete" value="0" checked="checked" style="margin-top: 5px"
						onclick="IsDelete()">否 <br /> -->
						<input type="button" value="删除视频" onclick="IsDelete()"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:downloadvideo()">下载视频 <input type="text" value="" style="display: none" id="videoid" /> </a>
						
				</div>
				<div id="checkvedio" style="display: none"> 
				是否上传新视频:<input type="radio" name="NewVedio" value="1"
						style="margin-top: 5px;" onclick="UploadNewVedio()">是 <input
						type="radio" name="NewVedio" value="0" checked="checked" style="margin-top: 5px"
						onclick="UploadNewVedio()">否 <br /> </div>
				<input type="text" id="imagetype" name="imagetype" value="" style="display: none"/>
				<input type="text" id="imagesize" name="imagesize" value="" style="display: none"/>
				<input type="text" id="size" name="size" value="" style="margin-top: 5px;width:220px;display: none"/>
				<input type="text" id="isupload" name="isupload" value=""  style="display: none" />
				<input type="text" id="deletevedio" name="deletevedio" value="0"  style="display: none" />
				<input type="text" id="uploadvedio" name="uploadvedio" value="0"  style="display: none" />
				<input type="text" id="targetId" name="targetId" value=""  style="display: none" />
				<input type="text" id="message" name="message" value="" style="display: none" />
				<input type="text" id="uploadtype" name="uploadtype" value="" style="display: none" />
			
					<div style="margin-left: 120px;margin-top: 15px">
						<input type="button" value="提交"  id="submitbutton" style="margin-top: 300px;margin-bottom: 20px" onclick="dosubmit()"/>
					</div>
				
				</div>
				
			</form>
	
		</div>
	</div>
		<div style="float: left;margin-top: -300px;margin-left:380px;display: none" id="vediodiv">
				<form action="${pageContext.request.contextPath}/UpdateVedioServlet?id=<%=request.getParameter("id") %>" id="vedioform" name="vedioform" enctype="multipart/form-data" method="post" target="ifm" >
					 <input type="file" value="" accept="video/mp4" id="vedio" name="vedio" style="margin-right: 20px;"/>
					 <input  type="submit" value="上传" onclick="SubmitVedio()" style="margin-top: 20px;margin-right: -70px;width: 50px;height: 25px" >
					 <br>
					 <input type="text" id="tishi" value="" style="border: none; background-color: #fff" disabled="disabled">
					</form>
					<iframe id='ifm' name='ifm'  style="border: none;width: 300px;height:50px"/>
					</div>
	
  </body>
</html>
