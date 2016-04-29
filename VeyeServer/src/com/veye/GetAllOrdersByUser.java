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
public class GetAllOrdersByUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetAllOrdersByUser() {
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
	
		response.setCharacterEncoding("UTF8"); // this line solves the problem
		response.setContentType("application/json");

		response.setHeader("Cache-control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "-1");

		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		response.setHeader("Access-Control-Max-Age", "86400");

	
		JsonObject returnJson = this.getOrdersByUser(userId);

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject getOrdersByUser(String userId) {

		JsonObject returnJson = new JsonObject();


		String returnMsg = "��ȡ�ɹ�";

		JsonArray orderArray = new JsonArray();
		
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
			
			
			//��ȡ����
			String sql = "select * from order_main where userid=" + userId;
			ResultSet rs = stmt.executeQuery(sql);		
			ResultSetMetaData metaData = rs.getMetaData();  
			int columnCount = metaData.getColumnCount();

			while (rs.next()) {
				JsonObject Obj = new JsonObject();
				
				for (int i = 1; i <= columnCount; i++) {  
		            String columnName =metaData.getColumnLabel(i);  
		            String value = rs.getString(columnName);  
		            if(value == null)
						value="";
		            Obj.addProperty(columnName, value);  
		        }   				
				orderArray.add(Obj);
				
			}			
			rs.close();
			
			//��ȡ�����µ���Ʒ
			for(int i=0; i<orderArray.size();i++){
				
				JsonObject orderInfo = (JsonObject)orderArray.get(i);
				
				JsonArray artworkArray = new JsonArray();
				
				sql ="select artworkid, order_item.price, size, order_item.name, order_item.artist, order_item.thumbnail, stock from order_item, artwork where order_item.artworkid = artwork.id and orderid=" + orderInfo.get("id");
				
				
				System.out.println(sql);
				
				
				rs = stmt.executeQuery(sql);		
				metaData = rs.getMetaData();  
				columnCount = metaData.getColumnCount();
				
				while (rs.next()) {
					JsonObject Obj = new JsonObject();
					
					for (int j = 1; j <= columnCount; j++) {  
			            String columnName =metaData.getColumnLabel(j);  
			            String value = rs.getString(columnName);  
			            if(value == null)
							value="";
			            Obj.addProperty(columnName, value);  
			        }   
					
					artworkArray.add(Obj);
					
					
				}	
				
				rs.close();
				
				orderInfo.add("artworks", artworkArray);
				
			
				
			}
			
			

			stmt.close();
			stmt = null;

			conn.close();
			conn = null;

		} catch (Exception e) {
			returnMsg = "�������쳣";
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
		returnJson.add("orders", orderArray);
		return returnJson;
	}

}
