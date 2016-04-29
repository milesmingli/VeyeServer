package manage.exhibition;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
public class Readtxt {

 public static void main(String[] args) throws IOException, JSONException {


    	 

File file = new File("d:\\ximalaya\\原始文件不要删除.txt");

BufferedReader br = new BufferedReader(new FileReader(file));

String line = null;

while((line = br.readLine())!= null){ //一次读取一行

//System.out.println(line); 
String aa=line.replace("{","");
String bb=aa.replace("}","");
String cc=bb.replace("[","");
String dd=cc.replace("]","");
String ee=dd.replace("\"","");
String ff=ee.split("result:")[1];
String []gg=ff.split(",");
JSONArray array = new JSONArray(); 
JSONArray array1 = new JSONArray(); 


StringBuffer sb = new StringBuffer();
for(int i=0;i<gg.length;i++){
	sb.append(gg[i]);
	
}
//System.out.println(sb);

Pattern p = Pattern.compile("nickname(.*?)smallLogo");
Pattern p1 = Pattern.compile("amount(.*?)createdAt");
Matcher m = p.matcher(sb);
Matcher m1 = p1.matcher(sb);
String hh="";
String ii="";

while (!m.hitEnd() && m.find()) {
	JSONObject jsonObj = new JSONObject(); 

	hh=m.group(1).replace(":", "打赏人:");
	//System.out.println(hh);
    jsonObj.put(hh.split(":")[0], hh.split(":")[1]);
    array.put(jsonObj);
}


System.out.println("打赏总数为"+array.length()+"次 \n");


while (!m1.hitEnd() && m1.find()) {
	JSONObject jsonObj1 = new JSONObject();  

	ii=m1.group(1).replace(":", "打赏金额:");
	 jsonObj1.put(ii.split(":")[0], ii.split(":")[1]);  
	 array1.put(jsonObj1);
	  
	
}

String jj=array.toString();
String kk=array1.toString();
String ll="";
int a=(int)(1+Math.random()*(1000-1+1));
System.out.println(a);
File file1 = new File("d:\\ximalaya\\"+a+"提取结果.txt");
PrintStream ps = new PrintStream(new FileOutputStream(file1));
for(int k=0;k<array.length();k++){
	
	ll=/*k+1+":"+*/(jj.split(",")[k]+","+kk.split(",")[k]);
	String mm=ll.replace("{","");
	String nn=mm.replace("}","");
	String oo=nn.replace("[","");
	String pp=oo.replace("]","");
	String qq=pp.replace("\"","");
	
	 ps.println(qq); 		
	System.out.println(qq);
	
}


}

br.close(); 
    
    
    }
     

}
