package manage;

import java.io.File;
import java.util.Calendar;
import java.util.Random;
import java.util.Date;  
import java.text.ParseException;
import java.text.SimpleDateFormat;  
public class CreateArtistFile {

	/**
	 * 创建目录
	 * 
	 * @param destDirName
	 *            路径
	 * @return
	 */
	public static boolean createDir(String destDirName) {
		File dir = new File(destDirName);
		File[] files = dir.listFiles();
		if (dir.exists()) {
			System.out.println("创建目录" + destDirName + "失败，目标目录已存在！");
			return false;
		}
		if (!destDirName.endsWith(File.separator))
			destDirName = destDirName + File.separator;
		// 创建单个目录
		if (dir.mkdirs()) {
			System.out.println("创建目录" + destDirName + "成功！");
			return true;
		} else {
			System.out.println("创建目录" + destDirName + "成功！");
			return false;
		}
	}

	/*
	 * 获得新建目录的路径名
	 */
	public static String getNewDirName() {
		 
		Calendar now = Calendar.getInstance();
		//生成随机数
		Random rand = new Random();
		int i = rand.nextInt();
		i = rand.nextInt(100000);
		i = (int) (Math.random() * 100000);
		//生成当前日期

		Date d = new Date();
		System.out.println(d);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateNowStr = sdf.format(d);
		
		// 创建目录
		String dirName = "" +dateNowStr +"_"+ i;
		
		System.out.println("生成目录为"+dirName);
	
		return dirName;
	}
	

/*public static void main(String[] args) {
	String name = null;
	name=getNewDirName();
	System.out.println("生成目录为"+name);


}*/



	





}


