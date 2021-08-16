package com.my.dao;

import java.util.List;

import com.my.vo.boardVO;

public interface boardDAOInterface {
	public List<boardVO> selectPost(String category) throws Exception;
	public boardVO selectOnePost(int no) throws Exception;
	public void insertPost(boardVO vo) throws Exception;
	public void updatePost(boardVO vo) throws Exception;
	public void deletePost(boardVO vo) throws Exception;
	public void deleteCategory(boardVO vo) throws Exception;
}
