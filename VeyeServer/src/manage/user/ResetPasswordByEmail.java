package manage.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.veye.Constants;



/**
 * Servlet implementation class AdReachGet
 */
public class ResetPasswordByEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public ResetPasswordByEmail() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			response.setCharacterEncoding("UTF8"); // this line solves the problem
			//response.setContentType("application/json");
			response.setContentType("text/html");
	
			response.setHeader("Cache-control", "no-cache, no-store");
			response.setHeader("Pragma", "no-cache");
			response.setHeader("Expires", "-1");
	
			response.setHeader("Access-Control-Allow-Origin", "*");
			response.setHeader("Access-Control-Allow-Methods", "POST");
			response.setHeader("Access-Control-Allow-Headers", "Content-Type");
			response.setHeader("Access-Control-Max-Age", "86400");
		
			
			PrintWriter out = response.getWriter();
		
			String email = request.getParameter("email");
			int verifynode=(int)((Math.random()*9+1)*100000);
	        String str=Integer.toString(verifynode);//生产6位数字的验证码
			HttpSession session =  request.getSession() ;

			 try{
				   Class.forName("org.gjt.mm.mysql.Driver") ;
				  }catch(ClassNotFoundException e){
				   e.printStackTrace() ;
				   System.out.println("Class Not Found Exception . ") ;
				  }
				  //连接URL
				
				  Connection conn = null ;
				  ResultSet rs = null ;
				  PreparedStatement psm = null;
				  
				  String sql = "SELECT email FROM user WHERE email=? ";
				  
				 try{
					   conn = DriverManager.getConnection(Constants.DB_URL, Constants.USER, Constants.PASS) ;
					   psm=conn.prepareStatement(sql);
					   psm.setString(1, email);
					   rs = psm.executeQuery() ;//返回查询结果
					   System.out.println(sql);
					   
					  }catch(SQLException e){
					   e.printStackTrace() ;
					 }
				 
				  try{
					   if (rs.next()){ 
						   
					
					        System.out.println(str+"_"+email);
					        
					        sql="update user set password='"+str+"'where email='"+email+"'";
					        System.out.println(sql);
					        psm.execute(sql);
					        System.out.println("执行成功");

					        Mail.sendMail(email, "Veye","临时密码", "您的临时密码为:"+str+"请登录后及时修改密码");
					        System.out.println("发送成功");
					        
					        out.print("发送成功");
					        
					   }else{
						   
						   out.print("发送失败,无此邮箱");
						   
					   }
						conn.close();
						conn = null;
					  }catch(SQLException e){
					   e.printStackTrace() ;
					  }
				  
			
				  out.close();
	       
	}
		
	    
     
    

}
