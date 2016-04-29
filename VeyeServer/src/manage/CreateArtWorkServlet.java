package manage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



public class CreateArtWorkServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {


		//��ô���Ŀ¼��·����
		String name=null;
		String path = CreateArtistFile.getNewDirName();
	
			
        //����Ŀ¼
		String pathname1= request.getSession().getServletContext().getRealPath("");
		String pathname2;
		pathname2=pathname1.replaceAll("\\\\","/"); 
		System.out.println("�滻���·��Ϊ"+pathname2);

	
	
		
		CreateArtistFile.createDir(request.getSession().getServletContext().getRealPath("")+"/veyePicture/artwork/"+path);	
		
		System.out.println("����·��"+request.getSession().getServletContext().getRealPath("")+"/veyePicture/artwork/"+path);
		
		RequestDispatcher rd = request.getRequestDispatcher("/uploadpic/createartwork.jsp");
		HttpSession session=request.getSession();
		session.setAttribute("userid",path);
		
		request.setAttribute("idname",path);
		request.setAttribute("pathname",pathname2+"/veyePicture/artwork/"+path);
		
		
		
		rd.forward(request, response);
		
	 
	}
	

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
