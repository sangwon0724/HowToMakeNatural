package com.my.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dao.userDAOInterface;

@Service
public class userService  implements userServiceInterface{
	@Autowired
    private userDAOInterface dao;
	
	//logout
	@Override
	public void logout(HttpSession session) throws Exception {
		session.invalidate();
	}
}