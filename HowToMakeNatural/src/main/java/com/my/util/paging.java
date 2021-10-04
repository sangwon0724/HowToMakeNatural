package com.my.util;

import java.util.HashMap;

public class paging {
	public HashMap<String, Object> settingPaging(String mode, HashMap<String, Object> map){
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int count=Integer.parseInt(map.get("count").toString());
		//Double orderNo=(Double) .doubleValue();
		
		switch (mode) {
		case "blog_post":
			//블록의 단위가 5인 경우
			result.put("count", count); //게시글 전체 개수
			result.put("page_total", (int)count/5+1); //전체 페이지 수
			result.put("page_current", Integer.parseInt(map.get("orderNo").toString())/5+1); //현재 페이지
			result.put("block_total", ((int)count/5+1)/10+1); //전체 페이지 수
			result.put("block_current", (Integer.parseInt(map.get("orderNo").toString())/5+1)/10+1); //현재 블록
			break;

		default:
			break;
		}
		
		return result;
	}
}
