package manage.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manage.CreateArtistFile;



public class CreateGalleryServletForUser extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

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
		//获得创建目录的路径名
		String path = request.getParameter("id");
		System.out.println("id="+path);
        //创建目录
		String pathname1= request.getSession().getServletContext().getRealPath("");
		String pathname2;
		pathname2=pathname1.replaceAll("\\\\","/"); 
		System.out.println("替换后的路径为"+pathname2);

	
	
		
		CreateArtistFile.createDir(request.getSession().getServletContext().getRealPath("")+"/veyePicture/gallery/"+path);	
		
		System.out.println("工程路径"+request.getSession().getServletContext().getRealPath("")+"/veyePicture/gallery/"+path);
		
		RequestDispatcher rd = request.getRequestDispatcher("/uploadpic/creategallery_user.jsp");
	
		
		request.setAttribute("idname",path);
		request.setAttribute("pathname",pathname2+"/veyePicture/gallery/"+path);
		
		
		
		rd.forward(request, response);
		
	 
	}
	

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
