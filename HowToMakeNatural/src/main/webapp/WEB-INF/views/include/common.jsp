<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- 필수 (이유 : css 파일)  --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<c:set var="URL" value="${pageContext.request.requestURL}" />
<c:if test = "${fn:contains(URL, 'write')}">
	<style type="text/css">
		body {
			  margin: 0;
			  padding: 0;
			  border: 0;
			  font-size: 100%;
			  font: inherit;
			  vertical-align: baseline;
			  background-color: #dfe6e9;
		}
	</style>
</c:if>
<c:if test = "${!fn:contains(URL, 'write')}">
	<link href="<c:url value="/resources/css/reset.css" />" rel="stylesheet" type="text/css">
</c:if>

<link href="<c:url value="/resources/css/common.css" />" rel="stylesheet" type="text/css">

<!-- 아이콘 -->
<script src="https://kit.fontawesome.com/34a8d510cf.js" crossorigin="anonymous"></script>
   
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Allison&display=swap" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>