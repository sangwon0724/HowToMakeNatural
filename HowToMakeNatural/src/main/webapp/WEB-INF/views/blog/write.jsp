<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 공통 적용 파일 시작 -->
	<c:import url="../include/common.jsp"></c:import>
	<!-- 공통 적용 파일 종료-->

	<!-- include summernote css/js -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
		
	<link href="<c:url value="/resources/css/blog.css" />" rel="stylesheet" type="text/css">
<title>게시글 작성</title>

<script type="text/javascript">
		$(document).ready(function() {
	  		$('#summernote').summernote();
		});
	
		function uploadImageFile(file, editor) {
			data = new FormData();
			data.append("file", file);
			
			$.ajax({
				data : data,
				type : "POST",
				url : "./image",	
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
			
		$(document).ready(function() {
			$('#summernote').summernote({
				height: 300,                 // 에디터 높이
				minHeight: null,             // 최소 높이
				maxHeight: null,             // 최대 높이
				focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
				lang: "ko-KR",					// 한글 설정
				placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
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
		
		});
	</script>
</head>
<body>
	<form method="post" name="write_form" id="write_form" enctype="multipart/form-data" accept-charset="utf-8">
	    <input type="text" id="title" placeholder="제목을 입력해주세요.">
	    <div class="custom-select" style="width:200px;">
  <select>
    <option value="0">Select car:</option>
    <option value="1">Audi</option>
    <option value="2">BMW</option>
    <option value="3">Citroen</option>
    <option value="4">Ford</option>
    <option value="5">Honda</option>
    <option value="6">Jaguar</option>
    <option value="7">Land Rover</option>
    <option value="8">Mercedes</option>
    <option value="9">Mini</option>
    <option value="10">Nissan</option>
    <option value="11">Toyota</option>
    <option value="12">Volvo</option>
  </select>
</div>
	    <input type="text" id="tag" placeholder="#을 붙여 태그를 입력해주세요. (※ 주의 : 태그를 구분할때 #만 붙여야 합니다.) 예시) #일상#여행">
	 	<div id="summernote"></div>
 	</form>
	
	
	<!-- Scripts -->
	<script src="<c:url value="/resources/js/blog.js"/>"></script>
	
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
</body>
</html>