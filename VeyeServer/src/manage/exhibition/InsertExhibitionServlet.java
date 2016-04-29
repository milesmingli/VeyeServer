package manage.exhibition;


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

import manage.CreateFile;
import manage.Decoder;

public class InsertExhibitionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public InsertExhibitionServlet() {
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
		
		String returnMsg = "执行成功";
		
		String exhibitionid=request.getParameter("exhibitionid");
		String name=request.getParameter("name");
		String brief=request.getParameter("brief");
		String starttime=request.getParameter("starttime");
		String endtime=request.getParameter("endtime");
		String galleryid=request.getParameter("gallery").split(",")[1];
		String gallery=request.getParameter("gallery").split(",")[0];
		String contactperson=request.getParameter("contactperson");
		String phone=request.getParameter("phone");
		String fax=request.getParameter("fax");
		String email=request.getParameter("email");
		String portrait=request.getParameter("RsStream");

		String path = request.getSession().getServletContext().getRealPath("")
				.replaceAll("\\\\", "/");

		String Realpath = path + "/veyePicture/exhibition/" + exhibitionid + "/main.jpg";

		String relativepath = "/veyePicture/exhibition/" + exhibitionid
				+ "/main.jpg";

		CreateFile.getNewDirName(exhibitionid);
		CreateFile.createDir(path + "/veyePicture/exhibition/" + exhibitionid);

		Decoder.GenerateImage(portrait, Realpath);
		String sql = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("Class Not Found Exception ...");
		}
		// 连接URL

		
		Connection conn = null;
		Statement stmt = null;

		try {

			conn = DriverManager.getConnection(Constants.DB_URL,
					Constants.USER, Constants.PASS);
				stmt = conn.createStatement();
					// SQL语句
			
						sql = "insert into exhibition(id,name,brief,starttime,endtime,gallery,galleryid,contactperson,phone,fax,email,portrait) values('";
						sql = sql+exhibitionid+"','"+name+"','"+brief+"','"+starttime+"','"+endtime+"','"+gallery+"','"+galleryid+"','"+contactperson+"','"+phone+"','"+fax+"','"+email+"','"+relativepath+"')";
					System.out.println(sql);
		
					stmt.execute(sql);
		
					stmt.close();
					stmt = null;
		
					conn.close();
					conn = null;
					out.print(returnMsg+":");	
		} catch (SQLException e) {
			returnMsg = "执行失败";
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
