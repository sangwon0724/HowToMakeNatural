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
	
	var form = {
	  page: 0,
      object: $('#search_object').val(),
      search_text : $('#search_text').val()
	};
	
	//게시글 변경
	$.ajax({
      url: "/blog/main/Ajax",
      type: "POST",
      data: form,
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
	
	var form = {
		page: 0,
        category: ""
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/main/Ajax",
        type: "POST",
        data: form,
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
	
	var form = {
	  page: 0,
      object: $(event.target).attr("category"),
      search_text : $('#search_text').val()
	};
	
	//게시글 변경
	$.ajax({
      url: "/blog/main/Ajax",
      type: "POST",
      data: form,
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
	
	var form = {
		page: 0,
        category: $(event.target).attr('category')
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/main/Ajax",
        type: "POST",
        data: form,
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

/*============================================================================================================*/

/* 개인 블로그 부분 */