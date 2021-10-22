/* 개인 블로그 */

/* 개인 블로그 네이게이션 - 이웃 블로그 */
function neighbor_blog(){
	//작성 예정
	alert("이웃 블로그 목록 열기 기능 제작 예정");
}

/* 카테고리 클릭 */
function go_user_blog_category(id, category){
	location.href="/blog/" + id + "?category=" + category;
}

/* 게시글 목록 열고 닫기 */
function blog_post_list_toggle(){
	if($(event.target).text()==="목록 닫기"){
		$("#post_list_summary_O>#post_list_toggle").text("목록 열기");
		$("#post_list_summary_O>table").addClass("hidden");
		$("#post_list_summary_O>footer").removeClass("flex_center_center");
		$("#post_list_summary_O>footer").addClass("hidden");
		$("#post_list_summary_O>.post_list_summary_paging").addClass("hidden");
	}
	else if($(event.target).text()==="목록 열기"){
		$("#post_list_summary_O>#post_list_toggle").text("목록 닫기");
		$("#post_list_summary_O>table").removeClass("hidden");
		$("#post_list_summary_O>footer").addClass("flex_center_center");
		$("#post_list_summary_O>footer").removeClass("hidden");
		$("#post_list_summary_O>.post_list_summary_paging").removeClass("hidden");
	}
}

//이웃목록 - 좌측 페이징 버튼
function paging_neighbor_left(total_page, userID){
	var page = parseInt($(event.target).attr("page")); //클릭한 버튼이 가지고 있는 페이지 속성값
	
	//제약 조건 설정
	if($(event.target).hasClass('disabled') !== true && page >= 1){
		//MariaDB에 대해서 limit에 사용할 값 설정
		var start = page;
		start-=1; //MariaDB 특성 - 0부터 시작
		start*=9; //한 페이지당 9명씩 표출, SQL에 추가
		
		//ajax로 화면 수정
		paging_neighbor_ajax(start, userID);
		
		//페이징 버튼의 css 수정
		if(page === 1){
			$('#neighbor_panel>footer>div#neighbor_page_left').addClass('disabled');
		}
		else if(page !== 1){
			$('#neighbor_panel>footer>div#neighbor_page_left').removeClass('disabled');
		}
		$('#neighbor_panel>footer>div#neighbor_page_right').removeClass('disabled');
		
		//페이징 버튼의 page 속성값 수정
		$('#neighbor_panel>footer>div#neighbor_page_left').attr('page',page-1);
		$('#neighbor_panel>footer>div#neighbor_page_right').attr('page',page+1);
	}
}
//이웃목록 - 우측 페이징 버튼
function paging_neighbor_right(total_page, userID){
	var page = parseInt($(event.target).attr("page")); //클릭한 버튼이 가지고 있는 페이지 속성값
	
	//제약 조건 설정
	if($(event.target).hasClass('disabled') !== true && page <= total_page){
		//MariaDB에 대해서 limit에 사용할 값 설정
		var start = page;
		start-=1; //MariaDB 특성 - 0부터 시작
		start*=9; //한 페이지당 9명씩 표출, SQL에 추가
		
		//ajax로 화면 수정
		paging_neighbor_ajax(start, userID);
		
		//페이징 버튼의 css 수정
		
		//마지막 페이지에 대한 조건문
		if(page === total_page){
			$('#neighbor_panel>footer>div#neighbor_page_right').addClass('disabled');
		}
		else if (page !== total_page){
			$('#neighbor_panel>footer>div#neighbor_page_right').removeClass('disabled');
		}
		$('#neighbor_panel>footer>div#neighbor_page_left').removeClass('disabled');
		
		//페이징 버튼의 page 속성값 수정
		$('#neighbor_panel>footer>div#neighbor_page_left').attr('page',page-1);
		$('#neighbor_panel>footer>div#neighbor_page_right').attr('page',page+1);
	}
}

