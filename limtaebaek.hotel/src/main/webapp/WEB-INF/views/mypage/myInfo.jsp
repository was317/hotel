<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔:마이페이지</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<!-- 
	- res/js 추가 시
	<script src="<c:url value="/js/common.js"/>"></script>  
-->
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
							<a>개인정보</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;마이페이지</h3>
					</div>
					<jsp:include page="aside.jsp" />
					<div class="main-section">
						<h4 style="text-align: left; width: 90%; float: left">|개인정보</h4>
						<div class="inform_form">
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
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>