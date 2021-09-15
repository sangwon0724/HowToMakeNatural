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
}
