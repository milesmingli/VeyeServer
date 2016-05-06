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
<title>seller_organization.jsp</title>

	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/jquery.tagsinput1.js"></script>
	
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/jquery.tagsinput1.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/fileinput.css" />

 <script type="text/javascript" src="<%=basePath%>js/jsAddress.js"></script>
    
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/demo.css" />
	<!--必要样式-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/component.css" />
	<script type="text/javascript" src="<%=basePath%>js/component.js"></script>


<style type="text/css">


</style>

<script type="text/javascript" charset="utf-8">
var id = $.cookie('userid');
var randomconut = Math.floor(Math.random() * 1000);
var type=$.cookie('type_cookie');
var artistid=null;
var allname=null;
var d = new Date();
var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
var random = Math.floor(Math.random() * 10000);
var artwork_id=str+"_"+random;
var artist_id=str+"_"+random;

window.onload=function(){
	
	document.getElementById("userid").value=artist_id;

		$.ajax({
			url : '<%=basePath%>/SelectElementServlet?slectname=*'
				+"&tablename=artist where userid="+id+
				"&randomconut="+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				//alert(error+"1");
			},

			success : function(data) {
				//console.log("data2:" + JSON.stringify(data));
				
						allname=data;
						var linediv=document.getElementById("linediv");

						if(JSON.stringify(data)!="[]"){
						
						var artistdiv=document.getElementById("artistdiv");
						var picpath=null;
					for(var i=0;i<data.length;i++){
						 picpath='<%=basePath%>'+data[i].portrait;

						 var img = document.createElement('img');
						 var upadtebtn = document.createElement('input');
						 var deletebtn = document.createElement('input');
						 var p = document.createElement('input');

						 var br = document.createElement('br');
						 var picv1 = document.createElement('div');
						
						 
						 	picv1.setAttribute("style","float: left;text-align: center;width:200px;height:200px;position:relative;margin:auto;");
						 	picv1.setAttribute("id",i);
						  	p.value=data[i].name;
							p.setAttribute("disabled","disabled");
						  	p.setAttribute("style","margin-top:-22px;border: none;background:#fff;text-align: left;");
						
						 	img.src=picpath;
						  	img.setAttribute("style","position:absolute;left:0px;bottom:40px;");
						  	img.setAttribute("id",data[i].id);
						  	img.setAttribute("onclick","link(this)");
							
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
							
						  	artistdiv.appendChild(picv1);
							var artistdiv2=document.getElementById(i);
						  	artistdiv2.appendChild(p);
						  	artistdiv2.appendChild(img);
						  	artistdiv2.appendChild(br);
						  	artistdiv2.appendChild(upadtebtn);
						  	artistdiv2.appendChild(deletebtn);
							var imgwh=document.getElementById(data[i].id);
							var w=imgwh.width;
							var h=imgwh.height;
							
							if((w/h)<1){
								w=w/(h/150);

								document.getElementById(data[i].id).width=w;
								document.getElementById(data[i].id).height="150";
								

							}else{
								document.getElementById(data[i].id).width="150";
								
							}
							
							

							//linediv.innerHTML="<br><div><input type='button' value='添加艺术家' style='margin-left: 70px;margin-top: 50px' onclick='AddArtist()'/><br><img src='images/u21_line.png' style='width:99%;margin-top:50px' /></div>";	
							linediv.innerHTML="<div><img src='images/u21_line.png' style='width:99%;margin-top:50px' /><br><input type='button' value='添加艺术家' style='margin-left: 70px;margin-top: 50px' onclick='AddArtist()'/> </div>";	

						
					}

				}else{
					//linediv.innerHTML="<br><div><input type='button' value='添加艺术家' style='margin-left: 70px;margin-top: 50px' onclick='AddArtist()'/><br><img src='images/u21_line.png' style='width:99%;margin-top:50px' /></div>";	
					document.getElementById("pid").style.display="none";
					linediv.innerHTML="<div><img src='images/u21_line.png' style='width:99%;margin-top:50px' /><br><input type='button' value='添加艺术家' style='margin-left: 70px;margin-top: 50px' onclick='AddArtist()'/> </div>";	
	
				}	
						

			}
		});
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

				//console.log("data:" + JSON.stringify(data));
				
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

