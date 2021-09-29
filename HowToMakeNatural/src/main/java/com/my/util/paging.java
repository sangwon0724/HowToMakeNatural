package com.my.util;

import java.util.HashMap;

public class paging {
	public HashMap<String, Object> settingPaging(String mode, int count){
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		switch (mode) {
		case "blog_post":
			result.put("count", count);
			break;

		default:
			break;
		}
		
		return result;
	}
}
