package manage;

import java.io.File;
import java.util.Calendar;
import java.util.Random;
import java.util.Date;  
import java.text.ParseException;
import java.text.SimpleDateFormat;  
public class CreateArtistFile {

	/**
	 * ����Ŀ¼
	 * 
	 * @param destDirName
	 *            ·��
	 * @return
	 */
	public static boolean createDir(String destDirName) {
		File dir = new File(destDirName);
		File[] files = dir.listFiles();
		if (dir.exists()) {
			System.out.println("����Ŀ¼" + destDirName + "ʧ�ܣ�Ŀ��Ŀ¼�Ѵ��ڣ�");
			return false;
		}
		if (!destDirName.endsWith(File.separator))
			destDirName = destDirName + File.separator;
		// ��������Ŀ¼
		if (dir.mkdirs()) {
			System.out.println("����Ŀ¼" + destDirName + "�ɹ���");
			return true;
		} else {
			System.out.println("����Ŀ¼" + destDirName + "�ɹ���");
			return false;
		}
	}

	/*
	 * ����½�Ŀ¼��·����
	 */
	public static String getNewDirName() {
		 
		Calendar now = Calendar.getInstance();
		//���������
		Random rand = new Random();
		int i = rand.nextInt();
		i = rand.nextInt(100000);
		i = (int) (Math.random() * 100000);
		//���ɵ�ǰ����

		Date d = new Date();
		System.out.println(d);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateNowStr = sdf.format(d);
		
		// ����Ŀ¼
		String dirName = "" +dateNowStr +"_"+ i;
		
		System.out.println("����Ŀ¼Ϊ"+dirName);
	
		return dirName;
	}
	

/*public static void main(String[] args) {
	String name = null;
	name=getNewDirName();
	System.out.println("����Ŀ¼Ϊ"+name);


}*/



	





}


