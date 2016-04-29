package manage.target;



import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Date;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.cookie.DateUtils;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.veye.Constants;


//See the Vuforia Web Services Developer API Specification - https://developer.vuforia.com/resources/dev-guide/updating-target-cloud-database

public class UpdateTarget {

	//Server Keys
	private static String accessKey = Constants.accessKey;
	private static String secretKey = Constants.secretKey;
		
	//private static String targetId = "c1f41225f6dc46cf9f0bbd457c3a9d34";
	private static String url = "https://vws.vuforia.com";
	//static float width=190;
	
	//static String metadata="{'type':'gallery','galleryid':'2015-11-06_64136'}";
	
	public static void updateTarget( String targetId ,String targetName,String metadata,float width) throws URISyntaxException, ClientProtocolException, IOException, JSONException {
		HttpPut putRequest = new HttpPut();
		HttpClient client = new DefaultHttpClient();
		putRequest.setURI(new URI(url + "/targets/" + targetId));
		JSONObject requestBody = new JSONObject();
		requestBody.put("name", targetName); // Mandatory
		requestBody.put("application_metadata", Base64.encodeBase64String(metadata.getBytes())); // Optional
		requestBody.put("width", width); // Mandatory
		setRequestBody(requestBody);
		putRequest.setEntity(new StringEntity(requestBody.toString()));
		setHeaders(putRequest); // Must be done after setting the body
		
		HttpResponse response = client.execute(putRequest);
		System.out.println(EntityUtils.toString(response.getEntity()));
	}
	
	public static void setRequestBody(JSONObject requestBody) throws IOException, JSONException {
		//requestBody.put("active_flag", true); // Optional
	

	}
	
	private static void setHeaders(HttpUriRequest request) {
		SignatureBuilder sb = new SignatureBuilder();
		request.setHeader(new BasicHeader("Date", DateUtils.formatDate(new Date()).replaceFirst("[+]00:00$", "")));
		request.setHeader(new BasicHeader("Content-Type", "application/json"));
		request.setHeader("Authorization", "VWS " + accessKey + ":" + sb.tmsSignature(request, secretKey));
	}
	
	public static void main(String[] args) throws URISyntaxException, ClientProtocolException, IOException, JSONException {
		UpdateTarget u = new UpdateTarget();
		float width=190;
		String metadata="{'type':'gallery','galleryid':'2015-11-06_62136'}";
		String targetId = "84a4bf7f05e143ebb179f228b4401566";
		String targetName="ghgyuh";
		u.updateTarget(targetId,targetName,metadata,width);
	}
}
