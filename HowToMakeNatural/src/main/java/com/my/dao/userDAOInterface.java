package com.my.dao;

import java.util.List;
import java.util.Map;

import com.my.vo.userVO;

public interface userDAOInterface {
	//select
	public userVO selectUserInfoForBlog(String id) throws Exception;
}