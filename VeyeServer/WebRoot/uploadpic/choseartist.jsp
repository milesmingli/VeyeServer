<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'choseartist.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>

<script type="text/javascript" charset="utf-8">
var randomconut = Math.floor(Math.random() * 1000);
var type=$.cookie('type_cookie');
var id = $.cookie('userid');



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

	
	//添加列:id
	var newRowidTD = newTR.insertCell(1);
	//添加列内容
	newRowidTD.innerHTML = "<input name='selectid" + rowID + "' id='selectid" + rowID + "' type='text' size='17' readonly='readonly' style='text-align:center;border: 1px' />";

	
	//添加列:姓名
	var newLastNameTD = newTR.insertCell(2);
	//添加列内容
	newLastNameTD.innerHTML = "<input name='selectname" + rowID + "' id='selectname" + rowID + "' type='text' size='17' readonly='readonly' style='text-align:center;border: 1px' />";

	//添加列:年代
	var newBirthdayTD = newTR.insertCell(3);
	//添加列内容
	newBirthdayTD.innerHTML = "<input name='selectbirthday" + rowID + "' id='selectbirthday" + rowID + "' type='text' size='10' readonly='readonly' style='text-align:center;border: 1px' />";

	
	//添加列:简介
	var newBriefTD = newTR.insertCell(4);
	//添加列内容
	newBriefTD.innerHTML = "<textarea name='selectbrief" + rowID + "' id='selectbrief" + rowID + "' type='text' size='18'readonly='readonly' style='border: 1px;height:90px' ></textarea>";

	//添加列:性别
	var newGenderTD = newTR.insertCell(5);
	//添加列内容
	newGenderTD.innerHTML = "<input name='selectgender" + rowID + "' id='selectgender" + rowID + "' type='text' size='4' readonly='readonly'style='text-align:center;border: 1px'/>";

	//添加列:城市
	var newCityTD = newTR.insertCell(6);
	//添加列内容
	newCityTD.innerHTML = "<input name='selectcity" + rowID + "' id='selectcity" + rowID + "' type='text' size='10' readonly='readonly' style='text-align:center;border: 1px' />";
	//添加列:选择按钮
	var newChose = newTR.insertCell(7);
		//添加列内容		
		newChose.innerHTML = "<div align='center' style='width:40px text-align:center'><a  onclick=\"ChoseArtist('SignItem"+ rowID + "')\"href='javascript:;'><input name='chosebutton" + rowID + "' id='chosebutton" + rowID + "' type='button' value='选择' /> </a></div>";
			

	//将行号推进下一行
	txtTRLastIndex.value = (rowID + 1).toString();
	
	
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
	

var artistid=null;
function ChoseArtist(rowid){
	
	var signItem = findObj(rowid, document);
	//获取执行行的Index
	var rowIndex = signItem.rowIndex;
	//获取所有行数
	var rowcount=document.getElementById("txtTRLastIndex").value;
	//执行函数先将所有的button value设置为选择
	for(var i=1;i<rowcount;i++){
	
		document.getElementById("chosebutton" + i).value="选择";

	}
	//然后将选中行的button value设置为取消选择
	document.getElementById("chosebutton" + rowIndex).value="取消选择";
	
	artistid=document.getElementById("selectname" + rowIndex).value+","+document.getElementById("selectid" + rowIndex).value;
	
	
}

