package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dao.boardDAOInterface;
import com.my.vo.boardVO;

public class boardService implements boardServiceInterface {
	@Autowired
    private boardDAOInterface dao;

	@Override
	public List<boardVO> selectPost(String category) throws Exception {
		return dao.selectPost(category);
	}

	@Override
	public boardVO selectOnePost(int no) throws Exception {
		return dao.selectOnePost(no);
	}

	@Override
	public void insertPost(boardVO vo) throws Exception {
		dao.insertPost(vo);
	}

	@Override
	public void updatePost(boardVO vo) throws Exception {
		dao.updatePost(vo);
	}

	@Override
	public void deletePost(boardVO vo) throws Exception {
		dao.deletePost(vo);
	}

	@Override
	public void deleteCategory(boardVO vo) throws Exception {
		dao.deleteCategory(vo);
	}
}
