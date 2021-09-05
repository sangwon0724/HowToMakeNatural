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
	<title>
		<c:if test='background_logo != null and background_logo != ""'>${background_logo}</c:if>
		<c:if test='background_logo == null or background_logo == ""'>${userID}님의 블로그</c:if>
	</title>
</head>
<body>
	<!-- 배경글 -->
	<header id="background_logo"<c:if test='background_logo_image != null and background_logo_image != ""'> background-image="${background_logo_image}"</c:if>></header>
		<span>
			<c:if test='background_logo != null and background_logo != ""'>${background_logo}</c:if>
			<c:if test='background_logo == null or background_logo == ""'>${userID}님의 블로그입니다.</c:if>
		</span>
	<main id="blog_main">
		<!-- 프로필  + 카테고리 + 위젯 (type A. 기본)-->
		<div id="left" class="typeA"></div>
		
		<!-- 게시글 목록 (type A. 기본) -->
		<div id="post_info_pannel" class="typeA">
			<!-- 검색창 (type A. 기본) -->
			<div class="searchbox typeB"></div>
		</div>
		
		<!-- 이웃목록 + 위젯 (type A. 기본) -->
		<div id="right" class="typeA"></div>
		
		<!-- 프로필 + 카테고리 + 이웃목록 + 위젯 (type B. 스타일 변경)-->
		<div id="bottom" class="typeB"></div>
	</main>
</body>
</html>