package manage;
import java.io.File;
public class DeletePic {
	
	/**
	 * 删除文件、文件夹
	 */
	@SuppressWarnings("restriction")
	public static void deleteFile(String path) {
		@SuppressWarnings("restriction")
		File file = new File(path);
		if (file.isDirectory()) {
			File[] ff = file.listFiles();
			for (int i = 0; i < ff.length; i++) {
				deleteFile(ff[i].getPath());
			}
		}
		file.delete();
	}

	public static void main(String[] args) {
		deleteFile("/veyePicture/artwork/2015-09-22_88311/main.jpg");
	}
	
	

}
