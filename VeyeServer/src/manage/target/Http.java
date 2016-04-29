package manage.target;


import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.apache.commons.codec.digest.DigestUtils;

public class Http {
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
	
	public static void main(String[] args) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("a", "123");
		map.put("c", "d");
		map.put("b", "232");
		System.out.println(generateSign(map, null, null));
	}
}
