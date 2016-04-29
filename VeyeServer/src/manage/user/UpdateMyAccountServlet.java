package manage.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.veye.Constants;

import manage.Decoder;




/**
 * Servlet implementation class RunOneSql
 */
public class UpdateMyAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateMyAccountServlet() {
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
		
		String RsStream=request.getParameter("RsStream");
		String ispic=request.getParameter("ispic");
		String userid=request.getParameter("userid");
		String columnname=request.getParameter("columnname");
		String nickname=request.getParameter("nickname");
		String realname=request.getParameter("name");
		String gender=request.getParameter("gender");
		String birthday=request.getParameter("birthday");
		
		String birthday1=birthday.split("-")[0]+"-01-01";

		String prov=request.getParameter("prov");
		String city=request.getParameter("city");
		String dist=request.getParameter("dist");
		String email=request.getParameter("replaceemail");
		String phone=request.getParameter("replacephone");
		String type=request.getParameter("type");

		String path = request.getSession().getServletContext().getRealPath("")
				.replaceAll("\\\\", "/");

		String Realpath = path + "/veyePicture/user/" + userid + "/main.png";

		String relativepath = "/veyePicture/user/" + userid
				+ "/main.png";
		
		String sql=null;
		String sql1=null;
		String sql2=null;
		String gender1=null;
		if(gender.equals("0")){
			gender1="ÄÐ";
		}else if(gender.equals("1")){
			gender1="Å®";
		}
			System.out.println("--------------------------------------------------------");
			System.out.println(type);
			System.out.println("--------------------------------------------------------");

		sql="update user set  nickname='"+nickname+"', realname='"+realname+"',gender="+gender+",birthday='"+birthday+"',"
				+ "address='"+prov+","+city+","+dist+"',phone='"+phone+"',email='"+email+"',portrait='"+relativepath+"' where id="+userid;
		
	if(type.equals("seller_artist")){
			
		
		sql1="update artist set  name='"+realname+"',gender='"+gender1+"',birthday='"+birthday1+"',"
				+"phone='"+phone+"',prov='"+prov+"',city='"+city+"',district='"+dist+"',email='"+email+"',portrait='"+relativepath+"' where userid="+userid;
		
		sql2="update gallery set  name='"+realname+"',"
				+"phone='"+phone+"',province='"+prov+"',city='"+city+"',district='"+dist+"',email='"+email+"',portrait='"+relativepath+"' where userid="+userid;
		
		Boolean success1 = this.runSql1(sql1);
		Boolean success2 = this.runSql2(sql2);

		}
		Boolean success = this.runSql(sql);
		if(success==true){
			if(ispic.equals("1")){
				
				Decoder.GenerateImage(RsStream, Realpath);
				
			
			}
		
		}
	
		//System.out.println(success2.toString());

		
		RequestDispatcher rd  = request.getRequestDispatcher("CreateAccountForUpdate?id="+userid);
		rd.forward(request, response);
	

		
		/*PrintWriter out = response.getWriter();
	
		out.print("success");
		out.close();
	*/

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
			
			System.out.println(sql);

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
	private Boolean runSql1(String sql1) {

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
			System.out.println(sql1);
			stmt.execute(sql1);

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
	}	private Boolean runSql2(String sql2) {

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
			System.out.println(sql2);
			stmt.execute(sql2);

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
