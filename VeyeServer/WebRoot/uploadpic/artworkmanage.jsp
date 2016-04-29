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

<title>作品管理</title>

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
var alldata=null;


var randomconut = Math.floor(Math.random() * 1000);
var category=null;
var categoryjson={};

window.onload = function() {
	
	if(type=="seller_artist"){
		//alert(type);
		document.getElementById("artistdiv").style.display="none";
		document.getElementById("veyemanage").style.display="none";

	}else if(type=="seller_organization"){
		document.getElementById("veyemanage").style.display="none";

		
	}else if(type=="veye"){
	

	}
		$.ajax({
			url : "../SelectElementServlet?slectname=*"
				+"&tablename=user where id="+id+
				"&randomconut="+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				//alert(error+"1");
			},

			success : function(data) {
				console.log("data2:" + JSON.stringify(data));
				alldata=data;
			

				 
			}
		});
		
	
	
	
	
	
	$.ajax({
		url : "../ArtworkCategoryServlet?randomconut=" + randomconut,

		dataType : "json",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",

		error : function(request, error) {
			alert(error);
		},

		success : function(data) {
			//console.log(data);


			for (var i = 0; i < data.length; i++) {
				category=data[i].category;
				value=data[i].value;

				categoryjson[value]=category;
			}
		
			
			
			

		}
	});
	
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

		//添加列:图片
		var newDeleteTD1 = newTR.insertCell(1);
						 
		newDeleteTD1.innerHTML = "<img input name='img" + rowID + "' id='img" + rowID + "' alt='' src='' width='100' height='100'/>";	
		
