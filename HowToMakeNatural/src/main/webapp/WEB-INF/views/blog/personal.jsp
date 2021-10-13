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
		
		<c:if test='${neighborList != null and neighborList != ""}'>
			<c:forEach items="${neighborList}" var="neighbor" begin="0" end="0">
				<c:set var="neighbor_count" value="${neighbor.count}"/>
			</c:forEach>
		</c:if>
		<%-- 이웃 목록에 불러들일 전체 이웃의 수 --%>
		<input type="hidden" id="neighbor_count" value="${neighbor_count}">
		<%-- 이웃 목록의 총 페이지 수 --%>
		<c:if test="${neighbor_count%9 != 0}">
			<fmt:parseNumber var="neighbor_page_total" value="${neighbor_count/9+(1-neighbor_count/9%1)%1}" integerOnly="true"/>
		</c:if>
		<c:if test="${neighbor_count%9 == 0}">
			<fmt:parseNumber var="neighbor_page_total" value="${neighbor_count/9}" integerOnly="true"/>
		</c:if>
	<!-- 히든 값 영역 종료 -->
	
	
	
	<div id="center_panel">
		<!-- 네비게이션 시작 -->
		<nav id="personal_nav">
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
		
		
		
		<!-- 배경글 시작 -->
		<header id="background_logo" class="flex_column_center_center" <c:if test='${userInfo.blog_logo_image != null and userInfo.blog_logo_image != ""}'> background-image="${userInfo.blog_logo_image}"</c:if>
		onclick="go_user_blog('${userInfo.id}')"
		>
			<span>
				<c:if test='${userInfo.blog_logo_text != null && userInfo.blog_logo_text != ""}'>${userInfo.blog_logo_text}</c:if>
				<c:if test='${userInfo.blog_logo_text == null or userInfo.blog_logo_text == ""}'>${userInfo.id}님의 블로그입니다.</c:if>
			</span>
		</header>
		<!-- 배경글 종료 -->
		
		
		
		<c:if test="${mode eq 'view'}">
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
								<c:if test="${(empty sessionScope.user.id or neighborCheck == 0) and sessionScope.user.id ne userInfo.id}">
									<div class="flex_center_center">
										<span>이웃 추가</span>
										<i class="fas fa-plus"></i>
									</div>
								</c:if>
							</div>
						</div>
						<div id="search_panel" class="flex_center_center">
							<input type="text" id="search_text" onkeyup="search_enter()">
							<div id="search_button" onclick="personal_blog_search('${userInfo.id}')">
								<i class="fas fa-search"></i>
							</div>
						</div>
						<div id="category_panel">
							<span<c:if test='${param.category == null or param.category == ""}'> class="active"</c:if> onclick="go_user_blog('${userInfo.id}')">전체</span>
							<c:if test='${categoryList != null and categoryList != ""}'>
								<c:forEach items="${categoryList}" var="item">
									<span<c:if test="${param.category eq item.name}"> class="active"</c:if> onclick="go_user_blog_category('${userInfo.id}','${item.name}')">${item.name}</span>
								</c:forEach>
							</c:if>
						</div>
						<div id="neighbor_panel">
							<header>
								<span>이웃 목록</span>
							</header>
							<main<c:if test='${empty neighborList or neighborList eq ""}'> style="border-bottom:none;"</c:if>>
								<c:if test='${neighborList == null or neighborList == ""}'>
									<span>이웃이 없습니다.</span>
								</c:if>
								<c:if test='${neighborList != null and neighborList != ""}'>	
									<c:forEach items="${neighborList}" var="neighbor" begin="0" end="8">
										<div neighborID="${neighbor.target}">
											<main onclick="go_user_blog('${neighbor.target}')">
												이미지 영역
											</main>
											<footer>
												<span>${neighbor.nickname}</span>
											</footer>
										</div>
									</c:forEach>
								</c:if>
							</main>
							<footer class="<c:if test='${empty neighborList or neighborList eq ""}'>hidden</c:if><c:if test='${not empty neighborList and neighborList ne ""}'>flex_center_center</c:if>">
								<div id="neighbor_page_left" class="flex_center_center disabled" onclick="paging_neighbor_left(${neighbor_page_total},'${userInfo.id}')" page="0">
									<i class="fas fa-chevron-left" aria-hidden="true"></i>
								</div>
								<div id="neighbor_page_right" class="flex_center_center<c:if test="${neighbor_page_total == 1}"> disabled</c:if>" onclick="paging_neighbor_right(${neighbor_page_total},'${userInfo.id}')" page="2">
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
					<c:if test="${not empty postList and postList ne ''}">
					<div id="post_list_toggle" onclick="blog_post_list_toggle()">목록 닫기</div>
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
									<a href="/blog/${userInfo.id}/${post.no}" <c:if test="${post.no == onePost.no}"> class="active"</c:if>>${post.title}</a>&nbsp;<span>(댓글수)</span>
								</td>
								<td class="date">
									<span>${post.signdate}</span>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<footer class="post_list_summary_paging flex_center_center">
						<c:if test="${not empty postList and postList ne ''}">
							<c:if test="${paging.block_total gt 1 and paging.block_current gt 1}">
									<div class="post_list_paging_left flex_center_center" style="margin-right: 20px;" onclick="personal_paging_top(${status.current},'${userInfo.id}',${onePost.no},'left')"><i class="fas fa-angle-left"></i></div>
							</c:if>
							<c:forEach var="index" varStatus="status" begin="${(paging.block_current-1)*10+1}" end="${(paging.block_current-1)*10+10}">
								<c:if test="${status.current le paging.page_total}">
									<div class="post_list_paging_number flex_center_center<c:if test="${status.current == paging.page_current}"> active</c:if>" page="${status.current}" onclick="personal_paging_top(${status.current},'${userInfo.id}',${onePost.no}, 'number')"><span>${status.current}</span></div>
								</c:if>
							</c:forEach>
							<c:if test="${paging.block_total gt 1 and paging.block_current lt paging.block_total}">
									<div class="post_list_paging_right flex_center_center" style="margin-left: 20px;" onclick="personal_paging_top(${status.current},'${userInfo.id}',${onePost.no},'right')"><i class="fas fa-angle-right"></i></div>
							</c:if>
						</c:if>
					</footer>
					</c:if>
				</header>
				<!-- 게시글 목록 종료 (목록 열기/닫기 가능 O) -->
				<!-- 게시글이 보이는 화면 시작 -->
				<main id="post_panel">
					<c:if test='${empty onePost or onePost eq ""}'>
						<span>게시글이 존재하지 않습니다.</span>
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
									<button id="update" onclick="open_modal('go_update')">수정하기</button>
									<button id="delete" onclick="open_modal('go_delete')">삭제하기</button>
								</div>
								</c:if>
							</header>
							<header class="post_profileAndNameAndSigndate">
								<div class="profile_image" onclick="go_user_blog('${userInfo.id}')"></div>
								<span onclick="go_user_blog('${userInfo.id}')">${userInfo.blog_nickname}</span>
							</header>
							<main class="post_content">${onePost.content}</main>
							<footer class="post_tag">
								<c:if test="${onePost.tag != null and onePost.tag != ''}">
									<c:forEach items="${fn:split(onePost.tag,'#')}" var="item">
										<div class="tag flex_center_center" onclick="personal_blog_tag('${userInfo.id}','${item}')"><span><i>#</i>${item}</span></div>
									</c:forEach>
								</c:if>
							</footer>
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
								<div id="post_comment" class="flex_center_center" onclick="comment_area_toggle()">
									<span>댓글&nbsp;<span id="commentCount"><c:if test="${fn:length(commentList) > 0}">${fn:length(commentList)}</c:if><c:if test="${fn:length(commentList) < 0 or empty commentList}">0</c:if></span></span>&nbsp;|&nbsp;
									<i class="fas fa-chevron-down"></i>
								</div>
							</footer>
							<footer class="post_comment_hidden hidden">
								<c:if test="${not empty sessionScope.user.id}">
									<div id="write_comment">
										<header>
											<div class="profile_image"></div>
											<span class="nickname">${sessionScope.user.blog_nickname}</span>
										</header>
										<main>
											<textarea id="write_comment_content"></textarea>
											<div id="write_comment_button" class="flex_center_center" onclick="write_comment('${sessionScope.user.id}', ${onePost.no}, '${sessionScope.user.blog_nickname}')">작성</div>
										</main>
									</div>
								</c:if>
								
								<c:if test="${commentList != null and commentList ne ''}">
									<c:forEach items="${commentList}" var="item">
										<div class="comment" no="${item.no}">
											<header>
												<div class="profile_image"></div>
												<span class="nickname">${item.userNickname}</span>
												<c:if test="${sessionScope.user.id eq item.userID}">
													<div class="update_comment_button flex_center_center" onclick="open_modal_for_update_comment('update_comment', ${item.no})">
														<i class="fas fa-edit"></i>
													</div>
													<div class="delete_comment_button flex_center_center" onclick="open_modal_for_delete_comment('delete_comment', ${item.no})">
														<i class="fas fa-times"></i>
													</div>
												</c:if>
											</header>
											<main>${item.content}</main>
											<footer>${item.signdate}</footer>
										</div>
									</c:forEach>
								</c:if>
							</footer>
						</div>
				    </c:if>
				</main>
				<!-- 게시글이 보이는 화면 종료 -->
				<!-- 게시글 목록 시작 (목록 열기/닫기 가능 X) -->
				<footer id="post_list_summary_X">
					<c:if test="${not empty postList and postList ne ''}">
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
							<tr>
								<td class="title">
									<a href="/blog/${userInfo.id}/${post.no}<c:if test="${param.category != null and param.category ne ''}">?category=${param.category}</c:if>" <c:if test="${post.no == onePost.no}"> class="active"</c:if>>${post.title}</a>&nbsp;<span>(댓글수)</span>
								</td>
								<td class="date">
									<span>${post.signdate}</span>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<footer class="post_list_summary_paging flex_center_center">
						<div id="post_list_bottom_left" <c:if test="${paging.page_total gt 1 and paging.page_current gt 1}"> class="active"</c:if> page="0" onclick="personal_paging_bottom_left('${userInfo.id}', ${onePost.no}, ${paging.page_total})"><i class="fas fa-angle-left"></i>&nbsp;이전</div>
						<div id="post_list_bottom_right" <c:if test="${paging.page_total gt 1 and paging.page_current lt paging.page_total}"> class="active"</c:if> page="2" onclick="personal_paging_bottom_right('${userInfo.id}', ${onePost.no}, ${paging.page_total})">다음&nbsp;<i class="fas fa-angle-right"></i></div>
					</footer>
				</c:if>
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
		<%--게시글이 빈 경우에 대한 화면 잘림 방지용 --%>
		<c:if test="${empty postList or postList eq ''}"><div style="width: 100%; height: 30vh;"></div></c:if>
		<!-- 블로그 메인화면 종료 -->
		</c:if>
		
		
		
		<c:if test="${mode eq 'search' or mode eq 'tag'}">
		<!-- 블로그 검색화면 시작 -->
			<c:if test="${mode eq 'search'}">
			<!-- 검색 배너 시작 -->
				<div id="search_banner" class="flex_center_center">
					<div id="search_box" class="flex_center_center">
						<input type="text" id="search_text" onkeyup="search_enter()" value="${target}">
						<div id="search_button" onclick="personal_blog_search('${userInfo.id}')">
							<i class="fas fa-search"></i>
						</div>
					</div>
				</div>
			<!-- 검색 배너 종료 -->
			</c:if>
			
			<!-- 검색 결과 영역 시작 -->
				<div id="search_result_pannel">
					<!-- 검색 결과 게시글의 개수 시작 -->
					<header>
						<c:if test="${mode eq 'tag'}">
							<span id="tag_target">#${target}</span>
						</c:if>
						<span>검색결과 : 총 <span>${count}</span> 건</span>
					</header>
					<!-- 검색 결과 게시글의 개수 종료 -->
					
					<!-- 검색 결과 게시글의 표출 시작 -->
					<main>
						<c:if test="${count == 0}">
							<div id="zero_post">게시글이 존재하지 않습니다.</div>
						</c:if>
						<c:if test="${count gt 0}">
							<c:forEach items="${postList}" var="post" begin="0" end="9">
								<div class="post">
									<div class="title">
										<a href="/blog/${userInfo.id}/${post.no}">${post.title}</a>
									</div>
									<div class="content<c:if test="${mode eq 'tag'}"> tag</c:if>">
										<span>${post.content.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "")}</span>
										<c:if test="${mode eq 'tag'}">
											<c:if test="${post.tag != null and post.tag != ''}">
												<div class="tag_area">
													<c:forEach items="${fn:split(post.tag,'#')}" var="item">
														<div class="flex_center_center" onclick="personal_blog_tag('${userInfo.id}','${item}')"><span><i>#</i>${item}</span></div>
													</c:forEach>
												</div>
											</c:if>
										</c:if>
									</div>
									<div class="signdate flex_center_center">
										<span>${post.signdate}</span>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</main>
					<!-- 검색 결과 게시글의 표출 종료 -->
					
					<!-- 검색 결과 게시글의 페이징 시작 -->
					<c:if test="${paging.page_total gt 1}">
					<footer class="flex_center_center">
						<c:if test="${paging.block_total gt 1 and paging.block_current gt 1}">
								<div class="post_list_paging_left flex_center_center" style="margin-right: 20px;" onclick="personal_paging_search(${status.current},'${userInfo.id}', 'left','${mode}','${target}')"><i class="fas fa-angle-left"></i></div>
						</c:if>
						<c:forEach var="index" varStatus="status" begin="${(paging.block_current-1)*10+1}" end="${(paging.block_current-1)*10+10}">
							<c:if test="${status.current le paging.page_total}">
								<div class="post_list_paging_number flex_center_center<c:if test="${status.current == paging.page_current}"> active</c:if>" page="${status.current}" onclick="personal_paging_search(${status.current},'${userInfo.id}', 'number','${mode}','${target}')"><span>${status.current}</span></div>
							</c:if>
						</c:forEach>
						<c:if test="${paging.block_total gt 1 and paging.block_current lt paging.block_total}">
								<div class="post_list_paging_right flex_center_center" style="margin-left: 20px;" onclick="personal_paging_search(${status.current},'${userInfo.id}', 'right','${mode}','${target}')"><i class="fas fa-angle-right"></i></div>
						</c:if>
					</footer>
					</c:if>
					<!-- 검색 결과 게시글의 페이징 종료 -->
				</div>
			<!-- 검색 결과 영역 종료 -->
		<!-- 블로그 검색화면 종료 -->
		</c:if>
	</div>
	
	
	
	<!-- 모달 영역 시작 -->
	<c:if test="${sessionScope.user.id eq userInfo.id}">
	<div id="go_update" class="modal">
	    <div class="modal-content_forButton">
	      <span class="close">&times;</span>
	      <div class="modal_content">
	      	<span>해당 게시글을 수정하시겠습니까?</span>
			<div id="button_yesOrNo">
				<button onclick="post_update_yes('${sessionScope.user.id}',${onePost.no})">예</button>
				<button onclick="modal_cancle()">아니오</button>
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
				<button onclick="post_delete_yes('${sessionScope.user.id}',${onePost.no})">예</button>
				<button onclick="modal_cancle()">아니오</button>
			</div>
	      </div>
	    </div>
	</div>
	
	<div id="update_comment" class="modal">
	    <div class="modal-content_forButton">
	      <span class="close">&times;</span>
	      <div class="modal_content">
	      	<span>해당 댓글을 수정하시겠습니까?</span>
			<div id="button_yesOrNo">
				<button class="yes" onclick="update_comment_active('${sessionScope.user.id}')">예</button>
				<button class="no" onclick="modal_cancle()">아니오</button>
			</div>
	      </div>
	    </div>
	</div>
	
	<div id="delete_comment" class="modal">
	    <div class="modal-content_forButton">
	      <span class="close">&times;</span>
	      <div class="modal_content">
	      	<span>해당 댓글을 삭제하시겠습니까?</span>
	      	<input type="hidden" id="delete_comment_target_no" value="">
			<div id="button_yesOrNo">
				<button class="yes" onclick="delete_comment('${sessionScope.user.id}')">예</button>
				<button class="no" onclick="modal_cancle()">아니오</button>
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