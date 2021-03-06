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
public class GetArtworksByExhibition extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetArtworksByExhibition() {
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

		String exhibitionId = URLDecoder.decode(
				request.getParameter("exhibitionId"), "UTF-8");

		response.setCharacterEncoding("UTF8"); // this line solves the problem
		response.setContentType("application/json");

		response.setHeader("Cache-control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "-1");

		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		response.setHeader("Access-Control-Max-Age", "86400");

		JsonObject returnJson = this.getArtworksByExhibition(exhibitionId);

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject getArtworksByExhibition(String exhibitionId) {

		JsonObject returnJson = new JsonObject();

		String returnMsg = "获取成功";

		JsonArray artworkArray = new JsonArray();
		JsonObject galleryObj = new JsonObject();

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

			// 获取artwork
			String sql = "select * from artwork_view where id in (select artworkid from exhibition_artwork where  exhibitionid='"
					+ exhibitionId + "')";

			System.out.println(sql);

			ResultSet rs = stmt.executeQuery(sql);
			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();

			while (rs.next()) {
				JsonObject artworkObj = new JsonObject();
				for (int i = 1; i <= columnCount; i++) {
					String columnName = metaData.getColumnLabel(i);
					String value = rs.getString(columnName);
					if (value == null)
						value = "";
					artworkObj.addProperty(columnName, value);
				}

				artworkArray.add(artworkObj);
			}
			rs.close();

			// 获取展览对应的美术馆
			sql = "select name, city  from gallery where id = (select galleryid from exhibition where id = '"
					+ exhibitionId + "')";

			System.out.println(sql);

			rs = stmt.executeQuery(sql);
			metaData = rs.getMetaData();
			columnCount = metaData.getColumnCount();

			rs.next();
			
			for (int i = 1; i <= columnCount; i++) {
				String columnName = metaData.getColumnLabel(i);
				String value = rs.getString(columnName);
				if (value == null)
					value = "";
				galleryObj.addProperty(columnName, value);
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
		returnJson.add("gallery", galleryObj);
		returnJson.add("artworks", artworkArray);
		return returnJson;
	}

}
