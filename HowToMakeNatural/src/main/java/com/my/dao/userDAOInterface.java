package com.my.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface userDAOInterface {
	//select
	public HashMap<String, Object> selectUserInfoForBlog(String id) throws Exception;
}