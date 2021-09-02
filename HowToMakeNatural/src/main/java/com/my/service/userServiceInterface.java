package com.my.service;

import javax.servlet.http.HttpSession;

public interface userServiceInterface {
	//logout
	public void logout(HttpSession session) throws Exception;
}