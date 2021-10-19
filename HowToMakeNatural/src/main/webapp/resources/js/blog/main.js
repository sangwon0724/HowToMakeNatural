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
	
	var object = $('#search_object').val();
    var search = $('#search_text').val();
	
	//게시글 변경
	$.ajax({
      url: "/blog/main/ajax",
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
						<span>좋아요 ${item.goodCount}</span>
						<span>댓글 ${item.commentCount}</span>
					</div>
				</div>`;
	        		
	        		if(item.thumbnail !== null && item.thumbnail !== ''){
	        			postList+=
        				`
        				<div class="post_images">
		      				<img src="${item.thumbnail}" onclick="location.href='/blog/${item.userID}/${item.no}'">
						</div>
        				`;
	        		}
	        		
	        		postList += `</div>`;
          });//each 종료
          $('#board').html(postList);

          //페이징 부분 변경
          var pagingList="";
          
          if(result.paging !== undefined && result.paging.page_total > 1){
          	if(result.paging.block_total > 1 && result.paging.block_current > 1){
          		pagingList += `
          			<div class="post_list_paging_left flex_center_center" style="margin-right: 20px;" onclick="main_post_paging(${(result.paging.block_current-1)*10},'', 'left', '${object}', '${search}')"><i class="fas fa-angle-left"></i></div>
          		`;
          	}
          	
          	var paging_start = (result.paging.block_current-1)*10+1; //반복문 시작 값
          	var paging_end = (result.paging.block_current-1)*10+10; //반복문 종료 값
          	
          	for(var index=paging_start; index<=paging_end; index++){
          		if(index <= result.paging.page_total){
          			pagingList +=`<div class="post_list_paging_number flex_center_center`;
          			
          			if(index === result.paging.page_current){ pagingList += ` active`;}
          			
          			pagingList +=`" page="${index}" onclick="main_post_paging(${index},'', 'number', '${object}', '${search}')"><span>${index}</span></div>`;
          		}
          	} //for 종료
          	
          	if(result.paging.block_total > 1 && result.paging.block_current < result.paging.block_total){
          		pagingList += `
          			<div class="post_list_paging_right flex_center_center" style="margin-left: 20px;" onclick="main_post_paging(${(result.paging.block_current+1)*10+1},'', 'right', '${object}', '${search}')"><i class="fas fa-angle-right"></i></div>
          		`;
          	}
          }
          $('#main_paging').html(pagingList);
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
        url: "/blog/main/ajax",
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
						<span>좋아요 ${item.goodCount}</span>
						<span>댓글 ${item.commentCount}</span>
					</div>
				</div>`;
	        		
	        		if(item.thumbnail !== null && item.thumbnail !== ''){
	        			postList+=
        				`
        				<div class="post_images">
		      				<img src="${item.thumbnail}" onclick="location.href='/blog/${item.userID}/${item.no}'">
						</div>
        				`;
	        		}
	        		
	        		postList += `</div>`;
            });//each 종료
            $('#board').html(postList);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

//검색 게시글 카테고리 클릭
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
      object: category,
      search : $('#search_text').val()
	};
	
	var object = category;
	var search = $('#search_text').val();
	
	//게시글 변경
	$.ajax({
      url: "/blog/main/ajax",
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
						<span>좋아요 ${item.goodCount}</span>
						<span>댓글 ${item.commentCount}</span>
					</div>
				</div>`;
	        		
	        		if(item.thumbnail !== null && item.thumbnail !== ''){
	        			postList+=
        				`
        				<div class="post_images">
		      				<img src="${item.thumbnail}" onclick="location.href='/blog/${item.userID}/${item.no}'">
						</div>
        				`;
	        		}
	        		
	        		postList += `</div>`;
          });//each 종료
          $('#board').html(postList);

          //페이징 부분 변경
          var pagingList="";
          
          if(result.paging !== undefined && result.paging.page_total > 1){
          	if(result.paging.block_total > 1 && result.paging.block_current > 1){
          		pagingList += `
          			<div class="post_list_paging_left flex_center_center" style="margin-right: 20px;" onclick="main_post_paging(${(result.paging.block_current-1)*10},'', 'left', '${object}', '${search}')"><i class="fas fa-angle-left"></i></div>
          		`;
          	}
          	
          	var paging_start = (result.paging.block_current-1)*10+1; //반복문 시작 값
          	var paging_end = (result.paging.block_current-1)*10+10; //반복문 종료 값
          	
          	for(var index=paging_start; index<=paging_end; index++){
          		if(index <= result.paging.page_total){
          			pagingList +=`<div class="post_list_paging_number flex_center_center`;
          			
          			if(index === result.paging.page_current){ pagingList += ` active`;}
          			
          			pagingList +=`" page="${index}" onclick="main_post_paging(${index},'', 'number', '${object}', '${search}')"><span>${index}</span></div>`;
          		}
          	} //for 종료
          	
          	if(result.paging.block_total > 1 && result.paging.block_current < result.paging.block_total){
          		pagingList += `
          			<div class="post_list_paging_right flex_center_center" style="margin-left: 20px;" onclick="main_post_paging(${(result.paging.block_current+1)*10+1},'', 'right', '${object}', '${search}')"><i class="fas fa-angle-right"></i></div>
          		`;
          	}
          }
          $('#main_paging').html(pagingList);
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
        url: "/blog/main/ajax",
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
						<span>좋아요 ${item.goodCount}</span>
						<span>댓글 ${item.commentCount}</span>
					</div>
				</div>`;
	        		
	        		if(item.thumbnail !== null && item.thumbnail !== ''){
	        			postList+=
        				`
        				<div class="post_images">
		      				<img src="${item.thumbnail}" onclick="location.href='/blog/${item.userID}/${item.no}'">
						</div>
        				`;
	        		}
	        		
	        		postList += `</div>`;
            });//each 종료
            $('#board').html(postList);
            
            //페이징 부분 변경
            var pagingList="";
            if(result.paging !== undefined && result.paging.page_total > 1){
            	if(result.paging.block_total > 1 && result.paging.block_current > 1){
            		pagingList += `
            			<div class="post_list_paging_left flex_center_center" style="margin-right: 20px;" onclick="main_post_paging(${(result.paging.block_current-1)*10},'${category}', 'left')"><i class="fas fa-angle-left"></i></div>
            		`;
            	}
            	
            	var paging_start = (result.paging.block_current-1)*10+1; //반복문 시작 값
            	var paging_end = (result.paging.block_current-1)*10+10; //반복문 종료 값
            	
            	for(var index=paging_start; index<=paging_end; index++){
            		if(index <= result.paging.page_total){
            			pagingList +=`<div class="post_list_paging_number flex_center_center`;
            			
            			if(index === result.paging.page_current){ pagingList += ` active`;}
            			
            			pagingList +=`" page="${index}" onclick="main_post_paging(${index},'${category}', 'number')"><span>${index}</span></div>`;
            		}
            	} //for 종료
            	
            	if(result.paging.block_total > 1 && result.paging.block_current < result.paging.block_total){
            		pagingList += `
            			<div class="post_list_paging_right flex_center_center" style="margin-left: 20px;" onclick="main_post_paging(${(result.paging.block_current+1)*10+1},'${category}', 'right')"><i class="fas fa-angle-right"></i></div>
            		`;
            	}
            }
            $('#main_paging').html(pagingList);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

