package com.my.app;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.service.blogServiceInterface;
import com.my.vo.blogVO;

@Controller
public class blogController {
	@Autowired
    private SqlSession sqlSession;
	
	@Inject
	private blogServiceInterface blogService;
	
	/* 블로그 메인 */
	@RequestMapping(value = "/blog/main", method = RequestMethod.GET)
	public String getBoardList(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "") String category,  Model model) throws Exception {
		List<blogVO> postList;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page*10);
		map.put("category", category);
		postList=blogService.selectAllPost(map);
		
		model.addAttribute("postList", postList);
		
	    return "/blog/main";
	}
}
