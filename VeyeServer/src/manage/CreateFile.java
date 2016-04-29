package manage;

import java.io.File;

public class CreateFile {

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
	public static String getNewDirName(String name) {
	
		// 创建目录
		String dirName = name;
		
		//创建新对象
			
		
		return dirName;
	}

public static void main(String[] args) {
	
	String []boyfriendforxiaoying={"高富帅","矮矬穷","屌丝","男神"};

		System.out.println("小颖的男朋友是一个："+boyfriendforxiaoying[(int)(0+Math.random()*4)]);

	
}
}
