/* 공통 부분 - 차후에 분리 */

//로그인
$('#login').on('click',function(){
	location.href="/login";
});

//로그아웃
$('#logout').on('click',function(){
	location.href="/logout";
});

//로고 클릭
$('#logo>span').on('click', function(event){
	location.href="/";
});

//로그인
function login(){
	location.href="/login";
}

//로그아웃
function logout(){
	location.href="/logout";
}

/*============================================================================================================*/

/* 블로그 공통 */

//내 블로그 클릭시 내 블로그로 이동
function go_user_blog(id){
	location.href="/blog/" + id;
}

//엔터키를 누르는 경우에 검색 실행
function search_enter(){
	if(window.event.keyCode==13) {
  	$('#search_button').click();
  }
}

/*============================================================================================================*/

/* 블로그 메인 부분 */

//글 쓰기 클릭시 내 블로그의 글쓰기 화면으로 이동
function write_my_new_post(id){
	location.href="/blog/"+id+"/write";
}

//검색 기능 - 블로그 메인
function main_search(){
	//강조 변경
	$('#blog_main_category>section>div').removeClass('active');
	$('#category').addClass('hidden');
	$('#search_category').removeClass('hidden');
	$('.search_category_name').removeClass('active');
	
	switch ($('#search_object').val()) {
	  case 'post':
		 $('.search_category_name:nth-child(1)').addClass('active');
	    break;
	  case 'theme':
		 $('.search_category_name:nth-child(2)').addClass('active');
		  break;
	  case 'writer':
		 $('.search_category_name:nth-child(3)').addClass('active');
	    break;
	}
	
	var data = {
	  start: 0,
	  block: 10,
      object: $('#search_object').val(),
      search : $('#search_text').val()
	};
	
	//게시글 변경
	$.ajax({
      url: "/blog/main/Ajax",
      type: "POST",
      data: JSON.stringify(data),
      contentType: "application/json",
      success: function(result){
      	var postList="";
      	
      	$.each(result.postList, function (index, item) {
      		var content = item.content;
      		content = content.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
      		content = content.replace(/<IMG(.*?)>/gi, "");
      		
      		postList+=
             `<div class="main_post">
                 <div class="post_content">
					<div class="post_profileAndName">
						<div class="post_userProfile" userID="${item.userID}"></div>
						<a href="/blog/${item.userID}">${item.userNickName}</a>
					</div>
					<div class="post_title"><a href="/blog/${item.userID}/${item.no}">${item.title}</a></div>
					<div class="post_text"><a href="/blog/${item.userID}/${item.no}">${content}</a></div>
					<div class="post_goodAndComment">
						<span>좋아요 0</span>
						<span>댓글 0</span>
					</div>
				</div>
				<div class="post_image"></div>
			</div>`;
          });//each 종료
          $('#board').html(postList);
      },
      error: function(error){
          alert("오류 발생");
          console.log(error);
      }
  });
}

