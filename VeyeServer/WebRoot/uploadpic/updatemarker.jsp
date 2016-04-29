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
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	

<script type="text/javascript" charset="utf-8"> 
var type=$.cookie('type_cookie');
var accountid = $.cookie('userid');
var randomconut = Math.floor(Math.random() * 1000);
var alldata=null;
var id=decodeURI(<%="'"+request.getParameter("id")+"'"%>);

	window.onload = function() {
 		 if(type=="seller_organization"){
			 
			 	var obj=document.getElementById('type');
			    obj.options.length=0;
			    obj.options.add(new Option("美术馆","美术馆")); 
			
			    $.ajax({
					
					url : "./SelectElementServlet?slectname=*"
							+"&tablename=marker where userid='"+accountid+"'"+
							"&randomconut="+ randomconut,
					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					error : function(request, error) {
						alert(error);
					},
			
					success : function(data) {
			
						console.log("data3:" + JSON.stringify(data));
						
						
							document.getElementById("userid").value = data[0].id;
						 	document.getElementById("uniqueTargetId").value=data[0].uniqueTargetId;
							document.getElementById("imgid").src ="<%=basePath%>"+data[0].picture;
							document.getElementById("imgs").src ="<%=basePath%>"+((data[0].picture).replace("main","original"));
							document.getElementById("gallerydiv").style.display='block';	
							document.getElementById("name").value=data[0].owner;
							document.getElementById("size1").value = (data[0].size).split("*")[0];
							document.getElementById("size2").value = (data[0].size).split("*")[1].split("cm")[0];
							var gallery = document.getElementById("gallery");
							
							var galleryvalue=(data[0].arname).split(("G:"+data[0].id+"-"))[1];
							gallery.options.add(new Option(data[0].owner,(+data[0].owner+","+galleryvalue))); 
							
							console.log(document.getElementById("gallery").value);

					}
				});
			    
			    
			    
		 }
			 
<%-- 		 
	
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

		var sql=null;
		
		sql="select * from marker where id='"+id+"'";
	
		sql=encodeURIComponent(sql);
		
		
		$.ajax({

			url : "<%=basePath%>/MarkerManage?sql="+sql,

			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				alldata=data;
				
				document.getElementById("userid").value = data[0].id;
				var selecttype = document.getElementById("type");
				var gallery = document.getElementById("gallery").options;
				 	document.getElementById("uniqueTargetId").value=data[0].uniqueTargetId;
					document.getElementById("imgid").src ="<%=basePath%>"+data[0].picture;
					document.getElementById("imgs").src ="<%=basePath%>"+((data[0].picture).replace("main","original"));
					
				
				 for(var i=0;i<selecttype.length;i++){
						
						if(selecttype.options[i].value ==data[0].type){
							selecttype.options[i].selected = 'selected';  
						
								if(data[0].type=="美术馆"){
									document.getElementById("gallerydiv").style.display='block';	
								
									
									
									for(var j=0;j<gallery.length;j++){
										
										if((gallery[j].value).split(",")[0] == data[0].owner){
											gallery[j].selected = 'selected'; 
										
										}
									}
									
									document.getElementById("name").value=data[0].owner;
							}else{
								document.getElementById("name").value=data[0].type;
							}
							
						}
						
					}
				 
			
				 
				 
					document.getElementById("size1").value = (data[0].size).split("*")[0];
					
					document.getElementById("size2").value = (data[0].size).split("*")[1].split("cm")[0];
		
			}
		}); 
	
		 --%>
		


	}



	
	function dosubmit() {
		
		document.getElementById("size").value=document.getElementById("size1").value+"*"+document.getElementById("size2").value+"cm";
		var img=new Image();
		img=document.getElementById("imgs");
		var imagesize=img.width / img.height;
		var imgwh=document.getElementById("size1").value;
		var imght=document.getElementById("size2").value;
		
		alert(img.width);
			 if(size== null || size== ""){
					   alert("请补全尺寸");
						return;
					   
				   }
			 
			alert(imagesize-(imgwh/imght));
	 		
			//用来验证输入的长宽与上传图片长宽的像素比是否相差太大
			if (imagesize-(imgwh/imght)>0.15 || imagesize-(imgwh/imght)<-0.15 ) {
			
				alert('输入的尺寸和像素比相差太大请重新输入尺寸');
				return;
			}
				
				 document.form1.submit();
				 document.getElementById("submitbutton").disabled=true;

		}
	
	
	function OnChange(){

		var type=document.getElementById("type");
		var index = type.selectedIndex;
		//console.log(type.options[index].value);
		
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
		//console.log(type.options[index].value);
		
		
	}
	

</script>
  </head>
  
  <body>
   <div style="text-align: center;margin-top: 100px">
	
	
	</div>
	<div style="border:#AAAAAB 2px solid;width: 1000px;height:500px;margin-left: 20px">
		<div style="font-size: 14px;margin-top: 30px">
		
			<form action="${pageContext.request.contextPath}/UpDateNewMarkerServlet" method="post" name="form1">
			<div style="float: left;">
				<img alt="" src="" id="imgid" width="260px" height="260px">
				<img alt="" src="" id="imgs" style="display: none">
				
			</div>
				<div style="text-align: center;margin-top: 100px;float: right: margin-right: 200px;">
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
				&nbsp;图&nbsp;宽:<input type="text" id="size1" name="size1" value="" style="margin-top: 5px;width:220px"/>cm
				<br/>
				&nbsp;图&nbsp;高:<input type="text" id="size2" name="size2" value="" style="margin-top: 5px;width:220px"/>cm
				<br/>
				<input type="text" id="size" name="size" value="" style="margin-top: 5px;width:220px;display: none"/>
				<input type="text" id="uniqueTargetId" name="uniqueTargetId" value="" style="margin-top: 5px;width:220px;display: none"/>
					
					<div style="margin-left: 120px;margin-top: 15px">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="提交" id="submitbutton"/>
						</a>
					</div>
				
				</div>
			
				
			</form>
	
		</div>
	</div>
  </body>
</html>