//블로그 메인에서 내 메뉴 클릭
function blog_main_my_menu(id, menu){
	//강조 변경
	$('#my_menu>#third>div').removeClass('active');
	$('#my_menu>#third>div#'+menu).addClass('active');
	
	var data = {
		userID: id,
		menu: menu,
		start: 0,
		block: 5,
		category: ""
    };
	
	$.ajax({
        url: "/blog/menu/ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var list="";
        	
        	if(menu==="my_news"){
        		//$.each(result.newsList, function (index, item) {}); //each 종료
        		
        		list+=`
					<div style="width:100%; height: 100%; display:flex; justify-content:center; align-items: center;">
						<span>새 소식이 없습니다.</span>
					</div>
        		`;
        	}
        	else if(menu==="my_post"){
        		//게시글이 5개 이하인 경우 페이징이 없음
        		if(result.paging.count<=5 && result.paging.count>0){
        			list+=`<main style="width: 100%; height: 100%;">`;
            		$.each(result.postList, function (index, item) {
                		list+=`
                			<div class="line flex_center_center">
                				<div class="title"><a href="/blog/${id}/{item.no}">${item.title}</a></div>
                				<div class="signdate">${item.signdate}</div>
                			</div>
                		`;
                    });//each 종료
            		list+=`</main>`;
        		}//count if 종료
        		else if(result.paging.count>5){
        			list+=`<main style="width: 100%; height: 85%;">`;
            		$.each(result.postList, function (index, item) {
                		list+=`
                			<div class="line flex_center_center">
                				<div class="title"><a href="/blog/${id}/{item.no}">${item.title}</a></div>
                				<div class="signdate">${item.signdate}</div>
                			</div>
                		`;
                    });//each 종료
            		list+=`</main>`;
            		
            		list+=`
            			<footer id="show_info_paging">
            				<div id="show_info_post_left" class="" page="0" onclick="main_menu_paging_post_left('${id}', ${result.paging.page_total})">
            					<i class="fas fa-angle-left" aria-hidden="true"></i>
        					</div>
            				<div id="show_info_post_right" class="active" page="2" onclick="main_menu_paging_post_right('${id}', ${result.paging.page_total})">
            					<i class="fas fa-angle-right" aria-hidden="true"></i>
        					</div>
            			</footer>
        			`;
        		} //count if 종료
        		else if(result.paging.count === 0){
        			list+=`<main style="width: 100%; height: 100%;" class="flex_center_center"><span>작성한 게시글이 존재하지 않습니다.</span></main>`;
        		}//count if 종료
        	}//menu if 종료
        	else if(menu==="my_neighbor"){
        		//이웃이 9명 이하인 경우 페이징이 없음
        		if(result.paging.count<=9 && result.paging.count>0){
        			list+=`<main style="width: 100%; height: 100%; display: grid; grid-template-rows: repeat(3, 1fr); grid-template-columns: repeat(3, 1fr); padding: 5px; gap: 5px; box-sizing: border-box;">`;
            		$.each(result.neighborList, function (index, item) {
                		list+=`
                			<div class="neighbor">
                				<main>
		        					<img onclick="go_user_blog('${item.target}')" src="${item.blog_profile_image}">
		        				</main>
								<footer>
									<span>${item.nickname}</span>
								</footer>
                			</div>
                		`;
                    });//each 종료
            		list+=`</main>`;
        		}//count if 종료
        		else if(result.paging.count>9){
        			list+=`<main style="width: 100%; height: 85%; display: grid; grid-template-rows: repeat(3, 1fr); grid-template-columns: repeat(3, 1fr); padding: 5px; gap: 5px; box-sizing: border-box;">`;
            		$.each(result.neighborList, function (index, item) {
                		list+=`
                			<div class="neighbor">
                				<main>
		        					<img onclick="go_user_blog('${item.target}')" src="${item.blog_profile_image}">
		        				</main>
								<footer>
									<span>${item.nickname}</span>
								</footer>
                			</div>
                		`;
                    });//each 종료
            		list+=`</main>`;
            		
            		list+=`
            			<footer id="show_info_paging">
            				<div id="show_info_neighbor_left" class="" page="0" onclick="main_menu_paging_neighbor_left('${id}', ${result.paging.page_total})">
            					<i class="fas fa-angle-left" aria-hidden="true"></i>
        					</div>
            				<div id="show_info_neighbor_right" class="active" page="2" onclick="main_menu_paging_neighbor_right('${id}', ${result.paging.page_total})">
            					<i class="fas fa-angle-right" aria-hidden="true"></i>
        					</div>
            			</footer>
        			`;
        		} //count if 종료
        		else if(result.paging.count === 0){
        			list+=`<main style="width: 100%; height: 100%;" class="flex_center_center"><span>이웃이 존재하지 않습니다.</span></main>`;
        		}//count if 종료
        	} //menu if 종료
        	
            $('#info_area>#my_menu>#show_info').html(list);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 블로그 메인 - 내 메뉴 - 내 게시글 - 좌측 */
function main_menu_paging_post_left(blogUserID, total_page){
	var page = parseInt($(event.target).attr("page"));
	
	var start=page; //변경될 값
	
	//제약조건 설정
	if($(event.target).hasClass('active') === true && page >= 1){
		//화면 변경
		main_menu_paging_post_ajax(blogUserID, page);
		
		//css 변경
		if(page === 1){
			$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_post_left').removeClass('active');
		}
		else if(page !== 1){
			$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_post_left').addClass('active');
		}
		$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_post_right').addClass('active');
	}
}

/* 블로그 메인 - 내 메뉴 - 내 게시글 - 우측 */
function main_menu_paging_post_right(blogUserID, total_page){
	var page = parseInt($(event.target).attr("page"));
	
	var start=page; //변경될 값
	
	//제약조건 설정
	if($(event.target).hasClass('active') === true && page <= total_page){
		//화면 변경
		main_menu_paging_post_ajax(blogUserID, page);
		
		//css 변경
		if(page === total_page){
			$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_post_right').removeClass('active');
		}
		else if (page !== total_page){
			$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_post_right').addClass('active');
		}
		$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_post_left').addClass('active');
	}
}

/* 블로그 메인 - 내 메뉴 - 내 게시글 - ajax */
function main_menu_paging_post_ajax(blogUserID, page){
	var start=page; //변경될 값
	
	//MariaDB에 대해서 limit에 사용할 값 설정
	start-=1; //MariaDB 특성 - 0부터 시작
	start*=5; //한 페이지당 5개씩 표출, SQL에 추가
	
	//Ajax로 전달할 값 설정
	var data = {
		start: parseInt(start),
	    userID : blogUserID,
	    menu: "my_post"
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/menu/ajax",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var postList="";
        	$.each(result.postList, function (index, item) {
        		postList+=`
        			<div class="line flex_center_center">
        				<div class="title"><a href="/blog/${blogUserID}/{item.no}">${item.title}</a></div>
        				<div class="signdate">${item.signdate}</div>
        			</div>
        		`;
            });//each 종료
        	
            $('#info_area>#my_menu>#show_info>main').html(postList);
            
    		//page 속성 변경
    		$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_post_left').attr('page', page-1);
    		$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_post_right').attr('page', page+1);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 블로그 메인 - 내 메뉴 - 내 이웃 - 좌측 */
function main_menu_paging_neighbor_left(blogUserID, total_page){
	var page = parseInt($(event.target).attr("page"));
	
	var start=page; //변경될 값
	
	//제약조건 설정
	if($(event.target).hasClass('active') === true && page >= 1){
		//화면 변경
		main_menu_paging_neighbor_ajax(blogUserID, page);
		
		//css 변경
		if(page === 1){
			$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_neighbor_left').removeClass('active');
		}
		else if(page !== 1){
			$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_neighbor_left').addClass('active');
		}
		$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_neighbor_right').addClass('active');
	}
}

/* 블로그 메인 - 내 메뉴 - 내 이웃 - 우측 */
function main_menu_paging_neighbor_right(blogUserID, total_page){
	var page = parseInt($(event.target).attr("page"));
	
	var start=page; //변경될 값
	
	//제약조건 설정
	if($(event.target).hasClass('active') === true && page <= total_page){
		//화면 변경
		main_menu_paging_neighbor_ajax(blogUserID, page);
		
		//css 변경
		if(page === total_page){
			$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_neighbor_right').removeClass('active');
		}
		else if (page !== total_page){
			$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_neighbor_right').addClass('active');
		}
		$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_neighbor_left').addClass('active');
	}
}

/* 블로그 메인 - 내 메뉴 - 내 이웃 - ajax */
function main_menu_paging_neighbor_ajax(blogUserID, page){
	var start=page; //변경될 값
	
	//MariaDB에 대해서 limit에 사용할 값 설정
	start-=1; //MariaDB 특성 - 0부터 시작
	start*=5; //한 페이지당 5개씩 표출, SQL에 추가
	
	//Ajax로 전달할 값 설정
	var data = {
		start: parseInt(start),
	    userID : blogUserID,
	    menu: "my_neighbor"
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
        		neighborList+=`
        			<div class="neighbor">
        				<main>
        					<img onclick="go_user_blog('${item.target}')" src="${item.blog_profile_image}">
        				</main>
						<footer>
							<span>${item.nickname}</span>
						</footer>
        			</div>
        		`;
            });//each 종료
        	
            $('#info_area>#my_menu>#show_info>main').html(neighborList);
            
    		//page 속성 변경
    		$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_neighbor_left').attr('page', page-1);
    		$('#info_area>#my_menu>#show_info>#show_info_paging>#show_info_neighbor_right').attr('page', page+1);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

//블로그 메인 게시글에 대한 페이징
function main_post_paging(page, category, mode, object, search){
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
		    category: category,
		    block: 10
	    };
		
		if(object !== "" && object !== null){
			data.object = object;
			data.category="";
		}
		if(search !== "" && search !== null){
			data.search = search;
			data.category="";
		}
		
		//게시글 변경
		$.ajax({
	        url: "/blog/main/ajax",
	        type: "POST",
	        data: JSON.stringify(data),
	        contentType: "application/json",
	        success: function(result){
	        	$('#main_paging>div.active').removeClass('active'); //활성화 css 삭제, 공통
	        	
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
								<span>좋아요 ${item.goodCount}</span>
								<span>댓글 ${item.commentCount}</span>
							</div>
	        			</div>`;
	        		
	        		if(item.thumbnail !== null && item.thumbnail !== ''){
	        			postList+=
        				`
        				<div class="post_images">
		      				<img src="${item.thumbnail}" onclick="location.href='/blog/${item.userID}/${item.no}'">
						</div>
        				`;
	        		}
	        		
	        		postList += `</div>`;
	            });//each 종료
	            $('#board').html(postList);
	            
	            $('#main_paging>div[page='+page+']').addClass('active');
	        },
	        error: function(error){
	            alert("오류 발생");
	            console.log(error);
	        }
	    });
	}
}