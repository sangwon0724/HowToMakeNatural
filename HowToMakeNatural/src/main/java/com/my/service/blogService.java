package com.my.service;

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

	@Override
	public List<blogVO> selectAllPost(Map<String, Object> map) throws Exception {
		return dao.selectAllPost(map);
	}

	@Override
	public List<blogVO> selectPost(String category) throws Exception {
		return dao.selectPost(category);
	}

	@Override
	public blogVO selectOnePost(int no) throws Exception {
		return dao.selectOnePost(no);
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

	@Override
	public void deleteCategory(blogVO vo) throws Exception {
		dao.deleteCategory(vo);
	}
}