function link(obj){

	window.location.href="seller_organization/arrwork_artist.jsp?artistid="+obj.id;
	
	
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
	
	/*
	//重名验证
	var isaudit=$.cookie('isaudit');
	if(isaudit!="null"){
		document.getElementById("isaudit").value=isaudit;
    	$.cookie('isaudit', null, { expires: 1, path: '/' }); 
	} */


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
	
/* 	
 //同名验证
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
	}	 */
	
}

function Update(obj){
	
	
	var artistid=(obj.id).split("upadte")[0];
	
	window.location.href="uploadpic/updateartist.jsp?id="+artistid;

	
	
	
}
function Delete(obj){
	
	
	var artistid=(obj.id).split("delete")[0];
	

	if(confirm("确认删除吗")){
		
		
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
		
				if(JSON.stringify(data)!="[]"){
					alert("改艺术家名下有作品，不能删除");
					
				}else{

					delsql = "delete from artist where ";
					delsql = delsql + "id='"
							+artistid+ "'";
					delsql = encodeURIComponent(delsql);
					$.ajax({

						url : '<%=basePath%>/RunOneSql?sql='+ delsql+'&id='+artistid+'&tablename=artist',

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
					
				}
				
				
			}
		});
		
	
		
	}else{
		
		return;
	}
	
	
	
}


function AddArtist(){
	document.getElementById("AddArtistDiv").style.display="block";
	linediv.innerHTML="<br><div><input type='button' value='取消添加' style='margin-left: 70px;margin-top: 50px' id='RemoveArtist' onclick='RemoveArtist()'/> <br><img src='images/u21_line.png' style='width:99%;margin-top:50px' /></div>";	

	
}

function RemoveArtist(){
	
	var artistid=document.getElementById("userid").value;

	document.getElementById("AddArtistDiv").style.display="none";
	linediv.innerHTML="<div><img src='images/u21_line.png' style='width:99%;margin-top:50px' /><br><input type='button' value='添加艺术家' style='margin-left: 70px;margin-top: 50px' onclick='AddArtist()'/> </div>";	
	
	$.ajax({

		url : '<%=basePath%>/RemoveArtistServlet?artistid='+ artistid+'&randomconut='+randomconut,

		dataType : 'text',
		contentType : "application/x-www-form-urlencoded; charset=utf-8",

		error : function(request, error) {
			alert(error);
		},

		success : function(data) {
			

		}
	});

}

function AddArtist(){
	document.getElementById("AddArtistDiv").style.display="block";
	linediv.innerHTML="<div><img src='images/u21_line.png' style='width:99%;margin-top:50px' /><br><input type='button' value='取消添加' style='margin-left: 70px;margin-top: 50px' id='RemoveArtist' onclick='RemoveArtist()'/> </div>";	
	var artistid=document.getElementById("userid").value;
	
	$.ajax({

		url : '<%=basePath%>/CreateGallery_seller_organization?artistid='+ artistid+'&randomconut='+randomconut,

		dataType : 'text',
		contentType : "application/x-www-form-urlencoded; charset=utf-8",

		error : function(request, error) {
			alert(error);
		},

		success : function(data) {
			

		}
	});
	
}
	






</script>


</head>
<body style="font-family: 微软雅黑">
<div style="width: 100%;height: 100%;margin: 40px;text-align: center;" id="artistdiv">
<p id="pid" style="margin-top: -30px">点击艺术家头像可添加作品</p>
</div>
<div style="width: 100%;margin-top: 50px" id="linediv" >

