package com.veye;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.im4java.core.ConvertCmd;
import org.im4java.core.IMOperation;

/**
 * Servlet implementation class UserUpdate
 */
public class GeneData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GeneData() {
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

		generateArtworkData();

		 
		

	}

	private void generateArtworkData() {

		String serverPath=this.getServletConfig().getServletContext().getRealPath("/");
		serverPath = serverPath.substring(0,serverPath.length()-1);
		
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

			// 获取所有作品
			ArrayList<ArrayList> artworkArray = new ArrayList<ArrayList>();

			String sql = "select id, thumbnail from artwork";
			ResultSet rs = stmt.executeQuery(sql);
			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();

			while (rs.next()) {

				ArrayList<String> oneArtwork = new ArrayList<String>();
				for (int i = 1; i <= columnCount; i++) {

					String columnName = metaData.getColumnLabel(i);
					String value = rs.getString(columnName);
					if (value == null)
						value = "";
					oneArtwork.add(value);
				}

				artworkArray.add(oneArtwork);

			}
			rs.close();

			// 为每个作品重新生成marker 并上传 marker
			
			for (int i = 0; i < artworkArray.size(); i++) {

				ArrayList oneArtwork = (ArrayList) artworkArray.get(i);

				String id = (String) oneArtwork.get(0);
				String thumbnail = (String) oneArtwork.get(1);
				thumbnail = serverPath + thumbnail;
				thumbnail = thumbnail.replaceAll("/", "\\\\");
				thumbnail = thumbnail.replaceAll("\\\\", "\\\\\\\\");
				
				String marker = thumbnail.replace("thumb", "marker");
				
				//System.out.println(thumbnail);
				//System.out.println(marker);
				
				// 生成新的 marker
				
				ConvertCmd cmd = new ConvertCmd();
				cmd.setSearchPath("C:\\Program Files (x86)\\ImageMagick-6.8.5-Q16");

				IMOperation op = new IMOperation();
					
				op.addImage(thumbnail);
				op.normalize();
				op.addImage(marker);
				cmd.run(op);
				
				Thread.sleep(2000);
				
				// 上传新的 marker
				
				String targetId = "abc";
				

				// 更新数据库
				sql = "update artwork set uniqueTargetId='" + targetId + "' where id='" + id + "'";
				System.out.println(sql);
				stmt.execute(sql);
			}

			stmt.close();
			stmt = null;

			conn.close();
			conn = null;

		} catch (Exception e) {

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

	}

}
