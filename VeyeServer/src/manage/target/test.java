package manage.target;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.Date;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import manage.target.SignatureBuilder;
import net.sf.json.JSONSerializer;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.cookie.DateUtils;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.IOException;  
import java.io.InputStream;  
import java.io.OutputStreamWriter;  
import java.net.HttpURLConnection;  
import java.net.URL;

import com.alibaba.fastjson.JSON;
import com.veye.Constants;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class test{

	public static String post(String strURL,String json){
		
		//System.out.println(json);
		//System.out.println(strURL);
		
		   try {  
	            URL url = new URL(strURL);// 创建连接  
	            HttpURLConnection connection = (HttpURLConnection) url  
	                    .openConnection();  
	            connection.setDoOutput(true);  
	            connection.setDoInput(true);  
	            connection.setUseCaches(false);  
	            connection.setInstanceFollowRedirects(true);  
	            connection.setRequestMethod("POST"); // 设置请求方式  
	            connection.setRequestProperty("Accept", "application/json"); // 设置接收数据的格式  
	            connection.setRequestProperty("Content-Type", "application/json"); // 设置发送数据的格式  
	            connection.connect();  
	            OutputStreamWriter out = new OutputStreamWriter(  
	                    connection.getOutputStream(), "UTF-8"); // utf-8编码  
	            out.append(json);  
	            out.flush();  
	            out.close();  
	         
	            // 读取响应  
	            int length = (int) connection.getContentLength();// 获取长度  
	            
	            InputStream is = connection.getInputStream();  
	           
	            if (length != -1) {  
	                byte[] data = new byte[length];  
	                byte[] temp = new byte[512];  
	                int readLen = 0;  
	                int destPos = 0;  
	                while ((readLen = is.read(temp)) > 0) {  
	                    System.arraycopy(temp, 0, data, destPos, readLen);  
	                    destPos += readLen;  
	                } 
	                
	                String result = new String(data, "UTF-8"); // utf-8编码  
	                System.out.println(result);  
	                return result;  
	            }  
	        } catch (IOException e) {  
	            // TODO Auto-generated catch block  
	            e.printStackTrace();  
	        }  
	        return "error"; // 自定义错误信息  
	    }  
	
	
	
	
	public static String generateSign(Map<String, String> map, String appKey,String appSecret) {
		// 按key(参数名称)进行排序
		Set<String> set =  map.keySet();
		String keys[] = new String[set.size()];
		set.toArray(keys);
		Arrays.sort(keys);

		StringBuffer sb = new StringBuffer();
		sb.append(appKey);
	
		for(int i=0;i<keys.length;i++){
			
			sb.append(map.get(keys[i]));
		
		}
		
		sb.append(appSecret);
		String str2 = new String(sb);  
	    System.out.println(str2);
	         

		return DigestUtils.md5Hex(sb.toString());
		

	} 
	


	public static void main(String[] args) throws URISyntaxException,
			ClientProtocolException, IOException, JSONException {
		
		 String Productname="小米插线板";
		 String AppKey = "200010";
		 String AppSecret ="100a0b10603e1a453dd84743123029ab";
		 String url ="http://api.simplybrand.com/QueryProductService/Query";
		 long TimeStamp = System.currentTimeMillis()/1000;
		
		 Map<String, String> map = new HashMap<String, String>();
		 
		 map.put("Keyword", Productname);
		 map.put("SiteId", "1");
		 map.put("TimeStamp", Long.toString(TimeStamp));
		 
		 String returnstr=generateSign(map,AppKey,AppSecret);
		 
		
		 
		// System.out.println(TimeStamp);
		 
		 JSONObject json= new JSONObject();
		 json.put("Appkey", AppKey);
		 
		 json.put("Sign", returnstr);
		 
		 json.put("Keyword", Productname);
		 
		 json.put("TimeStamp", TimeStamp);
		 
		 json.put("SiteId", 1);
		 
		  post(url, json.toString());
		 //System.out.println(json.toString());
		 
	}



}
