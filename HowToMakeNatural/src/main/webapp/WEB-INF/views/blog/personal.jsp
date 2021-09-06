<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 공통 적용 파일 시작 -->
<c:import url="../include/common.jsp"></c:import>
<!-- 공통 적용 파일 -->
<link href="<c:url value="/resources/css/blog.css" />" rel="stylesheet"
	type="text/css">
<title>
	<c:if test='${userInfo.blog_logo_text != null && userInfo.blog_logo_text != ""}'>${userInfo.blog_logo_text}</c:if>
	<c:if test='${userInfo.blog_logo_text == null or userInfo.blog_logo_text == ""}'>${userInfo.id}님의 블로그</c:if>
</title>
</head>
<body>
	<!-- 히든 값 영역 시작 -->
	<input type="hidden" id="blogUserID" value="${userInfo.id}">
	<input type="hidden" id="nowPostNo" value="${nowPostNo}">
	<!-- 히든 값 영역 종료 -->
	<div id="center_panel">
		<!-- 네비게이션 시작 -->
		<nav id="nav">
			네비게이션
		</nav>
		<!-- 네비게이션 종료 -->
		<!-- 배경글 시작 -->
		<header id="background_logo" class="flex_column_center_center" <c:if test='${userInfo.blog_logo_image != null and userInfo.blog_logo_image != ""}'> background-image="${userInfo.blog_logo_image}"</c:if>>
			<span>
				<c:if test='${userInfo.blog_logo_text != null && userInfo.blog_logo_text != ""}'>${userInfo.blog_logo_text}</c:if>
				<c:if test='${userInfo.blog_logo_text == null or userInfo.blog_logo_text == ""}'>${userInfo.id}님의 블로그입니다.</c:if>
			</span>
		</header>
		<!-- 배경글 종료 -->
		<!-- 블로그 메인화면 시작 -->
		<main id="blog_personal_main" class="typeA">
			<!-- 프로필  + 검색 + 카테고리 + 이웃목록 + 위젯 시작 (type A. 기본)-->
			<div id="left" class="typeA">
				<div id="profile_panel">
					<div id="profile_image">프로필 이미지</div>
					<div id="profile_nickname" class="flex_center_center"><span>${userInfo.blog_nickname}</span>&nbsp;<span>(${userInfo.id})</span></div>
					<div id="profile_text" class="flex_center_center">
						<span><c:if test='${userInfo.blog_profile_text != null and userInfo.blog_profile_text != "" }'>${userInfo.blog_profile_text}</c:if></span>
					</div>
					<div id="personal_buttons" class="flex_center_center"><span>프로필/관리/통계</span></div>
				</div>
				<div id="search_panel" class="flex_center_center">
					<input type="text" id="search_text">
					<div id="search_button">
						<i class="fas fa-search"></i>
					</div>
				</div>
				<div id="category_panel">카테고리</div>
				<div id="neighbor_panel">이웃목록</div>
			</div>
			<!-- 프로필  + 검색 + 카테고리 + 이웃목록 + 위젯 종료 (type A. 기본)-->
			
			<!-- 게시글 패널 (type A. 기본) -->
			<div id=center class="flex_column_center_center typeA">
				<!-- 검색창 시작 (type B. 기본X) -->
				<div class="searchbox typeB"></div>
				<!-- 검색창 종료  (type B. 기본X) -->
				<!-- 게시글 목록 시작 (목록 열기/닫기 가능 O) -->
				<header id="post_list_summary_O">
					<span id="post_list_toggle">목록 닫기</span>
					<table cellspacing="0" cellpadding="0" class="post_summary_list">
						<colgroup>
							<col width="75%" style="background: lightgray" />
    						<col width="25%" style="background: lightblue" />
						</colgroup>
						<thead>
							<tr>
								<th><div class="title"><span>글 제목</span></div></th>
								<th><div class="date"><span>작성일</span></div></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${postList}" var="post" begin="0" end="4">
							<tr class="">
								<td class="title">
									<a href="/blog/${userInfo.id}/${post.no}" <c:if test="${post.no == nowPostNo}"> class="active"</c:if>>${post.title}</a>&nbsp;<span>(댓글수)</span>
								</td>
								<td class="date">
									<span>${post.signdate}</span>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<footer class="post_list_summary_paging">게시글 목록용 페이징</footer>
				</header>
				<!-- 게시글 목록 종료 (목록 열기/닫기 가능 O) -->
				<!-- 게시글이 보이는 화면 시작 -->
				<main id="post_panel">
					<c:if test='${onePost == null or onePost == ""}'>
						<c:forEach items="${postList}" var="post" begin="0" end="0">
							<div class="personal_post">
								<header class="post_category">${post.category}</header>
								<header class="post_title">${post.title}</header>
								<header class="post_profileAndNameAndSigndate">${userInfo.blog_nickname}</header>
								<main class="post_content">${post.content}</main>
								<footer class="post_goodAndComment">
									<span>좋아요 0</span>
									<span>댓글 0</span>
								</footer>
							</div>
					    </c:forEach>
				    </c:if>
					<c:if test='${onePost != null and onePost != ""}'>
						<div class="personal_post">
							<header class="post_category"><span>${onePost.category}</span></header>
							<header class="post_title"><span>${onePost.title}</span></header>
							<header class="post_profileAndNameAndSigndate">
								<div class="profile_image"></div>
								<span>${userInfo.blog_nickname}</span>
							</header>
							<main class="post_content">${onePost.content}</main>
							<footer class="post_goodAndComment">
								<span>좋아요 0</span>
								<span>댓글 0</span>
							</footer>
						</div>
				    </c:if>
				</main>
				<!-- 게시글이 보이는 화면 종료 -->
				<!-- 게시글 목록 시작 (목록 열기/닫기 가능 X) -->
				<footer id="post_list_summary_X">
					<table cellspacing="0" cellpadding="0" class="post_summary_list">
						<colgroup>
							<col width="75%" style="background: lightgray" />
    						<col width="25%" style="background: lightblue" />
						</colgroup>
						<thead>
							<tr>
								<th><div class="title"><span>글 제목</span></div></th>
								<th><div class="date"><span>작성일</span></div></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${postList}" var="post" begin="0" end="4">
							<tr class="">
								<td class="title">
									<a href="/blog/${userInfo.id}/${post.no}" <c:if test="${post.no == nowPostNo}"> class="active"</c:if>>${post.title}</a>&nbsp;<span>(댓글수)</span>
								</td>
								<td class="date">
									<span>${post.signdate}</span>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<footer class="post_list_summary_paging">게시글 목록용 페이징</footer>
				</footer>
				<!-- 게시글 패널 종료 (목록 열기/닫기 가능 X) -->
			</div>
			<!-- 게시글 목록 종료 (type A. 기본) -->
	
			<!-- 프로필  + 검색 + 카테고리 + 이웃목록 + 위젯 시작 (type B. 스타일 변경)-->
			<div id="bottom" class="typeB hidden">
				<div id="profile_panel">
					<div id="profile_image">프로필 이미지</div>
					<div id="profile_text" class="flex_center_center">
						<span><c:if test='${userInfo.blog_profile_text != null and userInfo.blog_profile_text != "" }'>${userInfo.blog_profile_text}</c:if></span>
					</div>
					<div id="personal_buttons" class="flex_center_center"><span>프로필/관리/통계</span></div>
				</div>
				<div id="search_panel" class="flex_center_center">
					<input type="text" id="search_text">
					<div id="search_button">
						<i class="fas fa-search"></i>
					</div>
				</div>
				<div id="category_panel">카테고리</div>
			</div>
			<!-- 프로필  + 검색 + 카테고리 + 이웃목록 + 위젯 종료 (type B. 스타일 변경)-->
		</div>
		<!-- 블로그 메인화면 종료 -->
	</div>
	
	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog.js"/>"></script>
</body>
</html>