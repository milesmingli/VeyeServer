package com.veye;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

/**
 * Servlet implementation class UserUpdate
 */
public class ReleaseOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReleaseOrder() {
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

		String orderid = URLDecoder.decode(request.getParameter("orderid"),
		"UTF-8");
		
	
		JsonObject returnJson = this.lockOrder(orderid);

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject lockOrder(String orderid)
	{

		JsonObject returnJson = new JsonObject();
	
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
				
			// 检查是否已经处于lock状态
			Boolean locked = false;
			String sql = "select paymentlock from order_main where id="
					+ orderid;

			System.out.println(sql);

			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {

				if (rs.getInt("paymentlock") == 1)
					locked = true;
			}

			//如果已经解锁，没有必要再解锁， 反之需要解锁
			if (locked == true) {

				// ----------------- 释放已经锁定的库存
				ArrayList<String> orderitems = new ArrayList<String>();

				sql = "select * from order_item where orderid=" + orderid;
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					orderitems.add(rs.getString("artworkid") + ","
							+ rs.getString("amount") + ","
							+ rs.getString("name") + ","
							+ rs.getString("artist"));
				}
				rs.close();

				for (int i = 0; i < orderitems.size(); i++) {
					String[] oneArtwork = orderitems.get(i).split(",");
					String artworkid = oneArtwork[0];
					String amount = oneArtwork[1];

					sql = "update artwork set stock=stock+" + amount
							+ " where id=" + artworkid;
					stmt.execute(sql);
				}

				// 将订单状态解锁
				sql = "update order_main set paymentlock = 0 where id= "
						+ orderid;
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
		
		return returnJson;
	}

}
