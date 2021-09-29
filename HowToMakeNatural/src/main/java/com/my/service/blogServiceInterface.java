package com.my.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface blogServiceInterface {
	//select
	public List<HashMap<String, Object>> selectPost(Map<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectCategory(Map<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectnNeighbor(Map<String, Object> map) throws Exception;
	
	//insert
	public void insertPost(Map<String, Object> map) throws Exception;
	
	//update
	public void updatePost(Map<String, Object> map) throws Exception;
	
	//delete
	public void deletePost(Map<String, Object> map) throws Exception;
}
