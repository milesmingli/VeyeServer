package com.veye;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

/**
 * Servlet implementation class UserUpdate
 */
public class UpdateFavorite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateFavorite() {
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

		String itemtype = URLDecoder
				.decode(request.getParameter("itemtype"), "UTF-8");
		
		String itemid = URLDecoder
				.decode(request.getParameter("itemid"), "UTF-8");
	

		String favorite = URLDecoder.decode(request.getParameter("favorite"),
				"UTF-8");

		JsonObject returnJson = this.updateFavorite(userid, itemtype, itemid, favorite);

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject updateFavorite(String userid, String itemtype, String itemid,
			String favorite) {

		JsonObject returnJson = new JsonObject();

		JsonObject userInfo = new JsonObject();

		String returnMsg = "更新成功";
		
		String returnFav="";

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
			
			
			if(favorite.trim().equalsIgnoreCase("0")){
				sql = "delete from favorite where userid=" + userid + " and itemtype='" + itemtype + "' and itemid='" + itemid + "'";
				stmt.execute(sql);
				
				if(itemtype.equalsIgnoreCase("artwork")){
					sql = "update artwork set favorite = favorite - 1 where id='" + itemid  + "'"; 
					
				}else if(itemtype.equalsIgnoreCase("artist")){
					sql = "update artist set favorite = favorite - 1 where id='" + itemid + "'"; 
					
				}if(itemtype.equalsIgnoreCase("gallery")){
					sql = "update gallery set favorite = favorite - 1 where id='" + itemid + "'"; 
					
				}
				stmt.execute(sql);
				
			}else if (favorite.trim().equalsIgnoreCase("1")){
				
				//获取缩略图
				String thumb = "";
				
				if(itemtype.equalsIgnoreCase("artwork")){
					sql = "select thumbnail from artwork where id='" + itemid + "'";
					
					
				}else if(itemtype.equalsIgnoreCase("gallery")){
					sql = "select portrait from gallery where id='" + itemid + "'";
					
				}else if(itemtype.equalsIgnoreCase("artist")){
					sql = "select portrait from artist where id='" + itemid + "'";
					
				}
				
				System.out.println(sql);
				
				ResultSet rs = stmt.executeQuery(sql);
				if(rs.next()){
					thumb = rs.getString(1);
				}
				rs.close();
				
				
				//插入数据
				sql = "insert IGNORE into favorite values (" + userid + ",'" + itemtype + "','" + itemid + "','" + thumb + "')";	
				
				System.out.println(sql);
				
				stmt.execute(sql);
				
				if(itemtype.equalsIgnoreCase("artwork")){
					sql = "update artwork set favorite = favorite + 1 where id='" + itemid+ "'"; 
					
				}else if(itemtype.equalsIgnoreCase("artist")){
					sql = "update artist set favorite = favorite + 1 where id='" + itemid+ "'"; 
					
				}if(itemtype.equalsIgnoreCase("gallery")){
					sql = "update gallery set favorite = favorite + 1 where id='" + itemid+ "'"; 
					
				}
				
				System.out.println(sql);
				stmt.execute(sql);
			}

			//查询修改之后有多少favorite
			if(itemtype.equalsIgnoreCase("artwork")){
				sql = "select favorite from artwork where id='" + itemid + "'"; 
				
			}else if(itemtype.equalsIgnoreCase("artist")){
				sql = "select favorite from artist where id='" + itemid + "'"; 
				
			}if(itemtype.equalsIgnoreCase("gallery")){
				sql = "select favorite from gallery where id='" + itemid + "'";  
				
			}
			
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()){
				returnFav = rs.getString(1);
			}
			rs.close();
			
			//如果小于零，重置为0
			if(Integer.valueOf(returnFav)<0){
				returnFav = "0";
			
				if(itemtype.equalsIgnoreCase("artwork")){
					sql = "update artwork set favorite=0 where id='" + itemid + "'"; 
					
				}else if(itemtype.equalsIgnoreCase("artist")){
					sql = "update artist set favorite=0 where id='" + itemid + "'";  
					
				}if(itemtype.equalsIgnoreCase("gallery")){
					sql = "update gallery set favorite=0 where id='" + itemid + "'";   
					
				}
				stmt.execute(sql);
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
		returnJson.addProperty("favorite", returnFav);
		return returnJson;
	}

}
