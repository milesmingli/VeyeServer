package manage.target;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Date;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.cookie.DateUtils;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.veye.Constants;

// See the Vuforia Web Services Developer API Specification - https://developer.vuforia.com/resources/dev-guide/adding-target-cloud-database-api

public class PostNewTarget implements TargetStatusListener {

	// Server Keys
	private static String accessKey = Constants.accessKey;
	private static String secretKey = Constants.secretKey;

	private static String url = Constants.url;
/*	private static String targetName = "77";
	private static String imageLocation = "c:/222.jpg";
	private static String metadata = "{'type':'gallery','galleryid':'11'}";*/
	private static  TargetStatusPoller targetStatusPoller;
	private static String uniqueTargetId=null;
	
	private final static float pollingIntervalMinutes = 60;// poll at 1-hour interval

	/**
	 * Posts a new target to the Cloud database; then starts a periodic polling
	 * until 'status' of created target is reported as 'success'.
	 * 
	 * @throws URISyntaxException
	 * @throws JSONException
	 * @throws IOException
	 */
	public  static void  postTargetThenPollStatus(String targetName,String imageLocation,String metadata,float width) throws URISyntaxException,
			IOException, JSONException {
		
		System.out.println("targetName="+targetName);
		System.out.println("metadata="+metadata);

		HttpPost postRequest = new HttpPost();
	
		HttpClient client = new DefaultHttpClient();
		postRequest.setURI(new URI(url + "/targets"));
		JSONObject requestBody = new JSONObject();
	
		
		File imageFile = new File(imageLocation);
		if (!imageFile.exists()) {
			System.out.println("File location does not exist!");
			System.exit(1);
		}
		byte[] image = FileUtils.readFileToByteArray(imageFile);
		requestBody.put("name", targetName); // Mandatory
		requestBody.put("width", width); // Mandatory
	
		requestBody.put("image", Base64.encodeBase64String(image)); // Mandatory
		requestBody.put("active_flag", 1); // Optional
		requestBody.put("application_metadata",
				Base64.encodeBase64String(metadata.getBytes())); // Optional

		postRequest.setEntity(new StringEntity(requestBody.toString()));

		SignatureBuilder sb = new SignatureBuilder();
		postRequest.setHeader(new BasicHeader("Date", DateUtils.formatDate(
				new Date()).replaceFirst("[+]00:00$", "")));
		postRequest.setHeader(new BasicHeader("Content-Type",
				"application/json"));
		postRequest.setHeader(
				"Authorization",
				"VWS " + accessKey + ":"
						+ sb.tmsSignature(postRequest, secretKey));

		HttpResponse response = client.execute(postRequest);
	
		String responseBody = EntityUtils.toString(response.getEntity());
		System.out.println(responseBody);

		JSONObject jobj = new JSONObject(responseBody);

		 uniqueTargetId = jobj.has("target_id") ? jobj
				.getString("target_id") : "";
		System.out.println("\nCreated target with id: " + uniqueTargetId);

		// Poll the target status until the 'status' is 'success'
		// The TargetState will be passed to the OnTargetStatusUpdate callback
	
	
		if (uniqueTargetId != null && !uniqueTargetId.isEmpty()) {
			targetStatusPoller = new TargetStatusPoller(pollingIntervalMinutes,
					uniqueTargetId, accessKey, secretKey);
			targetStatusPoller.startPolling();
		}
	}
	// Called with each update of the target status received by the
	// TargetStatusPoller
	@Override
	public void OnTargetStatusUpdate(TargetState target_state) {
		if (target_state.hasState) {

			String status = target_state.getStatus();

			System.out.println("Target status is: "
					+ (status != null ? status : "unknown"));

			if (target_state.getActiveFlag() == true
					&& "success".equalsIgnoreCase(status)) {

				targetStatusPoller.stopPolling();

				System.out.println("Target is now in 'success' status");
			}
		}
	}
	public static String GetuniqueTargetId(){
		
		String id=uniqueTargetId;
	
		return id;
		
	}
	public static void main(String[] args) throws URISyntaxException,
			ClientProtocolException, IOException, JSONException {
		PostNewTarget p = new PostNewTarget();
		 String targetName = "gallery12s4ws39";
		 String imageLocation = "c:/99.png";
		 String metadata = "{'type':'gallery','id':'99'}";
		 float width=620f;
		 p.postTargetThenPollStatus(targetName,imageLocation,metadata,width);
		System.out.println(p.GetuniqueTargetId()+"≤‚ ‘--"); 
	}

}
