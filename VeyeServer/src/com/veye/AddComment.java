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
import com.google.gson.JsonObject;

/**
 * Servlet implementation class UserUpdate
 */
public class AddComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddComment() {
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

		response.setCharacterEncoding("UTF8"); // this line solves the problem
		response.setContentType("application/json");

		response.setHeader("Cache-control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "-1");

		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		response.setHeader("Access-Control-Max-Age", "86400");

	
		String userid = URLDecoder.decode(request.getParameter("userid"),
				"UTF-8");
		
		String nickname = URLDecoder.decode(request.getParameter("nickname"),
		"UTF-8");

		String artworkid = URLDecoder
				.decode(request.getParameter("artworkid"), "UTF-8");
	

		String comment = URLDecoder.decode(request.getParameter("comment"),
				"UTF-8");

		JsonObject returnJson = this.addComment(userid, nickname, artworkid, comment);

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject addComment(String userid, String nickname, String artworkid,
			String comment) {

		JsonObject returnJson = new JsonObject();

		String returnMsg = "更新成功";
		
		JsonArray commentArray = new JsonArray();
		

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
			
			
			String sql= "insert into comment(userid,nickname, artworkid, datetime, comment) values(";
			sql = sql + "" +userid + ",'" + nickname + "','" + artworkid + "', NOW(), '" + comment + "')";
			
			
			System.out.println(sql);
			
			stmt.execute(sql);
			
			
			
			//获取评论
			sql = "select * from comment where artworkid='" + artworkid + "' order by datetime desc";
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
				
				commentArray.add(artworkObj);
			}			
			
			
		

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
		returnJson.add("comments", commentArray);
		return returnJson;
	}

}
