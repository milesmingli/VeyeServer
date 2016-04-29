package manage.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import manage.CreateArtistFile;



public class CreateArtist_sellerartist extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);


	 
	}
	

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		//获得创建目录的路径名
		String path = request.getParameter("artistid");
        //创建目录
		String pathname1= request.getSession().getServletContext().getRealPath("");
		String pathname2;
		pathname2=pathname1.replaceAll("\\\\","/"); 
		System.out.println("替换后的路径为"+pathname2);

		
		CreateArtistFile.createDir(request.getSession().getServletContext().getRealPath("")+"/veyePicture/artist/"+path);	
		HttpSession session=request.getSession();
		session.setAttribute("userid",path);
		System.out.println("工程路径"+request.getSession().getServletContext().getRealPath("")+"/veyePicture/artist/"+path);
		
		
	}
}
