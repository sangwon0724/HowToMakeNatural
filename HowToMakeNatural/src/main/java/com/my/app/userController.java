package com.my.app;

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

import com.my.service.userServiceInterface;
//import com.my.vo.blogVO;
import com.my.vo.userVO;

@Controller
public class userController {
	//==========할 일 목록==========
	
	//==========완료 목록==========
	
	@Autowired
    private SqlSession sqlSession;
	
	@Inject
	private userServiceInterface userService;
	
	//login - get
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginGET(HttpServletRequest request) {
		//로그인 전의 페이지 주소를 세션에 저장
		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("redirectURI", referer);
		
		return "/user/login";
	}
	
	//login-post
		@RequestMapping(value = "/login", method = RequestMethod.POST)
		public String postLogin(userVO vo, HttpServletRequest request) throws Exception {
			System.out.println("start login - method : post");
					
			//userVO result=userService.selectLogin(vo);
			HttpSession session = request.getSession();
			
			//임시
			if(vo != null) {
				session.setAttribute("user", vo);
			}

			//로그인 전의 페이지 주소로 이동
			return "redirect:"+(String) session.getAttribute("redirectURI");
		}
	
	//logout
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String getLogout(HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("start logout - method : get");
		
		userService.logout(session);

		//로그인 전의 페이지 주소를 세션에 저장
		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("redirectURI", referer);
	   
		//로그아웃 하기 전의 페이지 주소로 이동
		return "redirect:"+(String) session.getAttribute("redirectURI");
	}
}
