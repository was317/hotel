<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>서울호텔</title>
<meta charset="UTF-8">
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
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

.pointpanel, .paytypepanel {
	margin-left: 65%;
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
	width: 250px;
}

.confirm {
	width: 90%;
	margin: 0 auto;
}
/* 테이블  끝 */

/* 버튼 */
.buttongroup {
	margin-top: 30px;
	margin-bottom: 100px;
}

.btn {
	margin-left: 10px;
}
/* 버튼 끝 */
</style>
<script>
var confirm = function(msg, type) {
	   swal(msg, {
	        buttons: ["취소", "확인"],
	      }).then((value) => {
	    	  if(value)
	    		  window.history.back();
	    	  else
	    		  return;
	      });
	}
var alert = function(msg, type) {
	swal({
		  title: "",
		  text: msg,
		  icon: type,
		  button: "확인",
		}).then((value) => {
			return;
		});
}
$(function() {
	$("#adult").val("${booking.adult}");
	$("#kid").val("${booking.kid}");
	//취소버튼 클릭시 호출
	$("#cancel").click(function() {
		confirm("수정을 취소 하시겠습니까?", "warning");
	});
	
	//수정버튼 클릭시 호출
	$("#submit").click(function() {
		var checkIn = $("#checkIn").val();
		var checkOut = $("#checkOut").val();
		var adult = $("#adult").val();
		var kid = $("#kid").val();
		var payment = $("#payment").text();
		var bookingNum = $("#bookingNum").text();
		
		if($("#days").text() == ""){
	    	alert("날짜를 다시 설정해 주세요.", "warning");
	    	$("#checkIn").val("${booking.checkIn}");
	    	$("#checkOut").val("${booking.checkOut}");
	    	$("#days").text("${days}");
	    }
	    else {
	    	$.ajax({
				url:"changeBooking",
				data: {		
					checkIn: checkIn,
					checkOut: checkOut,
					adult: adult,
					kid: kid,
					payment: payment,
					bookingNum: bookingNum
				},
				success : function(data) {
					swal({
						text: "수정되었습니다",
						icon: "success",
						button: "확인",
					}).then((value) => {
						location.href="bookingManage";
					});
				},error:function(a, b, errMsg){
					alert("수정오류" + errMsg);
				} 			
			});
		}
	});
	
	//체크인
	$("#checkIn").change(function(){
		$("#checkOut").val("");
		$("#days").text("");
	    
	});
	
	//체크 아웃
	$("#checkOut").change(function(){
	    if(days() < 0){
	    	alert("체크아웃 날짜를 다시 설정해 주세요.", "warning");
	    	$("#checkOut").val("");
	    	$("#days").text("");
	    }
	    else {
			$("#days").text(parseInt(days()));
		   
			charge();
		}
	});

	function days(){
		var sdd = $("#checkIn").val();
	    var edd = $("#checkOut").val();
	    var ar1 = sdd.split('-');
	    var ar2 = edd.split('-');
	    var da1 = new Date(ar1[0], ar1[1], ar1[2]);
	    var da2 = new Date(ar2[0], ar2[1], ar2[2]);
	    var dif = da2 - da1;
	    var cDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
	    
	    return dif/cDay;
	}
	
	//금액 변동
	function charge(){
		var beforeD = "${days}" * 1;
		var afterD = $("#days").text() * 1;
		var point = "${booking.bookingPoint}" * 1;
		var beforC = "${booking.payment}" * 1 + point;
		
		if(beforeD == 0){
			beforeD++;
			afterD++;
		}
		//100원 밑 절사
		var changeCharge = Math.ceil(((beforC / beforeD) * (afterD - beforeD)) / 100) * 100;
		//변동금액이 -50%이하일때 50%금액으로 고정 
		if(changeCharge + beforC < beforC / 2){
			$("#changeCharge").text(beforC / 2 * (-1));
			$("#payment").text(beforC / 2 - point);
			return;
		}
		$("#changeCharge").text(changeCharge);
		$("#payment").text(changeCharge + beforC - point);
	}
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
				<!-- 예약정보 패널 -->
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
								 <span class="regnum">예약번호: <label id="bookingNum">${booking.bookingNum}</label></span>
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
									<td><label id="name">${name}</label></td>
								</tr>
								<tr>
									<td>체크인</td>
									<td>
										<div class="form-group">
											<div class="input-group date">
					                           <input type="date" class="form-control" id="checkIn"
					                           			onfocus="this.blur();" value="${booking.checkIn}"/>
					                           <span class="input-group-addon">
					                           <i class="glyphicon glyphicon-calendar"></i></span>
					                        </div>
										</div>
									</td>
									<td>체크아웃</td>
									<td>
										<div class="form-group">
											<div class="input-group date">
					                           <input type="date" class="form-control" id="checkOut"
					                           			onfocus="this.blur();" value="${booking.checkOut}"/>
					                           <span class="input-group-addon">
					                           <i class="glyphicon glyphicon-calendar"></i></span>
					                        </div>
										</div>
									</td>
								</tr>
								<tr>
									<td>숙박일수</td>
									<td><label id="days">${days}</label>박</td>
									<td>투숙인원</td>
									<td>
										<div class="form-group form-inline">
											<span>성인: </span>
											<select class="form-control" id="adult">
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
											</select>
											<span>&nbsp;/&nbsp;어린이: </span>
											<select class="form-control" id="kid">
												<option>0</option>
												<option>1</option>
												<option>2</option>
												<option>3</option>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<td>객실</td>
									<td><label id="roomType">${roomType}</label></td>
									<td>옵션</td>
									<td><label id="option">${optionList}</label></td>
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
								<span class="pointpanel">요금 합계: <label id="payment">${booking.payment}</label>원
								&nbsp;/&nbsp;
						요금 변동: <label id="changeCharge">0</label>원</span>
							</div>
						</div>
						<!-- 포인트,요금 끝-->

						<!-- 결제수단 -->
						<div class="panel-footer">
							<span class="paytypepanel">결제 수단: <label id="payType">${booking.paytype}</label></span>
						</div>

					</div>
					<!-- 예약정보 패널 끝-->
					<div class="buttongroup">
						<button type="button" class="btn btn-default pull-right" id="cancel">취소</button>
						<button type="button" class="btn btn-default pull-right" id="submit">수정 완료</button>
					</div>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>