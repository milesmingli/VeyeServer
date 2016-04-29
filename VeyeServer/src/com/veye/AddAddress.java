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
public class AddAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddAddress() {
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

		String province = URLDecoder.decode(request.getParameter("province"),
		"UTF-8");

		String city = URLDecoder.decode(request.getParameter("city"),
		"UTF-8");

		String district = URLDecoder.decode(request.getParameter("district"),
		"UTF-8");

		String address = URLDecoder.decode(request.getParameter("address"),
		"UTF-8");

		String postcode = URLDecoder.decode(request.getParameter("postcode"),
		"UTF-8");

		String receiver = URLDecoder.decode(request.getParameter("receiver"),
		"UTF-8");

		String phone = URLDecoder.decode(request.getParameter("phone"),
		"UTF-8");

		String isdefault = URLDecoder.decode(request.getParameter("isdefault"),
		"UTF-8");

	

		JsonObject returnJson = this.addAddress(userid, province, city, district,address, postcode ,receiver, phone,isdefault);

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject addAddress(String userid,String province, String city,String district,
			String address,String postcode , String receiver,String phone, String isdefault)
	{

		JsonObject returnJson = new JsonObject();
		
		String returnMsg = "更新成功";
		
		JsonArray addressArray = new JsonArray();

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
			

			//如果这个地址是默认地址，则把之前的默认地址去掉
			String sql=null;
			
			if(isdefault.equals("1")){
			
			sql = "update address set isdefault=0 where userid=" + userid;
			
			stmt.execute(sql);
			
			}
			
			sql= "insert into address(userid, province, city, district,address, postcode ,receiver, phone,isdefault) values(";
			sql = sql + userid + ",'" +  province + "','" +  city + "','" +  district + "','" + address + "','" + postcode  + "','" + receiver + "','" +  phone + "'," + isdefault + ")";
		
			
			System.out.println(sql);
			
			stmt.execute(sql, Statement.RETURN_GENERATED_KEYS);
		
			ResultSet rs = stmt.getGeneratedKeys(); 
			rs.next();
			
			
			//返回所有address

			sql = "select * from address where userid=" + userid;
			rs = stmt.executeQuery(sql);		
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
				
				addressArray.add(Obj);
				
			}			
			
			rs.close();

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
		returnJson.add("addresses", addressArray);
		return returnJson;
	}

}
