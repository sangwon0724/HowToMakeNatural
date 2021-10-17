/*======= 블로그 개인 설정= ======*/

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

/* 프로필 변경 */
function change_blog_info(id){
	var formData = new FormData();
	formData.append("userID", id);
	formData.append("blog_nickname", $("#blog_nickname").val());
	formData.append("blog_profile_image",$("#blog_profile_image")[0].files[0]);
	formData.append("blog_profile_text", $("#blog_profile_text").val());
	formData.append("blog_logo_text", $("#blog_logo_text").val());
	
	$.ajax({
        url: "/blog/setting/profile",
        type: "POST",
        enctype: 'multipart/form-data', // 필수
        processData: false, // 필수
        contentType: false, // 필수
        data: formData,
        success: function(result){
        	alert("정상적으로 변경되었습니다.");
        	window.location.reload();
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}

/* 배경 변경 */
function change_blog_background(id){
	var formData = new FormData();
	formData.append("userID", id);
	if($("#blog_background_image")[0].files[0] !== undefined){
		formData.append("blog_background_image", $("#blog_background_image")[0].files[0]);
	}
	if($("#blog_logo_image")[0].files[0] !== undefined){
		formData.append("blog_logo_image", $("#blog_logo_image")[0].files[0]);
	}
	
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
        	window.location.reload();
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });
}