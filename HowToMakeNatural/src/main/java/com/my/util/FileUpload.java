package com.my.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUpload {
	//Folder.mkdir() => 해당 디렉토리가 없을 때 해당 경로의 부모 디렉터리가 존재하지 않으면 폴더를 생성하지 않는다.
	//Folder.mkdirs() => 해당 디렉토리가 없을때 해당 경로의 부모 디렉터리가 존재하지 않으면 부모 디렉터리까지 함께 폴더를 생성한다.
	
	//inputStream을 통한 업로드 방식
	//1. File targetFile = new File(파일 업로드 경로 + 파일명);
	//2. try-catch문 작성
	//3. try문 안에서 InputStream fileStream = mf.getInputStream(); 작성
	//4. try문 안에서 FileUtils.copyInputStreamToFile(fileStream, targetFile); 작성
	
	/* 단일 파일 업로드 - 필요한 경우를 대비하여 파일명을 결과값으로 리턴 */
	public String fileUpload(MultipartHttpServletRequest request, String uploadRoot, String fileName) throws Exception {
		MultipartFile mf = request.getFile(fileName); //ajax에서 이름을 주었던 대로 MultipartFile 객체에 저장
		
    	String originalFileName = new String(mf.getOriginalFilename().getBytes("8859_1"),"utf-8"); //원본 파일명, 한글깨짐방지
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		try {
        	mf.transferTo(new File(uploadRoot + savedFileName)); //InputStream를 사용하지 않고 쉽게 저장하는 방법
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
		
		return savedFileName;
	}
	
	/* 폴더 존재 여부 확인 및 생성 */
	public void checkFolder(String root) {
		//폴더 존재 여부 확인
 		File Folder = new File(root); //필요한 경로에 폴더가 존재 하는 지 확인용 (확인 이유 : MultipartFile.transferTo 메소드는 해당 경로에 폴더가 없으면 오류가 발생한다.)
 		
    	// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
    	if (!Folder.exists()) {
			try{
			    Folder.mkdirs(); //폴더 생성합니다.
			    System.out.println("폴더가 생성되었습니다.");
	        } 
	        catch(Exception e){
	        	e.getStackTrace();
	        }        
        }
    	else {
    		System.out.println("이미 폴더가 생성되어 있습니다.");
    	}
	}
}
