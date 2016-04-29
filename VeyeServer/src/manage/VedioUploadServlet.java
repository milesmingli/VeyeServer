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
 * @author Administrator 文件上传 具体步骤： 1）获得磁盘文件条目工厂 DiskFileItemFactory 要导包 2） 利用
 *         request 获取 真实路径 ，供临时文件存储，和 最终文件存储 ，这两个存储位置可不同，也可相同 3）对
 *         DiskFileItemFactory 对象设置一些 属性 4）高水平的API文件上传处理 ServletFileUpload
 *         upload = new ServletFileUpload(factory); 目的是调用
 *         parseRequest（request）方法 获得 FileItem 集合list ，
 * 
 *         5）在 FileItem 对象中 获取信息， 遍历， 判断 表单提交过来的信息 是否是 普通文本信息 另做处理 6） 第一种. 用第三方
 *         提供的 item.write( new File(path,filename) ); 直接写到磁盘上 第二种. 手动处理
 * 
 */
public class VedioUploadServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); // 设置编码
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


		// 获得磁盘文件条目工厂
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 获取文件需要上传到的路径
		String path = request.getSession().getServletContext().getRealPath("");
		HttpSession session = request.getSession();
		String folder = (String) session.getAttribute("userid");
		String vediopath = path + "/veyePicture/artwork/" + folder;
		System.out.println(vediopath);
		
		String successmessage="上传成功!";
		String failmessage="上传失败,请上传12M以内的mp4文件";

		
		PrintWriter out = response.getWriter();
		
		// 如果没以下两行设置的话，上传大的 文件 会占用 很多内存，
		// 设置暂时存放的 存储室 , 这个存储室，可以和 最终存储文件 的目录不同
		/**
		 * 原理 它是先存到 暂时存储室，然后在真正写到 对应目录的硬盘上， 按理来说 当上传一个文件时，其实是上传了两份，第一个是以 .tem
		 * 格式的 然后再将其真正写到 对应目录的硬盘上
		 */
		//	factory.setRepository(new File(vediopath));
		// 设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室
		// factory.setSizeThreshold(1024*1024) ;

		// 高水平的API文件上传处理
		ServletFileUpload upload = new ServletFileUpload(factory);

		try {
			// 可以上传多个文件
			List<FileItem> list = (List<FileItem>) upload.parseRequest(request);

			for (FileItem item : list) {
				// 获取表单的属性名字

				long size = item.getSize();
				String vedioname=item.getName();
				
				if (size < 12582912 && (vedioname.indexOf("mp4")>0 || vedioname.indexOf("MP4")>0 )) {

					System.out.println("size=" + size);

					// 截取 上传文件的 字符串名字，加1是 去掉反斜杠，
					String filename = "main.mp4";

					// 真正写到磁盘上
					// 它抛出的异常 用exception 捕捉

					item.write(new File(vediopath, filename));// 写入文件
					
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
