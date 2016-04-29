package manage;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.veye.Constants;

/**
 * 
 * @author Administrator �ļ��ϴ� ���岽�裺 1����ô����ļ���Ŀ���� DiskFileItemFactory Ҫ���� 2�� ����
 *         request ��ȡ ��ʵ·�� ������ʱ�ļ��洢���� �����ļ��洢 ���������洢λ�ÿɲ�ͬ��Ҳ����ͬ 3����
 *         DiskFileItemFactory ��������һЩ ���� 4����ˮƽ��API�ļ��ϴ����� ServletFileUpload
 *         upload = new ServletFileUpload(factory); Ŀ���ǵ���
 *         parseRequest��request������ ��� FileItem ����list ��
 * 
 *         5���� FileItem ������ ��ȡ��Ϣ�� ������ �ж� ���ύ��������Ϣ �Ƿ��� ��ͨ�ı���Ϣ �������� 6�� ��һ��. �õ�����
 *         �ṩ�� item.write( new File(path,filename) ); ֱ��д�������� �ڶ���. �ֶ�����
 * 
 */
public class VedioUploadServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); // ���ñ���
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
		
		String VedioStatus=request.getParameter("VedioStatus");


		// ��ô����ļ���Ŀ����
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// ��ȡ�ļ���Ҫ�ϴ�����·��
		String path = request.getSession().getServletContext().getRealPath("");
		HttpSession session = request.getSession();
		String folder = (String) session.getAttribute("userid");
		String vediopath = path + "/veyePicture/artwork/" + folder;
		System.out.println(vediopath);
		
		String successmessage="�ϴ��ɹ�!";
		String failmessage="�ϴ�ʧ��,���ϴ�12M���ڵ�mp4�ļ�";

		
		PrintWriter out = response.getWriter();
		
		// ���û�����������õĻ����ϴ���� �ļ� ��ռ�� �ܶ��ڴ棬
		// ������ʱ��ŵ� �洢�� , ����洢�ң����Ժ� ���մ洢�ļ� ��Ŀ¼��ͬ
		/**
		 * ԭ�� �����ȴ浽 ��ʱ�洢�ң�Ȼ��������д�� ��ӦĿ¼��Ӳ���ϣ� ������˵ ���ϴ�һ���ļ�ʱ����ʵ���ϴ������ݣ���һ������ .tem
		 * ��ʽ�� Ȼ���ٽ�������д�� ��ӦĿ¼��Ӳ����
		 */
		//	factory.setRepository(new File(vediopath));
		// ���� ����Ĵ�С�����ϴ��ļ������������û���ʱ��ֱ�ӷŵ� ��ʱ�洢��
		// factory.setSizeThreshold(1024*1024) ;

		// ��ˮƽ��API�ļ��ϴ�����
		ServletFileUpload upload = new ServletFileUpload(factory);

		try {
			// �����ϴ�����ļ�
			List<FileItem> list = (List<FileItem>) upload.parseRequest(request);

			for (FileItem item : list) {
				// ��ȡ������������

				long size = item.getSize();
				String vedioname=item.getName();
				
				if (size < 12582912 && (vedioname.indexOf("mp4")>0 || vedioname.indexOf("MP4")>0 )) {

					System.out.println("size=" + size);

					// ��ȡ �ϴ��ļ��� �ַ������֣���1�� ȥ����б�ܣ�
					String filename = "main.mp4";

					// ����д��������
					// ���׳����쳣 ��exception ��׽

					item.write(new File(vediopath, filename));// д���ļ�
					
					String sql = "insert into status (id,status) values('"+folder+"',"+1+")";

					System.out.println(sql);
					
					Connection conn = null;
					Statement stmt = null;
					try {
					
					conn = DriverManager.getConnection(Constants.DB_URL,
							Constants.USER, Constants.PASS);
					stmt = conn.createStatement();
					
					stmt.execute(sql);
					
					stmt.close();
					stmt = null;
		
					conn.close();
					conn = null;
					
					//out.print(successmessage);
					}catch (SQLException e) {
						
						System.out.println(e);
					}
					

				} else {
					System.out.println(failmessage);
					session.setAttribute("failmessage",failmessage);
					out.print(failmessage);

				}
			}

		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block

			// e.printStackTrace();
		}

		// request.getRequestDispatcher("filedemo.jsp").forward(request,
		// response);

	}

}
