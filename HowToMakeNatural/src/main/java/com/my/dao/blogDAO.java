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
	public List<HashMap<String, Object>> selectNeighbor(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("blogMapper.selectNeighbor", map);
	}
	
	/* 이웃 여부 확인 */
	@Override
	public int checkMyNeighbor(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("blogMapper.checkMyNeighbor", map);
	};

	/* 좋아요 검색 */
	@Override
	public int selectGood(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("blogMapper.selectGood", map);
	}
	
	/* 좋아요 여부 확인 */
	@Override
	public int checkMyGood(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("blogMapper.checkMyGood", map);
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
	
	//이웃 추가
	@Override
	public void addNeighbor(Map<String, Object> map) throws Exception {
		sqlSession.insert("blogMapper.addNeighbor", map);
	}
	
	//좋아요 추가
	@Override
	public void addGood(Map<String, Object> map) throws Exception {
		sqlSession.insert("blogMapper.addGood", map);
	}
	
	
	

	//게시글 수정
	@Override
	public void updatePost(Map<String, Object> map) throws Exception {
		sqlSession.update("blogMapper.updatePost", map);
	}

	//댓글 수정
	@Override
	public void updateComment(Map<String, Object> map) throws Exception{
		sqlSession.update("blogMapper.updateComment", map);
	};
	
	
	

	//게시글 삭제
	@Override
	public void deletePost(Map<String, Object> map) throws Exception {
		sqlSession.update("blogMapper.deletePost", map);
	}
	
	//댓글 삭제
	@Override
	public void deleteComment(Map<String, Object> map) throws Exception{
		sqlSession.update("blogMapper.deleteComment", map);
	}
	
	//이웃 취소
	@Override
	public void cancleNeighbor(Map<String, Object> map) throws Exception {
		sqlSession.delete("blogMapper.cancleNeighbor", map);
	}

	//좋아요 취소
	@Override
	public void cancleGood(Map<String, Object> map) throws Exception {
		sqlSession.delete("blogMapper.cancleGood", map);
	}

}
