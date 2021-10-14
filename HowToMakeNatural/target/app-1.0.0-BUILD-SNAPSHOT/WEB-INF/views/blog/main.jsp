<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 공통 적용 파일 시작 -->
			<c:import url="../include/header.jsp"></c:import>
	<!-- 공통 적용 파일 -->
	<link href="<c:url value="/resources/css/blog.css" />" rel="stylesheet" type="text/css">
	<title>블로그 메인</title>
</head>
<body>
<!-- 아이콘 + 로고 + 검색창 시작 -->
	<header id="common_header">
		<section>
			<div id="logo">
				<span>Natural Blog</span>
			</div>
			<div id="search">
				<div id="search_box">
					<select id="search_object">
						<option value="post">제목/내용</option>
						<option value="theme">주제</option>
						<option value="writer">닉네임/아이디</option>
					</select>
					<input type="text" id="search_text" onkeyup="search_enter()">
					<div id="search_button" onclick="main_search()">
						<i class="fas fa-search"></i>
					</div>
				</div>
			</div>
			<div id="blank"></div>
			<div id="login_small">
				<div
					<c:if test="${empty sessionScope.user.id}"> onclick="login()"</c:if>
					<c:if test="${not empty sessionScope.user.id}"> onclick="logout()"</c:if>
				>
					<c:if test="${empty sessionScope.user.id}">로그인</c:if>
					<c:if test="${not empty sessionScope.user.id}">로그아웃</c:if>
				</div>
			</div>
			<div id="all_menu">
				<i class="fas fa-th"></i>
			</div>
		</section>
	</header>
<!-- 아이콘 + 로고 + 검색창 종료 -->
<!-- 블로그 홈 + 이웃 새글 (로그인시) 시작 -->
	<header id="blog_main_category">
		<section>
			<div class="active" onclick="blog_home_ajax()">블로그홈</div>
			<!-- 로그인시 보이는 화면 시작 -->
			<c:if test="${not empty sessionScope.user.id}">
				<div class="">이웃 새글</div>
			</c:if>
			<!-- 로그인시 보이는 화면 종료 -->
		</section>
	</header>
