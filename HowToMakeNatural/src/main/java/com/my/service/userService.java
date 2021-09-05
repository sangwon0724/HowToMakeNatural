package com.my.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dao.userDAOInterface;
import com.my.vo.userVO;

@Service
public class userService  implements userServiceInterface{
	@Autowired
    private userDAOInterface dao;
	
	//logout
	@Override
	public void logout(HttpSession session) throws Exception {
		session.invalidate();
	}

	/* 개인 블로그 입장시 해당 유저의 정보 가져오기 */
	@Override
	public userVO selectUserInfoForBlog(String id) throws Exception {
		return dao.selectUserInfoForBlog(id);
	}
}