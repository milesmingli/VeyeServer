package manage.user;

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

import manage.Decoder;

import com.veye.Constants;
//暂时无用，留待添加艺术家后跳转使用
//暂时无用，留待添加艺术家后跳转使用
//暂时无用，留待添加艺术家后跳转使用
//暂时无用，留待添加艺术家后跳转使用
public class GalleryInsertArtistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public GalleryInsertArtistServlet() {
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
		String birthday=request.getParameter("birthday");
		String brief=request.getParameter("brief").trim();
		String gender=request.getParameter("gender");
		String phone=request.getParameter("phone").trim();
		String telephone=request.getParameter("telephone").trim();
		String fax=request.getParameter("fax").trim();
		String web=request.getParameter("web").trim();
		String email=request.getParameter("email").trim();
		String prov=request.getParameter("prov").trim();
		String city=request.getParameter("city").trim();
		String district=request.getParameter("dist").trim();
		String isgallery=request.getParameter("isgallery");
		String artistcategory=request.getParameter("artistcategory");
		String country=request.getParameter("country");
		String isaudit=request.getParameter("isaudit");
		String id=request.getParameter("id");

		if(country==null){
			country="";
		}
		System.out.println(isgallery);
		if(prov==null){
			prov="";
		}if(city==null){
			city="";
		}if(district==null){
			district="";
		}
	

		//String RealRsStream = RsStream.replace("data:image/jpeg;base64,", "");

		String path = request.getSession().getServletContext().getRealPath("")
				.replaceAll("\\\\", "/");

		String Realpath = path + "/veyePicture/artist/" + userid + "/main.png";

		String relativepath = "/veyePicture/artist/" + userid
				+ "/main.png";
		

//	Decoder.GenerateImage(RsStream, Realpath);
		Date d= new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(d);
		String sql = null;
		String sql1 = null;
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
				if(isgallery.equals("否")){
					sql = "insert into artist (id,name,birthday,brief,gender,prov,city,district,artistcategory,country,phone,telephone,fax,web,email,portrait,hasgallery,isaudit,userid) values('";
					sql = sql +userid+"','"+name+"','"+birthday+"','"+brief+"','"+gender+"','"+prov+"','"+city+"','"+district+"','"+artistcategory+"','"+country+"','"+phone+"','"+telephone+"','"+fax+"','"+web+"','"+email+"','"+relativepath+"',0,"+isaudit+","+id+")";
				
				}
				
		
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
