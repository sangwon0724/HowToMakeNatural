/*======= 블로그 개인 설정 =======*/

/*=================================== 공통 영역  시작 ===================================*/

/* 보이는 화면 설정 */
function toggleSettingFunctionPanel(target){
	$("#setting_function_panel>article:not(#" + target + ")").addClass("hidden");
	$("#setting_function_panel>article#" + target).removeClass("hidden");
}

/* 프로필 이미지 변경에 대한 버튼 표출 여부 */
function toggle_button_for_image(target, mode){
	if(mode === "change"){
		//변경 버튼 클릭
		$("#blog_"+ target +"_image").removeClass("hidden"); //input file 보이기
		$("#" + target + "_image_update_O").addClass("hidden"); //변경 버튼 숨기기
		$("#" + target + "_image_update_X").removeClass("hidden"); //취소 버튼 보이기
	}
	else if(mode !== "change"){
		//취소 버튼 클릭
		$("#blog_"+ target +"_image").addClass("hidden"); //input file 숨기기
		$("#" + target + "_image_update_O").removeClass("hidden"); //변경 버튼 보이기
		$("#" + target + "_image_update_X").addClass("hidden"); //취소 버튼 숨기기
		
	}
}

//사진 변경 시 미리보기
function preview_image(input, target) {
  if (input.files && input.files[0]) {
  	
  var reader = new FileReader();

  reader.onload = function (e) {
          $("#setting_blog_" + target + "_image>.image_preview").attr('src', e.target.result);
      }

    reader.readAsDataURL(input.files[0]);
  }
}

/*=================================== 공통 영역  종료 ===================================*/
/*=================================== 개별 영역  시작 ===================================*/

