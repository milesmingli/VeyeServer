package manage;


import java.io.BufferedReader;  
import java.io.InputStreamReader;  
  
import org.im4java.core.ConvertCmd;
import org.im4java.core.IMOperation;
import org.im4java.process.ProcessStarter;


public class ImageConvert {
	
	public static  boolean ConvertImage( String imgpath,String savepath){
		
		boolean flag = false;
		
		 try{
	    	  ConvertCmd cmd = new ConvertCmd();
	    	  cmd.setSearchPath("C:\\Program Files (x86)\\ImageMagick-6.8.9-Q16");
	    	  
	    	  IMOperation op = new IMOperation();
	    	  op.addImage(imgpath);
	    	  op.brightnessContrast(0.0, 45.0);
	    	  op.normalize();
	    	  
	    	  System.out.println("savepath="+savepath);

	    	  String path =savepath.split("markerpic.")[0];
	    	  String realpath=path+"markerpic.jpg";
	    	 
	    	  op.addImage(realpath);

	    	  System.out.println("realpath="+realpath);
	    	  // execute the operation
	    	  cmd.run(op);
	    	  System.out.println("处理完成");
	         
	      }catch (Exception e) {
	    	  e.printStackTrace();
	      }
		
		return flag;
		
	}
	
   public static void main( String[] args ) {
	   
	   /*String path="C:\\imgTest\\14.";
	   String imgtype="jpg";
	   ImageConvert img = new ImageConvert();
	   
	   img.ConvertImage(path,imgtype);*/
   }
}