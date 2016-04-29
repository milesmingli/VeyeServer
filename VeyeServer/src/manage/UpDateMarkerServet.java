package manage;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import manage.target.PostNewTarget;

import org.json.JSONException;

import Decoder.BASE64Decoder;

import com.google.gson.JsonArray;
import com.veye.Constants;

public class UpDateMarkerServet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public UpDateMarkerServet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);

	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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

		PrintWriter out = response.getWriter();
		
		String returnMsg = "执行成功";
		String artwork=null;
		String artworkid=null;
		String gallery=null;
		String galleryid=null;
		String accountid=request.getParameter("accountid");
		String userid=request.getParameter("userid");
		String RsStream=request.getParameter("RsStream");
		String name=request.getParameter("name");
		String targetName=null;
		String metadata=null;
		String type=request.getParameter("type");
		String imagetype=request.getParameter("imagetype");

		if(type.equals("美术馆")){
			
			 gallery=request.getParameter("gallery").split(",")[0];
			 galleryid=request.getParameter("gallery").split(",")[1];
			 
			
			
		}else if(type.equals("作品")){
			 artwork=request.getParameter("artwork").split(",")[0];
			 artworkid=request.getParameter("artwork").split(",")[1];

		}
		
		String size=request.getParameter("size");
		String size1=request.getParameter("size1");
		

		System.out.println(name);
		

		//String RealRsStream = RsStream.replace("data:image/jpeg;base64,", "");

		String path = request.getSession().getServletContext().getRealPath("")
				.replaceAll("\\\\", "/");

		String Realpath = path + "/veyePicture/marker/" + userid + "/original."+imagetype;
		
		String ImageResizePath=path + "/veyePicture/marker/" + userid; 

		String relativepath = "/veyePicture/marker/" + userid
				+ "/main."+imagetype;
	
		String markerimgpath=path + "/veyePicture/marker/" + userid + "/thumb."+imagetype;
		String markerpicpath=path + "/veyePicture/marker/" + userid + "/markerpic.jpg";
		
		Decoder.GenerateImage(RsStream, Realpath);
		
		ImageResizer.ImageResize(ImageResizePath,imagetype);

		String sql = null;
		try {
			Class.forName("org.gjt.mm.mysql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("Class Not Found Exception ...");
		}
		// 连接URL

		Connection conn = null;
		Statement stmt = null;

		try {

			conn = DriverManager.getConnection(Constants.DB_URL,
					Constants.USER, Constants.PASS);
			stmt = conn.createStatement();
			// SQL语句
			
				if(type.equals("美术馆")){
					ImageConvert.ConvertImage(markerimgpath, markerpicpath);
					targetName="G:"+userid+"-"+galleryid;
					String imageLocation=markerpicpath;
					
					
					metadata="{"+"'type':"+"'gallery'"+",'id':'"+galleryid+"'}";
					
					float width= Float.parseFloat(size1);
					try {
						PostNewTarget.postTargetThenPollStatus(targetName, imageLocation, metadata,width);
						
						String uniqueTargetId=PostNewTarget.GetuniqueTargetId();
						
						sql = "insert into marker (id,type,owner,picture,arname,size,uniqueTargetId,userid) values('";
						sql = sql +userid+"','"+type+"','"+gallery+"','"+relativepath+"','G:"+userid+"-"+galleryid+"','"+size+"','"+uniqueTargetId+"',"+accountid+")";
						
					} catch (URISyntaxException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}					
				}/*else if(type.equals("作品")){
					sql = "insert into marker (id,type,owner,picture,arname,size) values('";
					sql = sql +userid+"','"+artwork+"','"+artworkid+"','"+relativepath+"','"+name+"','"+size+"')";
					
					targetName=artwork +"-"+artworkid;
					String imageLocation=Realpath;
					metadata="'{"+"type:"+artwork+",artworkid:"+galleryid+"}'";
					float width= Float.parseFloat(size1);
					try {
						PostNewTarget.postTargetThenPollStatus(targetName, imageLocation, metadata,width);
					} catch (URISyntaxException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}*/else{
					ImageConvert.ConvertImage(markerimgpath, markerpicpath);
					Random rand = new Random();
					int i = rand.nextInt();
					i = rand.nextInt(10000);
					i = (int) (Math.random() * 10000);
				
					
				
					targetName=type +"-"+i;
					String imageLocation=markerpicpath;
					metadata="{"+"'type':'"+type+"'}";
					float width= Float.parseFloat(size1);
					try {
						PostNewTarget.postTargetThenPollStatus(targetName, imageLocation, metadata,width);
						String uniqueTargetId=PostNewTarget.GetuniqueTargetId();
						sql = "insert into marker (id,type,picture,arname,size,uniqueTargetId) values('";
						sql = sql +userid+"','"+type+"','"+relativepath+"','"+type +"-"+i+"','"+size+"','"+uniqueTargetId+"')";
					} catch (URISyntaxException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
				
		
			System.out.println(sql);

			stmt.execute(sql);

			stmt.close();
			stmt = null;

			conn.close();
			conn = null;
			
			out.print(returnMsg+":");
		} catch (SQLException e) {
			returnMsg = "执行失败";
			out.print(returnMsg+":");
			System.out.println(e);
		} 
		
		
		finally {

			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException sqlex) {
					// ignore -- as we can't do anything about it here
				}

				stmt = null;
			}

			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqlex) {
					// ignore -- as we can't do anything about it here
				}

				conn = null;
			}
		}
		
		
		
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
