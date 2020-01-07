<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<style>
/*등록버튼*/
.registButton {
	width: 100%;
}

/*검색패널*/
.searchBar {
	margin-top: 20px;
	margin-bottom: 20px;
}

.form-control-static {
	margin-left: 20px;
}

/*테이블*/
.th1, .th3 {
	width: 100px;
}

.th2 {
	width: 300px;
}

.th4, .th5 {
	width: 200px;
}

.table {
	width: 90%;
	margin: 0 auto;
	text-align: center;
	vertical-align: middle;
}

th {
	text-align: center;
}
/* 테이블 끝 */
</style>
<script>
$(document).ready(function(){
	var ddd = $("#count option:selected").val();
	$("#btnSearch").on("click", function() {
		var ddd = $("#count option:selected").val();	
		var value = $("#keyword").val().toLowerCase();	
		$("#roomTable tbody tr").filter(function() {
			$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		
		});
	});
});

var alert = function(msg, type) {
	swal({
		title : "",
		text : msg,
		icon : type,
		customClass : "sweet-size",
		showCancelButton : true,
	});
}
var confirm = function(msg, type) {
	   swal(msg, {
		   icon: type,
	        buttons: ["취소", "확인"],
	      }).then((value) => {
	    	 if(value){ 
	    		 document.location.href="01.html";
	    	 }else{
	    		 alert("취소하였습니다.", "warning" );
	    		 return;	
	    	 }
	         });
	}
	$(function() {
	   //취소버튼 클릭시 호출
	   $(".delbtn").click(function () {
		   var roomNumber = $(this).attr('id').substr(1);
		  
		   swal("삭제하시겠습니까?", {
			   icon: "warning",
		        buttons: ["취소", "확인"],
		      }).then((value) =>{
		      if(value)
		   $.ajax({
				url:"delete",
				method:"GET",
				data: {					
					roomNum:roomNumber
				 	
				},
				success:function(){
	       			location.href = "/hotel/room/roomManager";
	       		
				},
				error:function(a, b, errMsg){
					alert("에러"+ errMsg);
				}
				
			})
			else
				return;
		      });
	});
	   
	   $(".databtn").click(function () {
		  
		   var roomNum = $(this).attr('id').substr(1);
			
		   location.href = "roomData?roomNum=" + roomNum;
		
	});
		$(".myInquiryButton, .inqTitle").click(function() {
			var tr = $(this).parent().parent();
			var inqNumber = tr.children().children().val();

			location.href = "myInquiry?inqNumber=" + inqNumber;
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
				<div class="container">
					<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
							<a>객실관리 ></a>
						 	<a>객실목록</a>	
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;객실 목록</h3>
					</div>
					<br><br>
					<div class="text-center">
						<!-- 객실등록 버튼 -->
						<a class="btn btn-primary btn-lg registButton " href="/hotel/room/roomAdd"
							role="button">객실등록</a> <br> <br>
						<!-- 객실등록 버튼 끝 -->
						<!-- 검색 패널 -->
						<div class="container center-block text-center">
							<div class="panel panel-default">
								<form class="form-inline searchBar">
									<div class="form-group">
										<p class="form-control-static">최대인원</p>
										<select class="form-control">
											<option value="4">4</option>
											<option value="3">3</option>
											<option value="2">2</option>
											<option value="1">1</option>
										</select>
										<p class="form-control-static">등록일자</p>
										<div class="input-group date">
											<input type="date" class="form-control"> <span
												class="input-group-addon"> <i
												class="glyphicon glyphicon-calendar"></i>
											</span>
										</div>
										~
										<div class="input-group date">
											<input type="date" class="form-control"> <span
												class="input-group-addon"> <i
												class="glyphicon glyphicon-calendar"></i>
											</span>
										</div>
										<p class="form-control-static">객실 명</p>
										<input type="text" id="keyword" name="keyword" class="form-control">
									</div>
				
									<button type="button" id="btnSearch" name="btnSearch" class="btn btn-default">검색</button>
								</form>
							</div>
						</div>
						<!-- 검색패널 끝 -->
						<br>
				
						<div class="container center-block">
							<table class="table table-hover table-bordered" id="roomTable">
								<thead class="thead">
									<tr class="info">
										<th class="th1">번호</th>
										<th class="th2">객실명</th>
										<th class="th3">최대인원</th>
										<th class="th4">등록일자</th>
										<th class="th5"></th>
									</tr>
								</thead>
								<tbody>
								
									<c:forEach var="list" items="${roomList}">
									<tr>
										<th>${list.roomNum }</th>
										<td>${list.roomName }</td>
										<td>${list.guests }</td>
										<td>${list.roomRegDate }</td>
										<td><a class="btn btn-default databtn" id="a${list.roomNum }" role="button">보기</a>
										
											<button class="btn btn-danger delbtn" id="c${list.roomNum }" >삭제</button></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
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