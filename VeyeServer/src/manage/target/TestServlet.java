package manage.target;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.json.JSONException;
import org.json.JSONObject;

public class TestServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TestServlet() {
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
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		 String Productname="小米插线板";
		 String AppKey = "200010";
		 String AppSecret ="100a0b10603e1a453dd84743123029ab";
		 String url ="http://api.simplybrand.com/QueryProductService/Query";
		
		 Map<String, String> map = new HashMap<String, String>();
		 
		 map.put("Productname", Productname);
		 
		 String returnstr=generateSign(map,AppKey,AppSecret);
		 
		 long TimeStamp = System.currentTimeMillis()/1000;
		 
		// System.out.println(TimeStamp);
		 
		 JSONObject json= new JSONObject();
		
		 try {
			 json.append("AppKey", AppKey);
			 json.append("Sign", returnstr);
			 json.append("Keyword", Productname);
			 json.append("TimeStamp", TimeStamp);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	
		 
		
		
		
		
		
		
		
		
	
		
		
		
		
	}
	
	public static String generateSign(Map<String, String> map, String appKey,	String appSecret) {
		// 按key(参数名称)进行排序

		Set<String> set =  map.keySet();
		String keys[] = new String[set.size()];
		set.toArray(keys);
		Arrays.sort(keys);
		
		StringBuffer sb = new StringBuffer();
		sb.append(appKey);

		for(Object key : keys){
			sb.append(keys);
		}
		sb.append(appSecret);
		return DigestUtils.md5Hex(sb.toString());

	} 
	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
