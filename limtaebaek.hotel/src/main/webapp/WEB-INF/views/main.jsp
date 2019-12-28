<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="common/import.jsp"></jsp:include>
<script src="<c:url value="/js/common.js"/>"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<style>
	div .searchBar {
		margin-top: 20px;
		margin-bottom: 20px;
	}
	
	div.promotion-title{
		padding-bottom: 5px;
	} 
	h4.promotion-title{
		margin-bottom: 0px;
	} 
	
	#more{
		float: right;
		font-size: 15px;
		text-decoration:none;
	}
	#more:hover{
		color:#A0A0A0;
	}
	/*메인 섹션 끝*/
	
.table-responsive {
	width: 90%;
	margin: 0 auto;
}

.modalbtn {
	margin-left: 50%;
}

.inputGroup {
	text-align: center;
}

.input-group {
	margin: 20px;
}

.previewImg {
	float: left;
}

div .searchBar {
	margin-top: 20px;
	margin-bottom: 20px;
}

.panel-defaul button {
	margin: 10px;
}

.custom-checkbox {
	float: left;
}

input[type="checkbox"] {
	display: none;
}

input[type="checkbox"]+label {
	display: inline-block;
	cursor: pointer;
	position: relative;
	margin-right: 25px;
	font-size: 12px
}

input[type="checkbox"]+label:BEFORE {
	content: "";
	display: inline-block;
	width: 20px;
	height: 20px;
	margin-right: 5px;
	left: 0;
	background-color: #ccc;
}

input[type="checkbox"]:checked+label:BEFORE {
	content: "\2713";
	font-size: 18px;
	color: #fff;
	background: #2187c1;
	text-align: center;
}

.isotope-element {
	width: 100%;
}

.table {
	border: 1px solid #dddddd;
}

/* DivTable */
.divTable {
	display: table;
	width: 100%;
}

.divTableRow {
	margin-left: 230px;
	display: table-row;
}

.divTableCell {
	display: table-cell;
	padding: 3px 10px;
}

.col1 {
	width: 148px;
	text-align: right;
}

.col2 {
	width: 600px;
}

.inputpice {
	letter-spacing: 1px;
}
.searchBtn{
	margin-left: 20px;
	padding: 10px 20px 10px 20px;
}
</style>
</head>
<script>
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

function confirmModalButton(roomNumber){
	$("input:checkbox[name=rom]").prop("checked",false);
	$("input:checkbox[name=count]").prop("checked",false);
	$("input:checkbox[name=option]").prop("checked",false);
	
	$.ajax({
		url : "room/getData",
		method : "GET",
		data : {
			roomNum : roomNumber
		},
		success : function(room) {
			var options = room.option;
			var optionList = options.split(" ");
			$("input:checkbox[name=option]").each(function(index){
				for(var i=0;i<optionList.length;i++){
				    if(index == optionList[i]){
				    	$(this).prop("checked", true);
					}
				}
  			}); 
		  		
			var roomImages = [room.roomImage1, room.roomImage2, room.roomImage3];	
			$(".previewImg").each(function(idx, img){
				if(roomImages[idx] != null)
					$(this).attr("src", "<c:url value='/img/" + roomImages [idx] + "'/>");
				})
			$("#roomType").val(room.roomName);
			$("#roomContent").val(room.roomContent);
			$("input:checkbox[name=rom][value=" +room.roomType+ "]").prop("checked",true);
			$("input:checkbox[name=count][value=" +room.guests+ "]").prop("checked",true);
			$("#price").text(room.roomPrice);
			
			$("#confirmModa1").modal('show');
		
		},
		error : function(a, b, errMsg) {
			alert("오류" + errMsg);
		}
	});
}