//블로그홈 클릭
function blog_home_ajax(){
	//강조 변경
	$('#category').removeClass('hidden');
	$('#category_name:first-child').addClass('active');
	$('#search_category').addClass('hidden');
	$('#blog_main_category>section>div:first-child').addClass('active');
	
	var data = {
		start: 0,
	    block: 10,
        category: ""
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/main/Ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var postList="";
        	
        	$.each(result.postList, function (index, item) {
          		var content = item.content;
          		content = content.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
          		content = content.replace(/<IMG(.*?)>/gi, "");
          		
        		postList+=
               `<div class="main_post">
                   <div class="post_content">
					<div class="post_profileAndName">
						<div class="post_userProfile" userID="${item.userID}"></div>
						<a href="/blog/${item.userID}">${item.userNickName}</a>
					</div>
					<div class="post_title"><a href="/blog/${item.userID}/${item.no}">${item.title}</a></div>
					<div class="post_text"><a href="/blog/${item.userID}/${item.no}">${content}</a></div>
					<div class="post_goodAndComment">
						<span>좋아요 0</span>
						<span>댓글 0</span>
					</div>
				</div>
				<div class="post_image"></div>
			</div>`;
            });//each 종료
            $('#board').html(postList);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

//검샊 게시글 카테고리 클릭
function blog_main_search_category_click(category){
	//강조 변경
	$('.search_category_name').removeClass('active');
	
	switch (category) {
	  case 'post':
		 $('.search_category_name:nth-child(1)').addClass('active');
		 $("#search_object option:eq(0)").prop("selected", true);
	    break;
	  case 'theme':
		 $('.search_category_name:nth-child(2)').addClass('active');
		 $("#search_object option:eq(1)").prop("selected", true);
		  break;
	  case 'writer':
		 $('.search_category_name:nth-child(3)').addClass('active');
		 $("#search_object option:eq(2)").prop("selected", true);
	    break;
	}
	
	var data = {
	  start: 0,
	  block: 10,
      object: $(event.target).attr("category"),
      search : $('#search_text').val()
	};
	
	//게시글 변경
	$.ajax({
      url: "/blog/main/Ajax",
      type: "POST",
      data: JSON.stringify(data),
      contentType: "application/json",
      success: function(result){
      	var postList="";
      	
      	$.each(result.postList, function (index, item) {
      		var content = item.content;
      		content = content.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
      		content = content.replace(/<IMG(.*?)>/gi, "");
      		
      		postList+=
             `<div class="main_post">
                 <div class="post_content">
					<div class="post_profileAndName">
						<div class="post_userProfile" userID="${item.userID}"></div>
						<a href="/blog/${item.userID}">${item.userNickName}</a>
					</div>
					<div class="post_title"><a href="/blog/${item.userID}/${item.no}">${item.title}</a></div>
					<div class="post_text"><a href="/blog/${item.userID}/${item.no}">${content}</a></div>
					<div class="post_goodAndComment">
						<span>좋아요 0</span>
						<span>댓글 0</span>
					</div>
				</div>
				<div class="post_image"></div>
			</div>`;
          });//each 종료
          $('#board').html(postList);
      },
      error: function(error){
          alert("오류 발생");
          console.log(error);
      }
  });
}

//게시글 카테고리 클릭
function blog_main_category_click(category){
	//강조 변경
	$('#category > .category_name').removeClass('active');
	$(event.target).addClass('active');
	
	var data = {
		start: 0,
	    block: 10,
        category: category
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/main/Ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var postList="";
        	
        	$.each(result.postList, function (index, item) {
          		var content = item.content;
          		content = content.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
          		content = content.replace(/<IMG(.*?)>/gi, "");
          		
        		postList+=
               `<div class="main_post">
                   <div class="post_content">
					<div class="post_profileAndName">
						<div class="post_userProfile" userID="${item.userID}"></div>
						<a href="/blog/${item.userID}">${item.userNickName}</a>
					</div>
					<div class="post_title"><a href="/blog/${item.userID}/${item.no}">${item.title}</a></div>
					<div class="post_text"><a href="/blog/${item.userID}/${item.no}">${content}</a></div>
					<div class="post_goodAndComment">
						<span>좋아요 0</span>
						<span>댓글 0</span>
					</div>
				</div>
				<div class="post_image"></div>
			</div>`;
            });//each 종료
            $('#board').html(postList);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

//블로그 메인에서 내 메뉴 클릭 //임시/ 만들 예정
function blog_main_my_menu_my_post(id, menu){
	//강조 변경
	$('#my_menu>#third>div').removeClass('active');
	$('#my_menu>#third>div#'+menu).addClass('active');
	
	var data = {
		id: id,
		menu: menu
    };
	
	//내용 변경 + 주소변경 (임시 주석)
	$.ajax({
        url: "/blog/menu/Ajax/",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var list="";
        	
        	if(menu==="my_news"){
        		$.each(result.newsList, function (index, item) {
            		list+=``;
                });//each 종료
        	}
        	else if(menu==="my_post"){
        		$.each(result.postList, function (index, item) {
            		list+=``;
                });//each 종료
        	}
        	else if(menu==="my_neighbor"){
            	$.each(result.neighborList, function (index, item) {
            		list+=``;
                });//each 종료
        	}
            $('#info_area>#my_menu>#show_info').html(postList);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/*============================================================================================================*/


/* 개인 블로그 */

/* 개인 블로그 네이게이션 - 이웃 블로그 */
function neighbor_blog(){
	//작성 예정
	alert("이웃 블로그 목록 열기 기능 제작 예정");
}

/* 개인 블로그 네이게이션 - 블로그 홈 */
function blog_home(){
	location.href="/blog/main";
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
        url: "/blog/menu/Ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var neighborList="";
        	$.each(result.neighborList, function (index, item) {
        		neighborList+=
               `<div neighborID="${item.target}">
					<main neighborID="${item.target}">
						이미지 영역
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
	        url: "/blog/paging/Ajax",
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
	        			`>${item.title}</a>&nbsp;<span>(댓글수)</span>
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
        url: "/blog/paging/Ajax",
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
        			`>${item.title}</a>&nbsp;<span>(댓글수)</span>
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
	        url: "/blog/paging/Ajax",
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
function write_submit(text, id, userNickName, no){
	var title = $("#title").val();
	var tag = $("#tag").val();
	var category = $("#category option:selected").val();
	var content = $('#summernote').summernote('code');
	var url="";
	var no;
	
	if(text === "등록"){
		url = "/blog/" + id +"/write/ajax";
	}
	else if(text === "수정"){
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
        	alert("게시글이 정상적으로 " + text + "되었습니다.");
        	location.href="/blog/"+$("#myID").val();
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
function post_update_no(){
	$("#go_update").css('display','none');
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
function post_delete_no(){
	$("#go_delete").css('display','none');
}

/* 댓글 추가 */
function write_comment(id, no){
	var data = {
		userID : id,
		no : no,
		content : $(".personal_post>.post_comment_hidden>#write_comment>main>#write_comment_content").val()
	};
	
	$.ajax({
        url: "/blog/comment/ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	alert("연결 성공");
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}