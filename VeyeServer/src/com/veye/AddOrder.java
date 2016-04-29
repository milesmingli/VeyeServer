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
public class AddOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddOrder() {
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
		
		String total = URLDecoder.decode(request.getParameter("total"),
				"UTF-8");
		
		String discount = URLDecoder.decode(request.getParameter("discount"),
		"UTF-8");

		String realpay = URLDecoder.decode(request.getParameter("realpay"),
		"UTF-8");
		
		String address = URLDecoder.decode(request.getParameter("address"),
		"UTF-8");

		String postcode = URLDecoder.decode(request.getParameter("postcode"),
		"UTF-8");

		String receiver = URLDecoder.decode(request.getParameter("receiver"),
		"UTF-8");

		String phone = URLDecoder.decode(request.getParameter("phone"),
		"UTF-8");

		String memo = URLDecoder.decode(request.getParameter("memo"),
		"UTF-8");

		String artworks = URLDecoder.decode(request.getParameter("artworks"),
		"UTF-8");
	

		JsonObject returnJson = this.addOrder(userid, total, discount, realpay, address, postcode ,receiver, phone,memo,artworks);

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject addOrder(String userid, String total,String discount, String realpay,String address,String postcode ,
			String receiver,String phone,String memo, String artworks)
	{

		JsonObject returnJson = new JsonObject();
		
		JsonObject orderInfo = new JsonObject();
		
		JsonArray artworkArray = new JsonArray();


		String returnMsg = "更新成功";

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
				
			//----------------- 插入订单
			String sql= "insert into order_main(userid, total, discount, realpay, address, postcode ,receiver, phone,memo, createtime, status) values(";
			sql = sql + userid+ "," + total + "," +  discount + "," +  realpay + ",'" +  
				address + "','" + postcode  + "','" + receiver + "','" +  phone + "','" + memo + "', NOW(),'未付款')";
		
			
			System.out.println(sql);
			
			stmt.execute(sql, Statement.RETURN_GENERATED_KEYS);
		
			ResultSet rs = stmt.getGeneratedKeys(); 
			rs.next();
			
			//刚刚生成的 订单 的 id
			String orderid = rs.getString(1);
			rs.close();
			 
			
			//---------------插入订单明细
			artworks = artworks.substring(1,artworks.length()-1);
			

			System.out.println(artworks);
			
			String[] artworkline = artworks.split(";");
			for(int i=0; i< artworkline.length; i++){
				
				String[] oneArtwork = artworkline[i].split(",");
				String artworkid=oneArtwork[0];
				String price = oneArtwork[1];
				String amount = oneArtwork[2];
				
				sql = "select name,artist, thumbnail from artwork where id='" + artworkid + "'";
				System.out.println(sql);
				rs = stmt.executeQuery(sql); 
				rs.next();
				
				String name= rs.getString("name");
				String artist = rs.getString("artist");
				String thumbnail = rs.getString("thumbnail");
				rs.close();
				
				sql = "insert into order_item values(" + orderid + ",'" + artworkid + "'," + price + "," + amount +
					",'" + name + "','" + artist + "','" + thumbnail + "')";
				System.out.println(sql);
				stmt.execute(sql);
				
				//减少库存 - 修改到 LockOrder 里面了
				//sql = "update artwork set stock=stock-1 where id=" + oneArtwork[0];
				//stmt.execute(sql);
			}
			
			
			//------------------- 返回订单的信息
			sql ="select * from order_main where id=" + orderid;
			rs = stmt.executeQuery(sql);		
			ResultSetMetaData metaData = rs.getMetaData();  
			int columnCount = metaData.getColumnCount();
			rs.next();
				
			for (int i = 1; i <= columnCount; i++) {  
		            String columnName =metaData.getColumnLabel(i);  
		            String value = rs.getString(columnName);  
		            if(value == null)
						value="";
		            orderInfo.addProperty(columnName, value);  
		    }   
			
			rs.close();
		
			//------------------- 返回订单项目的详细信息
			sql ="select artworkid, price, name, artist, thumbnail from order_item where orderid=" + orderid;
			rs = stmt.executeQuery(sql);		
			metaData = rs.getMetaData();  
			columnCount = metaData.getColumnCount();
			
			while (rs.next()) {
				JsonObject Obj = new JsonObject();
				
				for (int i = 1; i <= columnCount; i++) {  
		            String columnName =metaData.getColumnLabel(i);  
		            String value = rs.getString(columnName);  
		            if(value == null)
						value="";
		            Obj.addProperty(columnName, value);  
		        }   
				
				artworkArray.add(Obj);
				
				
			}		
			
			orderInfo.add("artworks", artworkArray);

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
		returnJson.add("order", orderInfo);
		return returnJson;
	}

}
