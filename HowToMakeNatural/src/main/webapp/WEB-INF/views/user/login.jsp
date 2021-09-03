<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="${pageContext.request.contextPath}/resources/css/index.css" rel="stylesheet" type="text/css">
	<title>로그인</title>
</head>
<body>
	<form name="login__form" method="post" class="login__form">
			<div class="loginLine">
				<header><span>아이디</span></header>
				<main><input type="text" name="id"></<main>
			</div>
			<div class="loginLine">
				<header><span>비밀번호</span></header>
				<main><input type="password" name="pw" onkeyup="enterkey()"></<main>
			</div>
			<div class="submitButton" onclick="login_submit()">로그인</div>
		</form>
		
		<script>
		function login_submit(){
			var id = login__form.id.value;
			var pw = login__form.pw.value;
			if (!id)
			{
				alert("아이디를 입력해주세요.");
				login__form.id.focus();
				return;
			}
			else
			{
				if (!pw)
				{
					alert("비밀번호를 입력해주세여.");
					login__form.pw.focus();
					return;
				}
				else{
					login__form.submit();
				}
			}
		}
		
		//엔터키가 눌렸을 때  실행
		function enterkey() {
	        if (window.event.keyCode == 13) {
	        	login_submit();
	        }
		}
	</script>
</body>
</html>