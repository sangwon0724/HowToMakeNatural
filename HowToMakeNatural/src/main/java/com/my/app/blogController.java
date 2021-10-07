package com.my.app;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.my.service.blogServiceInterface;
import com.my.service.userServiceInterface;
import com.my.util.paging;
import com.my.vo.userVO;

@Controller
public class blogController {
	//==========할 일 목록==========
	//7. 페이징 기능 추가
	//7-1. 메인 화면
	//8. 이웃 관련 기능 추가
	//8-1. 메인 화면
	//9. 메인 화면에서 내가 쓴 글 목록 가져오기 기능 추가
	//11. 게시글이 존재하지 않을 시 존재하지 않는다는 문구 추가
	//11-1. 개인블로그
	//12. 블로그 메인에 대한 사진 작업
	//13. 댓글 작업 (주소 : "/blog/유저아이디/게시글번호/comment")
	//17. url 인터셉터 추가 (write, update, delete) , 실험 : ajax (이유 : menu)
	
	//==========완료 목록==========
	//1. 블로그 메인 기본 틀 완성
	//1-1. 세션값 확인을 통한 이웃새글 파트 추가
	//1-2. 세션값 확인을 통한 내정보 파트 및 로그인 파트 추가
	//2. 개인 블로그 화면 추가 (주소 : "/blog/유저아이디")
	//3. view 기능 추가 (주소 : "/blog/유저아이디/게시글번호")
	//4. write 기능 추가 (작성 전 주소 : "/blog/유저아이디/write" => 작성 후 주소 : "/blog/유저아이디")
	//5. update 기능 추가  (수정 시 주소 : "/blog/유저아이디/게시글번호/update" => 수정 후 주소 : "/blog/유저아이디/게시글번호")
	//6. delete 기능 추가 (삭제 전 주소 : "/blog/유저아이디/게시글번호/delete" => 삭제 후 주소 : "/blog/유저아이디/")
	//7-2. 개인 블로그 - 게시글
	//7-3. 개인 블로그 - 단어 검색
	//7-4. 개인 블로그 - 태그 검색
	//8-2. 개인 블로그
	//10. 검색 기능 추가 - 메인 (Ajax로 board 영역만 변경)
	//11-2. 검색화면
	//14. 검색 기능 추가 - 개인 블로그
	//14-1. 개인 블로그 (단어검색)
	//14-2. 개인 블로그 (태그 클릭)
	//15. 개인 블로그 - 게시글 리스트 가져오기
	//15-1. 글 리스트 가져오기
	//15-2. 글 리스트에서 다른 페이지의 게시글 클릭시 이동후 해당 게시글의 페이지를 보여주기 (ajax)
	//16. view 관련해서 태그 추가
	
	@Autowired
    private SqlSession sqlSession;
	
	@Inject
	private blogServiceInterface blogService;
	
	@Inject
	private userServiceInterface userService;
	
	//페이징용
	private paging paging = new paging();
	
	//============================================= 블로그 메인 영역 시작 =====================================================================
	
	/* 블로그 메인 */
	@RequestMapping(value = "/blog/main", method = RequestMethod.GET)
	public String getMainPostList(Model model) throws Exception {
		
		System.out.println("블로그 메인");
		
		List<HashMap<String, Object>> postList;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 0);
		map.put("category", "");
		map.put("block", 10);
		
		postList=blogService.selectPost(map); //게시글 10개
		
		model.addAttribute("postList", postList);
		
