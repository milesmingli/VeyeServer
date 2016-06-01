package manage;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.veye.Constants;

import manage.target.PostNewTarget;

public class UploadArtWorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * Constructor of the object.
	 */
	public UploadArtWorkServlet() {
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
		System.out.println("开始执行");
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
		//System.out.println("执行123");
		PrintWriter out = response.getWriter();
		
		String returnMsg = "执行成功";
		

		String userid=request.getParameter("userid");
		System.out.println("userid="+userid);
		String RsStream=request.getParameter("RsStream");
		//System.out.println("RsStream="+RsStream);

		String name=request.getParameter("name");
		//System.out.println("name="+name);
	
		String artist=request.getParameter("artist");
		String artist1=request.getParameter("artist1");

		//System.out.println("执行1234");
		System.out.println("artist="+artist);
		
		String artistname=null;
		String artistid=null;
		if(artist!=null && artist!=""){
		 artistname=artist.split(",")[0];
		 artistid=artist.split(",")[1];
		}
		String artistname1=null;
		String artistid1=null;
		if(artist1!=null && artist1!=""){
		artistname1=artist1.split(",")[0];
		artistid1=artist1.split(",")[1];
			
		}

	
		
		//System.out.println("执行12345");
		String createtime=request.getParameter("createtime");
	
		//System.out.println("执行123456");
		String category=request.getParameter("category");
		
		String gallery=request.getParameter("gallery");
		String gallery1=request.getParameter("gallery1");
		String galleryname=null;
		String galleryid=null;
		if(gallery!=null && gallery!=""){
			 galleryname=gallery.split(",")[0];
			 galleryid=gallery.split(",")[1];
			
		}
		String galleryname1=null;
		String galleryid1=null;
		if(gallery1!=null && gallery1!=""){
			
			 galleryname1=gallery1.split(",")[0];
			 galleryid1=gallery1.split(",")[1];
		}

		
		
		//System.out.println(galleryname+galleryid+"----------");
		String brief=request.getParameter("brief");
		//System.out.println("执行ing");
		String size=request.getParameter("size");
		String size1=request.getParameter("size1");
		//System.out.println("正在执行");
		String price=request.getParameter("price");
		String agent=request.getParameter("agent");
		String agentphone=request.getParameter("agentphone");
		String agentmail=request.getParameter("agentmail");
		String issale=request.getParameter("issale");
		String stock=request.getParameter("stock");
		String imagetype=request.getParameter("imagetype");
		//String isupload=request.getParameter("isupload");
		String isupload="1";
		String tags=request.getParameter("tags");
		String targetName=null;
		String metadata=null;
		String type="artwork";
		String message=request.getParameter("message");
		String veyetype=request.getParameter("veyetype");
		String uploadtype=request.getParameter("uploadtype");

		//System.out.println(RsStream);
		//System.out.println(markerpic);
	

		String path = request.getSession().getServletContext().getRealPath("")
				.replaceAll("\\\\", "/");

		String Realpath = path + "/veyePicture/artwork/" + userid + "/original."+imagetype;
		String markerRealpath = path + "/veyePicture/artwork/" + userid + "/markerpic.jpg";

		String ImageResizePath=path + "/veyePicture/artwork/" + userid; 
		String relativepath = "/veyePicture/artwork/" + userid
				+ "/main."+imagetype;
		String thumbnail = "/veyePicture/artwork/" + userid
				+ "/thumb."+imagetype;
		
		String original = "/veyePicture/artwork/" + userid
				+ "/original."+imagetype;
		
		String markerimgpath=path + "/veyePicture/artwork/" + userid + "/thumb."+imagetype;
		String markerpicpath=path + "/veyePicture/artwork/" + userid + "/markerpic.jpg";
		String vediopath="";
		System.out.println(message);
		if(message.equals("1")){
			
			 vediopath = "/veyePicture/artwork/" + userid+"/main.mp4";

		}
		
		System.out.println("vediopath="+vediopath);
		Date d= new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(d);
		if(createtime.equals("")){
			
			createtime="1900-01-01";
			price="-1";
			stock="1";
		}
		
		
		
		String sql = null;
		String sql1="insert into status (id,status) values('"+userid+"',"+1+")";
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
			System.out.println("成功1");
		
			//将传来原始图的base64解码放到指定的文件夹内。
			Decoder.GenerateImage(RsStream, Realpath);
			System.out.println("成功3");
			
			
			
			ImageResizer.ImageResize(ImageResizePath,imagetype);
			System.out.println("成功4");
		
			
			// SQL语句
				targetName="A:"+userid;
				String imageLocation=markerpicpath;
				System.out.println("imageLocation="+imageLocation);

				metadata="{"+"'type':'"+type+"','id':'"+userid+"'}";
				
				float width= Float.parseFloat(size1);
			
				if(isupload.equals("1")){
					ImageConvert.ConvertImage(markerimgpath, markerpicpath);
					System.out.println("成功5");

					try {
						PostNewTarget.postTargetThenPollStatus(targetName, imageLocation, metadata,width);
					} catch (URISyntaxException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					String uniqueTargetId=PostNewTarget.GetuniqueTargetId();
					//String uniqueTargetId="";
					
				
						
						if(veyetype.equals("veyetype")){
							sql = "insert into artwork (id,name,artistid,artist,createtime,category,tags,brief,size,price,galleryid,gallery,agent,agentphone,agentemail,thumbnail,showpicture,originalpicture,issale,stock,ismarker,vedio,uniqueTargetId,type) values('";
							sql = sql +userid+"','"+name+"','"+artistid1+"','"+artistname1+"','"+createtime+"',"+category+",'"+tags+"','"+brief+"','"+size+"','"+price+"','"+galleryid1+"','"+galleryname1+"','"+agent+"','"+agentphone+"','"+agentmail+"','"+thumbnail+"','"+relativepath+"','"+original+"','"+issale+"','"+stock+"','"+isupload+"','"+vediopath+"','"+uniqueTargetId+"','"+uploadtype+"')";
							stmt.execute(sql);
						}else{
							sql = "insert into artwork (id,name,artistid,artist,createtime,category,tags,brief,size,price,galleryid,gallery,agent,agentphone,agentemail,thumbnail,showpicture,originalpicture,issale,stock,ismarker,vedio,uniqueTargetId,type) values('";
							sql = sql +userid+"','"+name+"','"+artistid+"','"+artistname+"','"+createtime+"',"+category+",'"+tags+"','"+brief+"','"+size+"','"+price+"','"+galleryid+"','"+galleryname+"','"+agent+"','"+agentphone+"','"+agentmail+"','"+thumbnail+"','"+relativepath+"','"+original+"','"+issale+"','"+stock+"','"+isupload+"','"+vediopath+"','"+uniqueTargetId+"','"+uploadtype+"')";
							}	
					
						
						
							
				}/*else{
					
					sql = "insert into artwork (id,name,artistid,artist,createtime,category,tags,brief,size,price,galleryid,gallery,agent,agentphone,agentemail,thumbnail,showpicture,originalpicture,issale,stock,ismarker,vedio) values('";
					sql = sql +userid+"','"+name+"','"+artistid+"','"+artistname+"','"+createtime+"',"+category+",'"+tags+"','"+brief+"','"+size+"','"+price+"','"+galleryid+"','"+galleryname+"','"+agent+"','"+agentphone+"','"+agentmail+"','"+thumbnail+"','"+relativepath+"','"+original+"','"+issale+"','"+stock+"','"+isupload+"','"+vediopath+"')";
					
					
				}*/
					System.out.println(sql);
		
					stmt.execute(sql);
					
					if(!message.equals("1")){
						System.out.println("无视频上传");
						stmt.execute(sql1);
					}
					

					stmt.close();
					stmt = null;
		
					conn.close();
					conn = null;
					System.out.println(Realpath+"999");
					System.out.println("veyetype="+veyetype);
					if(!veyetype.equals("veyetype")&& !veyetype.equals("seller_artist")){
						
						RequestDispatcher rd = request.getRequestDispatcher("/seller_organization/arrwork_artist.jsp?artistid="+artistid);
						rd.forward(request, response);
						
					}else if(veyetype.equals("seller_artist")){
						RequestDispatcher rd = request.getRequestDispatcher("/seller_artist/seller_artist.jsp?artistid="+artistid);
						rd.forward(request, response);
						
					}
				
		} catch (SQLException e) {
			returnMsg = "执行失败";
			out.print(returnMsg+":");
			out.print(e);
			
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
