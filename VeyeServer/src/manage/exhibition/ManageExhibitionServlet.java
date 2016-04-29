package manage.exhibition;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import Decoder.BASE64Decoder;

import com.google.gson.JsonArray;
import com.veye.Constants;

public class ManageExhibitionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public ManageExhibitionServlet() {
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
		String realexhibitionid=new String(request.getParameter("realexhibitionid").getBytes ("ISO-8859-1"), "UTF-8");
		String sql="SELECT exhibition_artwork.artworkid,artwork.id,artwork.name,artwork.thumbnail,artwork.gallery FROM (exhibition_artwork,artwork) where exhibition_artwork.artworkid=artwork.id and exhibition_artwork.exhibitionid='"+realexhibitionid+"'";
	
		
		System.out.println("sql="+sql);
		
		String returnMsg = "执行成功";
		String alldatas="";
		ResultSet rs = null ;
	
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
			stmt = conn.createStatement();
			rs=stmt.executeQuery(sql);

			  // json数组  
			   JSONArray array = new JSONArray();  
			    
			   // 获取列数  
			   ResultSetMetaData metaData = rs.getMetaData();  
			   int columnCount = metaData.getColumnCount();  
			   
			   // 遍历ResultSet中的每条数据  
			    while (rs.next()) {  
			        JSONObject jsonObj = new JSONObject();  
			         
			        // 遍历每一列  
			        for (int i = 1; i <= columnCount; i++) {  
			            String columnName =metaData.getColumnLabel(i);  
			            String value = rs.getString(columnName);  
			            jsonObj.put(columnName, value);  
			        }   
			        array.put(jsonObj);   
			    } 
			
		/*	while  (rs.next()) {
				
				String data=rs.getString("artwork.id")+","+rs.getString("artwork.name")+","+rs.getString("artwork.gallery")+","+rs.getString("artwork.thumbnail");
				
				alldatas=alldatas+"*"+data;
				
			}*/

			stmt.close();
			stmt = null;

			conn.close();
			conn = null;
			if(alldatas==""){
				
				alldatas="nothingness";
			}
			
			out.print(array.toString());
			System.out.println(array.toString());
			

		} catch (SQLException e) {
		
			System.out.println(e);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