</div>

	<div style="margin-left: 20px;margin-top: 100px;display: none" id="AddArtistDiv" >
		<div style="font-size: 14px;margin-top: 30px">

			<form action="${pageContext.request.contextPath}/UpdateArtistServlet" method="post" name="form1">
				
				<div style="float: left;margin-left: 10px">
				<input type="file" value="sdgsdg" id="demo_input" accept="image/png, image/jpeg"  />
				
				<textarea id="result" rows=30 cols=300 name=RsStream style="display: none" ></textarea>
				<p id="img_area"></p>
				  <div class="content">
			
				<div class="component" style="width: 250px;height: 250px">
				
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
			</div>
				
				</div>
					<div style="float: left;margin-top: 20px;margin-left: 90px;">
				I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="userid" name="userid"  value="${requestScope.idname}"  readonly="readonly" style="border: none"/>&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				姓 &nbsp;&nbsp;名&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="name" name="name" value="" style="margin-top: 5px ;" onkeyup=" Checkname()"/>&nbsp;<font color="red">*</font>
				<br/>
				<br/>
				<br/>
				年 &nbsp;代&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="birthday" name="birthday" value="" style="margin-top: 5px;" />&nbsp;<font color="red">*</font>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				性 &nbsp;&nbsp;别&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="gender" id="gender"  value="男" style="margin-top: 5px" checked="checked">&nbsp;&nbsp;&nbsp;男&nbsp;&nbsp;&nbsp;
				<input type="radio" name="gender" id="gender" value="女" style="margin-top: 5px" >&nbsp;&nbsp;&nbsp;女&nbsp;&nbsp;&nbsp;<font color="red">*</font>
				<br/>
				<br/>
				<br/>
				简 &nbsp;介&nbsp;&nbsp;&nbsp;&nbsp;<textarea  type="text" id="brief" name="brief" value="" style="margin-top: 5px;width: 441px;height: 100px;" placeholder="必填项，请输入简介"></textarea>&nbsp;<font color="red">*</font>
				<br/>
				<br/>
				<br/>
				居住地 &nbsp;&nbsp;
					<select id="cmbProvince" name="prov" ></select>
					&nbsp;<select id="cmbCity" name="city" style="width: 180px"></select>
					&nbsp;<select id="cmbArea" name="dist" style="width: 170px"></select>&nbsp;<font color='red'>*</font>
				<br/>
				<br/>
				<br/>			
				类 &nbsp;&nbsp;型 &nbsp;&nbsp;&nbsp;<select id="artistcategory" name="artistcategory" onchange="CategorycChange(this)" style="width: 155px;height: 25px"></select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			
				国  &nbsp;&nbsp;家 &nbsp;&nbsp;&nbsp;<input type="text" id="country" name="country" value="" style="margin-top: 5px" disabled="disabled"/>
				
				<br/>
				<br/>
				<br/>
				<div style="display: none">
				<input type="text" name="isgallery" id="isgallery"  value="否" style="margin-top: 5px">
				</div>
				手  &nbsp;&nbsp;机 &nbsp;&nbsp;&nbsp;<input type="text" id="phone" name="phone" value="" style="margin-top: 5px ;"  />&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;				
				电 &nbsp;&nbsp;话&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="telephone" name="telephone" value="" style="margin-top: 5px"/>
				<br/>
				<br/>
				<br/>
				网 &nbsp;&nbsp;站&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="web" name="web" value="" style="margin-top: 5px"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				传 &nbsp;&nbsp;真&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="fax" name="fax" value="" style="margin-top: 5px"/>
				<br/>
				<br/>
				<br/>
				邮&nbsp;&nbsp;&nbsp;箱&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="email" name="email" value="" style="margin-top: 5px;width: 440px" />&nbsp;&nbsp;
				<br/>
				<input type="text" id="accountid" name="accountid" value="" style="margin-top: 5px;display: none"/>
				<input type="text" id="isaudit" name="isaudit" value="0" style="margin-top: 5px;display: none"/>
				<input type="text" id="id" name="id" value="" style="margin-top: 5px;display: none"/>
				<br/>
				<br/>
				<br/>
				
					<div style="margin-left: 240px;margin-top: 15px;">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="  提  交  "  id="submitbutton" class="js-crop"/>
						</a>
					</div>
				
				</div>
			
				
			</form>
	
		</div>
	</div>
			
	

</div>
</body>
</html>