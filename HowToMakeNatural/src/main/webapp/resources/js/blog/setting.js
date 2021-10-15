/* 블로그 개인 설정 */

/* 보이는 화면 설정 */
function toggleSettingFunctionPanel(target){
	$("#setting_function_panel>article:not(#" + target + ")").addClass("hidden");
	$("#setting_function_panel>article#" + target).removeClass("hidden");
}

/* 프로필 변경 */
function changeProfile(id){
	var data = {
		userID : id
	};
	
	$.ajax({
        url: "/blog/setting/profile",
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