package com.veye;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.pingplusplus.model.Event;
import com.pingplusplus.model.Webhooks;

/**
 * Servlet implementation class UserUpdate
 */
public class PaymentSucceedHook extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaymentSucceedHook() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			request.setCharacterEncoding("UTF8");
			// 获取头部所有信息
			Enumeration headerNames = request.getHeaderNames();
			while (headerNames.hasMoreElements()) {
				String key = (String) headerNames.nextElement();
				String value = request.getHeader(key);
				System.out.println(key + " " + value);
			}
			// 获得 http body 内容
			BufferedReader reader = request.getReader();
			StringBuffer buffer = new StringBuffer();
			String string;
			while ((string = reader.readLine()) != null) {
				buffer.append(string);
			}
			reader.close();
			// 解析异步通知数据
			Event event = Webhooks.eventParse(buffer.toString());
			if ("charge.succeeded".equals(event.getType())) {
				response.setStatus(200);
				
				/*
				System.out.println("----------- hooks return---------------");
				System.out.println(event);
				System.out.println("----------- hooks return end---------------");
				*/
				
				
				JSONObject eventObj = new JSONObject(event.toString());
				
				
				
				JSONObject dataObj = (JSONObject) eventObj.get("data");
				
				JSONObject objObj = (JSONObject) dataObj.get("object");
				
		        String order_no =  objObj.getString("order_no");
		        Boolean paid = objObj.getBoolean("paid");
		        
		        System.out.println("-----------from payment hooks--------------");
				System.out.println(order_no);
				System.out.println(paid.toString());
				
				
				if(paid){
					
					
					// Register JDBC driver
					Class.forName("com.mysql.jdbc.Driver");

					// Open a connection
					Connection conn = DriverManager.getConnection(Constants.DB_URL,
							Constants.USER, Constants.PASS);
					// Execute SQL query
					Statement stmt = conn.createStatement();
					

					//更新订单状态
					String sql = "update order_main set status='已支付' where id=" + order_no;
					System.out.println(sql);
					stmt.execute(sql);
					
					
					//更改库存数量
					ArrayList<String> artworkList = new ArrayList<String>();
					ArrayList<Integer> amountList = new ArrayList<Integer>();
					
					
					sql = "select artworkid, amount from order_item where orderid=" + order_no;
					
					ResultSet rs = stmt.executeQuery(sql);		
					
					while (rs.next()) {
						artworkList.add(rs.getString(1));
						amountList.add(rs.getInt(2));
						
					}			
					rs.close();
					
					
					for(int i=0; i<artworkList.size();i++){
						sql = "update artwork set stock=stock -" + amountList.get(i) + " where id='" + artworkList.get(i) + "'";
						System.out.println(sql);
						stmt.execute(sql);
						
					}
					
					
					stmt.close();
					stmt = null;

					conn.close();
					conn = null;
					
				}
			  
		        

			} else if ("refund.succeeded".equals(event.getType())) {
				response.setStatus(200);
			} else {
				response.setStatus(500);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
