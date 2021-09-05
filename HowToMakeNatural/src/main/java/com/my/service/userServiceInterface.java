package com.my.service;

import javax.servlet.http.HttpSession;

import com.my.vo.userVO;

public interface userServiceInterface {
	//logout
	public void logout(HttpSession session) throws Exception;
	
	//select
	public userVO selectUserInfoForBlog(String id) throws Exception;
}