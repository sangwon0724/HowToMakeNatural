<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="<c:url value="/resources/css/reset.css" />" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/blog.css" />" rel="stylesheet" type="text/css">
	<title>블로그 메인</title>
</head>
<body>
<!-- 아이콘 + 로고 + 검색창 시작 -->
	<header id="blog_header">
		<section>
		</section>
	</header>
<!-- 아이콘 + 로고 + 검색창 종료 -->
<!-- 블로그 홈 + 이웃 새글 (로그인시) 시작 -->
	<header id="blog_main_category">
		<section>
			<div>블로그홈</div>
			<!-- 로그인시 보이는 화면 시작 -->
			<div>이웃 새글</div>
			<!-- 로그인시 보이는 화면 종료 -->
		</section>
	</header>
<!-- 블로그 홈 + 이웃 새글 (로그인시) 종료 -->
<!-- 메인 화면 시작 -->
	<main id="blog_main">
		<section id="post_area">
			<header id="category">
				카테고리
			</header>
			<main id="board">
				<c:forEach items="${postList}" var="post" begin="0" end="10">
					<div class="post">
						<div class="post_content">
							<div class="post_profileAndName">
								<div class="post_userProfile"></div>
								<span>${post.userNickName}</span>
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
			<footer id="paging">페이징 부분</footer>
		</section>
		<section id="info_area">
			<!-- 로그인을 하지 않았을 경우에 보일 부분 시작 -->
			<div id="sign">
				<div id="login"><span>Totailian 로그인</span></div>
				<div id="searchAndSignUp"><span><span id="searchID">아이디 찾기</span> | <span id="searchPW">비밀번호 찾기</span></span><span id="signUp">회원가입</span></div>
			</div>
			<!-- 로그인을 하지 않았을 경우에 보일 부분 종료 -->
			<!-- 로그인시 보이는 화면 시작 -->
			<div id="my_menu">
				<div id="first">
					<div id="my_info">간락한 내정보</div>
					<div id="logout">로그아웃</div>
				</div>
				<div id="second">
					<div id="my_blog">내 블로그</div>
					<div id="write_new_post">글쓰기</div>
				</div>
				<div id="third">
					<div id="my_news">새소식</div>
					<div id="my_post">내 글</div>
					<div id="my_neighbor">내 이웃</div>
				</div>
				<div id="show_info">
					정보가 보여질 부분
				</div>
			</div>
			<!-- 로그인시 보이는 화면 종료 -->
		</section>
	</main>
<!-- 메인 화면 종료 -->

	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog.js" />"></script>
</body>
</html>