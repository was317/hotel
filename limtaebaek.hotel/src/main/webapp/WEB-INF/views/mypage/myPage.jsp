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
/* 모달 버튼 */
.modalbtn{
	margin-left:90%;
}

/*문의 제목*/
.inqTitle{
	font-size: 15px;
	cursor:pointer;
}


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
$(function() {
	//보기 버튼
	$(".myInquiryButton, .inqTitle").click(function() {
		var tr = $(this).parent().parent();
		var inqNumber = tr.children().children().val();
			$("#inqNumParam").val(inqNumber);
		document.form.setAttribute("action", "myInquiry");
		document.form.submit();
	});

	//수정 버튼
	$(".modifyButton").click(function() {
		var tr = $(this).parent().parent();
		var inqNumber = tr.children().children().val();
		$("#inqNumParam").val(inqNumber);
		document.form.setAttribute("action", "modifyInquiry");
		document.form.submit();
	});

	//답변보기 버튼
	$(".answerModalButton").click(function() {
		var tr = $(this).parent().parent();
		var inqNumber = tr.children().children().val();
		$.ajax({
			url : "getAnswer",
			method : "GET",
			data : {
				inqNum : inqNumber
			},
			success : function(inq) {
				$("#Anscontent").val(inq.inqCmtContent);
				$("#answerModal").modal('show');

/* 					 $("#answerModal").modal({
					remote : "myInqAns"
				});  */
			},
			error : function(a, b, errMsg) {
				alert("오류" + errMsg);
			}
		});
	});
});

var loadUser = function(userNum) {
	$.ajax({
		url:"/hotel/user/getUser",
		method:"POST",
		data: {userNum: userNum},
		success:function(User){
			var myPointSum = 0;
			if(User.myPoints != null){
				User.myPoints.forEach(function(point) {
					myPointSum += point.pointChange;
				})
			}
			dataIn(User, myPointSum)
		},
		error:function(a, b, errMsg){
			alert("유저 데이터 불러오기에 실패했습니다.");
		}
	});
}

//data, correct datas
function dataIn(user, myPointSum){
	$("#userRegDate").text(user.userRegDate);
	$("#userEmail").text(user.userEmail);
	$("#userPassword").text(user.userPassword);
	$("#point").text(myPointSum);
	$("#userName").text(user.userName);
	$("#userEngFirstName").text(user.userEngFirstName);
	$("#userEngLastName").text(user.userEngLastName);
	$("#userBirth").text(user.userBirth);
	$("#userPhone").text(user.userPhone);
	$("#userTel").text(user.userTel);
	$("#userZip").text(user.userZip);
	$("#userAdd").text(user.userAdd);
	$("#userAddDetail").text(user.userAddDetail);
}
$(document).ready(loadUser("${sessionScope.user.userNum}"));

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
					if(idx > 10) return;
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
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;마이페이지</h3>
					</div>
					<jsp:include page="aside.jsp" />
					<div class="main-section">
						<div>
							<div>
								<div class="reserve_form">
									<h4 style="text-align:left; width:90%; float:left">| 예약내역</h4>
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
										<ul class="pagination" id="pages_bookings">
										</ul>
									</div>
									<!-- paging 끝 -->
					            </div>
					            <!-- paging 끝 -->

								<div class="question_form">
									<h4 style="text-align:left; width:90%; float:left">| 문의내역</h4>
									<table class="table table-bordered">
										<tbody>
											<tr>
												<th scope="row" width="10%">문의번호</th>
												<th scope="row" width="30%">문의제목</th>
												<th scope="row" width="15%">작성일</th>
												<th scope="row" width="15%">답변상태</th>
												<th scope="row" width="20%">확인</th>
											</tr>
											<c:forEach var="list" items="${inqList}" varStatus="count">
												<tr>
													<c:set var= "num" value="${inqCount.count + 1 - count.count}"/>
													<td><input type="hidden" value="${list.inqNum}"><c:out value="${num}"/></td>
													<td><a class="inqTitle">${list.inqTitle}</a></td>
													<td>${list.inqDate}</td>
													<td>${list.status}</td>
													<td>
														<button class="btn btn-default myInquiryButton" type="button">보기</button>
														<c:if test="${list.status eq '답변 대기'}">
															<button class="btn btn-default modifyButton" type="button">수정</button>
														</c:if>
														<c:if test="${list.status eq '답변완료'}">
															<button class="btn btn-default answerModalButton" type="button">답변 보기</button>
														</c:if>
													</td>
		
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<form name="form" method="post">
										<input id=inqNumParam name="inqNumber" type="hidden" value="">
									</form>
								</div>
					            <!-- paging 끝 -->
								<div class="inform_form">
									<h4 style="text-align:left; width:90%; float:left">| 개인정보</h4>
									<table class="table table-bordered">
										<colgroup>
											<col class="col1" width="15%">
											<col class="col2" width="85%">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row" class="first">가입일</th>
												<td>		
													<div >	
														<label id="userRegDate" class="control-label"></label> 
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="first">이메일</th>
												<td>		
													<div >	
														<label id="userEmail" class="control-label"></label> 
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="first">비밀번호</th>
												<td>		
													<div >	
														<label id="userPassword" class="control-label"></label> 
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="first">포인트</th>
												<td>		
													<div >	
														<label id="point" class="control-label"></label> 
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="first">이름(국문)</th>
												<td>		
													<div>	
														<label id="userName" class="control-label"></label> 
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="first">이름(영문)</th>
												<td>		
													<div>	
														<label id="userEngFirstName" class="control-label"></label> 
														<label id="userEngLastName" class="control-label"></label> 
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="first">생년월일</th>
												<td>		
													<div>	
														<label id="userBirth" class="control-label"></label> 
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="first">휴대전화</th>
												<td>		
													<div>	
														<label id="userPhone" class="control-label"></label> 
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="first">자택전화</th>
												<td>		
													<div>	
														<label id="userTel" class="control-label"></label> 
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="first">자택주소</th>
												<td>		
													<div>	
														<label id="userZip" class="control-label"></label><br>
														<label id="userAdd" class="control-label"></label><br>
														<label id="userAddDetail" class="control-label"></label> 
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
		
	<!-- 답변 모달 -->
	<div class="modal fade" id="answerModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- remote call이 되는영역 -->

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">답변</h4>
				</div>
				<div class="modal-body">
					<div class="panel panel-default">
						<table class="table">
							<tbody>
								<tr>
									<td><textarea id="Anscontent" class="form-control" rows="12" cols="60"
											onfocus="this.blur();">
					</textarea></td>
								</tr>
							</tbody>
						</table>

					</div>

						<button type="button" class="btn btn-default modalbtn"
							data-dismiss="modal">확인</button>

				</div>

				<!-- remote call끝 -->
			</div>
		</div>
	</div>
	<!-- 답변 모달 끝 -->
</body>
</html>