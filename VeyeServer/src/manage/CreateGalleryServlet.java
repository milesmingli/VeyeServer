package manage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class CreateGalleryServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {


		//获得创建目录的路径名
		String name=null;
		String path = CreateArtistFile.getNewDirName();
	
			
        //创建目录
		String pathname1= request.getSession().getServletContext().getRealPath("");
		String pathname2;
		pathname2=pathname1.replaceAll("\\\\","/"); 
		System.out.println("替换后的路径为"+pathname2);

		
		CreateArtistFile.createDir(request.getSession().getServletContext().getRealPath("")+"/veyePicture/gallery/"+path);	
		
		System.out.println("工程路径"+request.getSession().getServletContext().getRealPath("")+"/veyePicture/gallery/"+path);
		
		RequestDispatcher rd = request.getRequestDispatcher("/uploadpic/creategallery.jsp");
	
		
		request.setAttribute("idname",path);
		request.setAttribute("pathname",pathname2+"/veyePicture/gallery/"+path);
		
		
		
		rd.forward(request, response);
		
	 
	}
	

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
