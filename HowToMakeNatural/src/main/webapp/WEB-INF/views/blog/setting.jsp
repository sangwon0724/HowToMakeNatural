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
				<span style="font-weight: bold;">${sessionScope.user.blog_nickname}</span>
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
			<article id="setting_blog_info">
				<div class="title"><span>블로그 정보</span></div>
				<main>
					<div class="setting_item_name"><span>닉네임</span></div>
					<div id="setting_nickname" class="setting_item">
						<input type="text" id="blog_nickname" value="${userInfo.blog_nickname}" maxlength="30" placeholder="최대 30자까지 가능합니다.">
					</div>
					<div class="setting_item_name"><span>프로필 이미지</span></div>
					<div id="setting_profile_image" class="setting_item">
					<c:if test="${not empty userInfo.blog_profile_image and userInfo.blog_profile_image ne ''}">
						<div id="profile_image_preview" style="background-image: url('${userInfo.blog_profile_image}');"></div>
					</c:if>
					<c:if test="${empty userInfo.blog_profile_image or userInfo.blog_profile_image eq ''}">
						<div id="profile_image_preview"></div>
					</c:if>
					<input type="file" id="blog_profile_image"<c:if test="${not empty userInfo.blog_profile_image and userInfo.blog_profile_image ne ''}"> class="hidden"</c:if>>
					<c:if test="${not empty userInfo.blog_profile_image and userInfo.blog_profile_image ne ''}">
						<button id="profile_image_update_O" onclick="toggle_button_for_profiel_image('change')">변경</button>
						<button id="profile_image_update_X" onclick="toggle_button_for_profiel_image('')" class="hidden">X</button>
					</c:if>
					</div>
					<div class="setting_item_name"><span>프로필 소개글</span></div>
					<div id="setting_profile_text" class="setting_item">
						<input type="text" id="blog_profile_text" value="${userInfo.blog_profile_text}" maxlength="50" placeholder="최대 50자까지 가능합니다.">
					</div>
					<div class="setting_item_name last"><span>블로그 소개글</span></div>
					<div id="setting_logo_text" class="setting_item">
						<input type="text" id="blog_logo_text" value="${userInfo.blog_logo_text}" maxlength="50" placeholder="최대 50자까지 가능합니다.">
					</div>
					<div class="change_button_area">
						<button onclick="change_blog_info('${sessionScope.user.id}')">확인</button>
					</div>
				</main>
			</article>
			<!-- 블로그 정보 설정 종료 -->
			<!-- 블로그 베경 설정 시작 -->
			<article id="setting_blog_background" class="hidden">
				<div class="title"><span>블로그 베경</span></div>
				<div class="setting_item_name"><span>블로그 로고 배경</span></div>
				<div id="setting_logo_image"></div>
			배경이미지
			</article>
			<!-- 블로그 배경 설정 종료 -->
			<!-- 블로그 배치 설정 시작 -->
			<article id="setting_blog_placement" class="hidden">
				<div class="title"><span>블로그 배치</span></div>
			블로그 배치 타입
			</article>
			<!-- 블로그 배치 설정 종료 -->
			<!-- 블로그 위젯 설정 시작 -->
			<article id="setting_blog_wizet" class="hidden">
				<div class="title"><span>블로그 위젯</span></div>
			</article>
			<!-- 블로그 위젯 설정 종료 -->
			<!-- 블로그 이웃 목록 설정 시작 -->
			<article id="setting_blog_neighbor_list" class="hidden">
				<div class="title"><span>이웃 목록</span></div>
			</article>
			<!-- 블로그 이웃 목록 설정 종료 -->
			<!-- 블로그 나를 추가한 이웃 설정 시작 -->
			<article id="setting_blog_neighbor_follow_me" class="hidden">
				<div class="title"><span> 나를 추가한 이웃</span></div>
			</article>
			<!-- 블로그 나를 추가한 이웃 설정 종료 -->
			<!-- 블로그 카테고리 설정 시작 -->
			<article id="setting_blog_category" class="hidden">
				<div class="title"><span>카테고리 설정</span></div>
			</article>
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