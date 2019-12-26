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
</style>
<script>
$(function(){ 

$(".getReview").click(function () {
	  
	   var revNum = $(this).attr('id').substr(1);
		
	   location.href = "commentView?revNum=" + revNum;
	
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
			<div class="container center-block">
		<div class="location">
			<p>
				<a><span class="glyphicon glyphicon-home">&nbsp;></span></a> <a>후기 게시판</a>
			</p>
		</div>
		<div class="headTit">
			<h3>&nbsp;후기게시판</h3>
		</div>
		<br> <br>
	</div>


	<div class=" container">
		<div class="container center-block">
			<div class="">
			<c:choose>
				<c:when test="${(sessionScope.user.userGrade == '1' || sessionScope.user.userGrade == '2')}">
				<button class="btn btn-primary" type="button" value="후기 등록"
					onclick="location.href='/hotel/comment/commentAdd' "
					style="text-align: reight; float: right;">후기 등록</button>
					</c:when>
					</c:choose> 
					
			</div>

		</div>
		<br>
		<div class="container center-block">
			<table class="table table-hover">
				<thead>
					<tr class="info">
						<th scope="row">번호</th>
						<th>평점 | 방타입</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성 일자</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="list" items="${commentList}">
					<tr id="a${list.revNum }" class="getReview">
						<th><a>${list.revNum }</a></th>
						<td>
							<c:forEach begin="1" end="${list.rate}" step="1">
								<c:out value="★" />
							</c:forEach>
							<c:forEach begin="1" end="${5-list.rate}" step="1">
								<c:out value="☆" />
							</c:forEach>
						<br> ${list.roomType }
						</td>
						<td>${list.revTitle }</td>
						<td>${list.user.userName }님</td>
						<td>${list.revDate }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="container center-block">
				
				<!-- 페이징 -->
					<div class="container text-center">
						<ul class="pagination" id="pages">
						</ul>
					</div>
					<!-- 페이징 끝 -->
				
			</div>
		</div>
	</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>
