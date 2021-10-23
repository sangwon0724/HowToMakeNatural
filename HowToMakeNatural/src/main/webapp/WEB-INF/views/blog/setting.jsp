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
<link href="<c:url value="/resources/css/blog/setting.css" />" rel="stylesheet"type="text/css">
<title>
	${sessionScope.user.blog_nickname}&nbsp;님의 블로그 설정
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
					<span id="neighbor_blog_list" class="click">이웃 블로그
						<div class="dropdown-content">
						<c:if test="${not empty sessionScope.user.id}">
						    <c:forEach var="neighbor" items="${neighborList_mine}" varStatus="status">
								<a href="/blog/${neighbor.target}" class="neighbor_logo_text">
									<span>${neighbor.nickname}</span>&nbsp;|&nbsp;
									<c:if test="${not empty neighbor.blog_logo_text and neighbor.blog_logo_text ne ''}">${neighbor.blog_logo_text}</c:if>
									<c:if test="${empty neighbor.blog_logo_text or neighbor.blog_logo_text eq ''}">${neighbor.target}님의 블로그</c:if>
								</a>
							</c:forEach>
					    </c:if>
					  </div>
					</span>
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
				</div>
			</div>
			
			<div class="setting_menu_grid">
				<div class="setting_menu">
					<span class="setting_menu_line big"><bold>이웃 관리</bold></span>
					<span class="setting_menu_line small" onclick="toggleSettingFunctionPanel('setting_blog_neighbor_list')">내가 추가한 이웃</span>
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
			<article id="setting_blog_info" class="settingPanel_grid">
				<div class="title"><span>블로그 정보</span></div>
				<main>
					<div class="setting_item_name"><span>닉네임</span></div>
					<div id="setting_nickname" class="setting_item">
						<input type="text" id="blog_nickname" value="${userInfo.blog_nickname}" maxlength="30" placeholder="최대 30자까지 가능합니다.">
					</div>
					<div class="setting_item_name"><span>프로필 이미지</span></div>
					<div id="setting_blog_profile_image" class="setting_item">
					<c:if test="${not empty userInfo.blog_profile_image and userInfo.blog_profile_image ne ''}">
						<img alt="" src="${userInfo.blog_profile_image}" class="image_preview">
					</c:if>
					<c:if test="${empty userInfo.blog_profile_image or userInfo.blog_profile_image eq ''}">
						<img alt="" src="#" class="image_preview">
					</c:if>
					<input type="file" onchange="preview_image(this, 'profile')" id="blog_profile_image"<c:if test="${not empty userInfo.blog_profile_image and userInfo.blog_profile_image ne ''}"> class="hidden"</c:if>>
					<c:if test="${not empty userInfo.blog_profile_image and userInfo.blog_profile_image ne ''}">
						<button id="profile_image_update_O" class="image_update_O" onclick="toggle_button_for_image('profile', 'change')">변경</button>
						<button id="profile_image_update_X" class="image_update_X hidden" onclick="toggle_button_for_image('profile', '')">X</button>
					</c:if>
					</div>
					<div class="setting_item_name"><span>프로필 소개글</span></div>
					<div id="setting_profile_text" class="setting_item">
						<input type="text" id="blog_profile_text" value="${userInfo.blog_profile_text}" maxlength="50" placeholder="최대 50자까지 가능합니다.">
					</div>
					<div class="setting_item_name last"><span>블로그 소개글</span></div>
					<div id="setting_logo_text" class="setting_item last">
						<input type="text" id="blog_logo_text" value="${userInfo.blog_logo_text}" maxlength="50" placeholder="최대 50자까지 가능합니다.">
						<input type="color" id="blog_logo_text_color" value="${userInfo.blog_logo_text_color}" style="margin: 0 10px;">
						<input type="number" id="blog_logo_text_size" value="${userInfo.blog_logo_text_size}" style="width: 45px;">&nbsp;px
					</div>
					<div class="change_button_area">
						<button onclick="change_blog_info('${sessionScope.user.id}')">확인</button>
					</div>
				</main>
			</article>
			<!-- 블로그 정보 설정 종료 -->
			<!-- 블로그 베경 설정 시작 -->
			<article id="setting_blog_background" class="settingPanel_grid hidden">
				<div class="title"><span>블로그 배경</span></div>
				<main>
					<div class="setting_item_name"><span>블로그 전체 배경</span></div>
					<div id="setting_blog_background_image" class="setting_item">
					<c:if test="${not empty userInfo.blog_background_image and userInfo.blog_background_image ne ''}">
						<img alt="" src="${userInfo.blog_background_image}" class="image_preview">
					</c:if>
					<c:if test="${empty userInfo.blog_background_image or userInfo.blog_background_image eq ''}">
						<img alt="" src="#" class="image_preview">
					</c:if>
					<input type="file" onchange="preview_image(this, 'background')" id="blog_background_image"<c:if test="${not empty userInfo.blog_background_image and userInfo.blog_background_image ne ''}"> class="hidden"</c:if>>
					<c:if test="${not empty userInfo.blog_background_image and userInfo.blog_background_image ne ''}">
						<button id="background_image_update_O" class="image_update_O" onclick="toggle_button_for_image('background', 'change')">변경</button>
						<button id="background_image_update_X" class="image_update_X hidden" onclick="toggle_button_for_image('background', '')">X</button>
					</c:if>
					</div>
					<div class="setting_item_name last"><span>블로그 로고 배경</span></div>
					<div id="setting_blog_logo_image" class="setting_item last">
					<c:if test="${not empty userInfo.blog_logo_image and userInfo.blog_logo_image ne ''}">
						<img alt="" src="${userInfo.blog_logo_image}" class="image_preview">
					</c:if>
					<c:if test="${empty userInfo.blog_logo_image or userInfo.blog_logo_image eq ''}">
						<img alt="" src="#" class="image_preview">
					</c:if>
					<input type="file" onchange="preview_image(this, 'logo')" id="blog_logo_image"<c:if test="${not empty userInfo.blog_logo_image and userInfo.blog_logo_image ne ''}"> class="hidden"</c:if>>
					<c:if test="${not empty userInfo.blog_logo_image and userInfo.blog_logo_image ne ''}">
						<button id="logo_image_update_O" class="image_update_O" onclick="toggle_button_for_image('logo', 'change')">변경</button>
						<button id="logo_image_update_X" class="image_update_X hidden" onclick="toggle_button_for_image('logo', '')">X</button>
					</c:if>
					</div>
					<div class="change_button_area">
						<button onclick="change_blog_background('${sessionScope.user.id}')">확인</button>
					</div>
				</main>
			</article>
			<!-- 블로그 배경 설정 종료 -->
			<!-- 블로그 배치 설정 시작 -->
			<article id="setting_blog_placement" class="settingPanel_grid hidden">
				<div class="title"><span>블로그 배치</span></div>
				<main>
					<div class="setting_item_name last"><span>블로그 배치 타입</span></div>
					<div id="blog_setting_type" class="setting_item last">
						<div>
							<div class="blog_setting_type_top">
								<div class="blog_setting_type_preview" style="background-image: url(); background-size: cover;"></div>
							</div>
							<div class="blog_setting_type_middle">
								<span>A 타입</span>
							</div>
							<div class="blog_setting_type_bottom">
								<input type="radio" id="blog_setting_type_A" name="blog_setting_type_radio" value="A"<c:if test="${userInfo.blog_setting_type eq 'A'}"> checked</c:if>>&nbsp;
  								<label for="blog_setting_type_A">선택</label>
							</div>
						</div>
						<div>
							<div class="blog_setting_type_top">
								<div class="blog_setting_type_preview" style="background-image: url(); background-size: cover;"></div>
							</div>
							<div class="blog_setting_type_middle">
								<span>B 타입</span>
							</div>
							<div class="blog_setting_type_bottom">
								<input type="radio" id="blog_setting_type_B" name="blog_setting_type_radio"<c:if test="${userInfo.blog_setting_type eq 'B'}"> checked</c:if>>&nbsp;
  								<label for="blog_setting_type_B">선택</label>
							</div>
						</div>
					</div>
					<div class="change_button_area">
						<button onclick="change_blog_placement('${sessionScope.user.id}')">확인</button>
					</div>
				</main>
			</article>
			<!-- 블로그 배치 설정 종료 -->
			<!-- 블로그 이웃 목록 설정 시작 -->
			<article id="setting_blog_neighbor_list" class="settingPanel_normal neighbor hidden">
				<div class="title"><span>이웃 목록</span></div>
				<main>
					<div class="neighbor_list title">
						<div class="neighbor_info"><span>이웃 정보</span></div>
						<div class="neighbor_status"><span>이웃 상태</span></div>
						<div class="neighbor_signdate"><span>추가일</span></div>
					</div>
					<c:forEach var="neighbor" items="${neighborList_mine}" varStatus="status">
						<div class="neighbor_list<c:if test="${status.last}"> last</c:if>" target="${neighbor.target}">
							<div class="neighbor_info">
								<span>${neighbor.nickname}</span>
								&nbsp;|&nbsp;
								<a href="/blog/${neighbor.target}" class="neighbor_logo_text">
									<c:if test="${not empty neighbor.blog_logo_text and neighbor.blog_logo_text ne ''}">${neighbor.blog_logo_text}</c:if>
									<c:if test="${empty neighbor.blog_logo_text or neighbor.blog_logo_text eq ''}">${neighbor.target}님의 블로그</c:if>
								</a>
							</div>
							<div class="neighbor_status" target="${neighbor.target}">
								<button onclick="cancle_my_neighbor('${sessionScope.user.id}', '${neighbor.target}', '${neighbor.nickname}')">이웃취소</button>
							</div>
							<div class="neighbor_signdate"><span>${neighbor.signdate}</span></div>
						</div>
					</c:forEach>
				</main>
			</article>
			<!-- 블로그 이웃 목록 설정 종료 -->
			<!-- 블로그 나를 추가한 이웃 설정 시작 -->
			<article id="setting_blog_neighbor_follow_me" class="settingPanel_normal neighbor hidden">
				<div class="title"><span>나를 추가한 이웃</span></div>
				<main>
					<div class="neighbor_list title">
						<div class="neighbor_info"><span>이웃 정보</span></div>
						<div class="neighbor_status"><span>이웃 상태</span></div>
						<div class="neighbor_signdate"><span>추가일</span></div>
					</div>
					<c:forEach var="neighbor" items="${neighborList_followMe}" varStatus="status">
						<div class="neighbor_list<c:if test="${status.last}"> last</c:if>">
							<div class="neighbor_info">
								<span>${neighbor.nickname}</span>
								&nbsp;|&nbsp;
								<a href="/blog/${neighbor.id}" class="neighbor_logo_text">
									<c:if test="${not empty neighbor.blog_logo_text and neighbor.blog_logo_text ne ''}">${neighbor.blog_logo_text}</c:if>
									<c:if test="${empty neighbor.blog_logo_text or neighbor.blog_logo_text eq ''}">${neighbor.id}님의 블로그</c:if>
								</a>
							</div>
							<div class="neighbor_status" target="${neighbor.id}">
								<c:if test="${neighbor.status == 1}"><span>이웃</span></c:if>
								<c:if test="${neighbor.status == 0}"><button onclick="add_my_neighbor('${sessionScope.user.id}', '${neighbor.id}', '${neighbor.nickname}')">이웃추가</button></c:if>
							</div>
							<div class="neighbor_signdate"><span>${neighbor.signdate}</span></div>
						</div>
					</c:forEach>
				</main>
			</article>
			<!-- 블로그 나를 추가한 이웃 설정 종료 -->
			<!-- 블로그 카테고리 설정 시작 -->
			<article id="setting_blog_category" class="settingPanel_normal hidden">
				<div class="title">
					<span>카테고리 설정</span>
					<button onclick="category_insert('${sessionScope.user.id}')" style="color: green;"><i class="fas fa-plus-square"></i></button>
				</div>
				<main>
					<c:forEach var="category" items="${categoryList}">
						<div class="category_list">
							<div class="category_name" category_order_no="${category.category_order_no}">
								<span class="name" category_name="${category.category_name}">${category.category_name}</span>&nbsp;
								<span class="count">(&nbsp;${category.count}&nbsp;)</span>
							</div>
							<div class="category_move">
								<button onclick="category_move_up('${sessionScope.user.id}', ${category.category_order_no})" style="color: blue;"><i class="fas fa-caret-square-up"></i></button>
								<button onclick="category_move_down('${sessionScope.user.id}', ${category.category_order_no}, ${category.max})" style="color: blue;"><i class="fas fa-caret-square-down"></i></button>
								<button onclick="category_update('${sessionScope.user.id}', ${category.category_order_no})"><i class="fas fa-edit"></i></button>
								<button onclick="category_delete('${sessionScope.user.id}', ${category.category_order_no})" style="color: red;"><i class="fas fa-window-close"></i></button>
							</div>
						</div>
					</c:forEach>
				</main>
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