<!-- 블로그 홈 + 이웃 새글 (로그인시) 종료 -->
<!-- 메인 화면 시작 -->
	<main id="blog_main">
		<section id="post_area">
			<!-- 게시글 카테고리 시작 -->
			<header id="category">
				<span class="category_name active" onclick="blog_main_category_click('')">전체</span>
				<span class="category_name" onclick="blog_main_category_click('IT')" category="IT">IT</span>
				<span class="category_name" onclick="blog_main_category_click('미술')" category="미술">미술</span>
				<span class="category_name" onclick="blog_main_category_click('드라마')" category="드라마">드라마</span>
				<span class="category_name" onclick="blog_main_category_click('공연')" category="공연">공연</span>
				<span class="category_name" onclick="blog_main_category_click('여행')" category="여행">여행</span>
				<span class="category_name" onclick="blog_main_category_click('요리')" category="요리">요리</span>
			</header>
			<!-- 게시글 카테고리 종료 -->
			<!-- 검색시 게시글 카테고리 시작 -->
			<header id="search_category" class="hidden">
				<span class="search_category_name active" onclick="blog_main_search_category_click('post')">제목/내용</span>
				<span class="search_category_name" onclick="blog_main_search_category_click('theme')">주제</span>
				<span class="search_category_name" onclick="blog_main_search_category_click('writer')">닉네임/아이디</span>
			</header>
			<!-- 검색시 게시글 카테고리 종료 -->
			<!-- 게시글 목록 시작 -->
			<main id="board">
				<c:forEach items="${postList}" var="post" begin="0" end="10">
					<div class="main_post">
						<div class="post_content">
							<div class="post_profileAndName">
								<div class="post_userProfile" onclick="go_user_blog('${post.userID}')"></div>
								<a href="/blog/${post.userID}">${post.userNickName}</a>
							</div>
							<div class="post_title"><a href="/blog/${post.userID}/${post.no}">${post.title}</a></div>
							<div class="post_text"><a href="/blog/${post.userID}/${post.no}">${post.content.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "")}</a></div>
							<div class="post_goodAndComment">
								<span>좋아요 ${post.goodCount}</span>
								<span>댓글 ${post.commentCount}</span>
							</div>
						</div>
						
						<div class="post_image"
							<%-- 임시 코드 사용하는 부분 시작 --%>
							<c:if test="${post.no == 22}"> style="background-image : url('<c:url value="/resources/image/test/cheeze.jpg"/>');background-size:cover;"</c:if>
							<c:if test="${post.no == 21}"> style="background-image : url('<c:url value="/resources/image/test/googleAndApple.jpg"/>');background-size:cover;"</c:if>
							<c:if test="${post.no == 20}"> style="background-image : url('<c:url value="/resources/image/test/penthouse.jpg"/>');background-size:cover;"</c:if>
						>
						<%-- 임시 코드 사용하는 부분 종료 --%>
						</div>
						
					</div>
			    </c:forEach>
    		</main>
			<!-- 게시글 목록 종료 -->
			<c:if test="${paging.page_total gt 1}">
			<!-- 게시글 페이징 시작 -->
			<footer id="main_paging" class="flex_center_center">
				<c:if test="${paging.block_total gt 1 and paging.block_current gt 1}">
						<div class="post_list_paging_left flex_center_center" style="margin-right: 20px;" onclick="main_post_paging(${status.current},'', 'left')"><i class="fas fa-angle-left"></i></div>
				</c:if>
				<c:forEach var="index" varStatus="status" begin="${(paging.block_current-1)*10+1}" end="${(paging.block_current-1)*10+10}">
					<c:if test="${status.current le paging.page_total}">
						<div class="post_list_paging_number flex_center_center<c:if test="${status.current == paging.page_current}"> active</c:if>" page="${status.current}" onclick="main_post_paging(${status.current},'', 'number')"><span>${status.current}</span></div>
					</c:if>
				</c:forEach>
				<c:if test="${paging.block_total gt 1 and paging.block_current lt paging.block_total}">
						<div class="post_list_paging_right flex_center_center" style="margin-left: 20px;" onclick="main_post_paging(${status.current},'', 'right')"><i class="fas fa-angle-right"></i></div>
				</c:if>
			</footer>
			<!-- 게시글 페이징 종료 -->
			</c:if>
		</section>
		<section id="info_area">
			<!-- 로그인을 하지 않았을 경우에 보일 부분 시작 -->
			<c:if test="${empty sessionScope.user.id}">
			<div id="sign">
				<div id="login"><span>Natural Blog 로그인</span></div>
				<div id="searchAndSignUp"><span><span id="searchID">아이디 찾기</span> | <span id="searchPW">비밀번호 찾기</span></span><span id="signUp">회원가입</span></div>
			</div>
			</c:if>
			<!-- 로그인을 하지 않았을 경우에 보일 부분 종료 -->
			<!-- 로그인시 보이는 화면 시작 -->
			<c:if test="${not  empty sessionScope.user.id}">
			<div id="my_menu">
				<input type="hidden" id="my_ID" value="${sessionScope.user.id}">
				<div id="first">
					<div id="my_info">
						<div class="post_userProfile" onclick="go_user_blog('${sessionScope.user.id}')"></div>
						<span id="my_nickname" onclick="go_user_blog('${sessionScope.user.id}')">${sessionScope.user.blog_nickname}</span>
					</div>
					<div id="my_logout">
						<div id="logout">로그아웃</div>
					</div>
				</div>
				<div id="second">
					<div id="my_blog" onclick="go_user_blog('${sessionScope.user.id}')"><span>내 블로그</span></div>
					<div id="write_new_post" onclick="write_my_new_post('${sessionScope.user.id}')"><i class="fas fa-pen"></i>&nbsp;&nbsp;<span>글쓰기</span></div>
				</div>
				<div id="third">
					<div id="my_news" class="active" onclick="blog_main_my_menu('${sessionScope.user.id}','my_news')">새소식</div>
					<div id="my_post" onclick="blog_main_my_menu('${sessionScope.user.id}','my_post')">내 글</div>
					<div id="my_neighbor" onclick="blog_main_my_menu('${sessionScope.user.id}','my_neighbor')">내 이웃</div>
				</div>
				<div id="show_info">
					<div style="width:100%; height: 100%; display:flex; justify-content:center; align-items: center;">
						<span>새 소식이 없습니다.</span>
					</div>
				</div>
			</div>
			</c:if>
			<!-- 로그인시 보이는 화면 종료 -->
		</section>
	</main>
<!-- 메인 화면 종료 -->

	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog/common.js"/>"></script>
	<script src="<c:url value="/resources/js/blog/main.js"/>"></script>
	
	<!-- 공통 적용 파일 시작 -->
			<c:import url="../include/footer.jsp"></c:import>
	<!-- 공통 적용 파일 -->
</body>
</html>