package manage.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manage.Decoder;

import com.veye.Constants;




/**
 * Servlet implementation class RunOneSql
 */
public class UpdateAccountInformationForGallery extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateAccountInformationForGallery() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF8"); // this line solves the problem
		request.setCharacterEncoding("utf-8");

		response.setContentType("application/json");

		response.setHeader("Cache-control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "-1");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		response.setHeader("Access-Control-Max-Age", "86400");
		
		System.out.println("sql run");

		String license=request.getParameter("license");

		String RsStream=request.getParameter("RsStream");
		
		String galleryid=request.getParameter("galleryid");

		String id=request.getParameter("userid");

		Date d= new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(d);
		String sql=null;
		String gallerysql=null;
		String path = request.getSession().getServletContext().getRealPath("")
				.replaceAll("\\\\", "/");

		String Realpath = path + "/veyePicture/user/" + id + "/license.jpg";
		
		String licenseportrait= "/veyePicture/user/" + id + "/license.jpg";
		
		Decoder.GenerateImage(RsStream, Realpath);

		 sql = "update user set galleryid='"+galleryid+"',license='"+license+"',licenseportrait='"+licenseportrait+"',type='seller_organization' where id="+id; 
		 
		 gallerysql="insert into gallery (id,type,updatetime) VALUES ('"+galleryid+"','"+"»ú¹¹"+"','"+date+"')";
		 
		
		Boolean success = this.runSql(sql);
		Boolean success2 = this.runSql(gallerysql);
		System.out.println(success.toString());

		System.out.println(success2.toString());

		
	/*	PrintWriter out = response.getWriter();

		out.print("success");
		out.close();*/
		
		RequestDispatcher rd = request.getRequestDispatcher("CreateGalleryServletForUser?id="+galleryid);
		
		
		rd.forward(request, response);

		

	}

	private Boolean runSql(String sql) {

		Boolean success = true;

		Connection conn = null;
		Statement stmt = null;

		try {

			// Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			// Open a connection
			conn = DriverManager.getConnection(Constants.DB_URL, Constants.USER, Constants.PASS);

			// Execute SQL query
			stmt = conn.createStatement();

			stmt.execute(sql);

			stmt.close();
			stmt = null;

			conn.close();
			conn = null;

		} catch (Exception e) {
			success = false;
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

		return success;
	}

}
