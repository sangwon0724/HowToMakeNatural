<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 공통 적용 파일 시작 -->
	<c:import url="../include/header.jsp"></c:import>
	<!-- 공통 적용 파일 종료-->
	
	<!-- include summernote css/js -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
		
	<link href="<c:url value="/resources/css/blog.css" />" rel="stylesheet" type="text/css">
	
	<style type="text/css">
		body {
			  margin: 0;
			  padding: 0;
			  border: 0;
			  font-size: 100%;
			  font: inherit;
			  vertical-align: baseline;
			  background-color: #A29BFE;
		}
		
		/* The container must be positioned relative: */
		.custom-select {
		  position: relative;
		  font-family: Arial;
		}
		
		.custom-select select {
		  display: none; /*hide original SELECT element: */
		}
		
		.select-selected {
		  background-color: #A29BFE;
		}
		
		/* Style the arrow inside the select element: */
		.select-selected:after {
		  position: absolute;
		  content: "";
		  top: 14px;
		  right: 10px;
		  width: 0;
		  height: 0;
		  border: 6px solid transparent;
		  border-color: #fff transparent transparent transparent;
		}
		
		/* Point the arrow upwards when the select box is open (active): */
		.select-selected.select-arrow-active:after {
		  border-color: transparent transparent #fff transparent;
		  top: 7px;
		}
		
		/* style the items (options), including the selected item: */
		.select-items div,.select-selected {
		  color: #ffffff;
		  padding: 8px 16px;
		  border: 1px solid transparent;
		  border-color: transparent transparent rgba(0, 0, 0, 0.1) transparent;
		  cursor: pointer;
		}
		
		/* Style items (options): */
		.select-items {
		  position: absolute;
		  background-color: #A29BFE;
		  top: 100%;
		  left: 0;
		  right: 0;
		  z-index: 99;
		}
		
		/* Hide the items when the select box is closed: */
		.select-hide {
		  display: none;
		}
		
		.select-items div:hover, .same-as-selected {
		  background-color: rgba(0, 0, 0, 0.1);
		}
		
		/* summernote 중앙 정렬 */
		.note-editor{margin: 0 auto;}
	</style>
<title>게시글 작성</title>

<script type="text/javascript">
		$(document).ready(function() {
			$('#summernote').summernote({
				height: 300,                 // 에디터 높이
				minHeight: null,             // 최소 높이
				maxHeight: null,             // 최대 높이
				focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
				lang: "ko-KR",					// 한글 설정
				placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
				toolbar: [ /* 폰트선택 툴바 사용하려면 주석해제 */ // ['fontname', ['fontname']],
					['fontsize', ['fontsize']],
					['style', ['bold', 'italic', 'underline', 'clear']],
					['color', ['color']],
					['table', ['table']],
					['para', ['paragraph']],
					['insert', ['link', 'picture']],
					['view', []]
				],
				callbacks: {	//여기 부분이 이미지를 첨부하는 부분
					onImageUpload : function(files) {
						uploadImageFile(files[0],this);				
					},
					onPaste: function (e) {
						var clipboardData = e.originalEvent.clipboardData;
						if (clipboardData && clipboardData.items && clipboardData.items.length) {
							var item = clipboardData.items[0];
							if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
								e.preventDefault();
							}
						}
					}
				}
			});
			$('.note-editor').width($("#write_form").width()* 0.95); //summernote 가로 규격 변경 (단위 : 백분율)
			$(".note-group-image-url").remove(); //Image URL 등록 input 삭제
		});
		
		/* 이미지 업로드 */
		function uploadImageFile(file, editor) {
			data = new FormData();
			data.append("file", file);
			var url = "/blog/"+$("#myID").val()+"/write/image";
			
			$.ajax({
				data : data,
				type : "POST",
				url : url,	
				dataType:'json',
			    async: true,
				processData: false,		
				contentType: false,				
				success : function(data) {
			    	//항상 업로드된 파일의 url이 있어야 한다.
			    	alert("업로드에 지연시간이 있습니다..");
			    	setTimeout(function(){
			    		   // 1초 후 작동해야할 코드
			    		alert(data.url);
			    		$(editor).summernote('insertImage', data.url);
			    		/*if(document.getElementById('sumnail').value=="null"){
			    			document.getElementById('sumnail').value=data.url;	
			    		}*/
			    		
			    		   }, 1000);  	
			    	
				},
				error:function(request,status,error){			
					alert("code = "+ request.status);
					alert(" message = " + request.responseText);
					alert(" error = " + error);			 	
					$(editor).summernote('insertImage', '');
				}
			
			});
		}
	</script>
