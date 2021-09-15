package com.my.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dao.blogDAOInterface;
import com.my.vo.blogVO;

@Service
public class blogService implements blogServiceInterface {
	@Autowired
    private blogDAOInterface dao;
	
	/* 메인에서 가장 최근글 10개 긁어오기 */
	@Override
	public List<HashMap<String, Object>> selectPost(Map<String, Object> map) throws Exception {
		return dao.selectPost(map);
	}
	
	/* 게시글 개수 가져요기 */
	@Override
	public int selectCount(Map<String, Object> map) throws Exception {
		return dao.selectCount(map);
	}

	/* 카테고리 검색 */
	@Override
	public List<HashMap<String, Object>> selectCategory(Map<String, Object> map) throws Exception {
		return dao.selectCategory(map);
	}
	
	/* 이웃 검색 */
	@Override
	public List<HashMap<String, Object>> selectnNeighbor(Map<String, Object> map) throws Exception {
		return dao.selectnNeighbor(map);
	}

	@Override
	public void insertPost(blogVO vo) throws Exception {
		dao.insertPost(vo);
	}

	@Override
	public void updatePost(blogVO vo) throws Exception {
		dao.updatePost(vo);
	}

	@Override
	public void deletePost(blogVO vo) throws Exception {
		dao.deletePost(vo);
	}
}
