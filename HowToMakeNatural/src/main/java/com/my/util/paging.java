package com.my.util;

import java.util.HashMap;

public class paging {
	public HashMap<String, Object> settingPaging(String mode, int count){
		System.out.println(mode);
		System.out.println(count);
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		switch (mode) {
		case "blog_post":
			result.put("count", count); //게시글 전체 개수
			result.put("page_total", count/5+1); //전체 페이지 수
			break;

		default:
			break;
		}
		
		return result;
	}
}
