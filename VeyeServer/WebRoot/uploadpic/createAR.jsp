<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>createAR.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	

<script type="text/javascript" charset="utf-8"> 
var type=$.cookie('type_cookie');
var id = $.cookie('userid');
var randomconut = Math.floor(Math.random() * 1000);

	window.onload = function() {
		document.getElementById("accountid").value=id;
		if(type=="seller_organization"){
		    var obj=document.getElementById('type');
		    obj.options.length=0;
		    obj.options.add(new Option("美术馆","美术馆")); 
			document.getElementById("gallerydiv").style.display='block';
			var gallery=document.getElementById("gallery");
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
							
							gallery.options.add(new Option(data[0].name,(data[0].name+","+data[0].id))); 

							document.getElementById("name").value=data[0].name;
								
						}
					});
	
						
				}
			});

		    
		}else if (type=="veye"){
			
	
		//从画廊表里查找所有画廊返回结果添加到页面
		var sql="select * from gallery where type='机构'";
		$.ajax({

			url : "<%=basePath%>/SelectTypeServlet?sql="+sql,

			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				var select = document.getElementById("gallery");
			
				
				for(var i=0;i <data.length; i++){
					
					var opt = document.createElement('option');
				
	                opt.value =data[i].name+","+data[i].id;
	                opt.selected = false;
	                opt.innerHTML =data[i].name;
	                select.appendChild(opt);  
				}
			
			
		
			}
		});
		
		document.getElementById("name").value=document.getElementById("type").value;
		}
		
		
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
			
			img_area.innerHTML = '<div class="sitetip" ></div><img src="'+this.result+'" alt="" id="imgs" width="260px" height="260px" style="border:#AAAAAB 2px solid;"/>';
			
			imgs.src=document.getElementById("imgs").src;
		
			console.log(imgs.width / imgs.height);
			document.getElementById("imagesize").value = imgs.width / imgs.height;

			
		}
	

	}
	

	
	function dosubmit() {
		
		var RsStream=document.getElementById("result").value;
		//var username=document.getElementById("name").value;
		document.getElementById("size").value=document.getElementById("size1").value+"*"+document.getElementById("size2").value+"cm";
		var size=document.getElementById("size").value;
		var imgwh=document.getElementById("size1").value;
		var imght=document.getElementById("size2").value;
		var imagesize = document.getElementById("imagesize").value;

		 if(RsStream== null || RsStream== ""){
				   alert("请上传图片");
					return;
				   
			   }else if(size=="*cm"){
				   alert("请补全尺寸");
					return;
				   
			   }
		
		 
			//用来验证输入的长宽与上传图片长宽的像素比是否相差太大
			if (imagesize-(imgwh/imght)>0.15 || imagesize-(imgwh/imght)<-0.15 ) {
			
				alert("输入的尺寸和像素比相差太大请重新输入尺寸");
				return;
			}
	
				document.form1.submit();
				 document.getElementById("submitbutton").disabled=true;

	
	}
	
	
	function OnChange(){

		var type=document.getElementById("type");
		var index = type.selectedIndex;
		console.log(type.options[index].value);
		
		if(type.options[index].value=="美术馆"){
			document.getElementById("gallerydiv").style.display='block';
			var galleryname=document.getElementById("gallery");
			var index1 = galleryname.selectedIndex;
			document.getElementById("name").value=galleryname.options[index1].value.split(",")[0];
			
		} else if(type.options[index].value=="作品"){
			document.getElementById("gallerydiv").style.display="none";	
			

		}else{
			document.getElementById("gallerydiv").style.display="none";	
		
			document.getElementById("name").value=type.options[index].value;
		}

		
	}
	
	function SelectOnChange(){
		var type=document.getElementById("gallery");
		var index = type.selectedIndex;
		document.getElementById("name").value=type.options[index].value.split(",")[0];
		console.log(type.options[index].value);
		
		
	}
	

</script>
  </head>
  
  <body>
   <div style="text-align: center;margin-top: 100px">
	
	
	</div>
	<div style="border:#AAAAAB 2px solid;width: 1000px;height:500px;margin-left: 20px">
		<div style="font-size: 14px;margin-top: 30px">
		
			<form action="${pageContext.request.contextPath}/UpDateMarkerServet" method="post" name="form1">
				
				<div style="float: left;margin-left: 200px">
				<input type="file" value="sdgsdg" id="demo_input" />
				
				<textarea id="result" rows=30 cols=300 name=RsStream style="display: none" ></textarea>
				<p id="img_area"></p>
				</div>
				<div style="float: right;margin-top: 60px;margin-right: 20px;margin-right: 180px;">
				I&nbsp;D&nbsp;:<input type="text" id="userid" name="userid"  value="${requestScope.idname}"  readonly="readonly" style="width:225px"/>
				<br/>				
			
				类&nbsp;型:<select id="type" name="type" style="margin-top: 5px;width:225px" onchange="OnChange(this)">
				<option value="veye">veye</option>
				<option value="美术馆">美术馆</option>
			
				</select>
				<br/>
				<div style="display: none" id="gallerydiv">
				美术馆:<select id="gallery" name="gallery" style="margin-top: 5px;width:225px;" onchange="SelectOnChange(this)"></select>
				</div>
				名&nbsp;称:<input type="text" id="name" name="name" value="" style="margin-top: 5px;width:225px" readonly="readonly"/>
				<br/>
				图&nbsp;宽:<input type="text" id="size1" name="size1" value="" style="margin-top: 5px;width:220px"/>cm
				<br/>
				图&nbsp;高:<input type="text" id="size2" name="size2" value="" style="margin-top: 5px;width:220px"/>cm
				<br/>
				<input type="text" id="imagesize" name="imagesize" value="" style="display: none" /> 
				<input type="text" id="size" name="size" value="" style="margin-top: 5px;width:220px;display: none"/>
				<input type="text" id="imagewh" name="imagewh" value="" style="display: none"/>
				<input	type="text" id="imagetype" name="imagetype"  value="" style="display: none" /> 	
				<input	type="text" id="accountid" name="accountid"  value="" style="display: none" /> 	
				
					<div style="margin-left: 120px;margin-top: 15px">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="提交"  id="submitbutton" />
						</a>
					</div>
				
				</div>
			
				
			</form>
	
		</div>
	</div>
  </body>
</html>
