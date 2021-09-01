package com.my.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.vo.blogVO;

@Repository
public class blogDAO implements blogDAOInterface {
	@Autowired
    private SqlSession sqlSession;
	
	/* 메인에서 가장 최근글 10개 긁어오기 */
	@Override
	public List<blogVO> selectAllPost(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("blogMapper.selectAllPost", map);
	}
	
	@Override
	public List<blogVO> selectPost(String category) throws Exception {
		return sqlSession.selectList("blogMapper.selectPost",category);
	}

	@Override
	public blogVO selectOnePost(int no) throws Exception {
		return sqlSession.selectOne("blogMapper.selectOnePost",no);
	}

	@Override
	public void insertPost(blogVO vo) throws Exception {
		sqlSession.insert("blogMapper.insertPost", vo);
	}

	@Override
	public void updatePost(blogVO vo) throws Exception {
		sqlSession.update("blogMapper.updatePost", vo);
	}

	@Override
	public void deletePost(blogVO vo) throws Exception {
		sqlSession.delete("blogMapper.deletePost", vo);
	}

	@Override
	public void deleteCategory(blogVO vo) throws Exception {
		sqlSession.delete("blogMapper.deleteCategory", vo);
	}
}
