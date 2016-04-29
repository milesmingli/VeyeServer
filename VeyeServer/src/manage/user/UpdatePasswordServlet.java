package manage.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.veye.Constants;




/**
 * Servlet implementation class RunOneSql
 */
public class UpdatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdatePasswordServlet() {
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
		
		
		System.out.println("sql run");

		String username=request.getParameter("username");

		String password=request.getParameter("password");

		String name=request.getParameter("name");
		String sql=null;
		if(name.equals("email")){
		 sql = "update user set password='"+password+"' where email='"+username+"'"; 

		}else if(name.equals("phone")){
			
			 sql = "update user set password='"+password+"' where phone='"+username+"'"; 
	
		}
		
		
		System.out.println(sql);

		Boolean success = this.runSql(sql);

		

		System.out.println(success.toString());

		
		PrintWriter out = response.getWriter();
		
		out.print("success");
		out.close();

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
