package manage;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Decoder {
	public static void main(String[] args) {
	System.out.println("Ӧ�ó�����ֲ��ɲ������쳣������ϵsun��˾����������");
	}

	public static String GetImageStr() {// ��ͼƬ�ļ�ת��Ϊ�ֽ������ַ��������������Base64���봦��
		String imgFile = "c:/test.png";// �������ͼƬ
		InputStream in = null;
		byte[] data = null;
		// ��ȡͼƬ�ֽ�����
		try {
			in = new FileInputStream(imgFile);
			data = new byte[in.available()];
			in.read(data);
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// ���ֽ�����Base64����
		BASE64Encoder encoder = new BASE64Encoder();
		System.out.println(encoder.encode(data));
		return encoder.encode(data);// ����Base64��������ֽ������ַ���
		
	}

	public static boolean GenerateImage(String imgStr,String path) {// ���ֽ������ַ�������Base64���벢����ͼƬ
		if (imgStr == null) // ͼ������Ϊ��
			return false;
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			// Base64����
			byte[] b = decoder.decodeBuffer(imgStr);
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {// �����쳣����
					b[i] += 256;
				}
			}
			// ����jpegͼƬ
	       
			String imgFilePath =path;// �����ɵ�ͼƬ
			OutputStream out = new FileOutputStream(imgFilePath);
			out.write(b);
			out.flush();
			out.close();
			System.out.println(path);
			return true;
		} catch (Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public static boolean SaveVedio(String imgStr,String path) {
		
		
	/*	String imgFilePath =path;// �����ɵ�ͼƬ
		try {
			
			OutputStream out = new FileOutputStream(imgFilePath);
			out.write(imgStr.getBytes());
			out.flush();
			out.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
		
		return false;
		
	}
	
	

}