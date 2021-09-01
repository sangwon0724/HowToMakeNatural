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
	//==========할 일 목록==========
	//1. 블로그 메인 기본 틀 완성
	//2. 개인 블로그 추가 (주소 : "/blog/유저아이디")
	//3. view 기능 추가 (주소 : "/blog/유저아이디/게시글번호")
	//4. write 기능 추가 (작성 전 주소 : "/blog/유저아이디/write" => 작성 후 주소 : "/blog/유저아이디")
	//5. update 기능 추가  (수정 시 주소 : "/blog/유저아이디/게시글번호/update" => 수정 후 주소 : "/blog/유저아이디/게시글번호")
	//6. delete 기능 추가 (삭제 전 주소 : "/blog/유저아이디/게시글번호/delete" => 삭제 후 주소 : "/blog/유저아이디/")
	//7. 페이징 기능 추가
	//8. 이웃 관련 기능 추가
	
	//==========완료 목록==========
	
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
