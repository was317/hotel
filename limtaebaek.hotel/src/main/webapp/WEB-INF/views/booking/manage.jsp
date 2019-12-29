<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>서울호텔</title>
<meta charset="UTF-8">
<jsp:include page="../common/import.jsp"></jsp:include>
<script src="https://unpkg.com/isotope-layout@3/dist/isotope.pkgd.js"></script>
<style>
/*바디*/
.bodymain {
	padding: 0 30px 30px 30px;
}

/* 테이블*/
.table, th{
	text-align: center;
}

.th1, .th2, .th4 {
	width: 200px;
}
.th5{
	width: 150px;
}

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

$(document).ready(function() {
	var select = "예약번호";
	var td = ".td1";
	
	//셀렉트박스 클릭시 호출
	$("#selectBox").change(function() {
		select = $("#selectBox option:selected").val();
		$("#search").val("");
	});
	
	//검색시 호출
	$("#search").on("keyup", function() {
		var value = $(this).val().toLowerCase();
		if(select == "예약번호")
			$(this).val($(this).val().replace(/[^0-9]/gi, '')); 
		else
			$(this).val($(this).val().replace(/[^가-힣ㄱ-ㅎa-z]/gi, '')); 
			
		$("table tbody .tr1").filter(function() {
			$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		});
	});
	
	//예약정보 버튼 클릭시 호출
	$(".infoButton").click(function() {
		var tr = $(this).parent().parent();
		var bookingNum = tr.children().eq(0).text();
		var roomType = tr.children().eq(1).text();
		var name = tr.children().eq(3).text();
		$("#bookingNum").val(bookingNum);
		$("#roomType").val(roomType);
		$("#name").val(name);
		document.form.submit();
	});
});

$(function() {	
	var para = document.location.href.split("page=");
	var id = "#" + "page" + para[1];
	if(!para[1])
		id = "#page1";
	$(id).addClass('active');
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
				<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a> <a>예약관리</a>
						</p>
					</div>
				<div class="headTit">
					<h3>&nbsp;예약관리</h3>
				</div>
				<br> <br>
				<!-- 섹션 타이틀 끝-->
				<div class="container bodymain">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="form-inline text-center">
								<div class="form-group">
									<span> <select class="form-control" id="selectBox">
											<option>예약번호</option>
											<option>예약인</option>
									</select>
									</span> <input type="text" class="form-control" id="search">
								</div>
							</div>
						</div>
					</div>
					
						<table class="table table-hover table-bordered table-condensed" id="table">
						
							<tr class="success">
								<th class="th1">예약번호</th>
								<th class="th2">객실</th>
								<th class="th3">숙박일</th>
								<th class="th4">예약인</th>
								<th class="th5"></th>
							</tr>
							<tbody>
							<c:forEach var="list" items="${bookingList}">
							
								<tr class="tr1">
									<td class="td1">${list.bookingNum}</td>
									<td class="td2">${list.roomType}</td>
									<td class="td3">${list.checkIn} ~ ${list.checkOut}</td>
									<td class="td4"><c:choose>
											<c:when test="${list.userNum == 0}">(비회원) ${list.nuserKname}</c:when>
											<c:otherwise>${list.userName}</c:otherwise>
									</c:choose></td>
									<td class="td5"><button type="button" class="btn btn-success infoButton" id="${list.bookingNum}">예약정보</button></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					<!-- paging -->
					<div class="paging" style="text-align: center">
						<ul class="pagination">
							<li class="page-item">
								<c:if test="${page.nowPage-5 > 0}">
									<a class="page-link" href="/hotel/booking/bookingManage?page=${page.nowPage-5}" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span></a>
								</c:if>
							</li>
							<c:forEach var="i" begin="1" end="${page.maxPage}">
								<c:choose>
									<c:when test="${(i>=page.startPage) && (i<=page.endPage)}">
										<li id="page${i}"><a class="page-link pageNum" href="/hotel/booking/bookingManage?page=${i}">${i}</a></li>
									</c:when>
									<c:otherwise>
										<li style="display:none;" id="page${i}"><a class="page-link pageNum" href="/hotel/booking/bookingManage?page=${i}">${i}</a></li>
									</c:otherwise>
								</c:choose>	
							</c:forEach>
							<li class="page-item">
								<c:choose>
									<c:when test="${page.nowPage+5 > page.maxPage}">
										<a class="page-link" href="/hotel/booking/bookingManage?page=${page.maxPage}" aria-label="Next"> 
										<span aria-hidden="true">&raquo;</span></a>
									</c:when>
									<c:otherwise>
										<a class="page-link" href="/hotel/booking/bookingManage?page=${page.nowPage + 5}" aria-label="Next"> 
										<span aria-hidden="true">&raquo;</span></a>
									</c:otherwise>
								</c:choose>
							</li>
						</ul>
					</div>
				</div>
				<!-- paging 끝 -->
		</section>
	</div>
	<form name="form" method="post" action="bookingInformation">
		<input id=bookingNum name="bookingNum" type="hidden" value="">
		<input id=roomType name="roomType" type="hidden" value="">
		<input id=name name="name" type="hidden" value="">
	</form>
	<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>