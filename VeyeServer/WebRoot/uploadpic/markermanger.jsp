<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%-- <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%> --%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%-- <base href="<%=basePath%>"> --%>

<title>Marker管理</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="../js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>

<script type="text/javascript" charset="utf-8">
var type=$.cookie('type_cookie');
var id = $.cookie('userid');
window.onload = function() {
	if(type=="seller_organization"){
		
	 	document.getElementById('type').style.display="none";
	
	
}
	
}


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

	//添加一个参与人填写行
	function AddSignRow() { //读取最后一行的行号，存放在txtTRLastIndex文本框中 
		var txtTRLastIndex = findObj("txtTRLastIndex", document);
		var rowID = parseInt(txtTRLastIndex.value);

		var signFrame = findObj("SignFrame", document);
		//添加行
		var newTR = signFrame.insertRow(signFrame.rows.length);
		newTR.id = "SignItem" + rowID;

		//添加列:序号
		var newNameTD = newTR.insertCell(0);

		//添加列内容
		newNameTD.innerHTML = newTR.rowIndex.toString();

		//添加列:ID
		var newNameTD1 = newTR.insertCell(1);
		//添加列内容
		newNameTD1.innerHTML = "<input  name='selectid" + rowID + "' id='selectid" + rowID + "' type='text' size='13'  readonly='readonly' style='text-align:center;border: 1px'/>";

		//添加列:姓名
		var newLastNameTD = newTR.insertCell(2);
		//添加列内容
		newLastNameTD.innerHTML = "<input name='selectname" + rowID + "' id='selectname" + rowID + "' type='text' size='13' readonly='readonly' style='text-align:center;border: 1px' />";

		
		//添加列:邮箱
		var newTypeTD = newTR.insertCell(3);
		//添加列内容
		newTypeTD.innerHTML = "<input name='selecttype" + rowID + "' id='selecttype" + rowID + "' type='text' size='16'readonly='readonly' style='text-align:center;border: 1px' />";
		
		
		var newSizeTD = newTR.insertCell(4);
		//添加列内容
		newSizeTD.innerHTML = "<input name='selectsize" + rowID + "' id='selectsize" + rowID + "' type='text' size='16'readonly='readonly' style='text-align:center;border: 1px' />";
		//添加列:图片
		var newDeleteTD1 = newTR.insertCell(5);
				 
		newDeleteTD1.innerHTML = "<img input name='img" + rowID + "' id='img" + rowID + "' alt='' src='' width='100' height='100'/>";

		//添加列:删除按钮
		var newDeleteTD = newTR.insertCell(6);
		//添加列内容
		newDeleteTD.innerHTML = "<div align='center' style='width:40px text-align:center' ><a  href='javascript:;' onclick=\"DeleteSignRow('SignItem"
				+ rowID + "')\"><input name='deletebutton" + rowID + "' id='deletebutton" + rowID + "' type='button' value='删除' size='10' /> </a></div>";

			
		//添加列:添加修改按钮
		var newDeleteTD2 = newTR.insertCell(7);
		//添加列内容		
		newDeleteTD2.innerHTML = "<div align='center' style='width:40px text-align:center'><a  onclick=\"updateArtist('SignItem"+ rowID + "')\"href='javascript:;'><input name='updatebutton" + rowID + "' id='updatebutton" + rowID + "' type='button' value='修改' /> </a></div>";
			
		//将行号推进下一行
		txtTRLastIndex.value = (rowID + 1).toString();
	}
		//删除前验证

	function del(){
if(confirm("确认删除吗")){
   alert("yes");
   DeleteSignRow();
  }
  else{
   alert("no");
   return;
  }
}
	
	function DeleteSignRow(rowid) {
		if(confirm("确认删除吗")){
			  
			
		var signFrame = findObj("SignFrame", document);
		var signItem = findObj(rowid, document);

		//获取将要删除的行的Index
		var rowIndex = signItem.rowIndex;
		var id=document.getElementById("selectid" + rowIndex).value;
		delsql = "delete from marker where ";
		delsql = delsql + "id='"
				+id+ "'";
		delsql = encodeURIComponent(delsql);
	
		alert("删除成功");
	
		//删除指定Index的行
		document.getElementById("deletebutton" + rowIndex).type="hidden";
		document.getElementById("updatebutton" + rowIndex).type="hidden";
		document.getElementById("selectid" + rowIndex).type="hidden";
		document.getElementById("selectname" + rowIndex).type="hidden";
		document.getElementById("selecttype" + rowIndex).type="hidden";
		document.getElementById("selectsize" + rowIndex).type="hidden";
		document.getElementById("img" + rowIndex).src="";
		
		
		$.ajax({

			url : "../RunOneSql?sql="+ delsql+"&id="+id+"&tablename=marker",

			dataType : 'text',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				//alert(data);

			}
		});

		
		}else{
			 
			   return;
			  }
			
		
		
		
	}

	function updateArtist(rowid) {

		var signItem = findObj(rowid, document);

		//获取将要删除的行的Index
		var rowIndex = signItem.rowIndex;
		
		var selectid=encodeURI(encodeURI(document.getElementById("selectid" + rowIndex).value));

		//document.getElementById("passid").value=selectid;
		window.location.href="updatemarker.jsp?id="+selectid;
	
		

	}

	function ClearAllSign(){
		
		var signFrame = findObj("SignFrame",document);
		var rowscount = signFrame.rows.length;

		//循环删除行,从最后一行往前删除
		for(i=rowscount - 1;i > 0; i--){
		   signFrame.deleteRow(i);
		}

		//重置最后行号为1
		var txtTRLastIndex = findObj("txtTRLastIndex",document);
		txtTRLastIndex.value = "1";

		
		}
		
	/*------------------------------------------------------------------------------------------*/

	function search1() {
		ClearAllSign();
		var name = document.getElementById("name").value;
		var type = document.getElementById("type").value;
		var sql=null;

		if(name==""){
			
			sql="select * from marker where userid="+id+" limit 50";
			
		}else { //name为空,性别为空,city不为空的时候根据城市模糊查询
			
			
				sql = "select * from marker where ";
				sql = sql+ "arname like '%" + name + "%' and type='"+type+"'and userid="+id;
		
		
		} 
			sql = encodeURIComponent(sql);
			$.ajax({

					url : '../MarkerMangerServlet?sql=' + sql,

					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",

					error : function(request, error) {
						alert(error);
					},

					success : function(data) {
						//alert(data);

						if (data == "nothingness") {
							alert("查询结果为空，请重新输入查询条件");
							return;
						}
						
						var j;
						for(var i=0;i<data.length;i++){
							AddSignRow();
							j=i+1;
					
							document.getElementById("selectid" + 
								j.toString()).value = data[i].id;//id
							document.getElementById("selectname"
									+ j.toString()).value = data[i].arname;//名称
							document.getElementById("selecttype"
									+ j.toString()).value = data[i].type;//年代
							document.getElementById("selectsize"
									+ j.toString()).value = data[i].size;//简介
									
									//http://123.57.81.165:8080/maidian/Artists/20151579884/thumb.jpg
							document.getElementById("img"
									+ j.toString()).src=".."+data[i].picture;	
					
						}

					}
				});

	}
	
	
	function OnChange(){
		ClearAllSign();
		var type = document.getElementById("type").value;
		
		var sql=null;

			sql = "select * from marker where ";
			sql = sql+ "type='" + type + "' ";
			
	
			sql = encodeURIComponent(sql);
				$.ajax({

					url : '../MarkerMangerServlet?sql=' + sql,

					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",

					error : function(request, error) {
						alert(error);
					},

					success : function(data) {
						//alert(data);

						if (data == "nothingness") {
							alert("查询结果为空，请重新输入查询条件");
							return;
						}

						
						var j;
						for(var i=0;i<data.length;i++){
							AddSignRow();
							j=i+1;
					
							document.getElementById("selectid" + 
								j.toString()).value = data[i].id;//id
							document.getElementById("selectname"
									+ j.toString()).value = data[i].arname;//名称
							document.getElementById("selecttype"
									+ j.toString()).value = data[i].type;//年代
							document.getElementById("selectsize"
									+ j.toString()).value = data[i].size;//简介
									
									//http://123.57.81.165:8080/maidian/Artists/20151579884/thumb.jpg
							document.getElementById("img"
									+ j.toString()).src=".."+data[i].picture;	
					
						}

					}
				});
		
		
	}
	
	
	
	
	function OnChange1(){
		ClearAllSign();
		var type = document.getElementById("type").value;
		
		var sql=null;

			sql = "select * from marker where ";
			sql = sql+ "type='" + type + "' and userid="+id;
			
	
			sql = encodeURIComponent(sql);
				$.ajax({

					url : '../MarkerMangerServlet?sql=' + sql,

					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",

					error : function(request, error) {
						alert(error);
					},

					success : function(data) {
						//alert(data);

						if (data == "nothingness") {
							alert("查询结果为空，请重新输入查询条件");
							return;
						}

						
						var j;
						for(var i=0;i<data.length;i++){
							AddSignRow();
							j=i+1;
					
							document.getElementById("selectid" + 
								j.toString()).value = data[i].id;//id
							document.getElementById("selectname"
									+ j.toString()).value = data[i].arname;//名称
							document.getElementById("selecttype"
									+ j.toString()).value = data[i].type;//年代
							document.getElementById("selectsize"
									+ j.toString()).value = data[i].size;//简介
									
									//http://123.57.81.165:8080/maidian/Artists/20151579884/thumb.jpg
							document.getElementById("img"
									+ j.toString()).src=".."+data[i].picture;	
					
						}

					}
				});
		
		
	}
	
