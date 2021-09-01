<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블로그 메인</title>
</head>
<body>
<span>블로그 메인</span>
	<c:forEach items="${postList}" var="post" begin="0" end="10">
		<div class="post_row">
			<span class="title"><a href="/blog/${post.userID}/${post.no}">${post.title}</a></span>
			<span class="signdate">${boardList.signdate}</span>
		</div>
		<hr>
    </c:forEach>
</body>
</html>