package manage;



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.veye.Constants;


public class ArtWorkMange extends HttpServlet {


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public ArtWorkMange() {
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
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
		doPost(request, response);
	
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8"); 
		PrintWriter out = response.getWriter();	
		String sql=new String(request.getParameter("sql").getBytes ("ISO-8859-1"), "UTF-8");
		System.out.println(sql+"测试");
		String data = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null ;
		String alldatas="";
		
		try {
			// Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			// Open a connection
			conn = DriverManager.getConnection(Constants.DB_URL, Constants.USER, Constants.PASS);

			// Execute SQL query
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
			
			
	
			if(alldatas==""){
				
				alldatas="nothingness";
			}
			out.print(array.toString());
			System.out.println(array.toString());
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			
		}
	
	
        out.close();
		
	}
}
