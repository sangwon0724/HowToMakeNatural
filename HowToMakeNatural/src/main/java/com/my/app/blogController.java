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
	//1-1. 세션값 확인을 통한 이웃새글 파트 추가
	//1-2. 세션값 확인을 통한 내정보 파트 및 로그인 파트 추가
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
	public String getMainPostList(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "") String category,  Model model) throws Exception {
		
		System.out.println("블로그 메인");
		
		List<blogVO> postList;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page*10);
		map.put("category", category);
		
		postList=blogService.selectAllPost(map); //게시글 10개
		int count = blogService.selectCount(map); //게시글 총 개수
		
		model.addAttribute("postList", postList);
		model.addAttribute("count", count);
		
	    return "/blog/main";
	}
	
	/* 블로그 메인 글 가져오기 - Ajax */
	@ResponseBody
	@RequestMapping(value = "/blog/main/Ajax", method = RequestMethod.POST)
	public List<blogVO> getMainPostListAjax(blogVO blog,  Model model) throws Exception {
		
		System.out.println("Ajax 요청 - 블로그 메인 / 요청 카테고리 : "+blog.getCategory());
		
		List<blogVO> postList;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", blog.getPage()*10);
		map.put("category", blog.getCategory());
		postList=blogService.selectAllPost(map);
		
	    return postList;
	}
}