/* 프로필 변경 */
function change_blog_info(id){
	var formData = new FormData();
	formData.append("userID", id);
	formData.append("blog_nickname", $("#blog_nickname").val());
	formData.append("blog_profile_image",$("#blog_profile_image")[0].files[0]);
	formData.append("blog_profile_text", $("#blog_profile_text").val());
	formData.append("blog_logo_text", $("#blog_logo_text").val());
	formData.append("blog_logo_text_color", $("#blog_logo_text_color").val());
	formData.append("blog_logo_text_size", $("#blog_logo_text_size").val());
	
	$.ajax({
        url: "/blog/setting/profile",
        type: "POST",
        enctype: 'multipart/form-data', // 필수
        processData: false, // 필수
        contentType: false, // 필수
        data: formData,
        success: function(result){
        	alert("정상적으로 변경되었습니다.");
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/*---------------------------------------------------------------------------------*/

/* 배경 변경 */
function change_blog_background(id){
	var formData = new FormData();
	formData.append("userID", id);
		formData.append("blog_background_image", $("#blog_background_image")[0].files[0]);
		formData.append("blog_logo_image", $("#blog_logo_image")[0].files[0]);
	
	if($("#blog_background_image")[0].files[0] === undefined && $("#blog_logo_image")[0].files[0] === undefined){
		alert("변경하기 위해 선택된 이미지가 존재하지 않습니다.");
		return;
	}
	
	$.ajax({
        url: "/blog/setting/background",
        type: "POST",
        enctype: 'multipart/form-data', // 필수
        processData: false, // 필수
        contentType: false, // 필수
        data: formData,
        success: function(result){
        	alert("정상적으로 변경되었습니다.");
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/*---------------------------------------------------------------------------------*/

/* 배치 변경 */
function change_blog_placement(id){
	//Ajax로 전달할 값 설정
	var data = {
	    userID : id,
	    blog_setting_type: $("input[name=blog_setting_type_radio]:checked").val()
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/setting/placement",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	alert("정상적으로 변경되었습니다.");
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/*---------------------------------------------------------------------------------*/

/* 이웃 추가  */
function add_my_neighbor(id, target, nickname){
	if(!confirm(nickname + "님을 이웃목록에 추가하시겠습니까?")){
		return;
	}
	
	//Ajax로 전달할 값 설정
	var data = {
	    userID : id,
	    target: target,
	    mode: "insert"
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/setting/neighbor",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
            //1. 나를 추가한 이읏 패널에서 해당 이웃이 차지하고 있던 라인의 이웃추가 라인에서 추가 버튼을 지우고 서로이웃 추가
        	$("#setting_function_panel>article.neighbor>main>.neighbor_list>div.neighbor_status[target=" + target + "]").html("<span>이웃</서로이웃>");

        	//2. 이웃 목록을 다시 받아서 내 이웃 패널에 html을 다시 씌우기
        	var neighborList = ``;
        	
        	neighborList += `
        		<div class="neighbor_list title">
					<div class="neighbor_info"><span>이웃 정보</span></div>
					<div class="neighbor_status"><span>이웃 상태</span></div>
					<div class="neighbor_signdate"><span>추가일</span></div>
				</div>
        	`;
        	
        	$.each(result.neighborList, function (index, item) {
        		neighborList += `
        			<div class="neighbor_list" target="${item.target}">
						<div class="neighbor_info">
							<span>${item.nickname}</span>
							&nbsp;|&nbsp;
							<a href="/blog/${item.target}" class="neighbor_logo_text">
				`;
        		
        		if(item.blog_logo_text != null && item.blog_logo_text != ""){
        			neighborList += `${item.blog_logo_text}`;
        		}
        		if(item.blog_logo_text == null || item.blog_logo_text == ""){
        			neighborList += `${item.target}님의 블로그`;
        		}
        		
				neighborList += `	
							</a>
						</div>
						<div class="neighbor_status" target="${item.target}">
							<button onclick="cancle_my_neighbor('${item.id}', '${item.target}', '${item.nickname}')">이웃취소</button>
						</div>
						<div class="neighbor_signdate"><span>${item.signdate}</span></div>
					</div>
        		`;
            });//each 종료
        	$("#setting_function_panel>article#setting_blog_neighbor_list>main").html(neighborList);
        	$("#setting_function_panel>article#setting_blog_neighbor_list>main>.neighbor_list:last-child").addClass("last");
        	
        	alert("요청하신 작업이 정상적으로 처리되었습니다.");
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 이웃 취소  */
function cancle_my_neighbor(id, target, nickname){
	if(!confirm(nickname + "님을 이웃목록에서 삭제하시겠습니까?")){
		return;
	}
	//Ajax로 전달할 값 설정
	var data = {
	    userID : id,
	    target: target,
	    mode: "delete"
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/setting/neighbor",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
            //1. 해당 이웃이 차지하고 있던 라인에 cutsom css class 중에서 hidden 추가
        	$("#setting_function_panel>article#setting_blog_neighbor_list>main>.neighbor_list[target=" + target + "]").css("display", "none");
        	$("#setting_function_panel>article#setting_blog_neighbor_list>main>.neighbor_list:last-child").addClass("last");
        	
        	//2. 만약 나를 추가한 이웃에 해당 이웃이 남아있는 상태라면 이웃추가 버튼으로 변경
        	if($("#setting_function_panel>article.neighbor>main>.neighbor_list>div.neighbor_status[target=" + target + "]")){
        		$("#setting_function_panel>article.neighbor>main>.neighbor_list>div.neighbor_status[target=" + target + "]").html(`<button onclick="add_my_neighbor('${id}', '${target}', '${nickname}')">이웃추가</button>`);
        	}
        	
        	alert("요청하신 작업이 정상적으로 처리되었습니다.");
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/*---------------------------------------------------------------------------------*/

/* 나를 추가한 이웃 관련 */
function change_blog_neighbor_follow_me(id){
	//Ajax로 전달할 값 설정
	var data = {
	    userID : id
    };
	
	//게시글 변경
	$.ajax({
        url: "/업데이트_예정",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var list="";
        	$.each(result.list, function (index, item) {
        		
            });//each 종료
            $('해당 영역').html(list);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/*---------------------------------------------------------------------------------*/

/* 카테고리 관련 - 순서 변경 - 앞으로 당기기 */
function category_move_up(id, order_no){
	if(order_no === 1){
		alert("선택하신 카테고리는 현재 이미 최상단에 위치하고 있습니다.");
		return;
	}
	
	//Ajax로 전달할 값 설정
	var data = {
	    userID : id,
	    category_order_no: order_no,
	    mode: "moveUp"
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/setting/category",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	var changeTarget=$("#setting_function_panel>article#setting_blog_category>main>.category_list>.category_name[category_order_no="+order_no+"]").html();
        	
        	$("#setting_function_panel>article#setting_blog_category>main>.category_list>.category_name[category_order_no="+order_no+"]").html($("#setting_function_panel>article#setting_blog_category>main>.category_list>.category_name[category_order_no="+(parseInt(order_no)-1)+"]").html());
        	
        	$("#setting_function_panel>article#setting_blog_category>main>.category_list>.category_name[category_order_no="+(parseInt(order_no)-1)+"]").html(changeTarget);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 카테고리 관련 - 순서 변경 - 뒤로 밀기 */
function category_move_down(id, order_no, max){
	if(order_no === max){
		alert("선택하신 카테고리는 현재 이미 최하단에 위치하고 있습니다.");
		return;
	}
	
	//Ajax로 전달할 값 설정
	var data = {
	    userID : id,
	    category_order_no: order_no,
	    mode: "moveDown"
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/setting/category",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
    		var changeTarget=$("#setting_function_panel>article#setting_blog_category>main>.category_list>.category_name[category_order_no="+order_no+"]").html();
        	
        	$("#setting_function_panel>article#setting_blog_category>main>.category_list>.category_name[category_order_no="+order_no+"]").html($("#setting_function_panel>article#setting_blog_category>main>.category_list>.category_name[category_order_no="+(parseInt(order_no)+1)+"]").html());
        	
        	$("#setting_function_panel>article#setting_blog_category>main>.category_list>.category_name[category_order_no="+(parseInt(order_no)+1)+"]").html(changeTarget);
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 카테고리 관련 - 카테고리 추가 */
function category_insert(id){
	//Ajax로 전달할 값 설정
	var data = {
	    userID : id,
	    mode: "insert"
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/setting/category",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
    		//max 값때문에 전체 변경
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 카테고리 관련 - 카테고리 변경 */
function category_update(id, order_no){
	//Ajax로 전달할 값 설정
	var data = {
	    userID : id,
	    category_order_no: order_no,
	    mode: "update"
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/setting/category",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
    		
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 카테고리 관련 - 카테고리 삭제 */
function category_delete(id, category_name){
	if(!confirm("카테고리 &#34;"+ category_name + "&#34;를 삭제하시겠습니까?")){
		return;
	}
	
	//Ajax로 전달할 값 설정
	var data = {
	    userID : id,
	    category_order_no: order_no,
	    mode: "delete"
    };
	
	//게시글 변경
	$.ajax({
        url: "/blog/setting/category",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
    		
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/*=================================== 개별 영역  종료 ===================================*/