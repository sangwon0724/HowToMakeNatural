package com.my.util;

import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ThumbnailMaker {
    //System.out.println(matcher.group(0)); //이미지 태그 자체를 출력
    //System.out.println(matcher.group(1)); //이미지 태그의 src만 출력
	
	//단일 썸네일용
	public List<HashMap<String, Object>> setThumbnail (List<HashMap<String, Object>> mapList){
		for (HashMap<String, Object> map : mapList) {
			String text = map.get("content").toString(); //게시글의 내용 가져오기
	        Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); //img 태그 src 추출 정규표현식
	        Matcher matcher = pattern.matcher(text);

	        String thumbnail_text =  "";

	        if(matcher.find()){
	        	thumbnail_text = matcher.group(1);
	        }
	        
	        map.put("thumbnail", thumbnail_text); //map에 썸네일 배열 추가
		}
		
		return mapList;
	} //단일용 종료
	
	//복수 썸네일용
	public List<HashMap<String, Object>> setThumbnails (List<HashMap<String, Object>> mapList){
		for (HashMap<String, Object> map : mapList) {
			String text = map.get("content").toString(); //게시글의 내용 가져오기
	        Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>"); //img 태그 src 추출 정규표현식
	        Matcher matcher = pattern.matcher(text);
	        
	        String thumbnail_text =  ""; //배열로 만들어서 반환시킬 문자열
	        String[] thumbnail_array;

	        //split을 위한 연결 문자 추가
	        while(matcher.find()){
	        	thumbnail_text = thumbnail_text + matcher.group(1) + "_";
	        }
	        
	        //배열 만들기
	        thumbnail_array = thumbnail_text.split("_");
	        
	        map.put("thumbnail", thumbnail_array); //map에 썸네일 배열 추가
	        
	        /* <c:forEach var="thumbnail" items="${post.thumbnail}" begin="0" end="${fn:length(post.thumbnail)}">
            		<img class="post_images" src="${thumbnail}" onclick="location.href='/blog/${post.userID}/${post.no}'">
     		   </c:forEach> */
		}
		
		return mapList;
	} //복수용 종료
} //클래스 종료