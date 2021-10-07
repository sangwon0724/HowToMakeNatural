package com.my.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class blogDAO implements blogDAOInterface {
	@Autowired
    private SqlSession sqlSession;
	
	/* 메인에서 가장 최근글 10개 긁어오기 */
	@Override
	public List<HashMap<String, Object>> selectPost(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("blogMapper.selectPost", map);
	}
	
	/* 댓글 가져오기 */
	@Override
	public List<HashMap<String, Object>> selectComment(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("blogMapper.selectComment", map);
	}
	
	/* 카테고리 검색 */
	@Override
	public List<HashMap<String, Object>> selectCategory(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("blogMapper.selectCategory", map);
	}

	/* 이웃 검색 */
	@Override
	public List<HashMap<String, Object>> selectnNeighbor(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("blogMapper.selectNeighbor", map);
	}
	
	//게시글 추가
	@Override
	public void insertPost(Map<String, Object> map) throws Exception {
		sqlSession.insert("blogMapper.insertPost", map);
	}
	
	//댓글 추가
	@Override
	public void insertComment(Map<String, Object> map) throws Exception {
		sqlSession.insert("blogMapper.insertComment", map);
	}

	//게시글 수정
	@Override
	public void updatePost(Map<String, Object> map) throws Exception {
		sqlSession.update("blogMapper.updatePost", map);
	}

	//게시글 삭제
	@Override
	public void deletePost(Map<String, Object> map) throws Exception {
		sqlSession.delete("blogMapper.deletePost", map);
	}
}
