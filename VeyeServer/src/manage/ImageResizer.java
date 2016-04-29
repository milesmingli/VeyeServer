package manage;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.FileNotFoundException;  
import java.io.FileInputStream; 
import java.io.FileOutputStream; 
import java.math.*; 
import java.text.DecimalFormat;

import javax.imageio.ImageIO;

import net.coobird.thumbnailator.Thumbnails;

public class ImageResizer {


	
	public static void ImageResize(String FilePath , String imagetype) throws IOException,FileNotFoundException{
		
		File picture = new File(FilePath+"/original."+imagetype); 
		
		  System.out.println("picture="+picture);
		
		  BufferedImage sourceImg =ImageIO.read(new FileInputStream(picture));  
	    
		System.out.println(sourceImg.getWidth()); 
	    
	    float aa=(float)600/sourceImg.getWidth();
	    float bb=(float)1100/sourceImg.getWidth();
	    float cc=(float)sourceImg.getWidth()/sourceImg.getWidth();
	    float size = (float)(Math.round(aa*100))/100;
	    float bigsize = (float)(Math.round(bb*100))/100;
	    float originalsize=(float)(Math.round(cc*100))/100;
	    
	    System.out.println(size);
	    System.out.println(bigsize);
	    if(sourceImg.getWidth()>=1100){
	    Thumbnails.of(FilePath+"/original."+imagetype)   
		.scale(size)  
		.toFile(FilePath+"/thumb."+imagetype);
	   
	    Thumbnails.of(FilePath+"/original."+imagetype)   
	   	.scale(bigsize)  
	   	.toFile(FilePath+"/main."+imagetype);
	    }else if(sourceImg.getWidth()<1100 && sourceImg.getWidth()>=600){
	    	
	    	Thumbnails.of(FilePath+"/original."+imagetype)   
	  		.scale(size)  
	  		.toFile(FilePath+"/thumb."+imagetype);
	    	
	    	Thumbnails.of(FilePath+"/original."+imagetype)   
	  		.scale(originalsize)  
	  		.toFile(FilePath+"/main."+imagetype);
	    	
	    	
	    }else if(sourceImg.getWidth()<600){
	    	Thumbnails.of(FilePath+"/original."+imagetype)   
	  		.scale(originalsize)  
	  		.toFile(FilePath+"/thumb."+imagetype);
	    	
	    	Thumbnails.of(FilePath+"/original."+imagetype)   
	  		.scale(originalsize)  
	  		.toFile(FilePath+"/main."+imagetype);
	    	
	    }
	}
	
	
	/*public static void ImageResizeForMarker(String FilePath, String imagetype) throws IOException,FileNotFoundException{
		
		File picture = new File(FilePath+"/original."+imagetype);  
		  
		BufferedImage sourceImg =ImageIO.read(new FileInputStream(picture));  
	
	    float aa=(float)600/sourceImg.getWidth();
	    float bb=(float)1100/sourceImg.getWidth();

	    float size = (float)(Math.round(aa*100))/100;

	    System.out.println(size);
	    
	    Thumbnails.of(FilePath+"/original."+imagetype)   
		.scale(size)  
		.toFile(FilePath+"/main."+imagetype);
	 
	    boolean result = picture.delete();
	    
	    if(!result)
	    {

	     System.gc();//系统进行资源强制回收

	     picture.delete();

	    }

	}
	
	
	
	
	public static void ImageResizeForLittleMarker(String FilePath, String imagetype) throws IOException,FileNotFoundException{
		
		File picture = new File(FilePath+"/markerpic."+imagetype);  
		  
		BufferedImage sourceImg =ImageIO.read(new FileInputStream(picture));  
	
		
	    float aa=(float)600/sourceImg.getWidth();
	    float bb=(float)1100/sourceImg.getWidth();

	    float size = (float)(Math.round(aa*100))/100;
	    float bigsize = (float)(Math.round(bb*100))/100;

	    System.out.println(size);
	    System.out.println(bigsize);
	    
	    Thumbnails.of(FilePath+"/markerpic."+imagetype)   
		.scale(size)  
		.toFile(FilePath+"/marker."+imagetype);
	 
	    boolean result = picture.delete();
	    
	    if(!result)
	    {

	     System.gc();//系统进行资源强制回收

	     picture.delete();

	    }

	}*/
	
	
public static void main(String[] args) throws IOException,FileNotFoundException{
	
	
	File picture = new File("D:\\d.jpg");  
  
	BufferedImage sourceImg =ImageIO.read(new FileInputStream(picture));  
    
	System.out.println(sourceImg.getWidth()); 
    
    float aa=(float)600/sourceImg.getWidth();
    float bb=(float)1100/sourceImg.getWidth();

    float size = (float)(Math.round(aa*100))/100;
    float bigsize = (float)(Math.round(bb*100))/100;

    System.out.println(size);
    System.out.println(bigsize);
    
    Thumbnails.of("D:\\d.png")   
	.scale(size)  
	.toFile("D:\\ddd.png");
	
    Thumbnails.of("D:\\d.png")   
   	.scale(bigsize)  
   	.toFile("D:\\dddd.png");
	
}



}
