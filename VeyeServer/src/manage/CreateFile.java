package manage;

import java.io.File;

public class CreateFile {

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
	public static String getNewDirName(String name) {
	
		// ����Ŀ¼
		String dirName = name;
		
		//�����¶���
			
		
		return dirName;
	}

public static void main(String[] args) {
	
	String []boyfriendforxiaoying={"�߸�˧","������","��˿","����"};

		System.out.println("Сӱ����������һ����"+boyfriendforxiaoying[(int)(0+Math.random()*4)]);

	
}
}
