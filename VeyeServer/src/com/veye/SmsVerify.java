package com.veye;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import config.AppConfig;
import lib.MESSAGEXsend;
import utils.ConfigLoader;

/**
 * Servlet implementation class UserUpdate
 */
public class SmsVerify extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SmsVerify() {
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
		
		
		String phone = URLDecoder.decode(request.getParameter("phone"),
		"UTF-8");
		
		//System.out.println(phone);

		response.setCharacterEncoding("UTF8"); // this line solves the problem
		response.setContentType("application/json");

		response.setHeader("Cache-control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "-1");

		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		response.setHeader("Access-Control-Max-Age", "86400");

		
		
		JsonObject returnJson = this.phoneVerify(phone);

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject phoneVerify(String phone) {

		JsonObject returnJson = new JsonObject();
		
		//随机生成6位数字
		int num = (int)((Math.random()*9+1)*100000);
		String code = String.valueOf(num);
		
		System.out.println(num);
		
		//将6位数字以短信方式发送到手机
		try {

			AppConfig config = ConfigLoader
					.load(ConfigLoader.ConfigType.Message);
			MESSAGEXsend submail = new MESSAGEXsend(config);
			submail.addTo(phone);
			submail.setProject("kDPCE4");
			submail.addVar("code", code);
			submail.xsend();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		//返回结果给app端
		returnJson.addProperty("phone", phone);
		returnJson.addProperty("verifyCode", code);
		return returnJson;
	}

}
