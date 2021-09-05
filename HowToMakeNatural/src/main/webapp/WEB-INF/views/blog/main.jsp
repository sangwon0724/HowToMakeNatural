<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 공통 적용 파일 시작 -->
			<c:import url="../include/common.jsp"></c:import>
	<!-- 공통 적용 파일 -->
	<link href="<c:url value="/resources/css/blog.css" />" rel="stylesheet" type="text/css">
	<title>블로그 메인</title>
</head>
<body>
<!-- 아이콘 + 로고 + 검색창 시작 -->
	<header id="blog_header">
		<section>
			<div id="logo">
				<span>Totalian</span>
			</div>
			<div id="search">
				<div id="search_box">
					<select id="search_object">
						<option value="post">제목/내용</option>
						<option value="theme">주제</option>
						<option value="writer">닉네임/아이디</option>
					</select>
					<input type="text" id="search_text">
					<div id="search_button">
						<i class="fas fa-search"></i>
					</div>
				</div>
			</div>
			<div id="blank"></div>
			<div id="login_small">
				<div>로그인</div>
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
			<div class="active">블로그홈</div>
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
				<span class="category_name active">전체</span>
				<span class="category_name" category="IT">IT</span>
				<span class="category_name" category="미술">미술</span>
				<span class="category_name" category="드라마">드라마</span>
				<span class="category_name" category="공연">공연</span>
				<span class="category_name" category="여행">여행</span>
				<span class="category_name" category="요리">요리</span>
			</header>
			<!-- 게시글 카테고리 종료 -->
			<!-- 검색시 게시글 카테고리 시작 -->
			<header id="search_category" class="hidden">
				<span class="search_category_name active" category="post">제목/내용</span>
				<span class="search_category_name" category="theme">주제</span>
				<span class="search_category_name" category="writer">닉네임/아이디</span>
			</header>
			<!-- 검색시 게시글 카테고리 종료 -->
			<!-- 게시글 목록 시작 -->
			<main id="board">
				<c:forEach items="${postList}" var="post" begin="0" end="10">
					<div class="main_post">
						<div class="post_content">
							<div class="post_profileAndName">
								<div class="post_userProfile" userID="${post.userID}"></div>
								<a href="/blog/${post.userID}">${post.userNickName}</a>
							</div>
							<div class="post_title"><a href="/blog/${post.userID}/${post.no}">${post.title}</a></div>
							<div class="post_text"><a href="/blog/${post.userID}/${post.no}">${post.content}</a></div>
							<div class="post_goodAndComment">
								<span>좋아요 0</span>
								<span>댓글 0</span>
							</div>
						</div>
						<div class="post_image"></div>
					</div>
			    </c:forEach>
    		</main>
			<!-- 게시글 목록 종료 -->
			<!-- 게시글 페이징 시작 -->
			<footer id="paging">
				페이징 부분
			</footer>
			<!-- 게시글 페이징 종료 -->
		</section>
		<section id="info_area">
			<!-- 로그인을 하지 않았을 경우에 보일 부분 시작 -->
			<c:if test="${empty sessionScope.user.id}">
			<div id="sign">
				<div id="login"><span>Totailian 로그인</span></div>
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
						<div class="post_userProfile" userID="${sessionScope.user.id}"></div>
						<span id="my_nickname">닉네임</span>
					</div>
					<div id="my_logout">
						<div id="logout">로그아웃</div>
					</div>
				</div>
				<div id="second">
					<div id="my_blog"><span>내 블로그</span></div>
					<div id="write_new_post"><i class="fas fa-pen"></i>&nbsp;&nbsp;<span>글쓰기</span></div>
				</div>
				<div id="third">
					<div id="my_news" class="active">새소식</div>
					<div id="my_post">내 글</div>
					<div id="my_neighbor">내 이웃</div>
				</div>
				<div id="show_info">
					정보가 보여질 부분
				</div>
			</div>
			</c:if>
			<!-- 로그인시 보이는 화면 종료 -->
		</section>
	</main>
<!-- 메인 화면 종료 -->

	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog.js"/>"></script>
</body>
</html>