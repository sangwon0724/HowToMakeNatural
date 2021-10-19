package com.my.app;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.service.UserServiceInterface;

@Controller
public class UserController {
	//==========할 일 목록==========
	//1. 로그인 페이지 구체화
	//1-1. 영어 및 숫자만 입력되도록 함수 추가
	//1-2. 글자수 제한 기능 추가
	//2. 아이디 찾기 기능 구현
	//3. 비밀번호 찾기 기능 구현
	//4. 회원가입 기능 구현
	//4-1. 회원가입시 블로그/SNS에 대하여 DB에 기본값 저장
	
	//==========완료 목록==========
	
	@Autowired
    private SqlSession sqlSession;
	
	@Inject
	private UserServiceInterface userService;
	
	//login - get
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String getLogin(HttpServletRequest request) {
		//로그인 전의 페이지 주소를 세션에 저장
		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("redirectURI", referer);
		
		return "/user/login";
	}
	
	//login-post
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String postLogin(@RequestParam HashMap<String, Object> map, HttpServletRequest request) throws Exception {
		System.out.println("start login - method : post");
				
		//userVO result=userService.selectLogin(vo);
		HttpSession session = request.getSession();
		
		//임시 - 데이터 검증 과정 필요
		if(map != null) {
			session.setAttribute("user", userService.selectUserInfoForBlog(map.get("id").toString()));
		}

		//로그인 전의 페이지 주소로 이동
		return "redirect:"+(String) session.getAttribute("redirectURI");
	}
	
	//logout
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("start logout - method : get");

		//로그인 전의 페이지 주소를 String 변수에 저장
		String referer = request.getHeader("Referer");

		//세션 무효화
		session.invalidate();
	   
		//로그아웃 하기 전의 페이지 주소로 이동
		return "redirect:"+referer;
	}
}
