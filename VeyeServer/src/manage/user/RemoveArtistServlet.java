package manage.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manage.DeletePic;



public class RemoveArtistServlet extends HttpServlet {

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
		String pathname=request.getSession().getServletContext().getRealPath("")+"/veyePicture/artist/"+path;
		DeletePic.deleteFile(pathname);			

		
	}
}
