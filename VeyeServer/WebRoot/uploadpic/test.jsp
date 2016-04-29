<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>creategallery.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>
	<script src="<%=basePath%>/js/Area.js" type="text/javascript"></script>
	<script src="<%=basePath%>/js/AreaData_min.js" type="text/javascript"></script>

<script type="text/javascript" charset="utf-8"> 


	window.onload = function() {
		
		var sql="select * from artist";
		$.ajax({

			url : "<%=basePath%>/SelectTypeServlet?sql="+sql,

			dataType : 'text',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				console.log(data);
				var dataArray = data.split("*");
			
				var select = document.getElementById("artist");
			

				console.log(dataArray);
				
				for(var i=1;i <dataArray.length; i++){
					
					var opt = document.createElement('option');
					 var optdata=dataArray[i].split(",");
	                opt.value =dataArray[i];
	                opt.selected = false;
	                opt.innerHTML =optdata[0];
	                select.appendChild(opt);  
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

	function readFile() {
		
		
		var file = this.files[0];
		//这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件 
		if (!/image\/\w+/.test(file.type)) {
			alert("请确保文件为图像类型");
			return false;
		}
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e) {
			result.innerHTML = this.result.split(",")[1];
			
			img_area.innerHTML = '<div class="sitetip" ></div><img src="'+this.result+'" alt="" width="260px" height="260px" style="border:#AAAAAB 2px solid;"/>';
		
		}
	

	}
	

	
	function dosubmit() {
	

		var RsStream=document.getElementById("result").value;
		var username=document.getElementById("name").value;
		var brief=document.getElementById("brief").value;
		
		var address=document.getElementById("address").value;
		var contactperson=document.getElementById("contactperson").value;
		var phone=document.getElementById("phone").value;
		var email=document.getElementById("email").value;
		var seachprov;
		var seachcity;
		var seachdistrict;
		var AreaName = showAreaID(); 
			Area=AreaName.split(",");
			//alert(Area.length);
			
			if(Area.length==3){
				 seachprov=Area[0];
				 seachcity=Area[1];
				 seachdistrict=Area[2];
				 document.getElementById("prov").value=seachprov; 
				 document.getElementById("city").value=seachcity; 
				 document.getElementById("district").value=seachdistrict; 

			}
			
			if(Area.length==2 && (Area[0]=="北京市" ||Area[0]=="上海市" ||Area[0]=="天津市" ||Area[0]=="重庆市" ||Area[0]=="台湾省" ||Area[0]=="香港"  ||Area[0]=="澳门"  )){
				 seachprov=Area[0];
				 seachcity=Area[0];
				 seachdistrict=Area[1];	
				 document.getElementById("prov").value=seachprov; 
				 document.getElementById("city").value=seachcity; 
				 document.getElementById("district").value=seachdistrict; 
			}else if(Area.length==2 && (Area[0]!="北京市" ||Area[0]!="上海市" ||Area[0]!="天津市" ||Area[0]!="重庆市" ||Area[0]!="台湾省" ||Area[0]!="香港"  ||Area[0]!="澳门"  )){
				 alert("请把城市信息补充完整");
			
				 return;	
			}
			
			
			if(Area.length==1){
				 alert("请把城市信息补充完整");
				 return;
			}
		
			
				 if(username== null || username== ""){
					   alert("姓名不能为空");
						return;
				 	}else if(RsStream== null || RsStream== ""){
					   alert("请上传图片");
						return;
					   
				   }else if(brief== null || brief== ""){
					   alert("简介不能为空");
						return;
					   
				   }else if(address== null || address== ""){
					   alert("请输入街道");
						return;
					   
				   }
				   else if(phone== null || phone== ""){
					   alert("手机不能为空");
						return;
					   
				   }else if(email== null || email== ""){
					   alert("邮箱不能为空");
						return;
				   }else if(contactperson== null || contactperson== ""){
					    alert("联系人不能为空");
						return;
				   }
	
			 		//正则验证输入邮箱，性别，手机。。。。
					if(email!= null || email!= ""){
					
						 var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
						 if (!filter.test(email)){
							 alert('您的电子邮件格式不正确');
							 return;
						 }
					}
					
				
					
					if(phone!= null || phone!= ""){
						
						 var filter  = /^1[3|4|5|8][0-9]\d{4,8}$/;
						 if (!filter.test(phone)){
							 alert('不是完整的11位手机号或者正确的手机号前七位');
							 return;
						 }
					}
					
					
					document.form1.submit();
		
		}
	//城市插件
	$(function (){
		initComplexArea('seachprov', 'seachcity', 'seachdistrict', area_array, sub_array, '44', '0', '0');
	
		
	});
	
	//得到地区码
	function getAreaID(){
		var area = 0;          
		if($("#seachdistrict").val() != "0"){
			area = $("#seachdistrict").val();                
		}else if ($("#seachcity").val() != "0"){
			area = $("#seachcity").val();
		}else{
			area = $("#seachprov").val();
		}
		return area;
	}
	
	function showAreaID() {
		//地区码
		var areaID = getAreaID();
		
		//地区名
		var areaName = getAreaNamebyID(areaID);
		
		return areaName;
		    
	}
	
	
	
	//根据地区码查询地区名
	function getAreaNamebyID(areaID){
		var areaName = "";
		if(areaID.length == 2){
			areaName = area_array[areaID];
			
		}else if(areaID.length == 4){
			var index1 = areaID.substring(0, 2);
			areaName = area_array[index1] + "," + sub_array[index1][areaID];
		}else if(areaID.length == 6){
			var index1 = areaID.substring(0, 2);
			var index2 = areaID.substring(0, 4);
			areaName = area_array[index1] + "," + sub_array[index1][index2] + "," + sub_arr[index2][areaID];
		}
		return areaName;
	}
	
	
	
	function OnChange(){
		var type = document.getElementById("type").value;
		
		if(type=="个人"){
			document.getElementById("artist").style.display="block";	
		}else{
		document.getElementById("artist").style.display="none";	
			
		}
		
		
	}
	
</script>
  </head>
  
  <body>
   <div style="text-align: center;margin-top: 100px">
	
	
	</div>
	<div style="border:#AAAAAB 2px solid;width: 1000px;height:500px;margin-left: 20px">
		<div style="font-size: 14px;margin-top: 30px">
		
			<form action="${pageContext.request.contextPath}/UploadGalleryServlet" method="post" name="form1">
				
				<div style="float: left;margin-left: 100px">
				<input type="file" value="sdgsdg" id="demo_input" />
				
				<textarea id="result" rows=30 cols=300 name=RsStream style="display: none" ></textarea>
				<p id="img_area"></p>
				</div>
				<div style="float: right;margin-top: 60px;margin-right: 20px;margin-right: 100px;">
				I&nbsp;D&nbsp;:<input type="text" id="userid" name="userid"  value="${requestScope.idname}"  readonly="readonly" style="width:225px"/>
				<br/>
				姓&nbsp;名:<input type="text" id="name" name="name" value="" style="margin-top: 5px;width:225px"/>
				<br/>
				简&nbsp;介:<input type="text" id="brief" name="brief" value=""  style="margin-top: 5px;width:225px"/>
				<br/>
				类&nbsp;型:<select id="type" name="type" style="margin-top: 5px;width:225px" onchange="OnChange(this)">
				<option value="机构">机构</option>
				<option value="个人">个人</option>
				</select>
				<br/>
				艺术家:<select id="artist" name="artist" style="margin-top: 5px;width:225px;display: none"></select>
				<br/>
				城&nbsp;市:<select id="seachprov" name="seachprov" onChange="changeComplexProvince(this.value, sub_array, 'seachcity', 'seachdistrict');"style="margin-top: 5px"></select>
				<select id="seachcity" name="homecity" onChange="changeCity(this.value,'seachdistrict','seachdistrict');"></select>
				<span id="seachdistrict_div"><select id="seachdistrict" name="seachdistrict"></select></span>
				<br/>
				街&nbsp;道:<input type="text" id="address" name="address" value="" style="margin-top: 5px;width:225px"/>
				<br/>
				联系人:<input type="text" id="contactperson" name="contactperson" value="" style="margin-top: 5px;width:225px"/>
				<br/>
				手&nbsp;机:<input type="text" id="phone" name="phone" value="" style="margin-top: 5px;width:225px"/>
				<br/>
				邮&nbsp;箱:<input type="text" id="email" name="email" value="" style="margin-top: 5px;width:225px"/>
				<br/>
				<input type="text" id="prov" name="prov" style="display: none"/>
				<input type="text" id="city" name="city" style="display: none"/>
				<input type="text" id="district" name="district" style="display: none"/>
					<div style="margin-left: 120px;margin-top: 15px">
						<a href="javascript:dosubmit();"> 
						<input type="button" value="提交" />
						</a>
					</div>
				
				</div>
				
			</form>
	
		</div>
	</div>
  </body>
</html>
