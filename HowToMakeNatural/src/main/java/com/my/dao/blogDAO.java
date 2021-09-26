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
	
	/* 게시글 개수 가져요기 */
	@Override
	public int selectCount(Map<String, Object> map) throws Exception {
		int count=sqlSession.selectOne("blogMapper.selectCount", map);
		return count;
	}

	/* 카네고리 검색 */
	@Override
	public List<HashMap<String, Object>> selectCategory(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("blogMapper.selectCategory", map);
	}

	/* 이웃 검색 */
	@Override
	public List<HashMap<String, Object>> selectnNeighbor(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("blogMapper.selectNeighbor", map);
	}
	
	@Override
	public void insertPost(Map<String, Object> map) throws Exception {
		sqlSession.insert("blogMapper.insertPost", map);
	}

	@Override
	public void updatePost(Map<String, Object> map) throws Exception {
		sqlSession.update("blogMapper.updatePost", map);
	}

	@Override
	public void deletePost(Map<String, Object> map) throws Exception {
		sqlSession.delete("blogMapper.deletePost", map);
	}
}