//이웃목록 - 화면변경 ajax
function paging_neighbor_ajax(start, userID){
	//Ajax로 전달할 값 설정
	var data = {
		start: start,
	    userID : userID,
	    menu : "my_neighbor"
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/menu/ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var neighborList="";
        	$.each(result.neighborList, function (index, item) {
        		neighborList+=
               `<div neighborID="${item.target}">
					<main>
						<img onclick="go_user_blog('${item.target}')" src="${item.blog_profile_image}">
					</main>
					<footer>
						<span>${item.nickname}</span>
					</footer>
				</div>`;
            });//each 종료
            $('#neighbor_panel>main').html(neighborList);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 게시글의 댓글 영역 활성/비활성 */
function comment_area_toggle(){
	console.log($(event.target));
	if($(event.target).hasClass("active") !== true){
		//댓글창 드러내기
		$(".personal_post>.post_comment_hidden").addClass("comment_open");
		$(".personal_post>.post_goodAndComment>#post_comment").addClass("active");
		$(".personal_post>.post_goodAndComment>#post_comment>i").removeClass("fa-chevron-down");
		$(".personal_post>.post_goodAndComment>#post_comment>i").addClass("fa-chevron-up");
		$(".personal_post>.post_comment_hidden").removeClass("hidden");
	}
	else if($(event.target).hasClass("active") === true){
		//댓글창 숨기기
		$(".personal_post>.post_comment_hidden").removeClass("comment_open");
		$(".personal_post>.post_goodAndComment>#post_comment").removeClass("active");
		$(".personal_post>.post_goodAndComment>#post_comment>i").removeClass("fa-chevron-up");
		$(".personal_post>.post_goodAndComment>#post_comment>i").addClass("fa-chevron-down");
		$(".personal_post>.post_comment_hidden").addClass("hidden");
	}
}

/* 게시글 리스트 페이징 (상단) */
function personal_paging_top(page,blogUserID,nowPostNo, mode){
	var start=page; //변경될 값

	//1. 이전 목록
	//2. 다음 목록
	//3. 숫자
	
	if(mode === "left"){
		//이전 목록으로 가는 코드 작성
	}
	else if (mode === "right"){
		//다음 목록으로 가는 코드 작성
	}
	else if (mode === "number"){
		//MariaDB에 대해서 limit에 사용할 값 설정
		start-=1; //MariaDB 특성 - 0부터 시작
		start*=5; //한 페이지당 5개씩 표출, SQL에 추가
		
		//Ajax로 전달할 값 설정
		var data = {
			start: parseInt(start),
		    userID : blogUserID
	    };
		//게시글 변경
		$.ajax({
	        url: "/blog/paging/ajax",
	        type: "POST",
	        data: JSON.stringify(data),
	        contentType: "application/json",
	        success: function(result){
	        	$('#post_list_summary_O>.post_list_summary_paging>div.active').removeClass('active'); //활성화 css 삭제, 공통
	        	
	        	
	        	var postList="";
	        	$.each(result.postList, function (index, item) {
	        		postList+=
	               `<tr><td class="title"><a href="/blog/${blogUserID}/${item.no}"`;
	        		
	        		if(parseInt(item.no) === nowPostNo){postList+=` class="active"`;}
	        		
	        		postList+=
	        			`>${item.title}</a>&nbsp;<span>(${item.commentCount})</span>
					</td>
					<td class="date">
						<span>${item.signdate}</span>
					</td>
				</tr>`;
	            });//each 종료
	            $('#post_list_summary_O>.post_summary_list>tbody').html(postList);
	            $('#post_list_summary_O>.post_list_summary_paging>div[page='+page+']').addClass('active');
	        },
	        error: function(error){
	            alert("오류 발생");
	            console.log(error);
	        }
	    });
	}
}

/* 게시글 리스트 페이징 (하단) - 좌측 */
function personal_paging_bottom_left(blogUserID, nowPostNo, total_page){
	var page = parseInt($(event.target).attr("page"));
	
	var start=page; //변경될 값
	
	//제약조건 설정
	if($(event.target).hasClass('active') === true && page >= 1){
		//화면 변경
		personal_paging_bottom_ajax(blogUserID, page, nowPostNo);
		
		//css 변경
		if(page === 1){
			$('#post_list_summary_X>.post_list_summary_paging>div#post_list_bottom_left').removeClass('active');
		}
		else if(page !== 1){
			$('#post_list_summary_X>.post_list_summary_paging>div#post_list_bottom_left').addClass('active');
		}
		$('#post_list_summary_X>.post_list_summary_paging>div#post_list_bottom_right').addClass('active');
	}
}

/* 게시글 리스트 페이징 (하단) - 우측 */
function personal_paging_bottom_right(blogUserID, nowPostNo, total_page){
	var page = parseInt($(event.target).attr("page"));
	
	var start=page; //변경될 값
	
	//제약조건 설정
	if($(event.target).hasClass('active') === true && page <= total_page){
		//화면 변경
		personal_paging_bottom_ajax(blogUserID, page, nowPostNo);
		
		//css 변경
		if(page === total_page){
			$('#post_list_summary_X>.post_list_summary_paging>div#post_list_bottom_right').removeClass('active');
		}
		else if (page !== total_page){
			$('#post_list_summary_X>.post_list_summary_paging>div#post_list_bottom_right').addClass('active');
		}
		$('#post_list_summary_X>.post_list_summary_paging>div#post_list_bottom_left').addClass('active');
	}
}

/* 게시글 리스트 페이징 ajax (하단) */
function personal_paging_bottom_ajax(blogUserID, page, nowPostNo){
	var start=page; //변경될 값
	
	//MariaDB에 대해서 limit에 사용할 값 설정
	start-=1; //MariaDB 특성 - 0부터 시작
	start*=5; //한 페이지당 5개씩 표출, SQL에 추가
	
	//Ajax로 전달할 값 설정
	var data = {
		start: parseInt(start),
	    userID : blogUserID
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/paging/ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var postList="";
        	$.each(result.postList, function (index, item) {
        		postList+=
               `<tr><td class="title"><a href="/blog/${blogUserID}/${item.no}"`;
        		
        		if(parseInt(item.no) === nowPostNo){postList+=` class="active"`;}
        		
        		postList+=
        			`>${item.title}</a>&nbsp;<span>(${item.commentCount})</span>
				</td>
				<td class="date">
					<span>${item.signdate}</span>
				</td>
			</tr>`;
            });//each 종료
            $('#post_list_summary_X>.post_summary_list>tbody').html(postList);
            
    		//page 속성 변경
    		$('#post_list_summary_X>.post_list_summary_paging>div#post_list_bottom_left').attr('page', page-1);
    		$('#post_list_summary_X>.post_list_summary_paging>div#post_list_bottom_right').attr('page', page+1);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

//문자열 검색 기능 - 개인 블로그
function personal_blog_search(userID){
	location.href="/blog/" + userID + "/search/" + $("#search_text").val();
}

//문자열 검색 기능 - 개인 블로그
function personal_blog_tag(userID, tag){
	location.href="/blog/" + userID + "/tag/" + tag;
}

//검색 페이지에 대한 페이징
function personal_paging_search(page, blogUserID, mode, type, value){
	var start=page; //변경될 값

	//1. 이전 목록
	//2. 다음 목록
	//3. 숫자
	
	if(mode === "left"){
		//이전 목록으로 가는 코드 작성
	}
	else if (mode === "right"){
		//다음 목록으로 가는 코드 작성
	}
	else if (mode === "number"){
		//MariaDB에 대해서 limit에 사용할 값 설정
		start-=1; //MariaDB 특성 - 0부터 시작
		start*=10; //한 페이지당 5개씩 표출, SQL에 추가
		
		//Ajax로 전달할 값 설정
		var data = {
			start: parseInt(start),
		    userID : blogUserID
	    };
		
		if(type === "search"){
			data.search = value;
		}
		else if(type === "tag"){
			data.tag = value;
		}
		
		//게시글 변경
		$.ajax({
	        url: "/blog/paging/ajax",
	        type: "POST",
	        data: JSON.stringify(data),
	        contentType: "application/json",
	        success: function(result){
	        	$('#search_result_pannel>footer>div').removeClass('active');
	        	
	        	var postList="";
	        	$.each(result.postList, function (index, item) {
	        		var content = item.content;
	          		content = content.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	          		content = content.replace(/<IMG(.*?)>/gi, "");
	          		
	          		//제목 및 링크 추가
	        		postList+=
	               `
	              <div class="post">
							<div class="title">
								<a href="/blog/${blogUserID}/${item.no}">${item.title}</a>
							</div>
							<div class="content`;
	        		
	        		//tag의 경우에 추가하는 css class
	        		if(type === "tag"){
	        			postList+=` tag`;
	        		}
	        		
	        		//게시글 내용 추가
	        		postList+=`"><span>${content}</span>`;
	        		
	        		if(type === "tag" && item.tag !== null && item.tag !== ""){
	        			postList+=`<div class="tag_area">`; //태그 영역 열기
	        			
	        			//테그 아이템들 이어 붙이기
	        			$.each(item.tag.split('#'), function(index_inner, item_inner){
	        				postList+=`<div class="flex_center_center" onclick="personal_blog_tag('${blogUserID}','${item_inner}')"><span><i>#</i>${item_inner}</span></div>`;
	        			});
	        			
    				    postList+=`</div>`; //태그 영역 닫기
	        		}
	        		
	        		//작성일
					postList+=
					`	</div>
						<div class="signdate flex_center_center">
							<span>${item.signdate}</span>
						</div>
					</div>`;
	            });//each 종료
	            $('#search_result_pannel>main').html(postList);
	            $('#search_result_pannel>footer>div[page='+page+']').addClass('active');
	        },
	        error: function(error){
	            alert("오류 발생");
	            console.log(error);
	        }
	    });
	}
}

/*============================================================================================================*/

/* 블로그 작성 + 수정 + 삭제 부분 */

/* 게시글 추가 */
function write_submit(mode, id, userNickName, no){
	var title = $("#title").val();
	var tag = $("#tag").val();
	var category = $("#category option:selected").val();
	var content = $('#summernote').summernote('code');
	var url="";
	var no;
	
	if(mode === "insert"){
		url = "/blog/" + id +"/write/ajax";
	}
	else if(mode === "update"){
		url = "/blog/" + id +"/" + parseInt(no) + "/update/ajax";
	}
	
	if(category === null || category === undefined){
		category = "";
	}
	
	if (title === "")
	{
		alert("게시글의 제목을 입력해주세요");
		$("#title").focus();
		return;
	}
	if (title !== "" && content === "<p><br></p>")
	{
		alert("게시글의 내용을 입력해주세요");
		return;
	}
	
	var data = {
		title : title,
		tag : tag,
		category : category,
		content : content,
		userID : id,
		userNickName : userNickName,
		no: parseInt(no)
	};

	$.ajax({
        url: url,
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	if(mode === "insert"){
            	alert("게시글이 정상적으로 동록되었습니다.");
        		location.href="/blog/" + id;
        	}
        	else if(mode === "update"){
            	alert("게시글이 정상적으로 수정되었습니다.");
        		location.href="/blog/" + id + "/" + no;
        	}
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 게시글 수정 관련 모달 */
function post_update_yes(id, no){
	location.href= "/blog/" + id + "/" + no + "/update";
}

/* 게시글 삭제 관련 모달 */
function post_delete_yes(id, no){
	$.ajax({
        url: "/blog/"+id+"/"+no+"/delete",
        type: "POST",
        data: {},
        contentType: "application/json",
        success: function(result){
        	alert("게시글이 정상적으로 삭제되었습니다.");
        	location.href="/blog/"+id;
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 댓글 추가 */
function write_comment(id, no, nickname){
	var data = {
		userID : id,
		no : no,
		content : $(".personal_post>.post_comment_hidden>#write_comment>main>#write_comment_content").val()
	};
	
	$.ajax({
        url: "/blog/comment/insert",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var nickname_temp=nickname; //왠지 모를 오류때문에 추가
        	var commentList="";
        	
        	//댓글 쓰기 영역 추가
        	commentList+=`
        		<div id="write_comment">
					<header>
						<div class="profile_image"></div>
						<span class="nickname">${nickname_temp}</span>
					</header>
					<main>
						<textarea id="write_comment_content"></textarea>
						<div id="write_comment_button" class="flex_center_center" onclick="write_comment('${id}', ${no})">작성</div>
					</main>
				</div>
        	`;
        	
        	//댓글 추가
        	$.each(result.commentList, function (index, item) {
        		commentList+=`
        		<div class="comment" no="${item.no}">
					<header>
						<div class="profile_image"></div>
						<span class="nickname">${item.userNickname}</span>`;
        		
        		if(id === item.userID){
        			commentList+=`
						<div class="update_comment_button flex_center_center" onclick="open_modal_for_update_comment('update_comment', ${item.no})">
							<i class="fas fa-edit"></i>
						</div>
						<div class="delete_comment_button flex_center_center" onclick="open_modal_for_delete_comment('delete_comment', ${item.no})">
							<i class="fas fa-times"></i>
						</div>
        			`;
        		}
        		
			   commentList+=`
					</header>
					<main>${item.content}</main>
					<footer>${item.signdate}</footer>
				</div>
        		`;
            });//each 종료
        	
        	//$(".personal_post>.post_goodAndComment>#post_comment>span>span#commentCount").html(result.commentList.length); //댓글 수 변경
        	$(".personal_post>.post_comment_hidden").html(commentList);
        	alert("댓글이 정상적으로 추가되었습니다.");
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 모달 열기 - 댓글 수정용 */
function open_modal_for_update_comment(target, no){
    var modal = document.getElementById(target);
    var close = document.querySelector("#" + target + " .close");

    modal.style.display = "block";
    
    //$("#update_comment_target_no").val(no);
    $("#update_comment>.modal-content_forButton>.modal_content>#button_yesOrNo>button.yes").attr("no", no);
    
    close.onclick = function() {
        modal.style.display = "none";
    }
}
/* 댓글 수정 */
function update_comment_active(id){
	var no = $(event.target).attr("no");
	
	var content = $(".personal_post>.post_comment_hidden>.comment[no="+no+"]>main").html();
	
	modal_cancle();
	
	var update_form = `
	<textarea class="update_comment_content">${content}</textarea>
	<div class="update_comment_button flex_center_center" onclick="update_comment('${id}', ${no})">수정</div>									
	`;

	$(".personal_post>.post_comment_hidden>.comment[no="+no+"]>footer").addClass("hidden"); //footer 영역 삭제 (작성일)
	$(".personal_post>.post_comment_hidden>.comment[no="+no+"]>main").addClass("updateComment"); //main 영역의 css 변경 (댓글 작성 영역과 동일하게 변경)
	$(".personal_post>.post_comment_hidden>.comment[no="+no+"]>main").html(update_form);
}

/* 댓글 수정 */
function update_comment(id, no){
	var content = $(".personal_post>.post_comment_hidden>.comment[no="+no+"]>main>.update_comment_content").val();
	
	var data = {
		userID : id,
		no : no,
		content : content
	};
	
	$.ajax({
        url: "/blog/comment/update",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var commentList="";
        	
        	commentList += `
        		<p>
        			${content}
        		</p>
        	`;
        	
        	$(".personal_post>.post_comment_hidden>.comment[no="+no+"]>footer").removeClass("hidden"); //footer 영역 복구 (작성일)
        	$(".personal_post>.post_comment_hidden>.comment[no="+no+"]>main").removeClass("updateComment"); //main 영역의 css 변경 (일반 댓글 영역과 동일하게 변경)
        	$(".personal_post>.post_comment_hidden>.comment[no="+no+"]>main").html(commentList);
        	alert("댓글이 정상적으로 수정되었습니다.");
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 모달 열기 - 댓글 삭제용 */
function open_modal_for_delete_comment(target, no){
    var modal = document.getElementById(target);
    var close = document.querySelector("#" + target + " .close");

    modal.style.display = "block";
    
    //$("#delete_comment_target_no").val(no);
    $("#delete_comment>.modal-content_forButton>.modal_content>#button_yesOrNo>button.yes").attr("no", no);
    
    close.onclick = function() {
        modal.style.display = "none";
    }
}

/* 댓글 삭제 */
function delete_comment(id){
	//var no = parseInt($("#delete_comment_target_no").val());
	var no = parseInt($(event.target).attr("no"));
	
	var data = {
		userID : id,
		no : no
	};
	
	$.ajax({
        url: "/blog/comment/delete",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	modal_cancle();
        	$(".personal_post>.post_comment_hidden>.comment[no="+no+"]").css('display', 'none');
        	alert("댓글이 정상적으로 삭제되었습니다.");
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 좋아요 추가 및 취소 */
function goodAddAndCancle(id, no){
	if(id === ''){
		if (confirm("로그인이 필요한 서비스입니다.\n로그인하시겠습니까?")) {
	        location.href="/login";
	    }
		else{
			return;
		}
	}
	
	var data = {
		userID : id,
		no : no,
		mode: $("#post_good").attr("mode")
	};
	
	$.ajax({
        url: "/blog/good/ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	if($("#post_good").attr("mode") === "insert"){
            	$(".personal_post>.post_goodAndComment>#post_good>i").removeClass("far");
            	$(".personal_post>.post_goodAndComment>#post_good>i").addClass("fas");
            	$("#post_good").attr("mode", "delete");
        	}
        	else if($("#post_good").attr("mode") === "delete"){
            	$(".personal_post>.post_goodAndComment>#post_good>i").removeClass("fas");
            	$(".personal_post>.post_goodAndComment>#post_good>i").addClass("far");
            	$("#post_good").attr("mode", "insert");
        	}
        	
        	$(".personal_post>.post_goodAndComment>#post_good>span>span#goodCount").html(result.goodCount);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 모달 열기 - 이웃 추가용 */
function open_modal_for_add_neighbor(id){
	if(id === ''){
		if (confirm("로그인이 필요한 서비스입니다.\n로그인하시겠습니까?")) {
	        location.href="/login";
	    }
		else{
			return;
		}
	}
	else if(id !== ''){
	    var modal = document.getElementById("add_neighbor");
	    var close = document.querySelector("#add_neighbor .close");

	    modal.style.display = "block";
	    
	    close.onclick = function() {
	        modal.style.display = "none";
	    }
	}
}

/* 이웃 추가 */
function addNeighbor(id, target){
	var data = {
		userID : id,
		target: target,
		mode: "insert"
	};
	
	$.ajax({
        url: "/blog/neighbor/ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	alert("정상적으로 추가되었습니다.");
        	window.location.reload();
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}