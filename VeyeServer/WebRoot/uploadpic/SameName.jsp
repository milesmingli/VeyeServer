<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'SameName.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	
   <script type="text/javascript" charset="utf-8">
	var randomconut = Math.floor(Math.random() * 1000);
	var name=decodeURI(<%="'"+request.getParameter("name")+"'"%>);

	function findObj(theObj, theDoc) {
		var p, i, foundObj;
		if (!theDoc)
			theDoc = document;
		if ((p = theObj.indexOf("?")) > 0 && parent.frames.length) {
			theDoc = parent.frames[theObj.substring(p + 1)].document;
			theObj = theObj.substring(0, p);
		}
		if (!(foundObj = theDoc[theObj]) && theDoc.all)
			foundObj = theDoc.all[theObj];
		for (i = 0; !foundObj && i < theDoc.forms.length; i++)
			foundObj = theDoc.forms[i][theObj];
		for (i = 0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++)
			foundObj = findObj(theObj, theDoc.layers[i].document);
		if (!foundObj && document.getElementById)
			foundObj = document.getElementById(theObj);
		return foundObj;
	}
	function AddSignRow() { //读取最后一行的行号，存放在txtTRLastIndex文本框中 
		var txtTRLastIndex = findObj("txtTRLastIndex", document);
		var rowID = parseInt(txtTRLastIndex.value);

		var signFrame = findObj("SignFrame", document);
		//添加行
		var newTR = signFrame.insertRow(signFrame.rows.length);
		newTR.id = "SignItem" + rowID;
		
		//添加列:图片
		var newDeleteTD = newTR.insertCell(0);
				 
		newDeleteTD.innerHTML = "<div style='text-align:center'><img input name='img" + rowID + "' id='img" + rowID + "' alt='' src='' width='100' height='100'/></div>";
	
		//添加列:姓名
		var newLastNameTD = newTR.insertCell(1);
		//添加列内容
		newLastNameTD.innerHTML = "<input name='selectname" + rowID + "' id='selectname" + rowID + "' type='text' size='17' readonly='readonly' style='text-align:center;border: 1px' />";

		//添加列:年代
		var newBirthdayTD = newTR.insertCell(2);
		//添加列内容
		newBirthdayTD.innerHTML = "<input name='selectbirthday" + rowID + "' id='selectbirthday" + rowID + "' type='text' size='10' readonly='readonly' style='text-align:center;border: 1px' />";

		
		//添加列:简介
		var newBriefTD = newTR.insertCell(3);
		//添加列内容
		newBriefTD.innerHTML = "<textarea name='selectbrief" + rowID + "' id='selectbrief" + rowID + "' type='text' size='18'readonly='readonly' style='border: 1px;height:90px' ></textarea>";

		//添加列:性别
		var newGenderTD = newTR.insertCell(4);
		//添加列内容
		newGenderTD.innerHTML = "<input name='selectgender" + rowID + "' id='selectgender" + rowID + "' type='text' size='4' readonly='readonly'style='text-align:center;border: 1px'/>";

		//添加列:城市
		var newCityTD = newTR.insertCell(5);
		//添加列内容
		newCityTD.innerHTML = "<input name='selectcity" + rowID + "' id='selectcity" + rowID + "' type='text' size='10' readonly='readonly' style='text-align:center;border: 1px' />";

		
		//将行号推进下一行
		txtTRLastIndex.value = (rowID + 1).toString();
		
		
		}
	window.onload = function() {
		name=encodeURI(encodeURI(name));
		$.ajax({
	
			url : "./SelectElementServlet?slectname=*"
					+"&tablename=artist where name='"+name+"'"+
					"&randomconut="+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				alert(error);
			},
	
			success : function(data) {
	
				console.log("data:" + JSON.stringify(data));
				for(var i=0;i<data.length;i++){
					AddSignRow();
					j=i+1;
					
					document.getElementById("selectname"
							+ j.toString()).value = data[i].name;//姓名
					document.getElementById("selectbirthday"
							+ j.toString()).value = (data[i].birthday).split("-")[0];//年代
					document.getElementById("selectbrief"
							+ j.toString()).value = data[i].brief;//简介
					document.getElementById("selectgender"
							+ j.toString()).value =  data[i].gender;//性别
					document.getElementById("selectcity"
							+ j.toString()).value =  data[i].prov+data[i].city+data[i].district;//简介
					document.getElementById("img"
							+ j.toString()).src="<%=basePath%>"+data[i].portrait;
				}
		
				 
			}
		});
	}
	
	function Check(obj){
		if(obj.value=="是"){
			alert("无需重新创建艺术家，跳转至主页");
			parent.location.href="uploadpic/main.html";
		}else if(obj.value=="否"){
			alert("创建同名艺术家，审核通过后方可使用");
		
    		$.cookie('isaudit', "1", { expires: 1, path: '/' }); 
    		
			history.back(-1);
			
		}
		
		
		
	}
	
   </script>
  </head>
  
  <body style="font-family: 微软雅黑">

   
       <div style=";text-align: center;" id="alladdresses">
   
   		<table id="SignFrame" border="1" cellspacing="0" cellpadding="0"
			width="100%">
			<tbody>

				<tr id="trHeader" align="center">
					<td bgcolor="#D3D3D3">图片展示</td>
					<td bgcolor="#D3D3D3">姓名</td>
					<td bgcolor="#D3D3D3">年代</td>
					<td bgcolor="#D3D3D3">简介</td>
					<td bgcolor="#D3D3D3">性别</td>
					<td bgcolor="#D3D3D3">城市</td>
				
				</tr>

			</tbody>
		</table>
		<input name='txtTRLastIndex' type='hidden' id='txtTRLastIndex'value="1" />
		<p style="text-align: center;">以上作家是否包含您所需要的同名作家？</p>
		<br>
		<input type="button"  value="是" onclick="Check(this)"/>&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button"  value="否" onclick="Check(this)"/>
		<br>
		<br>
		<br>
		
    </div>
   
  </body>
</html>
