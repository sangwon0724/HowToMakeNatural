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
<link href="<c:url value="/resources/css/blog.css" />" rel="stylesheet"
	type="text/css">
<title>
	<c:if test='${userInfo.blog_logo_text != null && userInfo.blog_logo_text != ""}'>${userInfo.blog_logo_text}</c:if>
	<c:if test='${userInfo.blog_logo_text == null or userInfo.blog_logo_text == ""}'>${userInfo.id}님의 블로그</c:if>
</title>
</head>
<body>
	<!-- 히든 값 영역 시작 -->
		<c:if test="${not empty sessionScope.user.id}">
		<!-- 현재 유저의 아이디 -->
		<input type="hidden" id="myID" value="${sessionScope.user.id}">
		<input type="hidden" id="myNickName" value="${sessionScope.user.blog_nickname}">
		</c:if>
		
		<!-- 현재 위치한 블로그 주인의 아이디 -->
		<input type="hidden" id="blogUserID" value="${userInfo.id}">
		<!-- 현재 게시글 번호 -->
		<input type="hidden" id="nowPostNo" value="${nowPostNo}">
		
		<c:if test='${neighborList != null and neighborList != ""}'>
			<c:forEach items="${neighborList}" var="neighbor" begin="0" end="0">
				<c:set var="neighbor_count" value="${neighbor.count}"/>
			</c:forEach>
		</c:if>
		<!-- 이웃 목록에 불러들일 전체 이웃의 수 -->
		<input type="hidden" id="neighbor_count" value="${neighbor_count}">
		<!-- 이웃 목록의 총 페이지 수 -->
		<c:if test="${neighbor_count%9 != 0}">
			<fmt:parseNumber var="neighbor_page_total" value="${neighbor_count/9+(1-neighbor_count/9%1)%1}" integerOnly="true"/>
		</c:if>
		<c:if test="${neighbor_count%9 == 0}">
			<fmt:parseNumber var="neighbor_page_total" value="${neighbor_count/9}" integerOnly="true"/>
		</c:if>
		<input type="hidden" id="neighbor_page_total" value="${neighbor_page_total}">
		<!-- 이웃 목록의 현재 페이지 -->
		<input type="hidden" id="neighbor_page_current" value="1">
		
		<!-- 게시글의 총 개수 -->
		<!-- 게시글 목록의 총 페이지 수 -->
		<!-- 게시글 목록(위쪽)의 현재 페이지 -->
		<!-- 게시글 목록(아래쪽)의 현재 페이지 -->
	<!-- 히든 값 영역 종료 -->
	<div id="center_panel">
		<!-- 네비게이션 시작 -->
		<nav id="personal_nav">
			<div>
				<div id="span_type">
					<span id="my_blog" class="click" myID="<c:if test="${not empty sessionScope.user.id}">${sessionScope.user.id}</c:if>">내 블로그</span>
					<span> | </span>
					<span id="neighbor_blog" class="click" myID="<c:if test="${not empty sessionScope.user.id}">${sessionScope.user.id}</c:if>">이웃 블로그</span>
					<span> | </span>
					<span id="blog_home" class="click" >블로그홈</span>
				</div>
				<div id="blog_sign" class="flex_center_center">
				<c:if test="${empty sessionScope.user.id}"><span>로그인</span></c:if>
				<c:if test="${not empty sessionScope.user.id}"><span>로그아웃</span></c:if>
				</div>
				<div id="blog_all_menu" class="flex_center_center"><i class="fas fa-th"></i></div>
			</div>
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
		
	<c:choose>
		<c:when test="${fn:contains(userInfo.blog_setting_type, 'A')}">
			<main id="blog_personal_main" class="typeA">
		</c:when>
		<c:when test="${fn:contains(userInfo.blog_setting_type, 'B')}">
			<main id="blog_personal_main" class="typeB">
		</c:when>
	</c:choose>
			<!-- 프로필  + 검색 + 카테고리 + 이웃목록 + 위젯 시작 (type A. 기본)-->
			<c:choose>
				<c:when test="${fn:contains(userInfo.blog_setting_type, 'A')}">
					<div id="left" class="typeA">
						<div id="profile_panel">
							<div id="profile_image">프로필 이미지</div>
							<div id="profile_nickname" class="flex_center_center"><span>${userInfo.blog_nickname}</span>&nbsp;<span>(${userInfo.id})</span></div>
							<div id="profile_text" class="flex_center_center">
								<span><c:if test='${userInfo.blog_profile_text != null and userInfo.blog_profile_text != "" }'>${userInfo.blog_profile_text}</c:if></span>
							</div>
							<div id="personal_buttons" class="flex_center_center">
								<c:if test="${not empty sessionScope.user.id and sessionScope.user.id eq userInfo.id}">
									<span onclick="location.href='/blog/${sessionScope.user.id}/write'"><i class="fas fa-pen"></i>&nbsp;글쓰기</span>
									<span><i class="fas fa-cog"></i>&nbsp;관리</span>
								</c:if>
								<c:if test="${empty sessionScope.user.id or sessionScope.user.id ne userInfo.id}">
									<div class="flex_center_center">
										<span>이웃 추가</span>
										<i class="fas fa-plus"></i>
									</div>
								</c:if>
							</div>
						</div>
						<div id="search_panel" class="flex_center_center">
							<input type="text" id="search_text">
							<div id="search_button">
								<i class="fas fa-search"></i>
							</div>
						</div>
						<div id="category_panel">
							<span>전체</span>
							<c:if test='${categoryList != null and categoryList != ""}'>
							</c:if>
						</div>
						<div id="neighbor_panel">
							<header>
								<span>이웃 목록</span>
							</header>
							<main>
								<c:if test='${neighborList == null or neighborList == ""}'>
									<span>이웃이 없습니다.</span>
								</c:if>
								<c:if test='${neighborList != null and neighborList != ""}'>	
									<c:forEach items="${neighborList}" var="neighbor" begin="0" end="8">
										<div neighborID="${neighbor.target}">
											<main neighborID="${neighbor.target}">
												이미지 영역
											</main>
											<footer>
												<span>${neighbor.nickname}</span>
											</footer>
										</div>
									</c:forEach>
								</c:if>
							</main>
							<footer class="flex_center_center">
								<div id="neighbor_page_left" class="flex_center_center disabled">
									<i class="fas fa-chevron-left" aria-hidden="true"></i>
								</div>
								<div id="neighbor_page_right" class="flex_center_center<c:if test="${neighbor_page_total == 1}"> disabled</c:if>">
									<i class="fas fa-chevron-right" aria-hidden="true"></i>
								</div>
							</footer>
						</div>
					</div>
				</c:when>
			</c:choose>
			<!-- 프로필  + 검색 + 카테고리 + 이웃목록 + 위젯 종료 (type A. 기본)-->
			
			<!-- 게시글 패널 (type A. 기본) -->
			<div id=center class="flex_column_center_center typeA">
				<!-- 검색창 시작 (type B. 기본X) -->
				<span class="searchbox typeB"></span>
				<!-- 검색창 종료  (type B. 기본X) -->
				<!-- 게시글 목록 시작 (목록 열기/닫기 가능 O) -->
				<header id="post_list_summary_O">
					<div id="post_list_toggle">목록 닫기</div>
					<table cellspacing="0" cellpadding="0" class="post_summary_list">
						<colgroup>
							<col width = "75%">
							<col width = "25%">
						</colgroup>
						<thead>
							<tr>
								<th><div class="title"><span>글 제목</span></div></th>
								<th><div class="date"><span>작성일</span></div></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${postList}" var="post" begin="0" end="4">
							<tr>
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
								<header class="post_category">
									<span>
										<c:if test="${post.category eq '' or post.category == null}">전체</c:if>
										<c:if test="${post.category ne '' and post.category != null}">${post.category}</c:if>
									</span>
								</header>
								<header class="post_title">
									<span>${post.title}</span>
									<c:if test="${sessionScope.user.id eq userInfo.id}">
									<div id="button_updateAndDelete">
										<button id="update" no="${post.no}" onclick="open_modal('go_update')">수정하기</button>
										<button id="delete" no="${post.no}" onclick="open_modal('go_delete')">삭제하기</button>
									</div>
									</c:if>
								</header>
								<header class="post_profileAndNameAndSigndate">
									<div class="profile_image"><%-- 프로필 이미지 --%></div>
									<span>${userInfo.blog_nickname}</span>
								</header>
								<main class="post_content">${post.content}</main>
								<footer class="post_goodAndComment">
									<div id="post_good" class="flex_center_center">
									<c:if test='${thisPostIsGood != null and thisPostIsGood != ""}'>
										<i class="fas fa-heart"></i>
									</c:if>
									<c:if test='${thisPostIsGood == null or thisPostIsGood == ""}'>
										<i class="far fa-heart"></i>
									</c:if>
									<span>좋아요 <span id="goodCount">0</span></span>
									</div>
									<div id="post_comment" class="flex_center_center">
										<span>댓글&nbsp;<span id="commentCount">0</span></span>&nbsp;|&nbsp;
										<i class="fas fa-chevron-down"></i>
									</div>
								</footer>
								<footer class="post_comment_hidden hidden">
									<div class="comment">댓글</div>
								</footer>
							</div>
					    </c:forEach>
				    </c:if>
					<c:if test='${onePost != null and onePost != ""}'>
						<div class="personal_post">
							<header class="post_category">
								<span>
									<c:if test="${onePost.category eq '' or onePost.category == null}">전체</c:if>
									<c:if test="${onePost.category ne '' and onePost.category != null}">${post.category}</c:if>
								</span>
							</header>
							<header class="post_title">
								<span>${onePost.title}</span>
								<c:if test="${sessionScope.user.id eq userInfo.id}">
								<div id="button_updateAndDelete">
									<button id="update" no="${post.no}" onclick="open_modal('go_update')">수정하기</button>
									<button id="delete" no="${post.no}" onclick="open_modal('go_delete')">삭제하기</button>
								</div>
								</c:if>
							</header>
							<header class="post_profileAndNameAndSigndate">
								<div class="profile_image"></div>
								<span>${userInfo.blog_nickname}</span>
							</header>
							<main class="post_content">${onePost.content}</main>
							<footer class="post_goodAndComment">
									<div id="post_good" class="flex_center_center">
									<c:if test='${thisPostIsGood != null and thisPostIsGood != ""}'>
										<i class="fas fa-heart"></i>
									</c:if>
									<c:if test='${thisPostIsGood == null or thisPostIsGood == ""}'>
										<i class="far fa-heart"></i>
									</c:if>
									<span>좋아요 <span id="goodCount">0</span></span>
									</div>
									<div id="post_comment" class="flex_center_center">
										<span>댓글&nbsp;<span id="commentCount">0</span></span>&nbsp;|&nbsp;
										<i class="fas fa-chevron-down"></i>
									</div>
								</footer>
								<footer class="post_comment_hidden hidden">
									<div class="comment">댓글</div>
								</footer>
						</div>
				    </c:if>
				</main>
				<!-- 게시글이 보이는 화면 종료 -->
				<!-- 게시글 목록 시작 (목록 열기/닫기 가능 X) -->
				<footer id="post_list_summary_X">
					<table cellspacing="0" cellpadding="0" class="post_summary_list">
						<colgroup>
							<col width="75%"/>
    						<col width="25%"/>
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
	
	
	
	<!-- 모달 영역 시작 -->
	<c:if test="${sessionScope.user.id eq userInfo.id}">
	<div id="go_update" class="modal">
	    <div class="modal-content_forButton">
	      <span class="close">&times;</span>
	      <div class="modal_content">
	      	<span>해당 게시글을 수정하시겠습니까?</span>
			<div id="button_yesOrNo">
				<button id="yes">예</button>
				<button id="no">아니오</button>
			</div>
	      </div>
	    </div>
	</div>
	
	<div id="go_delete" class="modal">
	    <div class="modal-content_forButton">
	      <span class="close">&times;</span>
	      <div class="modal_content">
	      	<span>해당 게시글을 삭제하시겠습니까?</span>
			<div id="button_yesOrNo">
				<button id="yes">예</button>
				<button id="no">아니오</button>
			</div>
	      </div>
	    </div>
	</div>
	</c:if>
	<!-- 모달 영역 종료 -->
	
	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog.js"/>"></script>
	
	<!-- 공통 적용 파일 시작 -->
			<c:import url="../include/footer.jsp"></c:import>
	<!-- 공통 적용 파일 -->
</body>
</html>