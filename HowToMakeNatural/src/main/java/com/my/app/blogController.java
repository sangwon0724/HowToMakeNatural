package com.my.app;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.service.blogServiceInterface;
import com.my.vo.blogVO;
import com.my.service.userServiceInterface;
import com.my.vo.userVO;

@Controller
public class blogController {
	//==========할 일 목록==========
	//3. view 기능 추가 (주소 : "/blog/유저아이디/게시글번호")
	//4. write 기능 추가 (작성 전 주소 : "/blog/유저아이디/write" => 작성 후 주소 : "/blog/유저아이디")
	//5. update 기능 추가  (수정 시 주소 : "/blog/유저아이디/게시글번호/update" => 수정 후 주소 : "/blog/유저아이디/게시글번호")
	//6. delete 기능 추가 (삭제 전 주소 : "/blog/유저아이디/게시글번호/delete" => 삭제 후 주소 : "/blog/유저아이디/")
	//7. 페이징 기능 추가
	//8. 이웃 관련 기능 추가
	//9. 내가 쓴 글 목록 가져오기 기능 추가
	//11. 게시글이 존재하지 않을 시 존재하지 않는다는 문구 추가
	//12. 블로그 메인에 대한 사진 작업
	
	//==========완료 목록==========
	//1. 블로그 메인 기본 틀 완성
	//1-1. 세션값 확인을 통한 이웃새글 파트 추가
	//1-2. 세션값 확인을 통한 내정보 파트 및 로그인 파트 추가
	//2. 개인 블로그 화면 추가 (주소 : "/blog/유저아이디")
	//10. 검색 기능 추가 (Ajax로 board 영역만 변경)
	
	@Autowired
    private SqlSession sqlSession;
	
	@Inject
	private blogServiceInterface blogService;
	
	@Inject
	private userServiceInterface userService;
	
	/* 블로그 메인 */
	@RequestMapping(value = "/blog/main", method = RequestMethod.GET)
	public String getMainPostList(Model model) throws Exception {
		
		System.out.println("블로그 메인");
		
		List<blogVO> postList;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", 0);
		map.put("category", "");
		
		postList=blogService.selectPost(map); //게시글 10개
		int count = blogService.selectCount(map); //게시글 총 개수
		
		model.addAttribute("postList", postList);
		model.addAttribute("count", count);
		
	    return "/blog/main";
	}
	
	/* 블로그 메인 글 가져오기 - Ajax */
	@ResponseBody
	@RequestMapping(value = "/blog/main/Ajax", method = RequestMethod.POST)
	public Map<String, Object> getMainPostListAjax(blogVO blog,  Model model) throws Exception {
		
		System.out.println("Ajax 요청 - 블로그 메인 / 요청 카테고리 : "+ blog.getCategory() + " / 검색 요청 항목 : " + blog.getObject() + " / 검색 요청 문자 : "+blog.getSearch_text());
		
		List<blogVO> postList;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", blog.getPage()-1); //MariaDB 특성때문에  - 1
		map.put("category", blog.getCategory());
		map.put("object", blog.getObject());
		map.put("search", blog.getSearch_text());
		
		postList=blogService.selectPost(map); //게시글 10개
		int count = blogService.selectCount(map); //게시글 총 개수
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("postList", postList);
		result.put("count", count);
		
	    return result;
	}
	
	/* 개인 블로그 - 방문하기 */
	@RequestMapping(value = "/blog/{userID}", method = RequestMethod.GET)
	public String getPersonalBlog(@PathVariable String userID, Model model) throws Exception {
		
		System.out.println("개인 블로그 - 유저 아이디 : " + userID);
		
		//게시글 긁어오기
		List<blogVO> postList;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", 0);
		map.put("category", "");
		map.put("userID", userID);
		
		postList=blogService.selectPost(map); //게시글 10개
		int count = blogService.selectCount(map); //게시글 총 개수
		
		//해당 블로그의 유저 정보 가져오기
		userVO userInfo=userService.selectUserInfoForBlog(userID);
		
		model.addAttribute("postList", postList);
		model.addAttribute("count", count);
		model.addAttribute("userInfo", userInfo);
	    return "/blog/personal";
	}
	
	/* 개인 블로그 - 게시글 한 개만 보기 */
	@RequestMapping(value = "/blog/{userID}/{no}", method = RequestMethod.GET)
	public String getPersonalPostView(@PathVariable String userID, @PathVariable int no, Model model) throws Exception {
		
		System.out.println("개인 블로그 - 유저 아이디 : " + userID + " / 게시글 번호 : "+ no);
		
		//게시글 긁어오기
		List<blogVO> postList;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", 0);
		map.put("category", "");
		map.put("userID", userID);
		map.put("no", no);
		
		postList=blogService.selectPost(map); //게시글 검색
		
		//해당 블로그의 유저 정보 가져오기
		userVO userInfo=userService.selectUserInfoForBlog(userID);
		
		model.addAttribute("postList", postList);
		model.addAttribute("userInfo", userInfo);
	    return "/blog/personal";
	}
}
