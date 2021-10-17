package com.my.service;

import java.util.HashMap;

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

	
	//===========================================================<<< select >>>============================================================================
	
	/* 개인 블로그 입장시 해당 유저의 정보 가져오기 */
	@Override
	public HashMap<String, Object> selectUserInfoForBlog(String id) throws Exception {
		return dao.selectUserInfoForBlog(id);
	}
	
	//===========================================================<<< update >>>============================================================================
	
	/* 블로그 정보 변경*/
	@Override
	public void updateUserProfile(HashMap<String, Object> map) throws Exception {
		dao.updateUserProfile(map);
	}

	/* 블로그 배경 변경 */
	@Override
	public void updateBlogBackground(HashMap<String, Object> map) throws Exception {
		dao.updateBlogBackground(map);
	}
}