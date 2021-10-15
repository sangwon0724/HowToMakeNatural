/* 블로그 개인 설정 */

/* 보이는 화면 설정 */
function toggleSettingFunctionPanel(target){
	$("#setting_function_panel>article:not(#" + target + ")").addClass("hidden");
	$("#setting_function_panel>article#" + target).removeClass("hidden");
}

/* 프로필 변경 */
function change_blog_info(id){
	/*var data = {
		userID : id,
		blog_nickname: $("#blog_nickname").val(),
		blog_profile_text: $("#profile_text").val(),
		blog_logo_text: $("#logo_text").val()
	};*/
	
	var formData = new FormData();
	formData.append("userID", id);
	formData.append("blog_nickname", $("#blog_nickname").val());
	formData.append("blog_profile_image",$("#blog_profile_image")[0].files[0]);
	formData.append("blog_profile_text", $("#blog_profile_text").val());
	formData.append("blog_logo_text", $("#blog_logo_text").val());
	
	/*$.ajax({
        url: "/blog/setting/profile",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
        	alert("정상적으로 변경되었습니다.");
        	window.location.reload();
        },
        error: function(error){
            alert("오류 발생");
            console.log(error);
        }
    });*/
	
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