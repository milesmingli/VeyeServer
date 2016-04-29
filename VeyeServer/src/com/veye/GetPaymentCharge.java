package com.veye;

import java.io.BufferedReader;
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

import org.json.JSONObject;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.util.ArrayList;
import java.util.Enumeration;
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
import com.pingplusplus.model.Event;
import com.pingplusplus.model.Webhooks;


/**
 * Servlet implementation class UserUpdate
 */
public class GetPaymentCharge extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//public static String apiKey = "sk_test_KWjDKKKa9G8CuzbD8GH0qH4G";

	//public static String appId = "app_4erfvLnnTWLCyfLq";
	
	//public static String apiKey = "sk_live_bfvP4850O880vn1C0GyznDyD";

	//public static String appId = "app_ezHuz9WvfD005yTK";
	
	
	//--- Miles new live 
	
	public static String apiKey = "sk_live_aDGmTKP4yLOGKWP8i5ib1OSS";

	public static String appId = "app_yznnXTWXPab1zbjv";
	
	
	//---- Miles test 
	//public static String apiKey = "sk_test_rzfjXDCOGSO0a1CGSCDm5Ku1";

	//public static String appId = "app_yznnXTWXPab1zbjv";
	
	
	
	

	public GetPaymentCharge() {
		
		
		super();
		
		Pingpp.apiKey = apiKey;
		
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
		
				
			JSONObject paramObj = new JSONObject(buffer.toString());
			
			System.out.println("---- ping ++ YiShouKuan invoked -----");
			
			System.out.println(buffer.toString());
			
			String amount = paramObj.getString("amount");
			String channel = paramObj.getString("channel");
			String orderNo = paramObj.getString("order_no");
			
			JSONObject custom_params = (JSONObject) paramObj.get("custom_params");
				
		
		    String ip =  custom_params.getString("ip");
		    
		    System.out.println(amount + " " + channel + "  " + orderNo + "  " + ip) ;
		    
		    String returnMessage = this.getCharge(amount, orderNo, channel,ip);

			PrintWriter out = response.getWriter();
			out.println(returnMessage);
			out.close();
		    

		} catch (Exception e) {
			e.printStackTrace();
		}

	
		

	}

	private String getCharge(String amount, String orderId, String paymentChannel,String ipAddress) {
		
		String returnMsg;
		
		
		try {

			
			
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

		

		
		return returnMsg;
		
		
	}
	
	
	
	

}
