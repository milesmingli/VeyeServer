<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ExhibitionArtWork.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="./js/json2.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.cookie.js"></script>
	
	<script type="text/javascript">

	var type=$.cookie('type_cookie');
	var id = $.cookie('userid');
	var randomconut = Math.floor(Math.random() * 1000);
	var galleryid=null;
	window.onload = function() {
	
		if(type=="seller_organization"){
			
			$.ajax({
				
				url : "<%=basePath%>/SelectElementServlet?slectname=*"
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
						
					 $.ajax({
							
							url : "<%=basePath%>/SelectElementServlet?slectname=*"
									+"&tablename=exhibition where galleryid='"+galleryid+"'"+
									"&randomconut="+ randomconut,
							dataType : "json",
							contentType : "application/x-www-form-urlencoded; charset=utf-8",
							error : function(request, error) {
								alert(error);
							},
					
							success : function(data) {
					
								console.log("data:" + JSON.stringify(data));
								
								var select = document.getElementById("exhibitionid");
								
								
								for(var i=0;i <data.length; i++){
									
									var opt = document.createElement('option');
								
					                opt.value =data[i].name+","+data[i].id;
					                opt.selected = false;
					                opt.innerHTML =data[i].name;
					                select.appendChild(opt);  
								}
							
								 
								 
								 
						
											 
							}
						});
					 
					 
					 
			
								 
				}
			});
			
			
			
		}else if(type=="veye"){

			
			
			//从画廊表里查找所有画廊返回结果添加到页面
			var sql="select * from exhibition";
			
			$.ajax({

				url : "<%=basePath%>/SelectTypeServlet?sql="+sql,

				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",

				error : function(request, error) {
					alert(error);
				},

				success : function(data) {
					var select = document.getElementById("exhibitionid");
				
					
					for(var i=0;i <data.length; i++){
						
						var opt = document.createElement('option');
					
		                opt.value =data[i].name+","+data[i].id;
		                opt.selected = false;
		                opt.innerHTML =data[i].name;
		                select.appendChild(opt);  
					}
				
				
			
				}
			});
		}
		

	

}
	 
	function dosubmit() {
	
					
					
		document.form1.submit();
		 document.getElementById("submitbutton").disabled=true;

		
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

		//添加列:作品名
		var newNameTD2 = newTR.insertCell(1);
		//添加列内容
		newNameTD2.innerHTML = "<input  name='artworkid" + rowID + "' id='artworkid" + rowID + "' type='text' size='13'  readonly='readonly' style='text-align:center;border: 1px'margin-left: -50px/>";
		//添加列:作品名
		var newNameTD1 = newTR.insertCell(2);
		//添加列内容
		newNameTD1.innerHTML = "<input  name='artworkname" + rowID + "' id='artworkname" + rowID + "' type='text' size='13'  readonly='readonly' style='text-align:center;border: 1px'margin-left: -50px/>";

		//添加列:画廊名
		var newLastNameTD = newTR.insertCell(3);
		//添加列内容
		newLastNameTD.innerHTML = "<input name='galleryname" + rowID + "' id='galleryname" + rowID + "' type='text' size='7' readonly='readonly' style='text-align:center;border: 1px' />";

		//添加列:展示图片
		var newDeleteTD1 = newTR.insertCell(4);
						 
		newDeleteTD1.innerHTML = "<img input name='img" + rowID + "' id='img" + rowID + "' alt='' src='' width='100' height='100' />";
		
		//添加列:添加作品至展览
		var newLastNameTD = newTR.insertCell(5);
		//添加列内容
		//newLastNameTD.innerHTML = "<input value='添加该作品' name='insertbutton" + rowID + "' id='insertbutton" + rowID + "' type='button'  style='' onclick='AddArtWorkRow()' />";
		newLastNameTD.innerHTML = "<div align='center' style='width:40px text-align:center'><a  onclick=\"AddArtWorkRow('SignItem"+ rowID + "')\"href='javascript:;'><input name='insertbutton" + rowID + "' id='insertbutton" + rowID + "' type='button' value='添加作品' /> </a></div>";

		
		//将行号推进下一行
		txtTRLastIndex.value = (rowID + 1).toString();
		
	}
	
	
	
	var obj={};
	var selectobj={};
	
	//添加作品
	function AddArtWorkRow(addid) { //读取最后一行的行号，存放在txtTRLastIndex文本框中 
		var selecttext=document.getElementById("exhibitionid");
		var index=selecttext.selectedIndex;//获取被选中的option的索引 
		var textsel= selecttext.options[index].text;//获取相应的option的内容 
		
		if(textsel=="请选择"){
			alert("请先选择要添加的展览");
			return;
		}else{
			
		
		var addtxtTRLastIndex = findObj("addtxtTRLastIndex", document);
		var rowIDs = parseInt(addtxtTRLastIndex.value);

		var signFrame = findObj("ArtWorkRow", document);
		//添加行
		var newTRs = signFrame.insertRow(signFrame.rows.length);
		newTRs.id = "SignItems" + rowIDs;
	
		
		//添加列:序号
		var newNameTD = newTRs.insertCell(0);

		//添加列内容
		newNameTD.innerHTML = newTRs.rowIndex.toString();

		//添加列:作品名
		var newNameTD2 = newTRs.insertCell(1);
		//添加列内容
		newNameTD2.innerHTML = "<input  name='addartworkid" + rowIDs + "' id='addartworkid" + rowIDs + "' type='text' size='6'  readonly='readonly' style='text-align:center;border: 1px'margin-left: -50px/>";
		
		//添加列:作品名
		var newNameTD1 = newTRs.insertCell(2);
		//添加列内容
		newNameTD1.innerHTML = "<input  name='addartworkname" + rowIDs + "' id='addartworkname" + rowIDs + "' type='text' size='13'  readonly='readonly' style='text-align:center;border: 1px'margin-left: -50px/>";

		//添加列:画廊名
		var newLastNameTD = newTRs.insertCell(3);
		//添加列内容
		newLastNameTD.innerHTML = "<input name='addgalleryname" + rowIDs + "' id='addgalleryname" + rowIDs + "' type='text' size='7' readonly='readonly' style='text-align:center;border: 1px' />";

		//添加列:展示图片
		var newDeleteTD1 = newTRs.insertCell(4);
						 
		newDeleteTD1.innerHTML = "<img input name='addimg" + rowIDs + "' id='addimg" + rowIDs + "' alt='' src='' width='100' height='100' />";
		
		//添加列:添加作品至展览
		var newLastNameTD = newTRs.insertCell(5);
		//添加列内容
		newLastNameTD.innerHTML ="<div align='center' style='width:40px text-align:center' ><a  href='javascript:;' onclick=\"DeleteSignRow('SignItems"
			+ rowIDs + "')\"><input name='deletebutton" + rowIDs + "' id='deletebutton" + rowIDs+ "' type='button' value='删除' size='10' /> </a></div>";

		
		//将行号推进下一行
		addtxtTRLastIndex.value = (rowIDs + 1).toString();
		
		var addrowid=addid.split("SignItem")[1];
		

		document.getElementById("addartworkid" + rowIDs.toString()).value = document.getElementById("artworkid" + addrowid.toString()).value;//id	
		document.getElementById("addartworkname" + rowIDs.toString()).value = document.getElementById("artworkname" + addrowid.toString()).value;//id	
		document.getElementById("addgalleryname" + rowIDs.toString()).value = document.getElementById("galleryname" + addrowid.toString()).value;//id	
		document.getElementById("addimg"+ rowIDs.toString()).src=document.getElementById("img"+ addrowid.toString()).src;
		
			
			
			
			if(obj.hasOwnProperty(document.getElementById("addartworkid" + rowIDs.toString()).value) || selectobj.hasOwnProperty(document.getElementById("addartworkid" + rowIDs.toString()).value)){
				alert("改作品已存在，请勿重复添加");
				document.getElementById("addartworkid" + rowIDs.toString()).style.display='none';
				document.getElementById("addartworkname" + rowIDs.toString()).style.display='none';
				document.getElementById("addgalleryname" + rowIDs.toString()).style.display='none';
				document.getElementById("addimg" + rowIDs.toString()).style.display='none';
				document.getElementById("deletebutton" + rowIDs.toString()).style.display='none';
				document.getElementById("SignItems" + rowIDs.toString()).style.display='none';
				
				
			}else{
				
				obj[document.getElementById("addartworkid" + rowIDs.toString()).value]=document.getElementById("addartworkname" + rowIDs).value;
				//selectobj[document.getElementById("addartworkid" + rowIDs.toString()).value]=document.getElementById("addartworkname" + rowIDs).value;


			}
			
			console.log("data: %s", JSON.stringify(selectobj));
			
		
		
			document.getElementById("insertartworkid").value=JSON.stringify(obj);
	
		
			}		
		
		}	
			
		
	
	
	//添加作品
	function AddArtSerachWorkRow() { //读取最后一行的行号，存放在txtTRLastIndex文本框中 
		
		var addtxtTRLastIndex = findObj("addtxtTRLastIndex", document);
		var rowIDs = parseInt(addtxtTRLastIndex.value);

		var signFrame = findObj("ArtWorkRow", document);
		//添加行
		var newTRs = signFrame.insertRow(signFrame.rows.length);
		newTRs.id = "SignItems" + rowIDs;
	
		
		//添加列:序号
		var newNameTD = newTRs.insertCell(0);

		//添加列内容
		newNameTD.innerHTML = newTRs.rowIndex.toString();

		//添加列:作品名
		var newNameTD2 = newTRs.insertCell(1);
		//添加列内容
		newNameTD2.innerHTML = "<input  name='addartworkid" + rowIDs + "' id='addartworkid" + rowIDs + "' type='text' size='6'  readonly='readonly' style='text-align:center;border: 1px'margin-left: -50px/>";
		
		//添加列:作品名
		var newNameTD1 = newTRs.insertCell(2);
		//添加列内容
		newNameTD1.innerHTML = "<input  name='addartworkname" + rowIDs + "' id='addartworkname" + rowIDs + "' type='text' size='13'  readonly='readonly' style='text-align:center;border: 1px'margin-left: -50px/>";

		//添加列:画廊名
		var newLastNameTD = newTRs.insertCell(3);
		//添加列内容
		newLastNameTD.innerHTML = "<input name='addgalleryname" + rowIDs + "' id='addgalleryname" + rowIDs + "' type='text' size='7' readonly='readonly' style='text-align:center;border: 1px' />";

		//添加列:展示图片
		var newDeleteTD1 = newTRs.insertCell(4);
						 
		newDeleteTD1.innerHTML = "<img input name='addimg" + rowIDs + "' id='addimg" + rowIDs + "' alt='' src='' width='100' height='100' />";
		
		//添加列:添加作品至展览
		var newLastNameTD = newTRs.insertCell(5);
		//添加列内容
		newLastNameTD.innerHTML ="<div align='center' style='width:40px text-align:center' ><a  href='javascript:;' onclick=\"DeleteSignRow('SignItems"
			+ rowIDs + "')\"><input name='deletebutton" + rowIDs + "' id='deletebutton" + rowIDs+ "' type='button' value='删除' size='10' /> </a></div>";

		
		//将行号推进下一行
		addtxtTRLastIndex.value = (rowIDs + 1).toString();

	
		
					
		
		}
	
	
	
	
				
	
			function del(){
				if(confirm("确认删除吗")){
				
				   DeleteSignRow();
				  }
				  else{
				
				   return;
				  }
				}
			
			function DeleteSignRow(rowids) {
				if(confirm("确认删除吗")){	
				
				
					var  deleterowid=rowids.replace("SignItems","");
					
					document.getElementById("addartworkid" + deleterowid.toString()).style.display='none';
					document.getElementById("addartworkname" + deleterowid.toString()).style.display='none';
					document.getElementById("addgalleryname" + deleterowid.toString()).style.display='none';
					document.getElementById("addimg" + deleterowid.toString()).style.display='none';
					document.getElementById("deletebutton" + deleterowid.toString()).style.display='none';
					document.getElementById("SignItems" + deleterowid.toString()).style.display='none';
					
					var artworkjson=document.getElementById("addartworkid" + deleterowid.toString()).value;
					console.log(artworkjson);
					
					//obj = JSON.parse(obj);
					
					delete selectobj[artworkjson];
					//document.getElementById("insertartworkid").value=JSON.stringify(obj);
					
					var exhibitionid=document.getElementById("exhibitionid").value;
					var realexhibitionid=exhibitionid.split(",")[1];
					
					var sql="delete from exhibition_artwork where exhibitionid='"+realexhibitionid+"' and artworkid='"+document.getElementById("addartworkid" + deleterowid.toString()).value+"'";
					console.log(sql);
					
					$.ajax({

						url : "<%=basePath%>/DelOneSql?sql="+sql,

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

					//obj=selectobj;
					console.log("data: %s", JSON.stringify(obj));
				
					
				} else{
					
					   return;
					  }
			
				
				
				
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
	
	
	function ClearAllSignart(){
		
		var signFrame = findObj("ArtWorkRow",document);
		var rowscount = signFrame.rows.length;

		//循环删除行,从最后一行往前删除
		for(i=rowscount - 1;i > 0; i--){
		   signFrame.deleteRow(i);
		}

		//重置最后行号为1
		var txtTRLastIndex = findObj("addtxtTRLastIndex",document);
		txtTRLastIndex.value = "1";

		
	}
	function artworkserach(){
		
			ClearAllSign();
			var searchmessage=document.getElementById("serach").value;
			console.log(searchmessage);
			var artworkname=searchmessage.split(" ")[0];
			var galleryname=searchmessage.split(" ")[1];
		 	
		 	$.ajax({

				url : "<%=basePath%>/SerachExhibitionServlet?artworkname="+artworkname+"&galleryname="+galleryname+"&type="+type+"&galleryid="+galleryid,
				dataType : "json",
				contentType : "application/x-www-form-urlencoded; charset=utf-8",

				error : function(request, error) {
					alert(error);
				},

				success : function(data) {
					
					
					
					var j;
					for(var i=0;i<data.length;i++){
						AddSignRow();
						j=i+1;
				
						document.getElementById("artworkid" 
								+ j.toString()).value = data[i].id;//id
						document.getElementById("artworkname" 
								+ j.toString()).value = data[i].name;//name
						document.getElementById("galleryname"
								+ j.toString()).value = data[i].galleryname;//姓名
							
						document.getElementById("img"
										+ j.toString()).src="."+data[i].thumbnail;
								
					}
					
					
		
				}
			});  

	}

	function SelectOnchange(){
		selectobj={};
		console.log(selectobj);
		var exhibitionid=document.getElementById("exhibitionid").value;
		var realexhibitionid=exhibitionid.split(",")[1];
		
		var ArtworkArrayChange=null;
		var ArtworkArraySplit=null;

		$.ajax({

			url : "<%=basePath%>/ManageExhibitionServlet?realexhibitionid="+realexhibitionid,

			dataType : "json",
			contentType : "application/x-www-form-urlencoded; charset=utf-8",

			error : function(request, error) {
				alert(error);
			},

			success : function(data) {
				
				ClearAllSignart();
				if(data!="nothingness"){
				
				var j;
				for(var i=0;i<data.length;i++){
					AddArtSerachWorkRow();
					j=i+1;

					document.getElementById("addartworkid" + j).value = data[i].id;//id
					document.getElementById("addartworkname" + j).value =data[i].name;//name
					document.getElementById("addgalleryname" +j).value = data[i].gallery;//name
					document.getElementById("addimg"
							+ j.toString()).src="."+data[i].thumbnail;	
				
					selectobj[document.getElementById("addartworkid" + j.toString()).value]=document.getElementById("addartworkname" + j).value;

				}
				
				
				}
				
				
				
				
				
				
				
		/* 		ArtworkArrayChange = data.split("*");
			
				
				//console.log(document.getElementById("addartworkname" + i).value);
				ClearAllSignart();
				if(data!="nothingness"){
					
				
					for(var i=1;i<ArtworkArrayChange.length;i++){
						AddArtSerachWorkRow();
						
						
						ArtworkArraySplit=ArtworkArrayChange[i].split(",");
						
						document.getElementById("addartworkid" + i).value = ArtworkArraySplit[0];//id
						document.getElementById("addartworkname" + i).value = ArtworkArraySplit[1];//name
						document.getElementById("addgalleryname" +i).value = ArtworkArraySplit[2];//name
						document.getElementById("addimg"
								+ i.toString()).src="."+ArtworkArraySplit[3];
			
						//			console.log(document.getElementById("addartworkname" + i).value);
						
						selectobj[document.getElementById("addartworkid" + i.toString()).value]=document.getElementById("addartworkname" + i).value;

						
						
				
						
					} 
					
					
				}*/
				
		
		
			}
		});
	
	

	
	}
	
	</script>
	
	
  </head>
  
   <body>
  
  <div style="width: 100%;text-align: center">
  	<div style="width: 100%;">
  		<h1>管理展览作品</h1>
  		</div>
  		
  	<form action="${pageContext.request.contextPath}/InsertExhibition_Artwork" method="post" name="form1">
  	
  	<div style="width: 45%;border-color: #D3D3D3;border-style: solid;1px;float: left" >
		<table border="1" cellspacing="0" cellpadding="0" width="100%" >
			<tbody>

				<tr>
					<th style="text-align: right;">&nbsp;选择展览:&nbsp;
					 <select id="exhibitionid" name="exhibitionid" style="width:60%" onchange="SelectOnchange()">
					<option value="">请选择</option>
					</select>
					<input type="text" name="insertartworkid" id="insertartworkid"style="display: none">
					
						</th>
				
				</tr>

			</tbody>
		</table>
		
		
		

	
	<table id="ArtWorkRow" border="1" cellspacing="0" cellpadding="0"
			width="100%">
			<tbody>
				<tr id="trHeader" align="center">
					<td bgcolor="#D3D3D3">序号</td>
					<td bgcolor="#D3D3D3"  style="width: 8%">作品id</td>
					<td bgcolor="#D3D3D3">作品名称</td>
					<td bgcolor="#D3D3D3">所属美术馆</td>
					<td bgcolor="#D3D3D3" style="width: 10%">图片展示</td>
					<td bgcolor="#D3D3D3" style="width: 8%">已添加</td>
				</tr>

				<div>
					<input name='addtxtTRLastIndex' type='hidden' id='addtxtTRLastIndex'
						value="1" />
						
				</div>

			</tbody>
		</table>
		
						<a href="javascript:dosubmit();"> 
						<input type="button" value="提交" style="margin-top: 50px;margin-left: 0px" id="submitbutton" />
						</a>
  	</div>
  	
  		<div style="width: 50%;border-color: #D3D3D3;border-style: solid;1px;float: right">
		
				<table border="1" cellspacing="0" cellpadding="0" width="100%" >
			<tbody>

				<tr>
				
				
						<th style="text-align: right;">&nbsp;参展作品&nbsp;<input type="text" id="serach"style="width:60%" placeholder="请输入查询条件，多个条件用空格隔开">
						</th>
						
					
					<th><input type="button" value="搜&nbsp;索"
						style="width:55px; hight:18" onclick="artworkserach()" /></th>

				</tr>

			</tbody>
		</table>
		<table id="SignFrame" border="1" cellspacing="0" cellpadding="0"
			width="100%">
			<tbody>
				<tr id="trHeader" align="center">
					<td bgcolor="#D3D3D3">序号</td>
					<td bgcolor="#D3D3D3">作品id</td>
					<td bgcolor="#D3D3D3">作品名称</td>
					<td bgcolor="#D3D3D3">所属美术馆</td>
					<td bgcolor="#D3D3D3" style="width: 10%">图片展示</td>
					<td bgcolor="#D3D3D3" style="width: 8%">添加</td>
				</tr>

				<div>
					<input name='txtTRLastIndex' type='hidden' id='txtTRLastIndex'
						value="1" />
						
				</div>

			</tbody>
		</table>
		<br>
		
				
  		</div>
  		
  	</form>
  
  
  </div>
  
  </body>
</html>
