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
public class GetExibitionArtworkByGallery extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetExibitionArtworkByGallery() {
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
		
		
		String galleryId = URLDecoder
		.decode(request.getParameter("galleryId"), "UTF-8");

		response.setCharacterEncoding("UTF8"); // this line solves the problem
		response.setContentType("application/json");

		response.setHeader("Cache-control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "-1");

		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		response.setHeader("Access-Control-Max-Age", "86400");

	
		JsonObject returnJson = this.getGalleryArtworkForMainpage(galleryId);

		PrintWriter out = response.getWriter();
		out.println(returnJson.toString());
		out.close();

	}

	private JsonObject getGalleryArtworkForMainpage(String galleryId) {

		JsonObject returnJson = new JsonObject();


		String returnMsg = "获取成功";

		JsonArray exibitionArray = new JsonArray();
	
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
			
			
			//获取 gallery的所有展览
			//String sql = "select * from exhibition order by starttime desc ";
			
			String sql = "SELECT a.id, a.name, a.brief, a.starttime,a.endtime, a.gallery, a.galleryid, a.contactperson, a.phone, a.email, a.portrait, b.province, b.city,b.district, b.address";
			sql = sql + " FROM exhibition as a, gallery as b where a.galleryid = b.id and b.id='" + galleryId + "'";
			sql = sql +	" order by a.starttime desc ";
			
			System.out.println(sql);
			
			ResultSet rs = stmt.executeQuery(sql);		
			ResultSetMetaData metaData = rs.getMetaData();  
			int columnCount = metaData.getColumnCount();

			while (rs.next()) {
				JsonObject exibitionObj = new JsonObject();
				for (int i = 1; i <= columnCount; i++) {  
		            String columnName =metaData.getColumnLabel(i);  
		            String value = rs.getString(columnName);  
		            if(value == null)
						value="";
		            exibitionObj.addProperty(columnName, value);  
		        }   
				exibitionArray.add(exibitionObj);
			}			
			rs.close();
			
			//为每个 exibition 获取相应的作品
			
			for(int i=0; i< exibitionArray.size(); i ++){
				JsonObject exibtionObj = (JsonObject)exibitionArray.get(i);
				
				
				
				sql = "select id, size, thumbnail, artistid, artist from artwork where id in (select artworkid from exhibition_artwork where  exhibitionid='" + exibtionObj.get("id").getAsString() + "')";
				rs = stmt.executeQuery(sql);		
				metaData = rs.getMetaData();  
				columnCount = metaData.getColumnCount();

				JsonArray artworkArray = new JsonArray();

				
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
				
				
				exibtionObj.add("artworks", artworkArray);
				
				//System.out.println(galleryObj);
				
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
		returnJson.add("exhibitions", exibitionArray);
		return returnJson;
	}

}
