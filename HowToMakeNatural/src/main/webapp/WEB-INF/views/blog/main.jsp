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
		
	</header>
<!-- 아이콘 + 로고 + 검색창 종료 -->
<!-- 메인 화면 시작 -->
	<main id="blog_main">
		<section id="post_area">
			<header id="category"></header>
			<main id="board">
				<c:forEach items="${postList}" var="post" begin="0" end="10">
					<div class="post">
						<div class="post_content">
							<div class="post_profileAndName">${post.userNickName}</div>
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
		<section id="info_area"></section>
	</main>
<!-- 메인 화면 종료 -->

	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog.js" />"></script>
</body>
</html>