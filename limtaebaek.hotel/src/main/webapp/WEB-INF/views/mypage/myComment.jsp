<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔:마이페이지</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<style>
    /* main 섹션*/
    .main-section{
		margin-top:30px;
		margin-left:25%;
		height: 1000px;
		overflow: auto;
	}
	.main-section table{
		width:95%;
	}
	.main-section table a{
		text-decoration:none;
		text-align:center;
		color:#8c8c8c;
	}
	.main-section table a:hover{
		color:black;
	}
	.inform_form table th{
		background-color: #3C3C3C;
		color:white;
	}
    /* main 섹션 끝*/
</style>
<script>
var loadMyComment = function(userNum) {
	$.ajax({
		
		url:"/hotel/mypage/myCommentList?page=" + getParameterByName("page"),
		method:"POST",
		data:{
			userNum: userNum
		},
		success:function(result){
			$('#commnetList').empty();
			if(result.commnetList.length > 0 ){
				var commnetList = [];
				$(result.commnetList).each(function(idx, comment){
					var commentRate = "";
					for(var i = 0; i < comment.rate; i++){
						commentRate += "★";
					}
					for(var i = 0; i < 5 - comment.rate; i++){
						commentRate += "☆";
					}
					
					commnetList.push(
							'<tr id="' + comment.revNum + '" class="getReview">' +
							'<td>' + comment.revNum 			+ '</td>' +
							'<td>' + commentRate + "/" + comment.roomType + '</td>' +
							'<td>' + comment.revTitle			+ '</td>' +
							'<td>' + comment.revDate + '</td>' +
							'</tr>'				
					);
				});
				paging(result.page);

				$('#commnetList').append(commnetList.join(''));		

				$(".getReview").click(function () {
					location.href = "/hotel/comment/commentView?revNum=" + $(this).attr('id');
				});
			}else{
				$('#commnetList').append(
					'<tr><td colspan="6"><b>후기 작성 내역이 없습니다.</b></td></tr>'	);
			}
		},
		error:function(a, b, errMsg){
			$('#commnetList').empty();
			$('#commnetList').append(
				'<tr><td colspan="6"><b>후기 작성 내역을 불러오지 못했습니다.</b></td></tr>'	);
		}
	});
}

$(document).ready(loadMyComment("${sessionScope.user.userNum}"));
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
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
							<a>마이페이지</a>
							<a>후기 내역</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;마이페이지</h3>
					</div>
					<jsp:include page="aside.jsp" />
					<div class="main-section">
						<h4 style="text-align: left; width: 90%; float: left">|후기 작성 내역</h4>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th scope="row" width="10%">번호</th>
									<th scope="row" width="25%">평점/방타입</th>
									<th scope="row" width="45%">제목</th>
									<th scope="row" width="20%">작성일자</th>
								</tr>
							</thead>
							<tbody id="commnetList">
								
							</tbody>
						</table>
						<!-- paging -->
						<div class="text-center">
							<ul class="pagination" id="pages">
							</ul>
						</div>
						<!-- paging 끝 -->
					</div>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>