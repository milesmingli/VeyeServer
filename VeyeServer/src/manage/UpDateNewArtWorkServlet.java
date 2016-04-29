package manage;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.veye.Constants;

import manage.target.UpdateTarget;

public class UpDateNewArtWorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public UpDateNewArtWorkServlet() {
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
		
		String userid=request.getParameter("userid");
		//String RsStream=request.getParameter("RsStream");
		String name=request.getParameter("name");
	
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
		String createtime=request.getParameter("createtime");

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

		
		String brief=request.getParameter("brief");
		String size=request.getParameter("size");
		String size1=request.getParameter("size1");

		String price=request.getParameter("price");
		String agent=request.getParameter("agent");
		String agentphone=request.getParameter("agentphone");
		String agentemail=request.getParameter("agentemail");
		String issale=request.getParameter("issale");
		String stock=request.getParameter("stock");
		String imagetype=request.getParameter("imagetype");
		String isupload=request.getParameter("isupload");
		String targetId=request.getParameter("targetId");
		String tags=request.getParameter("tags");
		String targetName=null;
		String metadata=null;
		String type="artwork";
		String message=request.getParameter("message");
		String veyetype=request.getParameter("veyetype");
		System.out.println("message="+message);
		
		String path = request.getSession().getServletContext().getRealPath("")
				.replaceAll("\\\\", "/");

		String Realpath = path + "/veyePicture/artwork/" + userid + "/original."+imagetype;
		String ImageResizePath=path + "/veyePicture/artwork/" + userid; 
		String relativepath = "/veyePicture/artwork/" + userid
				+ "/main."+imagetype;
		String thumbnail = "/veyePicture/artwork/" + userid
				+ "/thumb."+imagetype;
		
		String original = "/veyePicture/artwork/" + userid
				+ "/original."+imagetype;

		String vediopath="";

		if(message.equals("1")){
			
			 vediopath = "/veyePicture/artwork/" + userid+"/main.mp4";

		}
		

		
		
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

					
					//if(RsStream==""||RsStream==null ){
			if(isupload.equals("1")){
				targetName="A:"+userid;
				String imageLocation=Realpath;
				metadata="{"+"'type':'"+type+"','id':'"+userid+"'}";

				float width= Float.parseFloat(size1);				
						if(message.equals("1")){
							if(veyetype.equals("veyetype")){

								sql = "update artwork set name='" + name +"', artistid='"+artistid1+"',artist='"+artistname1+"',brief='"+ brief+"',createtime='"+createtime+"' ,category=" +category+",tags='" +tags+"',size='" +size+"',price='" +price+"', galleryid='"+galleryid1+"',gallery='"+galleryname1+"',agent='"+agent+"',agentphone='"+agentphone+"',agentemail='"+agentemail+"',issale='"+issale+"',vedio='"+vediopath+"',stock='"+stock+"' where id="
										+"'"+ userid+"'";
								UpdateTarget.updateTarget(targetId, targetName,metadata, width);
							
							}else{
								

								sql = "update artwork set name='" + name +"', artistid='"+artistid+"',artist='"+artistname+"',brief='"+ brief+"',createtime='"+createtime+"' ,category=" +category+",tags='" +tags+"',size='" +size+"',price='" +price+"', galleryid='"+galleryid+"',gallery='"+galleryname+"',agent='"+agent+"',agentphone='"+agentphone+"',agentemail='"+agentemail+"',issale='"+issale+"',vedio='"+vediopath+"',stock='"+stock+"' where id="
										+"'"+ userid+"'";
								UpdateTarget.updateTarget(targetId, targetName,metadata, width);
							}
						
						
							
						}else{
						
							
							if(veyetype.equals("veyetype")){
								sql = "update artwork set name='" + name +"', artistid='"+artistid1+"',artist='"+artistname1+"',brief='"+ brief+"',createtime='"+createtime+"' ,category=" +category+",tags='" +tags+"',size='" +size+"',price='" +price+"', galleryid='"+galleryid1+"',gallery='"+galleryname1+"',agent='"+agent+"',agentphone='"+agentphone+"',agentemail='"+agentemail+"',issale='"+issale+"',vedio='"+vediopath+"',stock='"+stock+"' where id="
										+"'"+ userid+"'";
								UpdateTarget.updateTarget(targetId, targetName,metadata, width);
								
								
							}else{
								sql = "update artwork set name='" + name +"', artistid='"+artistid+"',artist='"+artistname+"',brief='"+ brief+"',createtime='"+createtime+"' ,category=" +category+",tags='" +tags+"',size='" +size+"',price='" +price+"', galleryid='"+galleryid+"',gallery='"+galleryname+"',agent='"+agent+"',agentphone='"+agentphone+"',agentemail='"+agentemail+"',issale='"+issale+"',vedio='"+vediopath+"',stock='"+stock+"' where id="
										+"'"+ userid+"'";
								UpdateTarget.updateTarget(targetId, targetName,metadata, width);
								
								
							}
							
						}
				
					

					}
					/*}else{
						
						sql = "update artwork set name='" + name +"', artistid='"+artistid+"',artist='"+artistname+"',brief='"+ brief+"',createtime='"+createtime+"' ,category='" +category+"',style='" +style+"',size='" +size+"',price='" +price+"', galleryid='"+galleryid+"',gallery='"+galleryname+"',agent='"+agent+"',agentphone='"+agentphone+"',agentemail='"+agentemail+"',issale='"+issale+"',stock='"+stock+"',thumbnail='"+thumbnail+"',showpicture='"+relativepath+"',originalpicture='"+original+"' where id="
								+"'"+ userid+"'";
						
						Decoder.GenerateImage(RsStream, Realpath);
						ImageResizer.ImageResize(ImageResizePath,imagetype);
					}*/	
			
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
			out.print(e);
			System.out.println(e);
		} catch (URISyntaxException e) {
			out.print(e);
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
