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

import config.AppConfig;
import lib.MESSAGEXsend;
import utils.ConfigLoader;

/**
 * Servlet implementation class UserUpdate
 */
public class ResetPaswordBySMS extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ResetPaswordBySMS() {
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

		String phone = URLDecoder
				.decode(request.getParameter("phone"), "UTF-8");

		// System.out.println(phone);

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

		String returnMsg = "重置成功";

		JsonObject returnJson = new JsonObject();

		Connection conn = null;
		Statement stmt = null;

		// 随机生成6位数字
		int num = (int) ((Math.random() * 9 + 1) * 100000);
		String code = String.valueOf(num);

		System.out.println(num);

		// 将6位数字以短信方式发送到手机
		try {

			// Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			// Open a connection
			conn = DriverManager.getConnection(Constants.DB_URL,
					Constants.USER, Constants.PASS);
			// Execute SQL query
			stmt = conn.createStatement();

			// 检查手机是否注册了

			String sql = "select * from user where phone = '" + phone + "'";
			ResultSet rs = stmt.executeQuery(sql);
			if (!rs.next()) {
				returnMsg = "手机号码 " + phone + " 未注册";
				code="";
				rs.close();
				conn.close();
			} else {

				// 发送短信
				AppConfig config = ConfigLoader
						.load(ConfigLoader.ConfigType.Message);
				MESSAGEXsend submail = new MESSAGEXsend(config);
				submail.addTo(phone);
				submail.setProject("KBoX41");
				submail.addVar("code", code);
				submail.xsend();

				// 更新数据库

				sql = "update USER set password='" + code + "'";
				sql = sql + "  where phone='" + phone + "'";

				// System.out.println(sql);

				stmt.execute(sql);

				stmt.close();
				stmt = null;

				conn.close();
				conn = null;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

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

		// 返回结果给app端
		returnJson.addProperty("returnMsg", returnMsg);
		returnJson.addProperty("phone", phone);
		returnJson.addProperty("tempPassword", code);
		return returnJson;
	}

}
