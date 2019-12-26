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
var loadMyBooking = function(userNum) {
	$.ajax({
		
		url:"/hotel/mypage/myBookingList?page=" + getParameterByName("page"),
		method:"POST",
		data:{
			userNum: userNum
		},
		success:function(result){
			$('#bookingList').empty();
			if(result.bookingList.length > 0 ){
				var bookingList = [];
				$(result.bookingList).each(function(idx, booking){					
					bookingList.push(
							'<tr id="' + booking.bookingNum + '" class="getBooking">' +
							'<td>' + booking.bookingNum				+ '</td>' +
							'<td>' + "서울호텔"				+ '</td>' +
							'<td>' + booking.roomType		+ '</td>' +
							'<td>' + booking.checkIn		+ '</td>' +
							'<td>' + booking.checkOut		+ '</td>' +
							'<td>' + (new Date(booking.checkOut) - new Date(booking.checkIn))/(1000*3600*24) + "일"	+ '</td>' +
							'<td>' + (Number(booking.adult) + Number(booking.kid)) + "명" + '</td>' +
							'</tr>'				
					);
				});
				
				paging(result.page);

				$('#bookingList').append(bookingList.join(''));		

				$(".getBooking").click(function () {
				   location.href = "/hotel/booking/myBooking?bookingNum=" + $(this).attr('id');
				});
			}else{
				$('#bookingList').append(
					'<tr><td colspan="7"><b>예약 내역이 없습니다.</b></td></tr>'	);
			}
		},
		error:function(a, b, errMsg){
			$('#bookingList').empty();
			$('#bookingList').append(
				'<tr><td colspan="7"><b>예약 내역을 불러오지 못했습니다.</b></td></tr>'	);
		}
	});
}

$(document).ready(loadMyBooking("${sessionScope.user.userNum}"));
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
							<a>예약 확인/취소</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;마이페이지</h3>
					</div>
					<jsp:include page="aside.jsp" />
					<div class="main-section">
						<h4 style="text-align: left; width: 90%; float: left">|예약 내역</h4>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th scope="row" width="14%">예약번호</th>
									<th scope="row" width="14%">호텔</th>
									<th scope="row" width="14%">객실</th>
									<th scope="row" width="19%">체크인</th>
									<th scope="row" width="19%">체크아웃</th>
									<th scope="row" width="10%">숙박일수</th>
									<th scope="row" width="10%">투숙인원</th>
								</tr>
							</thead>
							<tbody id="bookingList">
								
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