/* 		//添加列:视频
		var newVideoTD1 = newTR.insertCell(2);
						 
		newVideoTD1.innerHTML = "<video  width='320' height='240' name='video" + rowID + "' id='video" + rowID + "' src='' controls='controls' > </video>";	
		//将行号推进下一行
		 */

		//添加列:ID
		var newNameTD1 = newTR.insertCell(2);
		//添加列内容
		newNameTD1.innerHTML = "<input  name='selectid" + rowID + "' id='selectid" + rowID + "' type='text' size='7'  readonly='readonly' style='text-align:center;border: 1px'margin-left: -50px/>";

		//添加列:作品名
		var newLastNameTD = newTR.insertCell(3);
		//添加列内容
		newLastNameTD.innerHTML = "<input name='selectname" + rowID + "' id='selectname" + rowID + "' type='text' size='7' readonly='readonly' style='text-align:center;border: 1px' />";
		//添加列:作者
		var newArtistTD = newTR.insertCell(4);
		//添加列内容
		newArtistTD.innerHTML = "<input name='selectartist" + rowID + "' id='selectartist" + rowID + "' type='text' size='5'readonly='readonly' style='border: 1px' />";
		
		//添加列:年代
		var newCreateTimeTD = newTR.insertCell(5);
		//添加列内容
		newCreateTimeTD.innerHTML = "<input name='selectcreatetime" + rowID + "' id='selectcreatetime" + rowID + "' type='text' size='7' readonly='readonly' style='text-align:center;border: 1px' />";

		//添加列：类别
		var newCategoryTD = newTR.insertCell(6);
		//添加列内容
		newCategoryTD.innerHTML = "<input name='selectcategory" + rowID + "' id='selectcategory" + rowID + "' type='text' size='7' readonly='readonly'style='text-align:center;border: 1px'/>";

		//添加列:类型
		var newStyleTD = newTR.insertCell(7);
		//添加列内容
		newStyleTD.innerHTML = "<input name='selecttags" + rowID + "' id='selecttags" + rowID + "' type='text' size='7'readonly='readonly' style='text-align:center;border: 1px;height:90px' />";

		//添加列:简介
			
		var newBriefTD = newTR.insertCell(8);
		//添加列内容
		newBriefTD.innerHTML = "<textarea name='selectbrief" + rowID + "' id='selectbrief" + rowID + "' type='text' size='4'readonly='readonly' style='text-align:center;border: 1px;height:90px' ></textarea>";
		

		//添加列:尺寸
		var newSizeTD = newTR.insertCell(9);
		//添加列内容
		newSizeTD.innerHTML = "<input name='selectsize" + rowID + "' id='selectsize" + rowID + "' type='text' size='10'readonly='readonly' style='text-align:center;border: 1px' />";

		//添加列:价格
		var newPriceTD = newTR.insertCell(10);
		//添加列内容
		newPriceTD.innerHTML = "<input name='selectprice" + rowID + "' id='selectprice" + rowID + "' type='text' size='10'readonly='readonly' style='text-align:center;border: 1px' />";
		
		
		//添加列:用户
		var newgalleryTD = newTR.insertCell(11);
		//添加列内容
		newgalleryTD.innerHTML = "<input name='selectgallery" + rowID + "' id='selectgallery" + rowID + "' type='text' size='10'readonly='readonly' style='text-align:center;border: 1px' />";
		
		//添加列:联系人
		var newagentTD = newTR.insertCell(12);
		//添加列内容
		newagentTD.innerHTML = "<input name='selectagent" + rowID + "' id='selectagent" + rowID + "' type='text' size='10'readonly='readonly' style='text-align:center;border: 1px' />";
		
		//添加列:电话
		var newagentphoneTD = newTR.insertCell(13);
		//添加列内容
		newagentphoneTD.innerHTML = "<input name='selectagentphone" + rowID + "' id='selectagentphone" + rowID + "' type='text' size='10'readonly='readonly' style='text-align:center;border: 1px' />";
		
		//添加列:邮箱
		var newAgentEmailTD = newTR.insertCell(14);
		//添加列内容
		newAgentEmailTD.innerHTML = "<input name='selectagentemail" + rowID + "' id='selectagentemail" + rowID + "' type='text' size='10'readonly='readonly' style='text-align:center;border: 1px' />";
		
		//添加列:可售
		var newissaleTD = newTR.insertCell(15);
		//添加列内容
		newissaleTD.innerHTML = "<input name='selectissale" + rowID + "' id='selectissale" + rowID + "' type='text' size='4'readonly='readonly' style='text-align:center;border: 1px' />";
		
		//添加列:库存
		var newstockTD = newTR.insertCell(16);
		//添加列内容
		newstockTD.innerHTML = "<input name='selectstock" + rowID + "' id='selectstock" + rowID + "' type='text' size='4'readonly='readonly' style='text-align:center;border: 1px' />";
		//添加列:marker
		var newismarkerTD = newTR.insertCell(17);
		//添加列内容
		newismarkerTD.innerHTML = "<input name='selectismarker" + rowID + "' id='selectismarker" + rowID + "' type='text' size='4'readonly='readonly' style='text-align:center;border: 1px' />";
		
		
		//添加列:删除按钮
		var newDeleteTD = newTR.insertCell(18);
		//添加列内容
		newDeleteTD.innerHTML = "<div align='center' style='width:40px text-align:center' ><a  href='javascript:;' onclick=\"DeleteSignRow('SignItem"
				+ rowID + "')\"><input name='deletebutton" + rowID + "' id='deletebutton" + rowID + "' type='button' value='删除' size='10' /> </a></div>";
		//添加列:添加修改按钮
		var newDeleteTD2 = newTR.insertCell(19);
		//添加列内容		
		newDeleteTD2.innerHTML = "<div align='center' style='width:40px text-align:center'><a  onclick=\"updategallery('SignItem"+ rowID + "')\"href='javascript:;'><input name='updatebutton" + rowID + "' id='updatebutton" + rowID + "' type='button' value='修改' /> </a></div>";

	
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
		delsql = "delete from artwork where ";
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
		document.getElementById("selectartist" + rowIndex).type="hidden";
		document.getElementById("selectcreatetime" + rowIndex).type="hidden";
		document.getElementById("selectcategory" + rowIndex).type="hidden";
		document.getElementById("selecttags" + rowIndex).type="hidden";
		document.getElementById("selectbrief" + rowIndex).style.display="none";
		document.getElementById("selectsize" + rowIndex).type="hidden";
		document.getElementById("selectprice" + rowIndex).type="hidden";
		document.getElementById("selectgallery" + rowIndex).type="hidden";
		document.getElementById("selectagent" + rowIndex).type="hidden";
		document.getElementById("selectagentphone" + rowIndex).type="hidden";
		document.getElementById("selectagentemail" + rowIndex).type="hidden";
		document.getElementById("selectismarker" + rowIndex).type="hidden";
		document.getElementById("selectissale" + rowIndex).type="hidden";
		document.getElementById("selectstock" + rowIndex).type="hidden";
	
		document.getElementById("img" + rowIndex).src="";
		
		
		
		
	
		console.log(delsql);
		$.ajax({

			url : "../RunOneSql?sql="+ delsql+"&id="+id+"&tablename=artwork",

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
		
		window.location.href="updateartwork.jsp?id="+selectid;
	
		

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
		var artist = document.getElementById("artist").value;
		var user = document.getElementById("user").value;
		var sql=null;
		if(type=="seller_organization"){
			if(name=="" && artist=="" && user==""){
				
				sql="select * from artwork where galleryid='"+alldata[0].galleryid+"' limit 50";
				
			}
		
			 
			else if (name == "" && artist != "" && user=="") { //name为空,性别为空,city不为空的时候根据城市模糊查询
				sql = "select * from artwork where ";
				sql = sql+ "artist like '%" + artist + "%' and galleryid='"+alldata[0].galleryid+"'";
			} else if (name == "" && user != "" && artist=="") {//name为空,城市为空，性别不为空的时候性别查询
				sql = "select * from artwork where ";
				sql = sql+ "gallery like '%" + user + "%' and galleryid='"+alldata[0].galleryid+"'";
			} else if (name == "" && artist != "" && user!="" ) {//name 为空 城市和性别都不为空的时候根据城市和性别查询
				sql = "select * from artwork where ";
				sql = sql + " " + "gallery like '%" + user + "' " + "and" + " "
						+ "artist like '%" + artist + "%' and galleryid='"+alldata[0].galleryid+"'";
			} 	
	
			
			 else if (name != "" && artist == "" && user=="") { //name不为空,性别city为空的时候根据name模糊查询
				sql = "select * from artwork where ";
				sql = sql+ "name like '%" + name + "%'  and galleryid='"+alldata[0].galleryid+"'";
				
			} else if (name != ""  && artist!="" && user == "") {//name不为空,城市不为空，性别为空的时候根据name和城市模糊查询
				sql = "select * from artwork where ";
				sql = sql+ "name like '%" + name + "%' and artist like '%"+artist+ "%' and galleryid='"+alldata[0].galleryid+"'";
				
			} else if (name != ""  && user!="" && artist == "") {//name 不为空 性别不为空，城市为空的时候根据name和性别查询
				sql = "select * from artwork where ";
				sql = sql + " " + "gallery like'%" + user + "' " + "and" + " "
						+ "name like '%" + name + "%' and galleryid='"+alldata[0].galleryid+"'";
			} 		
				
			else if (name != "" && artist != "" && user!="") {//name和city,type都不为空的时候，按照价格，名称，性别模糊查询
				sql = "select * from artwork where ";
				sql = sql + "gallery like'%" + user + "' " + "and" + " " + "city like '%"
						+ artist + " %' " + "and" + " " + "name like '%"
						+ name + "%' and galleryid='"+alldata[0].galleryid+"'";
	
			}
		
		}else if(type=="veye"){
			if(name=="" && artist=="" && user==""){
				
				sql="select * from artwork limit 50";
				
			}
		
			 
			else if (name == "" && artist != "" && user=="") { //name为空,性别为空,city不为空的时候根据城市模糊查询
				sql = "select * from artwork where ";
				sql = sql+ "artist like '%" + artist + "%' ";
			} else if (name == "" && user != "" && artist=="") {//name为空,城市为空，性别不为空的时候性别查询
				sql = "select * from artwork where ";
				sql = sql+ "gallery like '%" + user + "%' ";
			} else if (name == "" && artist != "" && user!="" ) {//name 为空 城市和性别都不为空的时候根据城市和性别查询
				sql = "select * from artwork where ";
				sql = sql + " " + "gallery like '%" + user + "' " + "and" + " "
						+ "artist like '%" + artist + "%' ";
			} 	
	
			
			 else if (name != "" && artist == "" && user=="") { //name不为空,性别city为空的时候根据name模糊查询
				sql = "select * from artwork where ";
				sql = sql+ "name like '%" + name + "%' ";
				
			} else if (name != ""  && artist!="" && user == "") {//name不为空,城市不为空，性别为空的时候根据name和城市模糊查询
				sql = "select * from artwork where ";
				sql = sql+ "name like '%" + name + "%' and artist like '%"+artist+"%'";
				
			} else if (name != ""  && user!="" && artist == "") {//name 不为空 性别不为空，城市为空的时候根据name和性别查询
				sql = "select * from artwork where ";
				sql = sql + " " + "gallery like'%" + user + "' " + "and" + " "
						+ "name like '%" + name + "%' ";
			} 		
				
			else if (name != "" && artist != "" && user!="") {//name和city,type都不为空的时候，按照价格，名称，性别模糊查询
				sql = "select * from artwork where ";
				sql = sql + "gallery like'%" + user + "' " + "and" + " " + "city like '%"
						+ artist + " %' " + "and" + " " + "name like '%"
						+ name + "%' ";
	
			}
			
			
		}else if(type=="seller_artist"){
			
			
		if(name=="" && artist=="" && user==""){
				
				sql="select * from artwork where galleryid='"+alldata[0].galleryid+"' limit 50";
				
			}
		
			 
			else if (name == "" && artist != "" && user=="") { //name为空,性别为空,city不为空的时候根据城市模糊查询
				sql = "select * from artwork where ";
				sql = sql+ "artist like '%" + artist + "%' and galleryid='"+alldata[0].galleryid+"'";
			} else if (name == "" && user != "" && artist=="") {//name为空,城市为空，性别不为空的时候性别查询
				sql = "select * from artwork where ";
				sql = sql+ "gallery like '%" + user + "%' and galleryid='"+alldata[0].galleryid+"'";
			} else if (name == "" && artist != "" && user!="" ) {//name 为空 城市和性别都不为空的时候根据城市和性别查询
				sql = "select * from artwork where ";
				sql = sql + " " + "gallery like '%" + user + "' " + "and" + " "
						+ "artist like '%" + artist + "%' and galleryid='"+alldata[0].galleryid+"'";
			} 	
	
			
			 else if (name != "" && artist == "" && user=="") { //name不为空,性别city为空的时候根据name模糊查询
				sql = "select * from artwork where ";
				sql = sql+ "name like '%" + name + "%'  and galleryid='"+alldata[0].galleryid+"'";
				
			} else if (name != ""  && artist!="" && user == "") {//name不为空,城市不为空，性别为空的时候根据name和城市模糊查询
				sql = "select * from artwork where ";
				sql = sql+ "name like '%" + name + "%' and artist like '%"+artist+ "%' and galleryid='"+alldata[0].galleryid+"'";
				
			} else if (name != ""  && user!="" && artist == "") {//name 不为空 性别不为空，城市为空的时候根据name和性别查询
				sql = "select * from artwork where ";
				sql = sql + " " + "gallery like'%" + user + "' " + "and" + " "
						+ "name like '%" + name + "%' and galleryid='"+alldata[0].galleryid+"'";
			} 		
				
			else if (name != "" && artist != "" && user!="") {//name和city,type都不为空的时候，按照价格，名称，性别模糊查询
				sql = "select * from artwork where ";
				sql = sql + "gallery like'%" + user + "' " + "and" + " " + "city like '%"
						+ artist + " %' " + "and" + " " + "name like '%"
						+ name + "%' and galleryid='"+alldata[0].galleryid+"'";
	
			}
			
		}
		
			sql = encodeURIComponent(sql);
		$.ajax({

					url : '../ArtWorkMange?sql=' + sql,

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
									+ j.toString()).value = data[i].id;//id
								/* 	document.getElementById("video" 
											+ j.toString()).src = ".."+data[i].vedio;//id */
									
							document.getElementById("selectname"
									+ j.toString()).value = data[i].name;//姓名
					
							document.getElementById("selectartist"
									+ j.toString()).value = data[i].artist;//简介
							
							document.getElementById("selectcreatetime"
											+ j.toString()).value =(data[i].createtime).split("-")[0];//机构
											
							document.getElementById("selectcategory"
									+ j.toString()).value =categoryjson[data[i].category];//所属人
									
									
							document.getElementById("selecttags"
									+ j.toString()).value = data[i].tags;
							
							document.getElementById("selectbrief"
									+ j.toString()).value = data[i].brief;
							document.getElementById("selectsize"
									+ j.toString()).value =data[i].size;
							document.getElementById("selectprice"
									+ j.toString()).value =data[i].price;
									
						    document.getElementById("selectgallery"
											+ j.toString()).value =data[i].gallery;//手机	
											
							document.getElementById("selectagent"
									+ j.toString()).value = data[i].agent;//手机
							document.getElementById("selectagentphone"
									+ j.toString()).value = data[i].agentphone;//
																			
							document.getElementById("selectagentemail"
											+ j.toString()).value =data[i].agentemail;//
							
								if(data[i].issale=="1"){
										document.getElementById("selectissale"
														+ j.toString()).value ="是";//	
											}else {
												document.getElementById("selectissale"
														+ j.toString()).value ="否";//		
												
											}
							

								if(data[i].ismarker=="1"){
										document.getElementById("selectismarker"
														+ j.toString()).value ="是";//	
											}else {
												document.getElementById("selectismarker"
														+ j.toString()).value ="否";//		
												
											}
						
							document.getElementById("selectstock"
											+ j.toString()).value =data[i].stock;//
						
							document.getElementById("img"
									+ j.toString()).src=".."+data[i].thumbnail;	
								
						
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
		

						<th style="text-align: center;">&nbsp;作品名 &nbsp;
						
						<input type="text" id="name" name="name" style="width:200px">
						
						</th>
						
						<th style="text-align: center;" id="artistdiv" >&nbsp;作&nbsp;者&nbsp;<input type="text" id="artist" name="artist"  >
						</th>
					
						<th style="text-align: center;" id="veyemanage" >&nbsp;用户&nbsp;<input type="text" id="user" name="user" >
						</th>
						

					
					<th><input type="button" value="搜&nbsp;索"
						style="width:55px; hight:18" onclick="search1()" /></th>

				</tr>

			</tbody>
		</table>
		<div style="width: 1200px">
		<table id="SignFrame" border="1" cellspacing="0" cellpadding="0"
			width="100%">
			<tbody>

				<tr id="trHeader" align="center">
					<td bgcolor="#D3D3D3">序号</td>
					<td bgcolor="#D3D3D3">图片展示</td>
				<!-- 	<td bgcolor="#D3D3D3">视频展示</td> -->
					<td bgcolor="#D3D3D3">ID</td>
					<td bgcolor="#D3D3D3">作品名</td>
					<td bgcolor="#D3D3D3">作者</td>
					<td bgcolor="#D3D3D3">年代</td>
					<td bgcolor="#D3D3D3">类别</td>
					<td bgcolor="#D3D3D3">标签</td>
					<td bgcolor="#D3D3D3">简介</td>
					<td bgcolor="#D3D3D3">尺寸</td>
					<td bgcolor="#D3D3D3">价格</td>
					<td bgcolor="#D3D3D3">用户</td>
					<td bgcolor="#D3D3D3">经纪人</td>
					<td bgcolor="#D3D3D3">手机</td>
					<td bgcolor="#D3D3D3">邮箱</td>
					<td bgcolor="#D3D3D3">可售</td>
					<td bgcolor="#D3D3D3">库存</td>
					<td bgcolor="#D3D3D3">Marker</td>
					<td bgcolor="#D3D3D3">删除</td>
					<td bgcolor="#D3D3D3">修改</td>
				
			
					
				</tr>

				<div>
					<input name='txtTRLastIndex' type='hidden' id='txtTRLastIndex'
						value="1" />
						
				</div>

			</tbody>
		</table>
		</div>
		
		
<!-- <table>
<tbody>

<tr>
			
	
</tr>
</tbody>
</table> -->
	</form>


</body>
</html>
