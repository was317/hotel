<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<script src="<c:url value="/js/common.js"/>"></script>
<script src="https://unpkg.com/isotope-layout@3/dist/isotope.pkgd.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<style>
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
.td1{
	width:600px;
}
.td2{
	width:200px;
}
.td3{
	width:150px;
}

.noResult{
	width: 100%;
	margin: 0 auto;
	text-align: center;
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
</style>
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

$(document).ready(function() {
	var adult;
	var kid;
	var minprice;
	var maxprice;
	var selectbox;
	var checkList = Array.apply(null, new Array(4)).map(String.prototype.valueOf,"");
	   
	if("${adult}"){
 		$('#bookingcheckIn').val("${checkIn}");
 	    $('#bookingcheckOut').val("${checkOut}");
		$("#bookingAdult").val("${adult}");
		$("#bookingKid").val("${kid}");
		$("#dateForm").val("${checkIn} ~ ${checkOut}");
		$("#adult").val("${adult}");
		$("#kid").val("${kid}");
		adult = $("#adult").val();
		kid = $("#kid").val();
		selectbox = parseInt(adult) + parseInt(kid);
	}
	else{ 
		$("#dateForm").val("");
		$("#adult").val("선택");
		$("#kid").val("0");
	}
	
   // 필터링
	var $container = $('#isotope-items').isotope({
		layoutMode: 'fitRows',
		filter: function() {
		var $this = $(this); 
		var options = Array.apply(null, new Array(4)).map(String.prototype.valueOf,"");
		
		for(var i=0;i<4;i++){
			options[i] = checkList[i] ? $this.find('.txt1').text().match( checkList[i] ) : true;
		}

		var optionResult = options[0] && options[1] && options[2] && options[3];
		var minResult = minprice ? parseInt($this.find('.txt3').text()) >= parseInt(minprice) : true;
		var maxResult = maxprice ? parseInt($this.find('.txt3').text()) <= parseInt(maxprice) : true;
		var countResult = selectbox ? $this.find('.txt4').text().match( selectbox ) : true;
		
		return minResult && maxResult && countResult && optionResult;
     }
   });

   noResult();
	
   //최소금액
   var $min = $('#min').keyup( debounce( function() {
      minprice = parseInt($min.val());
      if($(this).val() == "")
         minprice = 0;
      if($('#max').val() == "")
         maxprice = minprice+10000000;
      if(minprice > maxprice){
         alert("최대금액을 넘을 수 없습니다");
         $(this).val(maxprice);
         minprice = maxprice;
      }
      $container.isotope();
      noResult();
   }) );

   //최대금액
   var $max = $('#max').keyup( debounce( function() {
      maxprice = parseInt($max.val());
      if($('#min').val() == "")
         minprice = 0;
      if(maxprice < minprice || $(this).val() == "")
         maxprice = minprice+10000000;
      $container.isotope();
      noResult();
   }) );

   //옵션
   var $optionboxes = $('.searchCheckBox');
   $optionboxes.change(function () {
	  checkList = Array.apply(null, new Array(4)).map(String.prototype.valueOf,"");
      var i=0;

      $('input:checkbox[name="searchOption"]').each(function() {
         if(this.checked){
            var checkId = $(this).attr("id");
            checkList[i] = $("label[for='"+checkId+"']").text();
            i++;
         }
      });
      $container.isotope();
      noResult();
   });

   //인원수
   var $selectboxes = $('#adult, #kid');
   $selectboxes.change(function() {
      adult = $("#adult option:selected").val();
      $("#bookingAdult").val(adult);
      
      kid = $("#kid option:selected").val();
      $("#bookingKid").val(kid);
   
      selectbox = parseInt(adult) + parseInt(kid);
      $container.isotope();
      noResult();
   });
   
   // 검색시간조절
   function debounce( fn, threshold ) {
      var timeout;
      threshold = threshold || 300;
      return function debounced() {
         clearTimeout( timeout );
          var args = arguments;
          var _this = this;
          function delayed() {
            fn.apply( _this, args );
          }
          timeout = setTimeout( delayed, threshold );
      };
   }
   
 	//검색 결과없을때 문구
	function noResult() {
		if ($container.data('isotope').filteredItems.length > 0) 
			$('.noResult').hide();
		else
			$('.noResult').show();
	}
});

function Today(){
    var dt = new Date();
    var year = dt.getFullYear();
    var month = dt.getMonth() + 1;
    var day = dt.getDate();
 
    if(month < 10) month = "0" + month;
    if(day < 10) day = "0" + day;
 
    return year + "/" + month + "/" + day;
}


$(function() {
	$(".confirmModalButton").click(function() {
		var roomNumber = $(this).parents().attr('id').substr(1);
		$("input:checkbox[name=rom]").prop("checked",false);
		$("input:checkbox[name=count]").prop("checked",false);
		$("input:checkbox[name=option]").prop("checked",false);
		
		$.ajax({
			url : "getData",
			method : "GET",
			data : {
				roomNum : roomNumber
			},
			success : function(room) {
				var options = room.option;
				var optionList = options.split(" ");
	 			$("input:checkbox[name=option]").each(function(index){
					for(var i=0;i<optionList.length;i++){
					    if($(this).siblings().text() == optionList[i]){
					    	$(this).prop("checked", true);
						}
					}
	  			});  
	 			
				var roomImages = [room.roomImage1, room.roomImage2, room.roomImage3];	
				$(".previewImg3").each(function(idx, img){
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
		
		
	});
	
	$(".bookingBtn").click(function() {
 		if($("#dateForm").val() ==""){
			alert("체크인/체크아웃을 선택해 주세요");
			return;
		}
		if($("#adult").val() =="선택"){
			alert("예약인원을 선택해 주세요");
			return;
		}
		
		var roomNumber = $(this).parents().parents().attr('id').substr(1);
		var roomType = $(this).parents().prev().prev().children().children().eq(0).text();
		var roomOption = $(this).parents().prev().prev().children().children().eq(1).text();
		var roomPrice = $(this).parents().prev().children().eq(0).text();
		$("#bookingRoomNumber").val(roomNumber);
		$("#bookingRoomPrice").val(roomPrice);
		$("#bookingRoomType").val(roomType);
		$("#bookingRoomOption").val(roomOption);
		//$("#bookingUser").val("${user.userNum}");
		document.form.submit();
	});

})


</script>
</head>
<body>
	<div>
		<jsp:include page="../common/header.jsp" />
		<jsp:include page="../common/gnb.jsp" />
		<div id="contents">
			<!-- 예약정보 검색 -->
			<section>
				<div class="container">
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
							</div>
							<hr>
							<div class="divTable">
								<div class="form-group divTableRow optionForm">
									<div class="divTableCell col1">
										<div class="custom-control custom-checkbox">
											<p class="form-control-static optionInfo">옵션을
												선택하세요&nbsp;&nbsp;|</p>
										</div>
									</div>
									<div class="divTableCell col2">
										<div class="custom-control custom-checkbox searchCheckBox">
											<input type="checkbox" class="custom-control-input"
												id="searchOption1" name="searchOption"> <label
												class="custom-control-label" for="searchOption1">조식</label>
										</div>
										<div class="custom-control custom-checkbox searchCheckBox">
											<input type="checkbox" class="custom-control-input"
												id="searchOption2" name="searchOption"> <label
												class="custom-control-label" for="searchOption2">스파</label>
										</div>
										<div class="custom-control custom-checkbox searchCheckBox">
											<input type="checkbox" class="custom-control-input"
												id="searchOption3" name="searchOption"> <label
												class="custom-control-label" for="searchOption3">야외수영장</label>
										</div>
										<div class="custom-control custom-checkbox searchCheckBox">
											<input type="checkbox" class="custom-control-input"
												id="searchOption4" name="searchOption"> <label
												class="custom-control-label" for="searchOption4">엑스트라베드</label>
										</div>
									</div>
								</div>

								<div class="form-group divTableRow priceForm">
									<div class="divTableCell col1">
										<p class="form-control-static priceInfo">금액범위&nbsp;&nbsp;|</p>
									</div>
									<div class="divTableCell col2">
										<input class="form-control inputpice" id="min"
											placeholder="최소금액"> <label>&nbsp;원 ~&nbsp;</label> <input
											class="form-control inputpice" type="text" id="max"
											placeholder="최대금액"> <label>&nbsp;원 </label>
										<button class="btn btn-default pull-right">선택초기화</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- 예약검색 폼 끝 -->


				<!-- 객실목록 -->
				<div class="container center-block" id="isotope-items">
					<c:forEach var="list" items="${roomList}">
						<div class="isotope-element" id="isotope-filter0">
							<div class="thumb-isotope">
								<table class="table table-hover">
									<tr id="a${list.roomNum }">
										<td class="confirmModalButton td1">
											<img width="300" height="200" src="<c:url value="/img/${list.roomImage1}"/>"></td>

										<td class="confirmModalButton td2" style="vertical-align: middle;">
											<h4>
												● <span class="txt0">${list.roomType }</span>
											</h4>
											<p>
												<c:forEach var="options" items="${list.options}">
													<c:choose>
												        <c:when test="${options.optNo == 1}">
												        	<p>- <span class="txt1">조식</span></p>
												        </c:when>
												        <c:when test="${options.optNo == 2}">
												        	<p>- <span class="txt1">스파</span></p>
												        </c:when>
												        <c:when test="${options.optNo == 3}">
												      		<p>- <span class="txt1">야외수영장</span></p>
												        </c:when>
												        <c:when test="${options.optNo == 4}">
												      		<p>- <span class="txt1">엑스트라베드</span></p>
												        </c:when>
												        <c:otherwise></c:otherwise>
												        </c:choose>
												</c:forEach>
											</p>
										</td>
										<td class="confirmModalButton td3" style="vertical-align: middle;">
											<span class="txt3">${list.roomPrice }</span>원<br>기준 <span
											class="txt4">${list.guests }</span> 명
										</td>

										<td class="td4" style="vertical-align: middle;"><button
												class="btn btn-default bookingBtn" type="button"
												style="width: 150px; height: 150px;">예약</button></td>
									</tr>
								</table>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- 객실목록 끝 -->
				<div class="container noResult">
					<p>검색결과가 없습니다.</p>
				</div>
				
				<div class="modal fade" id="confirmModa1">
					<div class="modal-dialog"
						style="max-width: 90%; width: auto; display: table;">
						<div class="modal-content">
							<!-- remote call이 되는영역 -->
							<div class="modal-dialog"
								style="width: 80%; display: table;">

								<div class="panel panel-default">
									<div class="container">
										<form id="form" class="form-inline">
											<div class="container inputGroup">
												<div class="input-group col-md-3">
													<img width="250" height="200" class="previewImg3">
												</div>
												<div class="input-group col-md-3">
													<img width="250" height="200" class="previewImg3">
												</div>

												<div class="input-group col-md-3">
													<img width="250" height="200" class="previewImg3">
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
				<br> <br>
			</section>
		</div>

		<form name="form" method="post" action="/hotel/booking/bookingForm">
			<input id="bookingRoomNumber" name="roomNum" type="hidden" value="">
			<input id="bookingcheckIn" name="checkIn" type="hidden" value="">
			<input id="bookingcheckOut" name="checkOut" type="hidden" value="">
			<input id="bookingAdult" name="adult" type="hidden" value="">
			<input id="bookingKid" name="kid" type="hidden" value="">
			<input id="bookingRoomType" name="roomType" type="hidden" value="">
			<input id="bookingRoomPrice" name="roomPrice" type="hidden" value="">
			<input id="bookingRoomoption" name="optName" type="hidden" value="">
		</form>
		
		<script>
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
			      //년:checkIn.getFullYear()
			      //월:checkIn.getMonth()
			      //일:checkIn.getDate()
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
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>
