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

<title>新展览管理</title>

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
var randomconut = Math.floor(Math.random() * 1000);
var galleryid=null;
window.onload=function(){
	
	if(type=="seller_organization"){
		
		document.getElementById("gallerydiv").style.display="none";
		$.ajax({
			
			url : "../SelectElementServlet?slectname=*"
					+"&tablename=user where id="+id+
					"&randomconut="+ randomconut,
			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			error : function(request, error) {
				alert(error);
			},
	
			success : function(data) {
	
				console.log("data:" + JSON.stringify(data));
				 galleryid=data[0].galleryid;
		
							 
			}
		});
		
		
		
	}else if(type=="veye"){
		document.getElementById("gallerydiv").style.display="block";

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
		var newDeleteTD1 = newTR.insertCell(1);
		 
		newDeleteTD1.innerHTML = "<img input name='img" + rowID + "' id='img" + rowID + "' alt='' src='' width='100' height='100'/>";	
		//将行号推进下一行
		//添加列内容
		newNameTD.innerHTML = newTR.rowIndex.toString();

		//添加列:ID
		var newNameTD1 = newTR.insertCell(2);
		//添加列内容
		newNameTD1.innerHTML = "<input  name='selectid" + rowID + "' id='selectid" + rowID + "' type='text' size='7'  readonly='readonly' style='text-align:center;border: 1px'margin-left: -50px/>";

		//添加列:作品名
		var newLastNameTD = newTR.insertCell(3);
		//添加列内容
		newLastNameTD.innerHTML = "<input name='selectname" + rowID + "' id='selectname" + rowID + "' type='text' size='7' readonly='readonly' style='text-align:center;border: 1px' />";

		var newBriefTD = newTR.insertCell(4);
		//添加列内容
		newBriefTD.innerHTML = "<textarea name='selectbrief" + rowID + "' id='selectbrief" + rowID + "' type='text' size='4'readonly='readonly' style='text-align:center;border: 1px;height:90px' ></textarea>";
		
		//添加列:年代
		var newCreateTimeTD = newTR.insertCell(5);
		//添加列内容
		newCreateTimeTD.innerHTML = "<input name='selectstarttime" + rowID + "' id='selectstarttime" + rowID + "' type='text' size='7' readonly='readonly' style='text-align:center;border: 1px' />";

		//添加列：类别
		var newCategoryTD = newTR.insertCell(6);
		//添加列内容
		newCategoryTD.innerHTML = "<input name='selectendtime" + rowID + "' id='selectendtime" + rowID + "' type='text' size='7' readonly='readonly'style='text-align:center;border: 1px'/>";

		//添加列:作者
		var newArtistTD = newTR.insertCell(7);
		//添加列内容
		newArtistTD.innerHTML = "<input name='selectgalleryname" + rowID + "' id='selectgalleryname" + rowID + "' type='text' size='8'readonly='readonly' style='border: 1px' />";
		
		//添加列:简介
		//添加列:类型
		var newStyleTD = newTR.insertCell(8);
		//添加列内容
		newStyleTD.innerHTML = "<input name='selectcontactperson" + rowID + "' id='selectcontactperson" + rowID + "' type='text' size='4'readonly='readonly' style='text-align:center;border: 1px;height:90px' />";


		//添加列:尺寸
		var newSizeTD = newTR.insertCell(9);
		//添加列内容
		newSizeTD.innerHTML = "<input name='selectphone" + rowID + "' id='selectphone" + rowID + "' type='text' size='10'readonly='readonly' style='text-align:center;border: 1px' />";
		//添加列:尺寸
		var newfaxTD = newTR.insertCell(10);
		//添加列内容
		newfaxTD.innerHTML = "<input name='selectfax" + rowID + "' id='selectfax" + rowID + "' type='text' size='10'readonly='readonly' style='text-align:center;border: 1px' />";

		//添加列:价格
		var newPriceTD = newTR.insertCell(11);
		//添加列内容
		newPriceTD.innerHTML = "<input name='selectemail" + rowID + "' id='selectemail" + rowID + "' type='text' size='10'readonly='readonly' style='text-align:center;border: 1px' />";
		
		//添加列:删除按钮
		var newDeleteTD = newTR.insertCell(12);
		//添加列内容
		newDeleteTD.innerHTML = "<div align='center' style='width:40px text-align:center' ><a  href='javascript:;' onclick=\"DeleteSignRow('SignItem"
				+ rowID + "')\"><input name='deletebutton" + rowID + "' id='deletebutton" + rowID + "' type='button' value='删除' size='10' /> </a></div>";
		//添加列:添加修改按钮
		var newDeleteTD2 = newTR.insertCell(13);
		//添加列内容		
		newDeleteTD2.innerHTML = "<div align='center' style='width:40px text-align:center'><a  onclick=\"updategallery('SignItem"+ rowID + "')\"href='javascript:;'><input name='updatebutton" + rowID + "' id='updatebutton" + rowID + "' type='button' value='修改' /> </a></div>";
		//添加列:图片
	
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
		sql = "delete from exhibition where ";
		sql = sql + "id='"
				+id+ "'";
		sql = encodeURIComponent(sql);
		//alert(delsql);
		alert("删除成功");
	
		//删除指定Index的行
		document.getElementById("deletebutton" + rowIndex).type="hidden";
		document.getElementById("updatebutton" + rowIndex).type="hidden";
		document.getElementById("selectid" + rowIndex).type="hidden";
		document.getElementById("selectname" + rowIndex).type="hidden";
		document.getElementById("selectbrief" + rowIndex).style.display="none";
		document.getElementById("selectstarttime" + rowIndex).type="hidden";
		document.getElementById("selectendtime" + rowIndex).type="hidden";
		document.getElementById("selectgalleryname" + rowIndex).type="hidden";
		document.getElementById("selectcontactperson" + rowIndex).type="hidden";
		document.getElementById("selectphone" + rowIndex).type="hidden";
		document.getElementById("selectfax" + rowIndex).type="hidden";
		document.getElementById("selectemail" + rowIndex).type="hidden";
		document.getElementById("img" + rowIndex).src="";
		
		
	
		
		$.ajax({

			url : "../DelOneSql?sql="+sql,

			dataType : 'text',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				alert("删除成功");
				//console.log(data);
			
		
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
		window.location.href="UpdateExhibitionGallery.jsp?id="+selectid;
	
		

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
		var galleryname = document.getElementById("galleryname").value;
		var sql=null;

		
		if(type=="seller_organization"){
				
			if(name=="" && galleryname==""){
				
				sql="select * from exhibition where galleryid='"+galleryid+"'";
				
			}
			 else if (name != "" && galleryname == "") { //name不为空,性别city为空的时候根据name模糊查询
				sql = "select * from exhibition where ";
				sql = sql+ "name like '%" + name + "%' and galleryid='"+galleryid+"'";
				
			}
		}else if (type=="veye"){
			
			if(name=="" && galleryname==""){
				
				sql="select * from exhibition";
				
			}
		
			 
			else if (name == "" && galleryname != "") { //name为空,性别为空,city不为空的时候根据城市模糊查询
				sql = "select * from exhibition where ";
				sql = sql+ "galleryname like '%" + artist + "%' ";
			} 
			 else if (name != "" && galleryname == "") { //name不为空,性别city为空的时候根据name模糊查询
				sql = "select * from exhibition where ";
				sql = sql+ "name like '%" + name + "%' ";
				
			} else if (name != ""  && galleryname!="" ) {//name不为空,城市不为空，性别为空的时候根据name和城市模糊查询
				sql = "select * from exhibition where ";
				sql = sql+ "name like '%" + name + "%' and galleryname like '%"+galleryname+"%'";
				
			}
			
		}
			sql = encodeURIComponent(sql);
		$.ajax({

					url : '../ExhibitionManageServlet?sql=' + sql,

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
							
							document.getElementById("selectname"
									+ j.toString()).value = data[i].name;//姓名
					
							document.getElementById("selectbrief"
									+j.toString()).value = data[i].brief;//简介
							
							document.getElementById("selectstarttime"
											+ j.toString()).value = data[i].starttime;//机构
											
							document.getElementById("selectendtime"
									+j.toString()).value = data[i].endtime;//所属人
									//console.log(galleryDetaileArrdy[3]);
									
							document.getElementById("selectgalleryname"
									+ j.toString()).value = data[i].gallery;
							
							document.getElementById("selectcontactperson"
									+ j.toString()).value = data[i].contactperson;
							document.getElementById("selectphone"
									+ j.toString()).value = data[i].phone;
							document.getElementById("selectemail"
									+ j.toString()).value = data[i].email;
							
							document.getElementById("img"
									+ j.toString()).src=".."+ data[i].portrait;	
						
						}

					}
				});

	}
</script>

</head>

<body>
	<form action="" id="form1" method="post">

		<table border="1" cellspacing="0" cellpadding="0" width="95%" style="margin-top: 100px;">
			<tbody>

				<tr>
					<th style="color: red;">请选择查询条件</th>
		

						<th style="text-align: center;">&nbsp;展览名称 &nbsp;
						
						<input type="text" id="name" name="name" style="width:200px">
						
						</th>
						
						<th style="text-align: center;" id="gallerydiv">&nbsp;所属画廊&nbsp;<input type="text" id="galleryname" name="galleryname"  >
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
					<td bgcolor="#D3D3D3">ID</td>
					<td bgcolor="#D3D3D3">展览名称</td>
					<td bgcolor="#D3D3D3">简介</td>
					<td bgcolor="#D3D3D3">开始时间</td>
					<td bgcolor="#D3D3D3">结束时间</td>
					<td bgcolor="#D3D3D3">所属画廊</td>
					<td bgcolor="#D3D3D3">联系人</td>
					<td bgcolor="#D3D3D3">手机</td>
					<td bgcolor="#D3D3D3">传真</td>
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
