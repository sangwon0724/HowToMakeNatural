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