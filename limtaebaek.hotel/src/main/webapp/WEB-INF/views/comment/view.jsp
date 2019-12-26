<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<!-- 
	- res/js 추가 시
	<script src="<c:url value="/js/common.js"/>"></script>  
-->
<style>
	/*
	- res/css 추가 시
	@import url("<c:url value="/css/section.css" />");
	*/
.center-block button{
	text-align: center;
	
}
</style>
<script>
$(document).ready(function(){
	$("#read").click(function(){
		$("#bx").show();
		$("#bx1").show();
		$("#textbox").attr("readonly",false).attr("disabled".false);
		
		});
	
	$("#bx, #bx1").click(function(){
		$("#bx").hide();
		$("#bx1").hide();
		$("#textbox").attr("readonly",true).attr("disabled".false);
		
		});


});
	


var alert = function(msg, type) {
	swal({
		title : "",
		text : msg,
		icon : type,
		customClass : "sweet-size",
		showCancelButton : true,
	});
}
var confirm = function(msg, type) {
	   swal(msg, {
		   icon: type,
	        buttons: ["취소", "확인"],
	      }).then((value) => {
	    	 if(value){ 
	    		 document.location.href="03.html";
	    	 }else{
	    		 alert("취소하였습니다.", "warning" );
	    		 return;
	    	 }
	         });
	}

$(function(){
	var commentImages = ["${comment.revImage1}", "${comment.revImage2}", "${comment.revImage3}"];
	$(".previewImg2").each(function(idx, img){	
		if(commentImages[idx] != "")
			$(this).attr("src",  "<c:url value='/img/" + commentImages[idx] + "'/>")
	})
	
	
	  $("#back").click(function() {
		   window.history.back();
		    	      
		   });
	  
	  $(".delReview").click(function () {
		  var revNum = $(this).attr('id').substr(1);
		  
			$.ajax({
				url:"delView",
				method:"GET",
				data: {		
					revNum:revNum
			
				},
				success:function(){
					
	    			location.href = "/hotel/comment/commentLookUp";
				},
				error:function(a, b, errMsg){
					alert("삭제 불가 에러", 'warning');
				}
				
			})
		
	});
	  
	  $(".getReview").click(function () {
		  
		   var revNum = $(this).attr('id').substr(1);
			
		   location.href = "commentView2?revNum=" + revNum;
		
	});
});
</script>
</head>
<body>
	<div>
		<jsp:include page="../common/header.jsp" />
		<jsp:include page="../common/gnb.jsp" />
		<!-- 예약정보 검색 -->
		<div id="contents">
			<section>
			<div class=" container" >

<div class="container center-block" style="width: 80%; "  >
	
	
	
		
	<table class="table table-sm"  id="table1">
  <thead>
    <tr  class="info">
      <th scope="col">제목 : ${comment.revTitle }</th>
      <th scope="col">작성자 :${comment.user.userName } 님</th>
      <th scope="col"></th>
      <th scope="col">작성일 : ${comment.revDate }</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th class="table-light" scope="row" colspan="4" height="200px;"><font color="black">${comment.revContent }</font></th>
     
    </tr>
    		
 
    <tr><td colspan="4"></td></tr>
  
   	
 
  </tbody>
</table>	
				<div class="col-sm-2 col-md-4">
						<div class="input-group">
								<img width="250" height="200" class="previewImg2"> 
						</div></div>
				<div class="col-sm-2 col-md-4">
						<div class="input-group">
								<img width="250" height="200" class="previewImg2"> 
						</div></div>
					<div class="col-sm-2 col-md-4">
						<div class="input-group">
								<img width="250" height="200" class="previewImg2"> 
						</div></div>
	</div>
	<br><br>
	<div class="container center-block" style="width: 80%; "  >
	<c:if test="${sessionScope.user.userNum == comment.userNum || sessionScope.user.userGrade == '2'  }">	
	<button class="btn btn-default delReview" id="a${comment.revNum }" name="delReview" type="button" value= "" style="text-align: reight; float: right;"   >삭제 하기</button>
	<button class="btn btn-default getReview" id="c${comment.revNum }" type="button" value="후기 수정" style="text-align: reight; float: right;"   >수정 하기</button>		
	</c:if>
	<button class="btn btn-primary" type="button"  style="text-align: reight; float: right;"  id="back" >목록으로</button>
		
	
<%-- 		<c:choose>
		<c:when test="${(sessionScope.user.userNum == ${user.userNum } || sessionScope.page == 'admin')}">
		
	</c:when>
					
	</c:choose> 	 --%>
	</div>
	</div><br><br>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>