</head>
<body>
	<form method="post" id="write_form" enctype="multipart/form-data" accept-charset="utf-8" onSubmit="return false;">
	    <input type="text" id="title" placeholder="제목을 입력해주세요.">
	    <div class="write_line">
		    <input type="text" id="tag" placeholder="#을 붙여 태그를 입력해주세요. 예시) #일상#여행">
		    <div class="custom-select" style="width:200px;">
			  <select id="category">
			    <option value="">전체</option>
			  </select>
			</div>
	    </div>
	 	<div id="summernote" name="text"></div>
	 	<button id="submit" onclick="write_submit('<c:if test="${mode ne 'update'}">등록</c:if><c:if test="${mode eq 'update'}">수정</c:if>', '${sessionScope.user.id}', '${sessionScope.user.blog_nickname}','<c:if test="${mode eq 'update'}">${data.no}</c:if>')" >작성</button>
 	</form>
 	
	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog/common.js"/>"></script>
	<script src="<c:url value="/resources/js/blog/personal.js"/>"></script>
	
	<!-- 공통 적용 파일 시작 -->
			<c:import url="../include/footer.jsp"></c:import>
	<!-- 공통 적용 파일 -->
	
	<script>
		/* 커스텀 select 박스 시작  */
		var x, i, j, l, ll, selElmnt, a, b, c;
		/* Look for any elements with the class "custom-select": */
		x = document.getElementsByClassName("custom-select");
		l = x.length;
		for (i = 0; i < l; i++) {
		  selElmnt = x[i].getElementsByTagName("select")[0];
		  ll = selElmnt.length;
		  /* For each element, create a new DIV that will act as the selected item: */
		  a = document.createElement("DIV");
		  a.setAttribute("class", "select-selected");
		  a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
		  x[i].appendChild(a);
		  /* For each element, create a new DIV that will contain the option list: */
		  b = document.createElement("DIV");
		  b.setAttribute("class", "select-items select-hide");
		  for (j = 1; j < ll; j++) {
		    /* For each option in the original select element,
		    create a new DIV that will act as an option item: */
		    c = document.createElement("DIV");
		    c.innerHTML = selElmnt.options[j].innerHTML;
		    c.addEventListener("click", function(e) {
		        /* When an item is clicked, update the original select box,
		        and the selected item: */
		        var y, i, k, s, h, sl, yl;
		        s = this.parentNode.parentNode.getElementsByTagName("select")[0];
		        sl = s.length;
		        h = this.parentNode.previousSibling;
		        for (i = 0; i < sl; i++) {
		          if (s.options[i].innerHTML == this.innerHTML) {
		            s.selectedIndex = i;
		            h.innerHTML = this.innerHTML;
		            y = this.parentNode.getElementsByClassName("same-as-selected");
		            yl = y.length;
		            for (k = 0; k < yl; k++) {
		              y[k].removeAttribute("class");
		            }
		            this.setAttribute("class", "same-as-selected");
		            break;
		          }
		        }
		        h.click();
		    });
		    b.appendChild(c);
		  }
		  x[i].appendChild(b);
		  a.addEventListener("click", function(e) {
		    /* When the select box is clicked, close any other select boxes,
		    and open/close the current select box: */
		    e.stopPropagation();
		    closeAllSelect(this);
		    this.nextSibling.classList.toggle("select-hide");
		    this.classList.toggle("select-arrow-active");
		  });
		}
	
		function closeAllSelect(elmnt) {
		  /* A function that will close all select boxes in the document,
		  except the current select box: */
		  var x, y, i, xl, yl, arrNo = [];
		  x = document.getElementsByClassName("select-items");
		  y = document.getElementsByClassName("select-selected");
		  xl = x.length;
		  yl = y.length;
		  for (i = 0; i < yl; i++) {
		    if (elmnt == y[i]) {
		      arrNo.push(i)
		    } else {
		      y[i].classList.remove("select-arrow-active");
		    }
		  }
		  for (i = 0; i < xl; i++) {
		    if (arrNo.indexOf(i)) {
		      x[i].classList.add("select-hide");
		    }
		  }
		}
	
		/* If the user clicks anywhere outside the select box,
		then close all select boxes: */
		document.addEventListener("click", closeAllSelect);
		/* 커스텀 select 박스 종료  */
	</script>
	
	<c:if test="${mode eq 'update'}">
	<script>
		$('#title').val('${data.title}');
		$('#tag').val('${data.tag}');
		$('#category').val('${data.category}').prop("selected", true);
		$('#summernote').summernote('code', '${data.content}');
	</script>
	</c:if>
</body>
</html>