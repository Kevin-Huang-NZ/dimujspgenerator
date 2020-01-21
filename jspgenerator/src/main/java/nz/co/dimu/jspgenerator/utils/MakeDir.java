package nz.co.dimu.jspgenerator.utils;

import java.io.File;

public class MakeDir {
	public static String makeByPackage(String packageName, String baseDir){
		if (baseDir == null || baseDir.trim().length() == 0) {
			return null;
		}
		
		if (packageName == null || packageName.trim().length() == 0) {
			return null;
		}
		String path = baseDir;
		String[] dirs = packageName.split("\\.");
		for (String dir : dirs) {
			if (dir.trim().length() > 0) {
				path = path + "/" + dir;
			}
		}
		File direction = new File(path); 
		if (!direction.exists()) {
			direction.mkdirs();
		}
		
		return path;
	}
	
	public static String make(String folders, String baseDir){
		if (baseDir == null || baseDir.trim().length() == 0) {
			return null;
		}
		
		if (folders == null || folders.trim().length() == 0) {
			return null;
		}
		String path = baseDir + "/" + folders;
		File direction = new File(path); 
		if (!direction.exists()) {
			direction.mkdirs();
		}
		
		return path;
	}
	
//	public static void main(String[] args) {
//		MakeDir.makeByPackage("aa.bb", "D:/program/eclipse-ws/tool/generated");
//	}
}
