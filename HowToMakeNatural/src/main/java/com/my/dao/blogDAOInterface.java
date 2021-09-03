package com.my.dao;

import java.util.List;
import java.util.Map;

import com.my.vo.blogVO;

public interface blogDAOInterface {
	//select
	public List<blogVO> selectPost(Map<String, Object> map) throws Exception;
	public int selectCount(Map<String, Object> map) throws Exception;
	public blogVO selectOnePost(int no) throws Exception;
	
	//insert
	public void insertPost(blogVO vo) throws Exception;
	
	//update
	public void updatePost(blogVO vo) throws Exception;
	
	//delete
	public void deletePost(blogVO vo) throws Exception;
}
