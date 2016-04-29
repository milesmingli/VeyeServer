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

<title>画廊管理</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="../js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" charset="utf-8">
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

		//添加列:图片
		var newDeleteTD1 = newTR.insertCell(1);
						 
		newDeleteTD1.innerHTML = "<img input name='img" + rowID + "' id='img" + rowID + "' alt='' src='' width='100' height='100'/>";	
		
		//添加列内容
		newNameTD.innerHTML = newTR.rowIndex.toString();

		//添加列:ID
		var newNameTD1 = newTR.insertCell(2);
		//添加列内容
		newNameTD1.innerHTML = "<input  name='selectid" + rowID + "' id='selectid" + rowID + "' type='text' size='7'  readonly='readonly' style='text-align:center;border: 1px'margin-left: -50px/>";

		//添加列:姓名
		var newLastNameTD = newTR.insertCell(3);
		//添加列内容
		newLastNameTD.innerHTML = "<input name='selectname" + rowID + "' id='selectname" + rowID + "' type='text' size='7' readonly='readonly' style='text-align:center;border: 1px' />";

		
		//添加列:简介
		var newBriefTD = newTR.insertCell(4);
		//添加列内容
		newBriefTD.innerHTML = "<textarea name='selectbrief" + rowID + "' id='selectbrief" + rowID + "' type='text' size='4'readonly='readonly' style='border: 1px;height:90px' ></textarea>";
		
		//添加列:机构
		var newTypeTD = newTR.insertCell(5);
		//添加列内容
		newTypeTD.innerHTML = "<input name='selecttype" + rowID + "' id='selecttype" + rowID + "' type='text' size='4' readonly='readonly' style='text-align:center;border: 1px' />";

		//添加列:所属人
		var newOwnerartistTD = newTR.insertCell(6);
		//添加列内容
		newOwnerartistTD.innerHTML = "<input name='selectownerartist" + rowID + "' id='selectownerartist" + rowID + "' type='text' size='8' readonly='readonly'style='text-align:center;border: 1px'/>";

		//添加列:城市
		var newAddressTD = newTR.insertCell(7);
		//添加列内容
		newAddressTD.innerHTML = "<textarea name='selectaddress" + rowID + "' id='selectaddress" + rowID + "' type='text' size='4'readonly='readonly' style='border: 1px;height:90px' ></textarea>";

		//添加列:联系人
		var newcontactpersonTD = newTR.insertCell(8);
		//添加列内容
		newcontactpersonTD.innerHTML = "<input name='selectcontactperson" + rowID + "' id='selectcontactperson" + rowID + "' type='text' size='5'readonly='readonly' style='border: 1px' />";

		//添加列:手机
		var newPhoneTD = newTR.insertCell(9);
		//添加列内容
		newPhoneTD.innerHTML = "<input name='selectphone" + rowID + "' id='selectphone" + rowID + "' type='text' size='10'readonly='readonly' style='border: 1px' />";

		//添加列:电话
		var newTelePhoneTD = newTR.insertCell(10);
		//添加列内容
		newTelePhoneTD.innerHTML = "<input name='selecttelephone" + rowID + "' id='selecttelephone" + rowID + "' type='text' size='10'readonly='readonly' style='border: 1px' />";

		//添加列:传真
		var newFaxTD = newTR.insertCell(11);
		//添加列内容
		newFaxTD.innerHTML = "<input name='selectfax" + rowID + "' id='selectfax" + rowID + "' type='text' size='10'readonly='readonly' style='border: 1px' />";

		//添加列:网站
		var newWebTD = newTR.insertCell(12);
		//添加列内容
		newWebTD.innerHTML = "<input name='selectweb" + rowID + "' id='selectweb" + rowID + "' type='text' size='10'readonly='readonly' style='border: 1px' />";

		//添加列:邮箱
		var newEmailTD = newTR.insertCell(13);
		//添加列内容
		newEmailTD.innerHTML = "<input name='selectemail" + rowID + "' id='selectemail" + rowID + "' type='text' size='16'readonly='readonly' style='border: 1px' />";
		
		//添加列:删除按钮
		var newDeleteTD = newTR.insertCell(14);
		//添加列内容
		newDeleteTD.innerHTML = "<div align='center' style='width:40px text-align:center' ><a  href='javascript:;' onclick=\"DeleteSignRow('SignItem"
				+ rowID + "')\"><input name='deletebutton" + rowID + "' id='deletebutton" + rowID + "' type='button' value='删除' size='10' /> </a></div>";


		//添加列:添加修改按钮
		var newDeleteTD2 = newTR.insertCell(15);
		//添加列内容		
		newDeleteTD2.innerHTML = "<div align='center' style='width:40px text-align:center'><a  onclick=\"updategallery('SignItem"+ rowID + "')\"href='javascript:;'><input name='updatebutton" + rowID + "' id='updatebutton" + rowID + "' type='button' value='修改' /> </a></div>";
	
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
		delsql = "delete from gallery where ";
		delsql = delsql + "id='"
				+id+ "'";
		delsql = encodeURIComponent(delsql);
		//alert(delsql);
		alert("删除成功");
	
		//删除指定Index的行
		document.getElementById("deletebutton" + rowIndex).type="hidden";
		document.getElementById("updatebutton" + rowIndex).type="hidden";
		document.getElementById("selectid" + rowIndex).type="hidden";
		document.getElementById("selectname" + rowIndex).type="hidden";
		document.getElementById("selectaddress" + rowIndex).style.display="none";
		document.getElementById("selecttype" + rowIndex).type="hidden";	
		document.getElementById("selectbrief" + rowIndex).style.display="none";
		document.getElementById("selectownerartist" + rowIndex).type="hidden";
		document.getElementById("selectcontactperson" + rowIndex).type="hidden";
		document.getElementById("selectphone" + rowIndex).type="hidden";
		document.getElementById("selecttelephone" + rowIndex).type="hidden";
		document.getElementById("selectfax" + rowIndex).type="hidden";
		document.getElementById("selectweb" + rowIndex).type="hidden";
		document.getElementById("selectemail" + rowIndex).type="hidden";
		document.getElementById("img" + rowIndex).src="";
		
		
		$.ajax({

			url : "../RunOneSql?sql="+ delsql+"&id="+id+"&tablename=gallery",

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

	function updategallery(rowid) {

		var signItem = findObj(rowid, document);

		//获取将要操作行的Index
		var rowIndex = signItem.rowIndex;
		
		var selectid=encodeURI(encodeURI(document.getElementById("selectid" + rowIndex).value));
	
		//document.getElementById("passid").value=selectid;
		window.location.href="updategallery.jsp?id="+selectid;
	
		

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
		var city = document.getElementById("city").value;
		var type = document.getElementById("type").value;
		var sql=null;

		if(name=="" && city=="" && type==""){
			
			sql="select * from gallery limit 50";
			
		}
	
		 
		else if (name == "" && city != "" && type=="") { //name为空,性别为空,city不为空的时候根据城市模糊查询
			sql = "select * from gallery where ";
			sql = sql+ "city like '%" + city + "%' ";
		} else if (name == "" && type != "" && city=="") {//name为空,城市为空，性别不为空的时候性别查询
			sql = "select * from gallery where ";
			sql = sql +"type like'%"
					+ type + "%' ";
		} else if (name == "" && city != "" && type!="" ) {//name 为空 城市和性别都不为空的时候根据城市和性别查询
			sql = "select * from gallery where ";
			sql = sql + " " + "type like'%" + type + "%' " + "and" + " "
					+ "city like '%" + city + "%' ";
		} 	

		
		 else if (name != "" && city == "" && type=="") { //name不为空,性别city为空的时候根据name模糊查询
			sql = "select * from gallery where ";
			sql = sql+ "name like '%" + name + "%' ";
			
		} else if (name != ""  && city!="" && type == "") {//name不为空,城市不为空，性别为空的时候根据name和城市模糊查询
			sql = "select * from gallery where ";
			sql = sql+ "name like '%" + name + "%' and city like '%"+city+"%'";
			
		} else if (name != ""  && type!="" && city == "") {//name 不为空 性别不为空，城市为空的时候根据name和性别查询
			sql = "select * from gallery where ";
			sql = sql + " " + "type like'%" + type + "%' " + "and" + " "
					+ "name like '%" + name + "%' ";
		} 		
			
		else if (name != "" && city != "" && type!="") {//name和city,type都不为空的时候，按照价格，名称，性别模糊查询
			sql = "select * from gallery where ";
			sql = sql + "type like'%" + type + "%' " + "and" + " " + "city like '%"
					+ city + " %' " + "and" + " " + "name like '%"
					+ name + "%' ";

		}
			sql = encodeURIComponent(sql);
		$.ajax({

					url : '../GalleryManage?sql=' + sql,

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
							document.getElementById("selectid" 
									+ j.toString()).value=data[i].id;
							document.getElementById("selectname"
									+ j.toString()).value =data[i].name;//姓名
					
							document.getElementById("selectbrief"
									+ j.toString()).value = data[i].brief;//简介
							
							document.getElementById("selecttype"
											+ j.toString()).value = data[i].type;//机构
									
							if(data[i].owner_artist!=null){
								document.getElementById("selectownerartist"
									+ j.toString()).value = data[i].owner_artist;//所属人
								}else{
									document.getElementById("selectownerartist"
									+ j.toString()).value = "";//所属人
								}
						
								
									
							document.getElementById("selectaddress"
									+ j.toString()).value =data[i].province+data[i].city+data[i].district+data[i].address;//简介
									
						    document.getElementById("selectcontactperson"
											+ j.toString()).value = data[i].contactperson;//手机	
											
							document.getElementById("selectphone"
									+ j.toString()).value = data[i].phone;//手机

							document.getElementById("selecttelephone"
											+ j.toString()).value = data[i].telephone;//
											
							document.getElementById("selectfax"
													+ j.toString()).value = data[i].fax;//手机
													
							document.getElementById("selectweb"
															+ j.toString()).value = data[i].web;//手机
									
							document.getElementById("selectemail"
									+ j.toString()).value = data[i].email;//
																			
									
									
									//http://123.57.81.165:8080/maidian/gallerys/20151579884/thumb.jpg
							document.getElementById("img"
									+ j.toString()).src=".."+data[i].portrait;	
							
							
						
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
		

						<th style="text-align: right;">&nbsp;姓&nbsp;名 &nbsp;
						
						<input type="text" id="name" name="name" style="width:200px">
						
						</th>
						
						<th style="text-align: right;">&nbsp;城&nbsp;市&nbsp;<input type="text" id="city" name="city"  >
						</th>
						
						<th style="text-align: right;">&nbsp;机&nbsp;构&nbsp;<input type="text" id="type" name="type">
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
					<td bgcolor="#D3D3D3">图片展示</td>
					<td bgcolor="#D3D3D3">ID</td>
					<td bgcolor="#D3D3D3">画廊名称</td>
					<td bgcolor="#D3D3D3">简介</td>
					<td bgcolor="#D3D3D3">类型</td>
					<td bgcolor="#D3D3D3">所属人</td>
					<td bgcolor="#D3D3D3">地址</td>
					<td bgcolor="#D3D3D3">联系人</td>
					<td bgcolor="#D3D3D3">手机</td>
					<td bgcolor="#D3D3D3">电话</td>
					<td bgcolor="#D3D3D3">传真</td>
					<td bgcolor="#D3D3D3">网站</td>
					<td bgcolor="#D3D3D3">邮箱</td>
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
