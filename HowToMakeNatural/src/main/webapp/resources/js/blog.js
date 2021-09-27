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

/*============================================================================================================*/

/* 블로그 메인 부분 */

//로그인
$('#blog_header>section>#login_small>div').on('click',function(){
	location.href="/login";
});
$('#common_header>section>#login_small>div').on('click',function(){
	if($("#common_header>section>#login_small>div").text().match("로그인")){
		location.href="/login";
	}
	else if($("#common_header>section>#login_small>div").text().match("로그아웃")){
		location.href="/logout";
	}
});


//프로필 사진 클릭시 해당 유저의 블로그로 이동
$('.post_userProfile').on('click', function(event){
	//location.href="/blog/"+$(event.target).attr("userID");
	location.href="/blog/"+$("#my_ID").val();
});

//내 닉네임 클릭시 내 블로그로 이동
$('#my_nickname').on('click', function(event){
	//location.href="/blog/"+$(event.target).attr("userID");
	location.href="/blog/"+$("#my_ID").val();
});

//내 블로그 클릭시 내 블로그로 이동
$('#my_blog').on('click', function(event){
	location.href="/blog/"+$("#my_ID").val();
});

//글 쓰기 클릭시 내 블로그의 글쓰기 화면으로 이동
$('#write_new_post').on('click', function(event){
	location.href="/blog/"+$("#my_ID").val()+"/write";
});

//검색 기능 - 블로그 메인
$('#common_header>section>#search>#search_box>#search_button').on('click', function(event){
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
      		postList+=
             `<div class="main_post">
                 <div class="post_content">
					<div class="post_profileAndName">
						<div class="post_userProfile" userID="${item.userID}"></div>
						<a href="/blog/${item.userID}">${item.userNickName}</a>
					</div>
					<div class="post_title"><a href="/blog/${item.userID}/${item.no}">${item.title}</a></div>
					<div class="post_text"><a href="/blog/${item.userID}/${item.no}">${item.content}</a></div>
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
});
$("#common_header>section>#search>#search_box>#search_text").on("keyup",function(key){
    if(key.keyCode==13) {
    	$('#search_button').click();
    }
});

//블로그홈 클릭
$('#blog_main_category>section>div:first-child').on('click', function(event){
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
        		postList+=
               `<div class="main_post">
                   <div class="post_content">
					<div class="post_profileAndName">
						<div class="post_userProfile" userID="${item.userID}"></div>
						<a href="/blog/${item.userID}">${item.userNickName}</a>
					</div>
					<div class="post_title"><a href="/blog/${item.userID}/${item.no}">${item.title}</a></div>
					<div class="post_text"><a href="/blog/${item.userID}/${item.no}">${item.content}</a></div>
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
});

