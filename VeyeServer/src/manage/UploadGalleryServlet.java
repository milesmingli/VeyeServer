package manage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.veye.Constants;

public class UploadGalleryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public UploadGalleryServlet() {
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
		
		
		String userid=request.getParameter("userid");
		String RsStream=request.getParameter("RsStream");
		String name=request.getParameter("name").trim();
		String brief=request.getParameter("brief").trim();
		//String type=request.getParameter("type").trim();
		String type="机构";
		String artist=null;
		String ownerartist[]=null;
		String province=request.getParameter("prov").trim();
		String city=request.getParameter("city").trim();
		String district=request.getParameter("dist").trim();
		String address=request.getParameter("address").trim();
		String contactperson=request.getParameter("contactperson").trim();
		String phone=request.getParameter("phone").trim();
		String telephone=request.getParameter("telephone").trim();
		String fax=request.getParameter("fax").trim();
		String web=request.getParameter("web").trim();
		String email=request.getParameter("email").trim();
		System.out.println(type);
		if(type.equals("个人")){
		
		artist=request.getParameter("artist");
		ownerartist=artist.split(",");
	
		}

		//String RealRsStream = RsStream.replace("data:image/jpeg;base64,", "");

		String path = request.getSession().getServletContext().getRealPath("")
				.replaceAll("\\\\", "/");

		String Realpath = path + "/veyePicture/gallery/" + userid + "/main.png";

		String relativepath = "/veyePicture/gallery/" + userid
				+ "/main.png";
		
		Date d= new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(d);
		System.out.println(date);

		
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
				sql = "insert into gallery (id,name,brief,type,province,city,district,address,contactperson,phone,telephone,fax,web,email,portrait,updatetime) values('";
				sql = sql +userid+"','"+name+"','"+brief+"','"+type+"','"+province+"','"+city+"','"+district+"','"+address+"','"+contactperson+"','"+phone+"','"+telephone+"','"+fax+"','"+web+"','"+email+"','"+relativepath+"','"+date+"')";
				
			
					System.out.println(sql);
		
					stmt.execute(sql);
		
					stmt.close();
					stmt = null;
		
					conn.close();
					conn = null;
					Decoder.GenerateImage(RsStream, Realpath);
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
