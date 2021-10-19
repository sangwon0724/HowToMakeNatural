package com.my.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface BlogServiceInterface {
	//select
	public List<HashMap<String, Object>> selectPost(Map<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectComment(Map<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectCategory(Map<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectNeighbor(Map<String, Object> map) throws Exception;
	public int checkMyNeighbor(Map<String, Object> map) throws Exception;
	public int selectGood(Map<String, Object> map) throws Exception;
	public int checkMyGood(Map<String, Object> map) throws Exception;
	
	//insert
	public void insertPost(Map<String, Object> map) throws Exception;
	public void insertComment(Map<String, Object> map) throws Exception;
	public void insertNeighbor(Map<String, Object> map) throws Exception;
	public void insertGood(Map<String, Object> map) throws Exception;
	
	//update
	public void updatePost(Map<String, Object> map) throws Exception;
	public void updateComment(Map<String, Object> map) throws Exception;
	
	//delete
	public void deletePost(Map<String, Object> map) throws Exception;
	public void deleteComment(Map<String, Object> map) throws Exception;
	public void deleteNeighbor(Map<String, Object> map) throws Exception;
	public void deleteGood(Map<String, Object> map) throws Exception;
}