</script>

</head>

<body>
	<form action="" id="form1" method="post">

		<table border="1" cellspacing="0" cellpadding="0" width="100%" style="margin-top: 100px;">
			<tbody>

				<tr>
					<th style="color: red;">请选择查询条件</th>
		
						<th style="text-align: center;">
						类&nbsp;型:<select id="type" name="type" style="margin-top: 5px;width:225px" onchange="OnChange(this)">
						<option value="veye">选择类型</option>
						<option value="veye">veye</option>
						<option value="美术馆">美术馆</option>
						</select>
						</th>

						<th style="text-align: center;">&nbsp;名&nbsp;称&nbsp;
						
						<input type="text" id="name" name="name" style="width:200px">
						
						</th>
						
					
					<th><input type="button" value="搜&nbsp;索"
						style="width:55px; hight:18" onclick="search1()" /></th>

				</tr>

			</tbody>
		</table>
		<table id="SignFrame" border="1" cellspacing="0" cellpadding="0"
			width="100%">
			<tbody>
				<tr id="trHeader" align="center">
					<td bgcolor="#D3D3D3">序号</td>
					<td bgcolor="#D3D3D3">ID</td>
					<td bgcolor="#D3D3D3">名称</td>
					<td bgcolor="#D3D3D3">类型</td>
					<td bgcolor="#D3D3D3">尺寸</td>
					<td bgcolor="#D3D3D3" style="width: 100px">图片展示</td>
					<td bgcolor="#D3D3D3">删除</td>
					<td bgcolor="#D3D3D3">修改</td>
				</tr>

				<div>
					<input name='txtTRLastIndex' type='hidden' id='txtTRLastIndex'
						value="1" />
						
				</div>

			</tbody>
		</table>
<!-- <table>
<tbody>

<tr>
			
	
</tr>
</tbody>
</table> -->
	</form>


</body>
</html>
