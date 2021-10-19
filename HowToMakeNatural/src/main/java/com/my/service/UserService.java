package com.my.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.mapper.UserMapper;

@Service
public class UserService  implements UserServiceInterface{
	@Autowired
    private UserMapper mapper;
	
	//===========================================================<<< select >>>============================================================================
	
	/* 개인 블로그 입장시 해당 유저의 정보 가져오기 */
	@Override
	public HashMap<String, Object> selectUserInfoForBlog(String id) throws Exception {
		return mapper.selectUserInfoForBlog(id);
	}
	
	//===========================================================<<< update >>>============================================================================
	
	/* 블로그 정보 변경*/
	@Override
	public void updateUserProfile(HashMap<String, Object> map) throws Exception {
		mapper.updateUserProfile(map);
	}
	
	/* 블로그 배경 변경 */
	@Override
	public void updateBlogBackground(HashMap<String, Object> map) throws Exception {
		mapper.updateBlogBackground(map);
	}
}