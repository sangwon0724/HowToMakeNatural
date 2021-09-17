<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 적용 파일 시작 -->
<c:import url="../include/common.jsp"></c:import>
<!-- 공통 적용 파일 종료-->
<link href="<c:url value="/resources/css/blog.css" />" rel="stylesheet"
	type="text/css">
<title>게시글 작성</title>
</head>
<body>
	1. 제목
	2. 내용
	3. 카테고리
	4. 태그
	5. 전송버튼 (ajax 사용 => 성공 => 블로그 메인으로 이동)
	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog.js"/>"></script>
</body>
</html>