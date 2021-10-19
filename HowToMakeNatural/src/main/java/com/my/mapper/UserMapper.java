package com.my.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface UserMapper {
	//select
	public HashMap<String, Object> selectUserInfoForBlog(String id) throws Exception;
	
	//update
	public void updateUserProfile(HashMap<String, Object> map) throws Exception;
	public void updateBlogBackground(HashMap<String, Object> map) throws Exception;
}