$(function(){
	$("#dateForm").val("");
	$("#adult").val("선택");
	$("#kid").val("0");
	
	$(".searchBtn").click(function () {
 		if($("#dateForm").val() ==""){
			alert("체크인/체크아웃을 선택해 주세요");
			return;
		}
		if($("#adult").val() =="선택"){
			alert("예약인원을 선택해 주세요");
			return;
		}
		
		var checkIn = $('#dateForm').val().substr(0,10);
		var checkOut = $('#dateForm').val().substr(13,22);
		var adult = $("#adult").val();
		var kid = $("#kid").val();

		location.href = "/hotel/room/roomReservation?checkIn=" + checkIn +
							"&checkOut=" + checkOut + "&adult=" + adult + "&kid=" +kid;
	});
	
	$.ajax({
		url:"room/roomList",
		method:"POST",
		success:function(result){
			$('#roomList').empty();
			
			if(result.length > 0 ){
				var roomList = [];
				$(result).each(function(idx, room){
					if(idx > 7) return;
					var roomImage = '<c:url value="/img/' + room.roomImage1 + '"/>';
					roomList.push(
							'<div class="col-sm-3 col-md-3">'+
						 	'<div class="thumbnail">' +
						    '<img src="' + roomImage +'" id="' + room.roomNum + '" class="thumbnail confirmModalButton"' +
						     ' style="height: 200px");"></a>' +
						    	'<div class="caption">' +
						           '<h3>서울호텔</h3>' +
						           '<h4>' + room.roomType + '</h4>' +
						           '<p>' + room.roomName + '</p>' +
						        '</div>' +
								'</div>' +
							'</div>'
					);
				});
				
				$('#roomList').append(roomList.join(''));	
				
				$(".confirmModalButton").click(function () {
					confirmModalButton($(this).attr("id"));
				});
			}
		},
		error:function(a, b, errMsg){
			$('#roomList').empty();
			$('#roomList').append(
					
				'<tr><td colspan="6"><b>포인트 사용 내역을 불러오지 못했습니다.</b></td></tr>'	
				);
		}
	});
})

