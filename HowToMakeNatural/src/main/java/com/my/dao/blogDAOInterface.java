package com.my.dao;

import java.util.List;
import java.util.Map;

import com.my.vo.blogVO;

public interface blogDAOInterface {
	public List<blogVO> selectAllPost(Map<String, Object> map) throws Exception;
	public List<blogVO> selectPost(String category) throws Exception;
	public blogVO selectOnePost(int no) throws Exception;
	public void insertPost(blogVO vo) throws Exception;
	public void updatePost(blogVO vo) throws Exception;
	public void deletePost(blogVO vo) throws Exception;
	public void deleteCategory(blogVO vo) throws Exception;
}