//검샊 게시글 카테고리 클릭
$('#search_category > .search_category_name').on('click', function(event){
	//강조 변경
	$('.search_category_name').removeClass('active');
	
	switch ($(event.target).attr("category")) {
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
      		postList+=
             `<div class="main_post">
                 <div class="post_content">
					<div class="post_profileAndName">
						<div class="post_userProfile" userID="${item.userID}"></div>
						<a href="/blog/${item.userID}">${item.userNickName}</a>
					</div>
					<div class="post_title"><a href="/blog/${item.userID}/${item.no}">${item.title}</a></div>
					<div class="post_text"><a href="/blog/${item.userID}/${item.no}">${item.content}</a></div>
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
});

//게시글 카테고리 클릭
$('#category > .category_name').on('click', function(event){
	//강조 변경
	$('#category > .category_name').removeClass('active');
	$(event.target).addClass('active');
	
	var data = {
		start: 0,
	    block: 10,
        category: $(event.target).attr('category')
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
        		postList+=
               `<div class="main_post">
                   <div class="post_content">
					<div class="post_profileAndName">
						<div class="post_userProfile" userID="${item.userID}"></div>
						<a href="/blog/${item.userID}">${item.userNickName}</a>
					</div>
					<div class="post_title"><a href="/blog/${item.userID}/${item.no}">${item.title}</a></div>
					<div class="post_text"><a href="/blog/${item.userID}/${item.no}">${item.content}</a></div>
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
});

//내 글 클릭 //임시/ 만들 예정
$('#my_menu>#third>div').on('click', function(event){
	//강조 변경
	$('#my_menu>#third>div').removeClass('active');
	$('#my_menu>#third>div#'+$(event.target).attr("id")).addClass('active');
	
	var data = {
		start: 0,
	    block: 10
    };
	
	//내용 변경 + 주소변경 (임시 주석)
	$.ajax({
        url: "/blog/main/Ajax/"+$(event.target).attr("id"),
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var postList="";
        	
        	$.each(result.postList, function (index, item) {
        		postList+=``;
            });//each 종료
            //$('#board').html(postList);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
});

/*============================================================================================================*/


/* 개인 블로그 네이게이션 - 내 블로그 */
$('#personal_nav>div>#span_type>span#my_blog').on('click', function(event){
	var myID=$("#personal_nav>div>#span_type>span#my_blog").attr('myID');
	
	if(myID===""){
		location.href="/login";
	}
	else if(myID!==""){
		location.href="/blog/"+myID;
	}
});

/* 개인 블로그 네이게이션 - 이웃 블로그 */
$('#personal_nav>div>#span_type>span#neighbor_blog').on('click', function(event){
	var myID=$("#personal_nav>div>#span_type>span#my_blog").attr('myID');
	
	if(myID===""){
		location.href="/login";
	}
	else if(myID!==""){
		//작성 예정
	}
});

/* 개인 블로그 네이게이션 - 블로그 홈 */
$('#personal_nav>div>#span_type>span#blog_home').on('click', function(event){
	location.href="/blog/main";
});

/* 개인 블로그 네이게이션 - 로그인 */
$('#personal_nav>div>#blog_sign').on('click', function(event){
	if($('#personal_nav>div>#blog_sign>span').text()==='로그인'){
		location.href="/login";
	}
	else if($('#personal_nav>div>#blog_sign>span').text()==='로그아웃'){
		location.href="/logout";
	}
});

/* 개인 블로그 네이게이션 - 로그인 */
$('#background_logo').on('click', function(event){
	location.href="/blog/" + $("#blogUserID").val();
});

/* 게시글 목록 열고 닫기 */
$('#post_list_summary_O>#post_list_toggle').on('click', function(event){
	if($("#post_list_summary_O>#post_list_toggle").text()==="목록 닫기"){
		$("#post_list_summary_O>#post_list_toggle").text("목록 열기");
		$("#post_list_summary_O>table").addClass("hidden");
		$("#post_list_summary_O>.post_list_summary_paging").addClass("hidden");
	}
	else if($("#post_list_summary_O>#post_list_toggle").text()==="목록 열기"){
		$("#post_list_summary_O>#post_list_toggle").text("목록 닫기");
		$("#post_list_summary_O>table").removeClass("hidden");
		$("#post_list_summary_O>.post_list_summary_paging").removeClass("hidden");
	}
});

/* 개인 블로그 게시글의 프로필 이미지 클릭시 개인 블로그 메인으로 이동 */
$('.personal_post>.post_profileAndNameAndSigndate>.profile_image').on('click', function(event){
	location.href="/blog/"+$("#blogUserID").val();
});

/* 개인 블로그 게시글의 유저 닉네임 클릭시 개인 블로그 메인으로 이동 */
$('.personal_post>.post_profileAndNameAndSigndate>span').on('click', function(event){
	location.href="/blog/"+$("#blogUserID").val();
});

/* 이웃 목록에서 이웃의 프로필 클릭 시 해당 이웃의 블로그로 이동 */
$('#neighbor_panel>main>div>main').on('click', function(event){
	location.href="/blog/"+$(event.target).attr("neighborID");
});

/* 이웃목록의 페이지 변경 */
$('#neighbor_panel>footer>div').on('click', function(event){
	var total_page = parseInt($('#neighbor_page_total').val()); //총 페이지 수
	var current_page =  parseInt($('#neighbor_page_current').val()); //현재 페이지
	var change_page=0; //변경될 페이지
	
	var target = $(event.target); //타겟 저장
	
	if($(target).attr('id')==="neighbor_page_left" && $(target).hasClass('disabled') !== true){
		if(current_page >= 2){
			change_page = current_page - 1;
			$('#neighbor_page_current').val(change_page); //페이지 값 변경
		}
	}
	else if ($(target).attr('id')==="neighbor_page_right" && $(target).hasClass('disabled') !== true){
		if(current_page -1 < total_page){
			change_page = current_page + 1;
			$('#neighbor_page_current').val(change_page); //페이지 값 변경
		}
	}
	
	//오류방지
	if(change_page !== 0){
		//1페이지에 대한 조건문
		if(change_page === 1){
			$('#neighbor_panel>footer>div#neighbor_page_left').addClass('disabled');
		}
		else if(change_page !== 1){
			$('#neighbor_panel>footer>div#neighbor_page_left').removeClass('disabled');
		}
		
		//마지막 페이지에 대한 조건문
		if(change_page === total_page){
			$('#neighbor_panel>footer>div#neighbor_page_right').addClass('disabled');
		}
		else if (change_page !== total_page){
			$('#neighbor_panel>footer>div#neighbor_page_right').removeClass('disabled');
		}
		
		//MariaDB에 대해서 limit에 사용할 값 설정
		change_page-=1; //MariaDB 특성 - 0부터 시작
		change_page*=9; //한 페이지당 9명씩 표출, SQL에 추가
		
		//Ajax로 전달할 값 설정
		var data = {
			start: parseInt(change_page),
		    userID : $('#blogUserID').val()
	    };
		//게시글 변경
		$.ajax({
	        url: "/blog/perosnal/Ajax/my_neighbor",
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
});

/* 게시글의 댓글 영역 활성/비활성 */
$('.personal_post>.post_goodAndComment>#post_comment').on('click', function(event){
	//댓글 버튼을 클릭하여 히든 영역이 활성화 된 경우
	//1. 댓글 버튼에 active 클래스를 toggle
	//2. 버튼의 모양 변경
	//3. 댓글 히든 영역 활성화
	
	if($(".personal_post>.post_goodAndComment>#post_comment").hasClass("active") !== true){
		console.log("오픈");
		$(".personal_post>.post_goodAndComment>#post_comment").addClass("active");
		$(".personal_post>.post_goodAndComment>#post_comment>i").removeClass("fa-chevron-down");
		$(".personal_post>.post_goodAndComment>#post_comment>i").addClass("fa-chevron-up");
		$(".personal_post>.post_comment_hidden").removeClass("hidden");
	}
	else if($(".personal_post>.post_goodAndComment>#post_comment").hasClass("active") === true){
		console.log("클로즈");
		$(".personal_post>.post_goodAndComment>#post_comment").removeClass("active");
		$(".personal_post>.post_goodAndComment>#post_comment>i").removeClass("fa-chevron-up");
		$(".personal_post>.post_goodAndComment>#post_comment>i").addClass("fa-chevron-down");
		$(".personal_post>.post_comment_hidden").addClass("hidden");
		
	}
});

/* 게시글 리스트 페이징 */
$('페이징 링크').on('click', function(event){
	var total_page = parseInt($('#게시글 총페이지').val()); //총 페이지 수
	var current_page =  parseInt($('#게시글 현재 페이지').val()); //현재 페이지
	var change_page=0; //변경될 페이지
	
	var target = $(event.target); //타겟 저장
	
	if($(target).attr('id')==="왼쪽" && $(target).hasClass('disabled') !== true){
		if(current_page >= 2){
			change_page = current_page - 1;
			$('#neighbor_page_current').val(change_page); //페이지 값 변경
		}
	}
	else if ($(target).attr('id')==="오른쪽" && $(target).hasClass('disabled') !== true){
		if(current_page -1 < total_page){
			change_page = current_page + 1;
			$('#neighbor_page_current').val(change_page); //페이지 값 변경
		}
	}
	
	//오류방지
	if(change_page !== 0){
		//1페이지에 대한 조건문
		if(change_page === 1){
			$('#왼쪽').addClass('disabled');
		}
		else if(change_page !== 1){
			$('왼쪽').removeClass('disabled');
		}
		
		//마지막 페이지에 대한 조건문
		if(change_page === total_page){
			$('#오른쪽').addClass('disabled');
		}
		else if (change_page !== total_page){
			$('오른쪽').removeClass('disabled');
		}
		
		//MariaDB에 대해서 limit에 사용할 값 설정
		change_page-=1; //MariaDB 특성 - 0부터 시작
		change_page*=5; //한 페이지당 5개씩 표출, SQL에 추가
		
		//Ajax로 전달할 값 설정
		var data = {
			start: parseInt(change_page),
		    userID : $('#blogUserID').val()
	    };
		//게시글 변경
		$.ajax({
	        url: "/blog/"+$("#myID").val()+"/Ajax",
	        type: "POST",
	        data: JSON.stringify(data),
	        contentType: "application/json",
	        success: function(result){
	        	var postList="";
	        	$.each(result.postList, function (index, item) {
	        		postList+=
	               `내용`;
	            });//each 종료
	            $('#게시글 목록').html(postList);
	        },
	        error: function(error){
	            alert("오류 발생");
	            console.log(error);
	        }
	    });
	}
});

/*============================================================================================================*/

/* 블로그 작성 + 수정 + 삭제 부분 */

/* 게시글 추가 */
function write_submit(text){
	var title = $("#title").val();
	var tag = $("#tag").val();
	var category = $("#category option:selected").val();
	var content = $('#summernote').summernote('code');
	var url="";
	var no=0;
	
	if(text === "등록"){
		url = "/blog/"+$("#myID").val()+"/write/ajax";
	}
	else if(text === "수정"){
		url = "/blog/"+$("#myID").val()+"/"+$("#no").val()+"/update/ajax";
		no = $("#no").val();
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
		userID : $("#myID").val(),
		userNickName : $("#myNickName").val(),
		no: no
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
$("#go_update>.modal-content_forButton>.modal_content>#button_yesOrNo>#yes").on('click',function(){
	location.href= "/blog/" + $("#myID").val() + "/" + $("#button_updateAndDelete>#update").attr('no') + "/update";
});
$("#go_update>.modal-content_forButton>.modal_content>#button_yesOrNo>#no").on('click',function(){
	$("#go_update").css('display','none');
});

/* 게시글 삭제 관련 모달 */
$("#go_delete>.modal-content_forButton>.modal_content>#button_yesOrNo>#yes").on('click',function(){
	var no= $("#button_updateAndDelete>#delete").attr('no');
	
	$.ajax({
        url: "/blog/"+$("#myID").val()+"/"+no+"/delete",
        type: "POST",
        data: {},
        contentType: "application/json",
        success: function(result){
        	alert("게시글이 정상적으로 삭제되었습니다.");
        	location.href="/blog/"+$("#myID").val();
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
});
$("#go_delete>.modal-content_forButton>.modal_content>#button_yesOrNo>#no").on('click',function(){
	$("#go_delete").css('display','none');
});