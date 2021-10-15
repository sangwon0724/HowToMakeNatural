<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 공통 적용 파일 시작 -->
<c:import url="../include/header.jsp"></c:import>
<!-- 공통 적용 파일 종료-->
<link href="<c:url value="/resources/css/blog.css" />" rel="stylesheet"type="text/css">
<title>
	${sessionScope.user.id}님의 블로그 설정
</title>
</head>
<body>
	<c:if test="${not empty sessionScope.user.id}">
		<!-- 히든 값 영역 시작 -->
		<!-- 히든 값 영역 종료 -->
	</c:if>
	
	
	
	<div id="setting_panel">
		<!-- 네비게이션 시작 -->
		<nav id="personal_nav_setting">
			<div>
				<div id="span_type">
					<span id="my_blog" class="click"
						<c:if test="${empty sessionScope.user.id}"> onclick="login()"</c:if>
						<c:if test="${not empty sessionScope.user.id}"> onclick="go_user_blog('${sessionScope.user.id}')"</c:if>
					>내 블로그</span>
					<span> | </span>
					<span id="neighbor_blog" class="click"
						<c:if test="${empty sessionScope.user.id}"> onclick="login()"</c:if>
						<c:if test="${not empty sessionScope.user.id}"> onclick="neighbor_blog()"</c:if>
					>이웃 블로그</span>
					<span> | </span>
					<span id="blog_home" class="click" onclick="blog_home()">블로그홈</span>
				</div>
				<div id="blog_sign" class="flex_center_center"
					<c:if test="${empty sessionScope.user.id}"> onclick="login()"</c:if>
					<c:if test="${not empty sessionScope.user.id}"> onclick="logout()"</c:if>
				>
				<c:if test="${empty sessionScope.user.id}"><span>로그인</span></c:if>
				<c:if test="${not empty sessionScope.user.id}"><span>로그아웃</span></c:if>
				</div>
				<div id="blog_all_menu" class="flex_center_center"><i class="fas fa-th"></i></div>
			</div>
		</nav>
		<!-- 네비게이션 종료 -->
		
		
		
		<!-- 블로그 설정 목록 화면 시작 -->
		<section id="setting_list_panel">
			<div class="setting_menu_grid">
				<div class="setting_menu">
					<span class="setting_menu_line big">프로필 변경</span>
					<span class="setting_menu_line small" onclick="toggleSettingFunctionPanel('setting_blog_info')">블로그 정보</span>
				</div>
			</div>
			
			<div class="setting_menu_grid">
				<div class="setting_menu">
					<span class="setting_menu_line big"><bold>블로그 꾸미기</bold></span>
					<span class="setting_menu_line small" onclick="toggleSettingFunctionPanel('setting_blog_background')">배경 변경</span>
					<span class="setting_menu_line small" onclick="toggleSettingFunctionPanel('setting_blog_placement')">배치 변경</span>
					<span class="setting_menu_line small" onclick="toggleSettingFunctionPanel('setting_blog_wizet')">위젯 설정</span>
				</div>
			</div>
			
			<div class="setting_menu_grid">
				<div class="setting_menu">
					<span class="setting_menu_line big"><bold>이웃 관리</bold></span>
					<span class="setting_menu_line small" onclick="toggleSettingFunctionPanel('setting_blog_neighbor_list')">이웃 목록</span>
					<span class="setting_menu_line small" onclick="toggleSettingFunctionPanel('setting_blog_neighbor_follow_me')">나를 추가한 이웃</span>
				</div>
			</div>
			
			<div class="setting_menu_grid">
				<div class="setting_menu">
					<span class="setting_menu_line big"><bold>카테고리 관리</bold></span>
					<span class="setting_menu_line small" onclick="toggleSettingFunctionPanel('setting_blog_category')">카테고리 관리</span>
				</div>
			</div>
		</section>
		<!-- 블로그 설정 목록 화면 종료 -->
		
		<!-- 블로그 설정 기능 화면 시작 -->
		<section id="setting_function_panel">
			<!-- 블로그 정보 설정 시작 -->
			<article id="setting_blog_info"></article>
			<!-- 블로그 정보 설정 종료 -->
			<!-- 블로그 베경 설정 시작 -->
			<article id="setting_blog_background" class="hidden"></article>
			<!-- 블로그 배경 설정 종료 -->
			<!-- 블로그 배치 설정 시작 -->
			<article id="setting_blog_placement" class="hidden"></article>
			<!-- 블로그 배치 설정 종료 -->
			<!-- 블로그 위젯 설정 시작 -->
			<article id="setting_blog_wizet" class="hidden"></article>
			<!-- 블로그 위젯 설정 종료 -->
			<!-- 블로그 이웃 목록 설정 시작 -->
			<article id="setting_blog_neighbor_list" class="hidden"></article>
			<!-- 블로그 이웃 목록 설정 종료 -->
			<!-- 블로그 나를 추가한 이웃 설정 시작 -->
			<article id="setting_blog_neighbor_follow_me" class="hidden"></article>
			<!-- 블로그 나를 추가한 이웃 설정 종료 -->
			<!-- 블로그 카테고리 설정 시작 -->
			<article id="setting_blog_category" class="hidden"></article>
			<!-- 블로그 카테고리 설정 종료 -->
		</section>
		<!-- 블로그 설정 기능 화면 종료 -->
	</div>
	
	
	
	<!-- 모달 영역 시작 -->
	<c:if test="${sessionScope.user.id eq userInfo.id}">
	<div id="temp" class="modal">
	    <div class="modal-content_forButton">
	      <span class="close">&times;</span>
	      <div class="modal_content">
	      	<span>temp</span>
			<div id="button_yesOrNo">
				<button onclick="실행기능('${sessionScope.user.id}')">예</button>
				<button onclick="modal_cancle()">아니오</button>
			</div>
	      </div>
	    </div>
	</div>
	</c:if>
	<!-- 모달 영역 종료 -->
	
	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog/common.js"/>"></script>
	<script src="<c:url value="/resources/js/blog/setting.js"/>"></script>
	
	<!-- 공통 적용 파일 시작 -->
			<c:import url="../include/footer.jsp"></c:import>
	<!-- 공통 적용 파일 -->
</body>
</html>