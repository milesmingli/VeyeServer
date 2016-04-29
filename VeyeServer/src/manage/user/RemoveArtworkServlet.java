package manage.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manage.CreateArtistFile;
import manage.DeletePic;



public class RemoveArtworkServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);


	 
	}
	

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		//获得创建目录的路径名
		String path = request.getParameter("artworkid");
        //创建目录
		String pathname=request.getSession().getServletContext().getRealPath("")+"/veyePicture/artwork/"+path;
		DeletePic.deleteFile(pathname);			

		
	}
}
