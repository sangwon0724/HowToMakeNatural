package com.my.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

public interface UserServiceInterface {
	//logout
	public void logout(HttpSession session) throws Exception;
	
	//select
	public HashMap<String, Object> selectUserInfoForBlog(String id) throws Exception;
	
	//update
	public void updateUserProfile(HashMap<String, Object> map) throws Exception;
	public void updateBlogBackground(HashMap<String, Object> map) throws Exception;
}