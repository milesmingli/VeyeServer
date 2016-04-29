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
public class UpdateAccountInformation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateAccountInformation() {
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

		String idcard=request.getParameter("idcard");

		String RsStream=request.getParameter("RsStream");
		
		String artistid=request.getParameter("artistid");

		String id=request.getParameter("userid");
		String name=request.getParameter("realname");
		String birthday=request.getParameter("birthday");
		String gender=request.getParameter("gender");
		if(gender.equals("0")){
			gender="ÄÐ";
		}else{
			gender="Å®";
		}
		String address=request.getParameter("address");
/*		String prov=address.split(",")[0];
		String city=address.split(",")[1];
		String district=address.split(",")[2];

		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		String portrait=request.getParameter("portrait");*/
		Date d= new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(d);
		String sql=null;
		String artistsql=null;
		String gallerysql=null;
		String path = request.getSession().getServletContext().getRealPath("")
				.replaceAll("\\\\", "/");

		String Realpath = path + "/veyePicture/user/" + id + "/idcard.jpg";
		
		String licenseportrait= "/veyePicture/user/" + id + "/idcard.jpg";
		
		Decoder.GenerateImage(RsStream, Realpath);

		 sql = "update user set artistid='"+artistid+"',galleryid='"+artistid+"',license='"+idcard+"',licenseportrait='"+licenseportrait+"',type='seller_artist' where id="+id; 

		
		 artistsql="insert into artist (id,hasgallery) VALUES ('"+artistid+"',"+"1"+")";
		 
		 gallerysql="insert into gallery (id,owner_artist,updatetime) VALUES ('"+artistid+"','"+artistid+"','"+date+"')";
		 
		 System.out.println(artistsql);
		
		Boolean success = this.runSql(sql);
		Boolean success1 = this.runSql(artistsql);
		Boolean success2 = this.runSql(gallerysql);
		System.out.println(success.toString());

		System.out.println(success1.toString());
		System.out.println(success2.toString());

		
	/*	PrintWriter out = response.getWriter();

		out.print("success");
		out.close();*/
		
		RequestDispatcher rd = request.getRequestDispatcher("CreateArtistServletForUser?id="+artistid);
		
		
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
