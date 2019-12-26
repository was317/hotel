<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>서울호텔</title>
<meta charset="UTF-8">
<jsp:include page="../common/import.jsp"></jsp:include>
<style>
/* 패널 해드 */
.panel-heading {
	padding-left: 100px;
}
/* 패널 해드 끝 */
/* 패널 */
.mainPanel {
	width: 80%;
	margin: 0 auto;
}
.pointpanel, .payment {
	margin-left: 80%;
}
.panel-body {
	padding: 30px;
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
	margin-right: -90%;
}
.btn{
	margin-left: 10px;
}
/* 버튼 끝 */
</style>
<script>
var alert = function(msg, type) {
	swal({
		text: msg,
		icon: type,
		buttons: true,
		buttons: "확인",
	});
}

$(function() {
	var bookingNum;
	//취소버튼 클릭시 호출
	$(".cancel").click(function() {
		bookingNum = $(this).attr('id').substr(1);
		confirm("예약을 취소 하시겠습니까?", "warning");
	});
	$("#backmypage_book").click(function(){
		location.href="/hotel/";
	})
	
	var confirm = function(msg, type) {
	   swal(msg, {
		  	icon: type,
	        buttons: ["취소", "확인"],
	      }).then((value) => {
	    	  if(value){
	    		  $.ajax({
						url:"delBooking",
						data: {		
							bookingNum: bookingNum
						},
						success : function(data) {
							swal({
				    			title: "예약이 취소되었습니다.", 
								text: "환불처리는 1~3일정도 소요됩니다.",
								icon: "success",
								buttons: "확인",
							}).then((willDelete) => {
								return location.href = "/hotel/";
							});
						},error:function(a, b, errMsg){
							alert("취소오류" + errMsg);
						} 			
					}); 
	    	  }
	    	  else
	    		  return;
	      });
	}
});


</script>
</head>
<body>
	<div>
		<jsp:include page="../common/header.jsp" />
		<jsp:include page="../common/gnb.jsp" />
		<div id="contents">
			<section class="container">
				<!-- 섹션 타이틀 -->
				<div class="container center-block">
					<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a> <a>예약조회</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;예약조회</h3>
					</div>
					<br> <br>
				</div>
				<!-- 섹션 타이틀 끝-->
				<!-- 예약정보 패널 -->
				<c:forEach var="myList" items="${nUserBooking}">
					<div class="mainPanel">
						<div class="panel panel-default">
	
							<!-- 패널 헤드 -->
							<div class="panel-heading">
								<h3>예약정보</h3>
							</div>
							<!-- 패널 헤드 끝 -->
	
							<!-- 예약일, 예약번호 -->
							<div class="panel panel-default">
								<div class="panel-heading">
									<span class="regnum">예약번호:
										<label>${myList.bookingNum}</label></span>
								</div>
							</div>
							<!-- 예약일, 예약번호 끝-->
	
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
										<td><label>${myList.nuserKname}</label></td>
									</tr>
									<tr>
										<td>체크인</td>
										<td><label>${myList.checkIn}</label></td>
										<td>체크아웃</td>
										<td><label>${myList.checkOut}</label></td>
									</tr>
									<tr>
										<td>숙박일수</td>
										<td><label>${days}</label>박</td>
										<td>투숙인원</td>
										<td>성인: <label>${myList.adult}</label> / 어린이: <label>${myList.kid}</label></td>
									</tr>
									<tr>
										<td>객실</td>
										<td><label>${myList.roomType}</label></td>
										<td>옵션</td>
										<td><label><c:forEach var="list" items="${optionList}" varStatus="status">
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
									</c:forEach></label></td>
									</tr>
								</table>
							</div>
							<!-- 테이블 끝-->
	
							<!-- 포인트,요금 -->
							<div class="panel panel-default">
								<div class="panel-footer">
									<span class="pointpanel">사용 포인트: <label>${myList.bookingPoint}</label></span>
								</div>
								<div class="panel-footer">
									<span class="pointpanel">요금 합계: <label>${myList.payment}</label></span>
								</div>
							</div>
							<!-- 포인트,요금 끝-->
	
							<!-- 결제수단 -->
							<div class="panel-footer">
								<span class="payment">결제 수단: <label>${myList.paytype}</label></span>
							</div>
						</div>
						<!-- 예약정보 패널 끝-->
						<div class="buttongroup">
							<button type="button" class="btn btn-warning pull-right cancel"
								id="c${myList.bookingNum}">예약취소</button>
					<!-- 		<button type="button" class="btn btn-default pull-right"
								id="backmypage_book">목록으로</button> -->
						</div>
					</div>
					<hr>
				</c:forEach>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>