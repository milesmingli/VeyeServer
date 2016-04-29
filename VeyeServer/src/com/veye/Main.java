package com.veye;

import org.im4java.core.ConvertCmd;
import org.im4java.core.IMOperation;


public class Main {
   public static void main( String[] args )
   {
      try{
    	  
    	   
    	  ConvertCmd cmd = new ConvertCmd();
    	  cmd.setSearchPath("C:\\Program Files (x86)\\ImageMagick-6.8.5-Q16");
    	  
    	  IMOperation op = new IMOperation();
    	  op.addImage("C:\\Users\\ming\\Desktop\\non\\1.png");
    	  
    	  
    	  op.brightnessContrast(0.0, 45.0);
    	  op.normalize();
    	  

    	  op.addImage("C:\\Users\\ming\\Desktop\\non\\1.jpg");

    	  // execute the operation
    	  cmd.run(op);
    	  

         
      }catch (Exception e) {
    	  e.printStackTrace();
      }
   }
}