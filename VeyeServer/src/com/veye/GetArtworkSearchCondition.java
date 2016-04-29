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
import java.util.ArrayList;

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
public class GetArtworkSearchCondition extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetArtworkSearchCondition() {
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

	
		JsonObject returnJson = this.getArtworkSearchCondition();

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject getArtworkSearchCondition() {

		JsonObject returnJson = new JsonObject();


		String returnMsg = "获取成功";

		JsonArray conditionArray = new JsonArray();
	
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
			
			
			//获取所有 title
			String sql = "select distinct title from search_condition where type='artwork'";
			ResultSet rs = stmt.executeQuery(sql);		
			ResultSetMetaData metaData = rs.getMetaData();  
			
			ArrayList<String> titles = new ArrayList<String>();
			
			while (rs.next()) {
				titles.add(rs.getString("title"));
			}			
			rs.close();
			
			System.out.println(titles);
			
			
			//获取每一个title下面的条件名称和条件细节
			
			for(int i=0; i< titles.size(); i ++){
				
				sql = "select name, search_condition, icon from search_condition where type='artwork' and title='" + titles.get(i) + "'";
				
				System.out.println(sql);
				
				
				rs = stmt.executeQuery(sql);		
				metaData = rs.getMetaData();  
				int columnCount = metaData.getColumnCount();

				JsonObject titleObj = new JsonObject();
				titleObj.addProperty("title", titles.get(i));
				
				JsonArray subArray = new JsonArray();
				while (rs.next()) {
					JsonObject Obj = new JsonObject();
					for (int j = 1; j <= columnCount; j++) {  
			            String columnName =metaData.getColumnLabel(j);  
			            String value = rs.getString(columnName);  
			            if(value == null)
							value="";
			            Obj.addProperty(columnName, value);  
			        }   
					subArray.add(Obj);
				}			
				rs.close();
				
				titleObj.add("conditions", subArray);
				
				conditionArray.add(titleObj);
						
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
		returnJson.add("conditions", conditionArray);
		return returnJson;
	}

}
