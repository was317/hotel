<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔:관리자 페이지 - 회원관리</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<style>
userbtns {
	float: right;
	margin-bottom: 10px;
}

div.searchBtns {
	text-align: right;
	margin: 5px 0 30px 0;
}

div.Btns {
	text-align: center;
	margin: 30px 0 30px 0;
}

.btn {
	border-radius: 0;
	font-size: 16;
	font-weight: 800;
}

.searchuser {
	margin: 0 auto;
	width: fit-content;
}
</style>
<script>
var loadUserList = function() {
	$.ajax({
		url:"listUsers?page=" + getParameterByName("page"),
		method:"POST",
		success:function(result){
			$('#userList').empty();
			if(result.userList.length > 0 ){
				var userList = [];
				$(result.userList).each(function(idx, user){
					userList.push(
							'<tr>' +
							'<td>' + user.userNum+'</td>' +
							'<td>' + user.userEmail+'</td>' +
							'<td>' + user.userName+'</td>' +
							'<td>' + user.userEngFirstName + " " + user.userEngLastName + '</td>' +
							'<td>' + user.userBirth + '</td>'	+
							'<td><button type="button" class="btn btn-default"' +
								'id="' + user.userNum + '" value="' + user.userNum + '">보기</button></td>'	+
							'</tr>'				
					);
				});
				paging(result.page);
				
				$('#userList').append(userList.join(''));
				
				$(result.userList).each(function(idx, user){
					$('button#' + user.userNum).bind("click", function(){
						loadUser(user.userNum);
					});
				});
				
			}else{
				$('#userList').append(
					'<tr><td colspan="6"><b>사용자가 없습니다.</b></td></tr>'	);
			}
		},
		error:function(a, b, errMsg){
			$('#userList').empty();
			$('#userList').append(
				'<tr><td colspan="6"><b>사용자 목록을 불러오지 못했습니다.</b></td></tr>'	);
		}
	});
};

var loadUser = function(userNum) {
	$.ajax({
		url:"getUser",
		method:"POST",
		data: {userNum: userNum},
		success:function(User){
			var myPointSum = 0;
			if(User.myPoints != null){
				User.myPoints.forEach(function(point) {
					myPointSum += point.pointChange;
				})
			}
			dataIn(User, myPointSum);
			dataIn_correct(User, myPointSum);
			$("#dataModal").modal('show');
		},
		error:function(a, b, errMsg){
			alert("유저 데이터 불러오기에 실패했습니다.");
		}
	});
}

$(document).ready(loadUserList());

$(function(){
	$("#userSearchBtn").bind("click", function(e){	
		e.preventDefault();
		
		if($("#userSearch").val() == ""){
			loadUserList()
		}else{
			var userName = null;	
			var userEmail = null;
			var userNum = 0;
			switch($("#searchSelect :selected").val()){
				case "userName":
					userName=$("#userSearch").val();
					break;
				case "userEmail":
					userEmail=$("#userSearch").val();
					break;
				case "userNum":
					userNum=$("#userSearch").val();
					break;
			}
			$.ajax({
				url:"searchListUsers",
				method:"POST",
				data: {
						userName:userName,
						userEmail:userEmail,
						userNum:userNum
					},
				success:function(users){
					$('#userList').empty();
					if(users.length > 0 ){
						var userList = [];
						$(users).each(function(idx, user){
							userList.push(
									'<tr>' +
									'<td>' + user.userNum+'</td>' +
									'<td>' + user.userEmail+'</td>' +
									'<td>' + user.userName+'</td>' +
									'<td>' + user.userEngFirstName + " " + user.userEngFirstName + '</td>' +
									'<td>' + user.userBirth + '</td>'	+
									'<td><a href="#">보기</a></td>'	+
									'</tr>'				
							);
								
						});
						$('#userList').append(userList.join(''));
						
					}else{
						$('#userList').append(
							'<tr><td colspan="6"><b>사용자가 없습니다.</b></td></tr>'	);
					}
					
				},
				error:function(a, b, errMsg){
					$('#userList').empty();
					$('#userList').append(
						'<tr><td colspan="6"><b>검색에 실패했습니다.</b></td></tr>'	);
				}
			});
		}
	});
})
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
							<a>회원관리 ></a>
						 	<a>회원목록</a>	
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;회원 목록</h3>
					</div>
					<br><br>
					<div class="panel panel-default">
						<div class="panel-body">
							<form class="form-inline searchuser">
								<div class="form-group">
									<select class="form-control" id="searchSelect">
										<option value="userName">성명(국문)</option>
										<option value="userEmail">이메일</option>
										<option value="userNum">번호</option>
									</select> 
									<input id="userSearch" type="text" class="form-control" required="required">
								</div>
								<button type="submit" class="btn btn-default" id="userSearchBtn">검색</button>
							</form>
						</div>
					</div>
					<br>
					<table class="table table-hover">
						<thead>
							<tr class="info">
								<th scope="row">번호</th>
								<th>이메일</th>
								<th>성명(국문)</th>
								<th>성명(영문)</th>
								<th>생년원일</th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody id="userList">
							
						</tbody>
					</table>
					<!-- 페이징 -->
					<div class="container text-center">
						<ul class="pagination" id="pages">
						</ul>
					</div>
					<!-- 페이징 끝 -->
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
	<div id="Modal">
		<jsp:include page="userData.jsp" />
	</div>
</body>
</html>