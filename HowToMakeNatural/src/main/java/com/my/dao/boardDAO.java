package com.my.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.vo.boardVO;

public class boardDAO implements boardDAOInterface {
	@Autowired
    private SqlSession sqlSession;
	
	@Override
	public List<boardVO> selectPost(String category) throws Exception {
		return sqlSession.selectList("boardMapper.selectPost",category);
	}

	@Override
	public boardVO selectOnePost(int no) throws Exception {
		return sqlSession.selectOne("boardMapper.selectOnePost",no);
	}

	@Override
	public void insertPost(boardVO vo) throws Exception {
		sqlSession.insert("boardMapper.insertPost", vo);
	}

	@Override
	public void updatePost(boardVO vo) throws Exception {
		sqlSession.update("boardMapper.updatePost", vo);
	}

	@Override
	public void deletePost(boardVO vo) throws Exception {
		sqlSession.delete("boardMapper.deletePost", vo);
	}

	@Override
	public void deleteCategory(boardVO vo) throws Exception {
		sqlSession.delete("boardMapper.deleteCategory", vo);
	}
}
