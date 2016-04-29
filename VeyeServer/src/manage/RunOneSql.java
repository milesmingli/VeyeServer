package manage;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
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

import manage.target.DeleteTarget;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.veye.Constants;

import java.util.Timer;  
import java.util.TimerTask; 


/**
 * Servlet implementation class RunOneSql
 */
public class RunOneSql extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RunOneSql() {
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
		
		String pathname1= request.getSession().getServletContext().getRealPath("");
		String pathname2;
		pathname2=pathname1.replaceAll("\\\\","/"); 
		
		String TABLE_NAME = request.getParameter("tablename");
		String id=request.getParameter("id");
		
		
		
		if(TABLE_NAME.equals("artwork")){
			
			String path=this.DeleteFile(TABLE_NAME,id);
			
			String realpath=path.split("/thumb")[0];
			
			final String Delpath=path.split("#")[1];
			if(Delpath.equals("null")){
				DeletePic.deleteFile(pathname2+realpath);			
				
			}else{

				DeletePic.deleteFile(pathname2+realpath);
				 new Thread(){
			            public void run(){
			               try {
			                  Thread.sleep(300000);
			                  
			                  System.out.println("延迟5分钟执行");
			                  
			 			    DeleteTarget.GettargetId(Delpath);
			               } catch (InterruptedException e) { }
			            }
			         }.start();  
			             
			}
			
		
		
			
		}else{
			if(TABLE_NAME.equals("marker")){
				System.out.println(this.DeleteFile(TABLE_NAME,id));
				String path=this.DeleteFile(TABLE_NAME,id).split("#")[0];
				final String Delpath=this.DeleteFile(TABLE_NAME,id).split("#")[1];

				String realpath=path.replace("/main.png", "");
				DeletePic.deleteFile(pathname2+realpath);
				//传id给DeleteTarget，删除marker
				 new Thread(){
			            public void run(){
			               try {
			                  Thread.sleep(300000);
			                  
			                  System.out.println("延迟5分钟执行");
			                  
			 			    DeleteTarget.GettargetId(Delpath);
			               } catch (InterruptedException e) { }
			            }
			         }.start();  
			
			     // DeleteTarget.GettargetId(this.DeleteFile(TABLE_NAME,id).split("#")[1]);
				
			}else{
				String path=this.DeleteFile(TABLE_NAME,id);
				String realpath=path.replace("/main.png", "");
				DeletePic.deleteFile(pathname2+realpath);
				System.out.println(pathname2+realpath);	
			}
		

		}
		
	
		
		System.out.println("sql run");

		String sql = new String(request.getParameter("sql").getBytes ("ISO-8859-1"), "UTF-8"); 
		
	
		
		System.out.println(sql);

		Boolean success = this.runSql(sql);

		

		System.out.println(success.toString());

		
		PrintWriter out = response.getWriter();
		
		out.print("链接成功");
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

	
	private String DeleteFile(String table_name,String id) {
		String path="";
		String path1="";
		String sql=null;
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
			if(table_name.equals("artwork")){
			
				sql = "select thumbnail,uniqueTargetId from " + table_name+" where id='"+id+"'";
				System.out.println("1122");
			
			}else if(table_name.equals("artist") || table_name.equals("gallery") ){
				sql = "select portrait from " + table_name+" where id='"+id+"'";

			}else if(table_name.equals("marker")){
				sql = "select * from " + table_name+" where id='"+id+"'";

				
			}
			

			System.out.println(sql);

			ResultSet rs = stmt.executeQuery(sql);

			ResultSetMetaData metaData = rs.getMetaData();
			int columnCount = metaData.getColumnCount();

			while (rs.next()) {
				if(table_name.equals("marker")){
				path=rs.getString("picture")+"#"+rs.getString("uniqueTargetId");
				}else if(table_name.equals("artwork")){
					path1=rs.getString("uniqueTargetId");
					path=rs.getString("thumbnail")+"#"+path1;
					
					System.out.println(path);
				}
				
				else{
				path=rs.getString(1);
	
				}
			}

			rs.close();
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

		return path;
	}

}
