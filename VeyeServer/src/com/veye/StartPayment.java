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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.veye.Constants;

import com.pingplusplus.Pingpp;
import com.pingplusplus.exception.APIConnectionException;
import com.pingplusplus.exception.APIException;
import com.pingplusplus.exception.AuthenticationException;
import com.pingplusplus.exception.ChannelException;
import com.pingplusplus.exception.InvalidRequestException;
import com.pingplusplus.exception.PingppException;
import com.pingplusplus.model.App;
import com.pingplusplus.model.Charge;
import com.pingplusplus.model.ChargeCollection;


/**
 * Servlet implementation class UserUpdate
 */

//已经被弃用，采用了新的方式 ping++ 快捷支付。

public class StartPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//public static String apiKey = "sk_test_KWjDKKKa9G8CuzbD8GH0qH4G";

	//public static String appId = "app_4erfvLnnTWLCyfLq";
	
	
	public static String apiKey = "sk_live_bfvP4850O880vn1C0GyznDyD";

	public static String appId = "app_ezHuz9WvfD005yTK";

	
	
	
	
	public StartPayment() {
		
		
		super();
		
		Pingpp.apiKey = apiKey;
		
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
		

		String orderId = URLDecoder.decode(request.getParameter("orderId"), "UTF-8");
		String paymentChannel = URLDecoder.decode(request.getParameter("paymentChannel"), "UTF-8");
		
		
		String ipAddress = URLDecoder.decode(request.getParameter("ipAddress"), "UTF-8");

		response.setCharacterEncoding("UTF8"); // this line solves the problem
		response.setContentType("application/json");

		response.setHeader("Cache-control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "-1");

		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		response.setHeader("Access-Control-Max-Age", "86400");

	
		String returnMessage = this.getCharge(orderId, paymentChannel,ipAddress);

		PrintWriter out = response.getWriter();
		out.println(returnMessage);
		out.close();

	}

	private String getCharge(String orderId, String paymentChannel,String ipAddress) {
		
		String returnMsg;
		
		
		Connection conn = null;
		Statement stmt = null;

		try {

			//获取订单信息
			
			// Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			// Open a connection
			conn = DriverManager.getConnection(Constants.DB_URL,
					Constants.USER, Constants.PASS);
			// Execute SQL query
			stmt = conn.createStatement();
			
			
			//获取金额
			String sql = "select realpay from order_main where id=" + orderId;
			ResultSet rs = stmt.executeQuery(sql);		
			rs.next();			
			String amount = String.valueOf((int)rs.getDouble(1)*100);		
			
			System.out.println(amount);
			
			
			rs.close();
		
			stmt.close();
			stmt = null;

			conn.close();
			conn = null;
			
			//请求凭据并返回
			Charge charge = null;
	        Map<String, Object> chargeMap = new HashMap<String, Object>();
	        chargeMap.put("amount", amount);
	        chargeMap.put("currency", "cny");
	        chargeMap.put("subject", "Veye Payment");
	        chargeMap.put("body", "Veye Payment");
	        chargeMap.put("order_no", orderId);
	        chargeMap.put("channel", paymentChannel);
	        chargeMap.put("client_ip", ipAddress);
	        Map<String, String> app = new HashMap<String, String>();
	        app.put("id",appId);
	        chargeMap.put("app", app);
	        try {
	            //发起交易请求
	            charge = Charge.create(chargeMap);
	            System.out.println(charge);
	        } catch (PingppException e) {
	            e.printStackTrace();
	        }
	        
	        
	        
	        returnMsg = charge.toString();
			
			

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

		
		return returnMsg;
		
		
	}
	
	
	
	

}
