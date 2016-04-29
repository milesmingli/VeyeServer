package com.veye;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class UserUpdate
 */
public class GetArtworksByAR extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetArtworksByAR() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String userId = URLDecoder
		.decode(request.getParameter("userid"), "UTF-8");

		String type = URLDecoder
		.decode(request.getParameter("type"), "UTF-8");
		
		String id = URLDecoder
				.decode(request.getParameter("id"), "UTF-8");
		
		String appendList = URLDecoder
		.decode(request.getParameter("appendList"), "UTF-8");

		response.setCharacterEncoding("UTF8"); // this line solves the problem
		response.setContentType("application/json");

		response.setHeader("Cache-control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "-1");

		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		response.setHeader("Access-Control-Max-Age", "86400");

		JsonObject returnJson = new JsonObject();
			
		if(this.checkScanLimit(userId)==false){
			returnJson.addProperty("returnMsg", "已经到达扫描次数上限");
		}else{
			returnJson = this.getGalleryByAR(type,id,appendList);
		}
		
		

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}
	
	
	private boolean checkScanLimit(String userId){
		
		boolean canScan = false;
		
		Connection conn = null;
		Statement stmt = null;

		try {

			// Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			// Open a connection
			conn = DriverManager.getConnection(Constants.DB_URL,
					Constants.USER, Constants.PASS);
			// Execute SQL query
			stmt = conn.createStatement();
			
			String sql="select scanlimit from user where id=" + userId;
			
			
			
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			int limit = rs.getInt("scanlimit");
			
			
			
			rs.close();
			
			if(limit>0){
				canScan = true;
				
				sql="update user set scanlimit = scanlimit - 1 where id=" + userId;
				stmt.execute(sql);
				sql="update user set scans = scans + 1 where id=" + userId;
				stmt.execute(sql);
				
			}else{
				canScan = false;
			}
			
		}catch(Exception e){
			
			System.out.println(e);
		}finally {

			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException sqlex) {
					// ignore -- as we can't do anything about it here
				}

				stmt = null;
			}

			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqlex) {
					// ignore -- as we can't do anything about it here
				}

				conn = null;
			}
		}
		
		
		return canScan;
		
	}

	private JsonObject getGalleryByAR(String type, String id, String appendList) {

		JsonObject returnJson = new JsonObject();


		String returnMsg = "获取成功";

		JsonArray artworkArray = new JsonArray();
		
		JsonObject info = new JsonObject(); 
		
	
		Connection conn = null;
		Statement stmt = null;

		try {

			// Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			// Open a connection
			conn = DriverManager.getConnection(Constants.DB_URL,
					Constants.USER, Constants.PASS);
			// Execute SQL query
			stmt = conn.createStatement();
			
			String sql="";
			//获取appendList中的作品。
			
			if(appendList.length()>0){
				
				System.out.println(appendList);
				
				String[] strArray = null;   
		        strArray = appendList.split(",");
		        
		        appendList="";
		        for(int i=0;i<strArray.length;i++){
		        	appendList = appendList + "'" + strArray[i] + "',";
		        }
				
		        appendList = appendList.substring(0, appendList.length()-1);
		        
		        System.out.println(appendList);
			}
			
			if(appendList.length()>0){
			
				sql = "select * from artwork_view where id in (" + appendList + ") ";
				System.out.println(sql);
				
				ResultSet rs = stmt.executeQuery(sql);		
				ResultSetMetaData metaData = rs.getMetaData();  
				int columnCount = metaData.getColumnCount();

				while (rs.next()) {
					JsonObject artworkObj = new JsonObject();
					for (int i = 1; i <= columnCount; i++) {  
			            String columnName =metaData.getColumnLabel(i);  
			            String value = rs.getString(columnName);  
			            if(value == null)
							value="";
			            artworkObj.addProperty(columnName, value);  
			        }   
					
					artworkArray.add(artworkObj);
				}			
				rs.close();
			}
			
			
			//获取相关的作品
			if(appendList.length()>0){
				if(type.equalsIgnoreCase("gallery")){
					
					sql = "select * from artwork_view  where galleryid='" + id + "' and id NOT in (" + appendList + ") order by createtime desc limit 20 ";
				
				}else if(type.equalsIgnoreCase("artwork")){
					
					sql = "select * from artwork_view where artistid=(select artistid from artwork_view where id='" + id + "') and id NOT in (" + appendList + ") order by createtime desc limit 20";
					
				}else if(type.equalsIgnoreCase("veye")){
					
					sql = "select * from artwork_view where id NOT in (" + appendList + ") order by createtime desc limit 20";
					
				}
			}else{
				
				
				if(type.equalsIgnoreCase("gallery")){
					sql = "select * from artwork_view  where galleryid='" + id + "'  order by createtime desc limit 20 ";
				
				}else if(type.equalsIgnoreCase("artwork")){
					
					sql = "select * from artwork_view where artistid=(select artistid from artwork_view where id='" + id + "')  order by createtime desc limit 20";
					
				}else if(type.equalsIgnoreCase("veye")){
					sql = "select * from artwork_view  order by createtime desc limit 20";
					
				}
			}
			
			System.out.println(sql);
			
			ResultSet rs = stmt.executeQuery(sql);		
			ResultSetMetaData metaData = rs.getMetaData();  
			int columnCount = metaData.getColumnCount();

			while (rs.next()) {
				JsonObject artworkObj = new JsonObject();
				for (int i = 1; i <= columnCount; i++) {  
		            String columnName =metaData.getColumnLabel(i);  
		            String value = rs.getString(columnName);  
		            if(value == null)
						value="";
		            artworkObj.addProperty(columnName, value);  
		        }   
				
				artworkArray.add(artworkObj);
			}			
			rs.close();
			
			sql = "";
			
			//获取marker本身对应的信息
			if(type.equalsIgnoreCase("gallery")){
				sql = "select * from gallery  where id='" + id + "'";
			
			}else if(type.equalsIgnoreCase("artwork")){
				
				sql = "select * from artwork_view where id ='" + id + "'";  
				
			}else if(type.equalsIgnoreCase("veye")){
				
				sql = "select * from veye";  
			}
			
			
			
				rs = stmt.executeQuery(sql);		
				metaData = rs.getMetaData();  
				columnCount = metaData.getColumnCount();
	
				while (rs.next()) {
					
					for (int i = 1; i <= columnCount; i++) {  
			            String columnName =metaData.getColumnLabel(i);  
			            String value = rs.getString(columnName);  
			            if(value == null)
							value="";
			            info.addProperty(columnName, value);  
			        }   
					
				}			
				rs.close();
			
			
			//CLOSE RELATED THINGS
			stmt.close();
			stmt = null;

			conn.close();
			conn = null;

		} catch (Exception e) {
			returnMsg = "服务器异常";
			System.out.println(e);
		}

		finally {

			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException sqlex) {
					// ignore -- as we can't do anything about it here
				}

				stmt = null;
			}

			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqlex) {
					// ignore -- as we can't do anything about it here
				}

				conn = null;
			}
		}

		returnJson.addProperty("returnMsg", returnMsg);
		returnJson.addProperty("type", type);
		returnJson.add("info", info);
		returnJson.add("artworks", artworkArray);
		return returnJson;
	}

}
