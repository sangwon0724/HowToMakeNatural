package com.my.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class userDAO implements userDAOInterface {
	@Autowired
    private SqlSession sqlSession;
	
	//===========================================================<<< select >>>============================================================================

	/* 개인 블로그 입장시 해당 유저의 정보 가져오기 */
	@Override
	public HashMap<String, Object> selectUserInfoForBlog(String id) throws Exception {
		return sqlSession.selectOne("userMapper.selectUserInfoForBlog", id);
	}
	
	//===========================================================<<< update >>>============================================================================
	
	/* 블로그 정보 변경 */
	@Override
	public void updateUserProfile(HashMap<String, Object> map) throws Exception {
		sqlSession.update("userMapper.updateUserProfile", map);
	}

	/* 블로그 배경 변경 */
	@Override
	public void updateBlogBackground(HashMap<String, Object> map) throws Exception {
		sqlSession.update("userMapper.updateBlogBackground", map);
	}
}
