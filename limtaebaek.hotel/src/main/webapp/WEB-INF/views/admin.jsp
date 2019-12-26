<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔:관리자 페이지</title>
<jsp:include page="common/import.jsp"></jsp:include>
<style>
	.today_status{
		margin-left:8%;
		width:84%;
		height:250px;
	}
	.today_status th{
		text-align: center;
	}
	
	.question{
		margin-left:8%;
		width:84%;
	}
	.question th{
		text-align:center;
	}
	#more{
		float: right;
		font-size: 15px;
		text-decoration:none;
		margin-top:10px;
	}
	#more:hover{
		color:#A0A0A0;
	}
	/*메인 섹션 끝*/
</style>
</head>
<c:if test="${(sessionScope.user.userGrade == '2' && sessionScope.page == 'admin')}">
	<script>
		$(document).ready(function(){
			$.ajax({
				url:"/hotel/booking/todayBookingUser",
				method:"POST",
				success:function(result){
						$("#bookingNum").text(result + " 명");
					},
					error:function(a, b, errMsg){
						alert("유저 데이터 불러오기에 실패했습니다.");
					}
				});
			
			$.ajax({
				url:"/hotel/inquiry/todayInquiry",
				method:"POST",
				success:function(result){
						$("#inquiryNum").text(result + " 건 / ");
					},
					error:function(a, b, errMsg){
						alert("유저 데이터 불러오기에 실패했습니다.");
					}
				});
			
			$.ajax({
				url:"/hotel/inquiry/todayInquiryNoComent",
				method:"POST",
				success:function(result){
						$("#inquiryNum").text($("#inquiryNum").text() + result + " 건");
					},
					error:function(a, b, errMsg){
						alert("유저 데이터 불러오기에 실패했습니다.");
					}
				});
		
			$.ajax({
				url:"/hotel/user/todayJoinUser",
				method:"POST",
				success:function(result){
						$("#joinUserNum").text(result + " 명");
					},
					error:function(a, b, errMsg){
						alert("유저 데이터 불러오기에 실패했습니다.");
					}
				});
			$.ajax({
				url:"/hotel/inquiry/inquiryMainList",
				method:"POST",
				success:function(result){
					$('#inquiryList').empty();
					if(result.length > 0 ){
						var inquiryList = [];
						$(result).each(function(idx, inquiry){
							inquiryList.push(
									'<tr>' +
									'<td>' + inquiry.inqTitle+'</td>' +
									'<td>' + inquiry.inqWriter+'</td>' +
									'<td>' + inquiry.inqDate+'</td>' +
									'</tr>'				
							);
						});
						
						$('#inquiryList').append(inquiryList.join(''));
						
					}else{
						$('#inquiryList').append(
							'<tr><td colspan="3"><b>문의가 없습니다..</b></td></tr>'	);
					}
				},
				error:function(a, b, errMsg){
					$('#inquiryList').empty();
					$('#inquiryList').append(
						'<tr><td colspan="3"><b>문의를 불러오지 못했습니다.</b></td></tr>'	);
				}
			});
		});
	</script>
</c:if>
<body>
	<div>
		<jsp:include page="common/header.jsp" />
		<jsp:include page="common/gnb.jsp" />
		<!-- 예약정보 검색 -->
		<div id="contents">
			<section>
				<c:choose>
					<c:when test="${(sessionScope.user.userGrade == '2' && sessionScope.page == 'admin')}">
						<div class="container center-block text-center">
							<div class="container">
								<div class="today_status">
									<h4 style="text-align:left">Today 현황</h4>
									<table class="table table-bordered">
										<colgroup>
											<col width="50%" class="col1">
											<col width="50%" class="col2">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row">예약 수</th>
												<td>
													<p id="bookingNum"></p>
												</td>
											</tr>
											<tr>
												<th scope="row">문의사항 / 미처리문의</th>
												<td>
													<p id="inquiryNum"></p>
												</td>
											</tr>
											<tr>
												<th scope="row">회원가입</th>
												<td>
													<p id="joinUserNum"></p>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="container">
								<div class="question">
									<h4 style="text-align:left; width:90%; float:left">| 문의사항</h4>
									<a id="more" href="/hotel/inquiry/inquiryManage">more <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
									<table class="table table-bordered">
										<thead>
											<tr>
												<th scope="row" width="65%">제목</th>
												<th scope="row" width="15%">이름</th>
												<th scope="row" width="20%">날짜</th>
											</tr>
										</thead>
										<tbody id="inquiryList">
											<tr>
												<td>10월 10일 기존 체크인 시간보다 1시간 더 일찍 체크인 하고싶습니다.</td>
												<td>user01</td>
												<td>2019-10-10 09:00</td>							
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<jsp:include page="user/adminLogin.jsp" />
					</c:otherwise>
				</c:choose>
			</section>
		</div>
		<jsp:include page="common/footer.jsp" />
	</div>
</body>
</html>