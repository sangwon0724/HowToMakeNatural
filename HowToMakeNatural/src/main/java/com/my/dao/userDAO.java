package com.my.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class userDAO implements userDAOInterface {
	@Autowired
    private SqlSession sqlSession;
}
