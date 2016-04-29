package manage.user;



import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class AdReachGet
 */
public class EmailVerifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public EmailVerifyServlet() {
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
	        	out.print(str);
		        Mail.sendMail(email, "Veye", "邮箱验证", "您收到的验证码为:"+str);
		        out.close();
	       
	}
		
	    
     
    

}