function Today(){
    var dt = new Date();
    var year = dt.getFullYear();
    var month = dt.getMonth() + 1;
    var day = dt.getDate();
 
    if(month < 10) month = "0" + month;
    if(day < 10) day = "0" + day;
 
    return year + "/" + month + "/" + day;
}
$(function(){
   var checkInDate;
   var checkOutDate;
   $('#date').daterangepicker({
       autoUpdateInput: false,
       "locale": {
          "format": "YYYY/MM/DD",
          "separator": " ~ ",
           "applyLabel": "확인",
           "cancelLabel": "취소",
           "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
           "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월",
                        "7월", "8월", "9월", "10월", "11월", "12월"],
           "firstDay": 1,
           "toLabel": "To"
       },    
       "minDate": Today(),   //오늘 날짜
      
   },function(start, end) {
      checkInDate = start.format('YYYY-MM-DD');
      checkOutDate = end.format('YYYY-MM-DD');
   });
   
   $('#date').on('apply.daterangepicker', function(ev, picker) {
      var arr1 = checkInDate.split('-');
      var arr2 = checkInDate.split('-');
      checkIn = new Date(arr1[0], arr1[1], arr1[2]);
      checkOut = new Date(arr2[0], arr2[1], arr2[2]);
      alert('체크인: ' + checkInDate + '\n' + '체크아웃: ' + checkOutDate, "info");
      $('#dateForm').val(picker.startDate.format('YYYY-MM-DD') + ' ~ ' + picker.endDate.format('YYYY-MM-DD'));
      $('#bookingcheckIn').val(picker.startDate.format('YYYY-MM-DD'));
      $('#bookingcheckOut').val(picker.endDate.format('YYYY-MM-DD'));
   });

   $('#date').on('cancel.daterangepicker', function(ev, picker) {
      $('#dateForm').val('');
   });
     
});
</script>
<body>
	<div>
		<jsp:include page="common/header.jsp" />
		<jsp:include page="common/gnb.jsp" />
		<!-- 예약정보 검색 -->
		<div id="contents">
			<section>
				<div class="container center-block text-center">
					<div class="panel panel-default">
						<form class="form-inline searchBar">
							<div class="container text-center form-group">
								<p class="form-control-static">예약정보를 선택하세요</p>
								<p class="form-control-static">&nbsp; | &nbsp;체크인/체크아웃</p>
								<div class="input-group date" id="date">
									<input type="text" class="form-control" id="dateForm"
										onfocus="this.blur();" /> <span class="input-group-addon">
										<i class="glyphicon glyphicon-calendar"></i>
									</span>
								</div>
								<p class="form-control-static">&nbsp; | &nbsp; 성인</p>
								<select class="form-control" id="adult">
									<option>선택</option>
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
								</select>
								<p class="form-control-static">&nbsp; | &nbsp; 유아</p>
								<select class="form-control" id="kid">
									<option>0</option>
									<option>1</option>
									<option>2</option>
									<option>3</option>
								</select>
					
								<button type="button" class="btn btn-default searchBtn" style="position: absolute; margin-top: 16px;">검색</button>
							</div>
				      </form>
				   	</div>
				</div>
				<!-- 예약정보 끝 -->
			
				<!-- 패키지 프로모션 -->
				<div class="container center-block text-center">
					<div class="panel panel-default">
						<div class="panel-body promotion-title">
				        	<h4 class="text-center promotion-title">PACKAGES PROMOTIONS</h4>
				        	<a id="more" href="/hotel/promotion/boardPro">more <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
				     	</div>
				  	</div>
				  	<div class="row">
				  	
						<c:forEach items="${listPros}" var="pro">
					     	<div class="col-sm-3 col-md-3">
					        	<div class="thumbnail">
				           			<img class="thumbnail" style="height: 200px" src="<c:url value="/img/${pro.promotionDetails[0].prodPic}"/>"></img>
					       			<div class="caption">
					          			<h3>서울호텔</h3>
					          			<h4>${pro.proTitle}</h4>
					          			<p>${pro.proStartDate} ~ ${pro.proEndDate}</p>
					       			</div>
					 			</div>
					 		</div>
						</c:forEach>
					</div>
				</div>
				<!-- 끝 -->
				<!-- 룸 프로모션 -->
				<div class="container center-block text-center">
					<div class="panel panel-default">
						<div class="panel-body promotion-title">
			         		<h4 class="text-center promotion-title">ROOMS</h4>
				         	<a id="more" href="/hotel/room/roomReservation">more <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
				      	</div>
				   	</div>
				   	<div class="row" id="roomList">				  		
					</div>
				</div>
			<!-- 끝 -->
			</section>
		</div>
		<jsp:include page="common/footer.jsp" />
	</div>
	
	<div class="modal fade" id="confirmModa1">
		<div class="modal-dialog"
			style="max-width: 100%; width: auto; display: table;">
			<div class="modal-content">
				<!-- remote call이 되는영역 -->

				<div class="modal-dialog"
					style="max-width: 70%; width: 70%; display: table;">

					<div class="panel panel-default">
						<div class="container">
							<form id="form" class="form-inline">
								<div class="container inputGroup">
									<div class="input-group col-md-3">
										<img width="250" height="200" class="previewImg">
									</div>
									<div class="input-group col-md-3">
										<img width="250" height="200" class="previewImg1">
									</div>

									<div class="input-group col-md-3">
										<img width="250" height="200" class="previewImg2">
									</div>
								</div>
							</form>
							<!-- 테이블 -->
							<div class="table-responsive">
								<table class="table table-hover table-bordered">

									<tbody>
										<tr>
											<th>객실명</th>
											<td><input id="roomType" onfocus="this.blur();"></td>
										</tr>
										<tr>
											<th>방타입</th>
											<td>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="st" name="rom" value="스탠다드" disabled> <label
														class="custom-control-label" for="st">스탠다드</label>
												</div>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="dt" name="rom" value="디럭스" disabled> <label
														class="custom-control-label" for="dt">디럭스</label>
												</div>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="gt" name="rom" value="그랜드" disabled> <label
														class="custom-control-label" for="gt">그랜드</label>
												</div>
											</td>
										</tr>
										<tr>
											<th>옵션</th>
											<td>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="option1" name="option" value="1" disabled>
													<label class="custom-control-label" for="option1">조식</label>
												</div>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="option2" name="option" value="2" disabled>
													<label class="custom-control-label" for="option2">스파</label>
												</div>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="option3" name="option" value="3" disabled>
													<label class="custom-control-label" for="option3">야외수영장</label>
												</div>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="option4" name="option" value="4" disabled>
													<label class="custom-control-label" for="option4">엑스트라베드</label>
												</div>
											</td>
										</tr>
										<tr>

											<th>가능인원수</th>
											<td>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="count1" name="count" value="1" disabled> <label
														class="custom-control-label" for="count1">1명</label>
												</div>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="count2" name="count" value="2" disabled> <label
														class="custom-control-label" for="count2">2명</label>
												</div>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="count3" name="count" value="3" disabled> <label
														class="custom-control-label" for="count3">3명</label>
												</div>
												<div class="custom-control custom-checkbox col-md-2">
													<input type="checkbox" class="custom-control-input"
														id="count4" name="count" value="4" disabled> <label
														class="custom-control-label" for="count4">4명</label>
												</div>
											</td>

										</tr>
										<tr>
											<th>금액</th>
											<td><p id="price"></p></td>
										</tr>
										<tr>
											<th>상세내용</th>
											<td><textarea rows="20" cols="110" id="roomContent"
													onfocus="this.blur();"></textarea></td>
										</tr>

									</tbody>
								</table>
							</div>
						</div>
					</div>
					<button type="button" class="btn btn-default modalbtn"
						data-dismiss="modal">확인</button>

				</div>
			</div>
		</div>
	</div>
</body>
</html>