function search() {
	ClearAllSign();
	var name = document.getElementById("name").value;
	var city = document.getElementById("city").value;
	var gender = document.getElementById("gender").value;
	var sql=null;
		
		if(name=="" && city=="" && gender==""){
			
			alert("请输入查询条件");
			return;
		} 
		else if (name == "" && city != "" && gender=="") { //name为空,性别为空,city不为空的时候根据城市模糊查询
			sql = "select * from artist where ";
			sql = sql+ "prov like '%" + city + "%' and isaudit=0 ";
		} else if (name == "" && gender != "" && city=="") {//name为空,城市为空，性别不为空的时候性别查询
			sql = "select * from artist where ";
			sql = sql +"gender='"
					+ gender + "' and isaudit=0 ";
		} else if (name == "" && city != "" && gender!="" ) {//name 为空 城市和性别都不为空的时候根据城市和性别查询
			sql = "select * from artist where ";
			sql = sql + " " + "gender='" + gender + "' " + "and" + " "
					+ "prov like '%" + city + "%' and isaudit=0 ";
		} 	

		
		 else if (name != "" && city == "" && gender=="") { //name不为空,性别city为空的时候根据name模糊查询
			sql = "select * from artist where ";
			sql = sql+ "name like '%" + name + "%' and isaudit=0";
			
		} else if (name != ""  && city!="" && gender == "") {//name不为空,城市不为空，性别为空的时候根据name和城市模糊查询
			sql = "select * from artist where ";
			sql = sql+ "name like '%" + name + "%' and prov like '%"+city+"%' and isaudit=0 ";
			
		} else if (name != ""  && gender!="" && city == "") {//name 不为空 性别不为空，城市为空的时候根据name和性别查询
			sql = "select * from artist where ";
			sql = sql + " " + "gender='" + gender + "' " + "and" + " "
					+ "name like '%" + name + "%' and isaudit=0 ";
		} 		
			
		else if (name != "" && city != "" && gender!="") {//name和city,gender都不为空的时候，按照价格，名称，性别模糊查询
			sql = "select * from Artist where ";
			sql = sql + "gender='" + gender + "'" + "and" + " " + "prov like '%"
					+ city + " %' " + "and" + " " + "name like '%"
					+ name + "%' and isaudit=0 ";

		}
	console.log(sql);
		sql = encodeURIComponent(sql);
	
	$.ajax({

				url : './ArtistManage?sql=' + sql,

				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",

				error : function(request, error) {
					alert(error+"3");
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
								+ j.toString()).value = data[i].id;//姓名		
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




function callback(){
	
	if(artistid!=null){
		
		$.cookie('artistid', artistid, { expires: 1, path: '/' }); 
		history.back(-1);

	}else{
		alert("请选择一个艺术家");
	}

	
}


</script>
  </head>
   <body style="font-family: 微软雅黑">

   
       <div style=";text-align: center;" id="alladdresses">
   	<table border="1" cellspacing="0" cellpadding="0" width="100%" style="margin-top: 100px;">
			<tbody>

				<tr>
					<th style="color: red;">请选择查询条件</th>
		

						<th style="text-align: right;">&nbsp;姓&nbsp;名 &nbsp;
						
						<input type="text" id="name" name="name" style="width:200px">
						
						</th>
						
						<th style="text-align: right;">&nbsp;城&nbsp;市&nbsp;<input type="text" id="city" name="city"  >
						</th>
						
						<th style="text-align: right;">&nbsp;性&nbsp;别&nbsp;<input type="text" id="gender" name="gender">
						</th>
					
					<th><input type="button" value="搜&nbsp;索"
						style="width:55px; hight:18" onclick="search()" /></th>

				</tr>

			</tbody>
		</table>
   		<table id="SignFrame" border="1" cellspacing="0" cellpadding="0"
			width="100%">
			<tbody>

				<tr id="trHeader" align="center">
					<td bgcolor="#D3D3D3">图片展示</td>
					<td bgcolor="#D3D3D3">艺术家id</td>
					<td bgcolor="#D3D3D3">姓名</td>
					<td bgcolor="#D3D3D3">年代</td>
					<td bgcolor="#D3D3D3">简介</td>
					<td bgcolor="#D3D3D3">性别</td>
					<td bgcolor="#D3D3D3">城市</td>
					<td bgcolor="#D3D3D3">选择艺术家</td>
				</tr>

			</tbody>
		</table>
		<input name='txtTRLastIndex' type='hidden' id='txtTRLastIndex'value="1" />
		<br>
		<br>
		<br>
		<input type="button"  value="返回" onclick="callback()"/>&nbsp;&nbsp;&nbsp;
	
		<br>
		<br>
		<br>
		
    </div>
   
  </body>
</html>
