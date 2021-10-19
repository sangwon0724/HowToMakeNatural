package com.my.util;

import java.util.HashMap;

public class Paging {
	public HashMap<String, Object> settingPaging(String mode, HashMap<String, Object> map, int block){
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		int count=Integer.parseInt(map.get("count").toString());
		//Double orderNo=(Double) .doubleValue();
		
		switch (mode) {
			case "blog_post":
				//기준 : 블로그 게시글 , 블록 단위가 : 5
				result.put("count", count); //게시글 전체 개수
				result.put("page_total", (int)count/block+1); //전체 페이지 수
				result.put("page_current", Integer.parseInt(map.get("orderNo").toString())/block+1); //현재 페이지
				result.put("block_total", ((int)count/block+1)/10+1); //전체 블록 수
				result.put("block_current", (Integer.parseInt(map.get("orderNo").toString())/block+1)/10+1); //현재 블록
				break;
			case "blog_neighbor":
				//기준 : 블로그 게시글 , 블록 단위가 : 9
				result.put("count", count); //게시글 전체 개수
				result.put("page_total", (int)count/block+1); //전체 페이지 수
				break;
			default:
				break;
		}
		
		return result;
	}
}
