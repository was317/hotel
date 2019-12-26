<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
/*  진행상황 네비게이션  */
.breadcrumb {
	text-align: center;
}

.breadcrumb>li+li:before {
	color: #ccc;
	content: ">";
	margin-right: 10px;
}

.breadcrumb>li>a {
	color: #ccc;
	font-size: 20px;
}

.breadcrumb>li>a:hover {
	text-decoration: none;
}

.breadcrumb>.active {
	color: black;
	font-size: 20px;
	font-weight: bold;
}
/* 진행상황 네비게이션 끝*/

/* 패널 해드 */
.panel-heading {
	padding-left: 80px;
	padding-right: 80px;
}
/* 패널 해드 끝 */

/* 패널 */
.mainPanel {
	width: 80%;
	margin: 0 auto;
}
.panel-footer{
	text-align: right;
}
.pointpanel{
	margin-right:30px;
}

.panel-body {
	padding: 40px;
}
/* 패널 끝 */

/* 테이블  */
colgroup col.info {
	background-color: #dff0d8;
	width: 150px;
	height: 500px;
}

colgroup col.col {
	width: 300px;
}

.confirm {
	width: 90%;
	margin: 0 auto;
}
/* 테이블  끝 */

/* 버튼 */
.buttongroup {
	width: 100%;
	margin-top: 30px;
	margin-bottom: 100px;
	margin-left: 47%;
}
/* 버튼 끝 */
</style>
<script>
$(function() {
	//예약조회버튼 클릭시 호출
	$("#myBooking").click(function() {
		location.href = "myBooking?bookingNum=" + $('#bookingNum').text();
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
			<section class="container">
				<!-- 섹션 타이틀 -->
				<div class="container center-block">
					<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a> <a>예약</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;예약</h3>
					</div>
					<br> <br>
				</div>
				<!-- 섹션 타이틀 끝-->
				<div class="mainPanel">
					<!-- 진행상황 네비게이션 -->
					<nav class="navbar navbar-default">
						<ol class="breadcrumb">
							<li><a href="/hotel/room/roomReservation">STEP1 날짜/인원/객실
									선택</a></li>
							<li><a>STEP2 고객 정보 입력</a></li>
							<li class="active">STEP3 예약완료</li>
						</ol>
					</nav>
					<!-- 진행상황 네비게이션 끝 -->

					<!-- 예약정보 패널 -->
					<div class="panel panel-default">
						<!-- 패널 헤드 -->
						<div class="panel-heading">
							<h3>예약이 완료되었습니다.</h3>
							<h4>예약하신 내용이 이메일로 발송되었습니다.</h4>
							<h2 class="text-right">예약번호: <label id="bookingNum">${booking.bookingNum}</label></h2>
						</div>
						<!-- 패널 헤드 끝 -->

						<!-- 테이블 -->
						<div class="panel-body">
							<table class="table table-bordered confirm">
								<colgroup>
									<col class="info">
									<col class="col">
									<col class="info">
									<col class="col">
								</colgroup>
								<tr>
									<td>호텔</td>
									<td>서울호텔</td>
									<td>성명</td>
									<td><label id="name">${booking.userName}</label></td>
								</tr>
								<tr>
									<td>체크인</td>
									<td><label id="checkIn">${booking.checkIn}</label></td>
									<td>체크아웃</td>
									<td><label id="checkOut">${booking.checkOut}</label></td>
								</tr>
								<tr>
									<td>숙박일수</td>
									<td><label id="days">${days}</label>박</td>
									<td>투숙인원</td>
									<td>성인: <label id="adult">${booking.adult}</label> / 어린이: <label id="kid">${booking.kid}</label></td>
								</tr>
								<tr>
									<td>객실</td>
									<td><label id="roomType">${booking.roomType}</label></td>
									<td>옵션</td>
									<td><label id="option">
									<c:forEach var="list" items="${optionList}" varStatus="status">
										<c:choose>
									        <c:when test="${list.optNo == 1}">
									        	조식&nbsp;
									        </c:when>
									        <c:when test="${list.optNo == 2}">
									        	스파&nbsp;
									        </c:when>
									        <c:when test="${list.optNo == 3}">
									      		야외수영장&nbsp;
									        </c:when>
									        <c:when test="${list.optNo == 4}">
									      		엑스트라베드&nbsp;
									        </c:when>
									        <c:otherwise></c:otherwise>
									    </c:choose>
									</c:forEach>
									</label></td>
								</tr>
							</table>
						</div>
						<!-- 테이블 끝-->

						<!-- 포인트,요금 -->
						<div class="panel panel-default">
							<div class="panel-footer">
								<span class="pointpanel">사용 포인트: <label id="point">${booking.bookingPoint}</label></span>
							</div>
							<div class="panel-footer">
								<span class="pointpanel">요금 합계: <label id="charge">${booking.payment}</label>
								 / 결제수단: <label id="paytype">${booking.paytype}</label></span>
							</div>
						</div>
						<!-- 포인트,요금 끝-->
					</div>
					<!-- 예약정보 패널 끝-->

					<div class="buttongroup">
						<button type="button" class="btn btn-default btn-lg" id="myBooking">예약조회</button>
					</div>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>