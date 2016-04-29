package manage.exhibition;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;  

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Decoder.BASE64Decoder;

import com.google.gson.JsonArray;
import com.veye.Constants;

public class InsertExhibition_Artwork extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public InsertExhibition_Artwork() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);

	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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

		PrintWriter out = response.getWriter();
		
		String returnMsg = "ִ�гɹ�";
		String artworkid=null;
		String exhibitionid=request.getParameter("exhibitionid").split(",")[1];
	
		String insertartworkid=request.getParameter("insertartworkid");
	
		String str=insertartworkid.replace("{", "");
		String str1=str.replace("}", "");
		
		
		System.out.println("str1="+str1);
		
		String artworkidArrays[]=str1.split(",");
		System.out.println("artworkidArrays.length="+artworkidArrays.length);
		
		String path= request.getContextPath();
	

		
		String sql = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("Class Not Found Exception ...");
		}
		// ����URL

		
		Connection conn = null;
		Statement stmt = null;

		try {

			conn = DriverManager.getConnection(Constants.DB_URL,
					Constants.USER, Constants.PASS);
				stmt = conn.createStatement();
					
				
				for(int i=0;i<artworkidArrays.length;i++){
					
					artworkid=artworkidArrays[i].split(":")[0];
					// SQL���
					sql = "insert into exhibition_artwork(exhibitionid,artworkid) values('";
					sql = sql+exhibitionid+"',"+artworkid+")";
					
					System.out.println(sql);
					if(artworkid!=""){
					
						stmt.execute(sql);

					}
				
				}
				
				stmt.close();
				stmt = null;
	
				conn.close();
				conn = null;
				out.print(returnMsg+":");	
				System.out.println("ss34");
				response.sendRedirect(path+"/exhibition/ExhibitionArtWork.jsp");
				
				System.out.println("ww34");
		
				
				
		} catch (SQLException e) {
			returnMsg = "ִ��ʧ��";
			out.print(returnMsg+":");
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
			
		
		
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