	    return "/blog/main";
	}
	
	/* 블로그 메인 글 가져오기 - Ajax */
	@ResponseBody
	@RequestMapping(value = "/blog/main/Ajax", method = RequestMethod.POST)
	public Map<String, Object> getMainPostListAjax(@RequestBody HashMap<String, Object> map,  Model model) throws Exception {
		
		System.out.println("Ajax 요청 - 블로그 메인  / 게시글 단위 수 : " + map.get("block") + " / 요청 카테고리 : "+ map.get("category") + " / 검색 요청 항목 : " + map.get("object") + " / 검색 요청 문자 : "+map.get("search"));
		
		List<HashMap<String, Object>> postList;
		
		postList=blogService.selectPost(map); //게시글 10개
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("postList", postList);
		
	    return result;
	}
	
	//============================================= 블로그 메인 영역 종료 =====================================================================
	//============================================= 개인 블로그 영역 시작 =====================================================================
	
	/* 개인 블로그 - 방문하기 */
	@RequestMapping(value = "/blog/{userID}", method = RequestMethod.GET)
	public String getPersonalBlog(@RequestParam(value="category", defaultValue="") String category, @PathVariable String userID, Model model) throws Exception {
		
		System.out.println("개인 블로그 - 유저 아이디 : " + userID);
		
		//xml 파일에서 사용할 값 설정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 0); //게시글 검색 + 이웃 검색
		map.put("category", category); //게시글 검색
		map.put("userID", userID); //게시글 검색 + 카테고리 검색 + 이웃 검색
		map.put("block", 5); //게시글 검색
		

		//개인 게시글 긁어오기
		List<HashMap<String, Object>> postList=blogService.selectPost(map); //게시글 10개
		
		//해당 블로그의 유저 정보 가져오기
		userVO userInfo=userService.selectUserInfoForBlog(userID);
		
		//카테고리목록 긁어오기
		List<HashMap<String, Object>> categoryList=blogService.selectCategory(map); //카테고리 목록
		
		//이웃목록 긁어오기
		List<HashMap<String, Object>> neighborList=blogService.selectnNeighbor(map); //이웃 9명
		
		//단일 게시글 정보
		HashMap<String, Object> onePost=postList.get(0);
		
		model.addAttribute("postList", postList); //게시글
		model.addAttribute("userInfo", userInfo); //유저 정보
		model.addAttribute("categoryList", categoryList); //카테고리 목록
		model.addAttribute("neighborList", neighborList); //이웃 목록
		model.addAttribute("onePost", onePost); //단일 게시물에 대한 정보 등록
		model.addAttribute("mode", "view"); //게시글 모드
		
		//페이징 정보
		HashMap<String, Object> pagingSetting=paging.settingPaging("blog_post", onePost, 5); //페이징 설정
		model.addAttribute("paging", pagingSetting); //페이징 정보 설정
		
	    return "/blog/personal";
	}
	
	/* 개인 블로그 - 게시글 한 개만 보기 */
	@RequestMapping(value = "/blog/{userID}/{no}", method = RequestMethod.GET)
	public String getPersonalPostView(@RequestParam(value="category", defaultValue="") String category, @PathVariable String userID, @PathVariable int no, Model model) throws Exception {
		
		System.out.println("개인 블로그 - 유저 아이디 : " + userID + " / 게시글 번호 : "+ no);
		
		//xml 파일에서 사용할 값 설정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 0);  //MariaDB 특성
		map.put("category", category);
		map.put("userID", userID);
		map.put("block", 5);
		
		//게시글 목록을 위한 전체 검색
		List<HashMap<String, Object>> postList=blogService.selectPost(map); //게시글 목록
		
		//해당 블로그의 유저 정보 가져오기
		userVO userInfo=userService.selectUserInfoForBlog(userID);
		
		//카테고리목록 긁어오기
		List<HashMap<String, Object>> categoryList=blogService.selectCategory(map); //카테고리 목록
		
		//이웃목록 긁어오기
		List<HashMap<String, Object>> neighborList=blogService.selectnNeighbor(map); //이웃 9명
		
		model.addAttribute("postList", postList); //게시글 목록 등록
		model.addAttribute("userInfo", userInfo); //블로그 유조애 대한 정보 등록
		model.addAttribute("categoryList", categoryList); //카테고리 목록
		model.addAttribute("neighborList", neighborList); //이웃 목록
		model.addAttribute("mode", "view"); //게시글 모드
		

		map.put("no", no); //단일 게시글 검색용
		HashMap<String, Object> onePost=blogService.selectPost(map).get(0); //단일 게시물 검색
		model.addAttribute("onePost", onePost); //단일 게시물에 대한 정보 등록
		
		//페이징 정보
		HashMap<String, Object> pagingSetting=paging.settingPaging("blog_post", postList.get(0), 5); //페이징 설정
		model.addAttribute("paging", pagingSetting); //페이징 정보 설정
		
	    return "/blog/personal";
	}
	

	/* 개인 블로그 - 방문하기 */
	@RequestMapping(value = "/blog/{userID}/{menu}/{target}", method = RequestMethod.GET)
	public String getPersonalBlogSearch(@PathVariable String userID, @PathVariable String menu, @PathVariable String target, Model model) throws Exception {
		
		System.out.println("개인 블로그 - 유저 아이디 : " + userID);
		
		//xml 파일에서 사용할 값 설정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 0); //게시글 검색 + 이웃 검색
		map.put("category", ""); //게시글 검색
		map.put("userID", userID); //게시글 검색 + 카테고리 검색 + 이웃 검색
		map.put(menu, target); //문자를 통한 검색 or 태그를 통한 검색
		map.put("block", 10); //게시글 검색
		

		//개인 게시글 긁어오기
		List<HashMap<String, Object>> postList=blogService.selectPost(map); //게시글 10개
		
		//해당 블로그의 유저 정보 가져오기
		userVO userInfo=userService.selectUserInfoForBlog(userID);
		
		model.addAttribute("postList", postList); //게시글
		model.addAttribute("userInfo", userInfo); //유저 정보
		model.addAttribute("mode", menu); //검색 모드
		model.addAttribute("target", target); //검색 모드
		
		HashMap<String, Object> pagingSetting = null; //페이징 정보 세팅용
		
		if(postList.size() > 0 == true) {
			model.addAttribute("count", postList.get(0).get("count")); //게시글 개수
			pagingSetting=paging.settingPaging("blog_post", postList.get(0), 10); //페이징 설정
		}
		else if(postList.size() > 0 == false) {
			model.addAttribute("count", 0); //게시글 개수
			HashMap<String, Object> temp = new HashMap<String, Object>(); //페이징 설정
			temp.put("count", 0);
			temp.put("orderNo", 0);
			pagingSetting=paging.settingPaging("blog_post_search", temp, 10); //페이징 설정
		}
		
		model.addAttribute("paging", pagingSetting); //페이징 정보 설정
		
	    return "/blog/personal";
	}
	
	/* 개인 블로그 게시글 목록 가져오기 - Ajax */
	@ResponseBody
	@RequestMapping(value = "/blog/paging/Ajax", method = RequestMethod.POST)
	public Map<String, Object> getPersonalPostListAjax(@RequestBody HashMap<String, Object> map,  Model model) throws Exception {
		
		System.out.println("게시글 목록을 위한  Ajax 요청 - 개인 블로그 - 유저 아이디 : " + map.get("userID"));
		
		List<HashMap<String, Object>> postList;
		
		postList=blogService.selectPost(map); //게시글 5개
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("postList", postList);
		
	    return result;
	}
	
	/* 개인 블로그 - 게시글 작성  */
	@RequestMapping(value = "/blog/{userID}/write", method = RequestMethod.GET)
	public String getPersonalPostWrite(@PathVariable String userID, Model model) throws Exception {
		
		System.out.println("개인 블로그 게시글 작성 - 유저 아이디 : " + userID);
		
	    return "/blog/write";
	}
	
	/* 개인 블로그 - 게시글 작성 - ajax */
	@ResponseBody
	@RequestMapping(value = "/blog/{userID}/write/ajax", method = RequestMethod.POST)
	public Map<String, Object> ajaxPersonalPostWrite(@PathVariable String userID, @RequestBody HashMap<String, Object> map,  Model model) throws Exception {
		
		System.out.println("개인 블로그 게시글 작성  ajax- 유저 아이디 : " + userID);
		
		System.out.println("전송 데이터 : \n" + map);
		
		//게시글 insert
		blogService.insertPost(map);

		Map<String, Object> result = new HashMap<String, Object>(); //반환용
		result.put("message", "success"); //성공 메세지 전달
		
	    return result;
	}

	/* 개인 블로그 - 게시글 수정 */
	@RequestMapping(value = "/blog/{userID}/{no}/update", method = RequestMethod.GET)
	public String getPersonalPostUpdate(@PathVariable String userID, @PathVariable int no, Model model) throws Exception {
		
		System.out.println("개인 블로그 게시글 수정 (get)- 유저 아이디 : " + userID + " / 게시글 번호 : "+ no);
		
		//게시글 정보 가져오기
		//xml 파일에서 사용할 값 설정
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 0);  //MariaDB 특성
		map.put("category", "");
		map.put("userID", userID);
		map.put("block", 5);
		map.put("no", no); //단일 게시글 검색용
		
		//단일 게시글 검색
		List<HashMap<String, Object>> postList=blogService.selectPost(map);
				
		//model에 등록하기
		model.addAttribute("data", postList.get(0)); //단일 게시물에 대한 정보 등록
		model.addAttribute("mode", "update");
		
	    return "/blog/write";
	}
	
	/* 개인 블로그 - 게시글 수정 ajax */
	@ResponseBody
	@RequestMapping(value = "/blog/{userID}/{no}/update/ajax", method = RequestMethod.POST)
	public Map<String, Object> postPersonalPostUpdate(@PathVariable String userID, @PathVariable int no, @RequestBody HashMap<String, Object> map,  Model model) throws Exception {
		
		System.out.println("개인 블로그 게시글 수정 (post)- 유저 아이디 : " + userID + " / 게시글 번호 : "+ no);
		
		blogService.updatePost(map);
		
		Map<String, Object> result = new HashMap<String, Object>(); //반환용
		result.put("message", "success"); //성공 메세지 전달
		
	    return result;
	}

	/* 개인 블로그 - 게시글 삭제 ajax*/
	@ResponseBody
	@RequestMapping(value = "/blog/{userID}/{no}/delete", method = RequestMethod.POST)
	public Map<String, Object> getPersonalPostDelete(@PathVariable String userID, @PathVariable int no, Model model) throws Exception {
		
		System.out.println("개인 블로그 게시글 삭제 - 유저 아이디 : " + userID + " / 게시글 번호 : "+ no);

		Map<String, Object> result = new HashMap<String, Object>(); //반환용
		
		//삭제 처리
		result.put("no", no);
		blogService.deletePost(result);
		
		result.put("message", "success"); //성공 메세지 전달
		
	    return result;
	}
	
	/* 개인 블로그 - 게시글 작성 - ajax */
	@ResponseBody
	@RequestMapping(value = "/blog/comment/ajax", method = RequestMethod.POST)
	public Map<String, Object> ajaxPersonalComment(@RequestBody HashMap<String, Object> map,  Model model) throws Exception {
		
		System.out.println("개인 블로그 댓글 작성  ajax- 작성자 아이디 : " + map.get("userID") + " / 작성 대상 게시글 번호 : " + map.get("no"));
		
		//댓글 insert
		blogService.insertComment(map);

		Map<String, Object> result = new HashMap<String, Object>(); //반환용
		result.put("message", "success"); //성공 메세지 전달
		
	    return result;
	}
	
	//게시글 작성시 이미지 처리
	@RequestMapping(value="/blog/{userID}/write/image", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, @PathVariable String userID, HttpServletRequest request)  {
		System.out.println("이미지 업로드 - 유저 아이디 : " + userID);
		
		JsonObject jsonObject = new JsonObject();
		
		// 외부경로로 저장을 희망할때.
		//String realFileRoot = "C:\Users\you\Desktop\My_Space\GitHub\HowToMakeNatural\HowToMakeNatural\src\main\webapp\resources\image\";
		
		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/image/blog/"+userID+"/"; //경로 지정
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);
		//File targetFile = new File(realFileRoot+ savedFileName);//테스트	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/resources/image/blog/"+userID+"/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			//jsonObject.addProperty("url", fileRoot+savedFileName); 
			System.out.println(fileRoot+savedFileName);//경로 및 파일명 출력
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}
	//============================================= 개인 블로그 영역 종료 =====================================================================
	//============================================= 블로그 공통 영역 시작 =====================================================================
	
	/* 블로그 메인에서 로그인시 보이는 개인 메뉴 - Ajax */ //작성중
	@ResponseBody
	@RequestMapping(value = "/blog/menu/Ajax", method = RequestMethod.POST)
	public Map<String, Object> getMainAjaxForMyMenu(@RequestBody HashMap<String, Object> map,  Model model) throws Exception {
		
		System.out.println("Ajax 요청 - 개인 메뉴 : " + map.get("menu"));
		
		List<HashMap<String, Object>> neighborList;
		Map<String, Object> result = new HashMap<String, Object>(); //반환용
		
		switch (map.get("menu").toString()) {
		case "my_news":
			
			break;
		case "my_post":
			
			break;
		case "my_neighbor":
			neighborList=blogService.selectnNeighbor(map);
			result.put("neighborList", neighborList);
			break;
		}
		
	    return result;
	}
	
	//============================================= 블로그 공통 영역 종료 =====================================================================
}
