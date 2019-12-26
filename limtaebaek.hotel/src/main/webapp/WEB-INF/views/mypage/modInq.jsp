<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>서울호텔:마이페이지</title>
<meta charset="UTF-8">
<jsp:include page="../common/import.jsp"></jsp:include>
<style>
/* 본문 컨테이너 */
.container {
	width: 70%;
	margin: 0 auto;
}

.form-inline {
	width: 80%;
	margin: 0 auto;
}

.col {
	height: 40px;
	width: 100px;
}

.tr2 {
	height: 200px;
}

/* 버튼 */
.buttongroup {
	margin-top: 20px;
	margin-bottom: 50px;
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

$.urlParam = function(name) {
	var results = new RegExp('[\?&]' + name + '=([^&#]*)')
			.exec(window.location.href);
	return results[1] || 0;
}

$(document).ready(function(){
	$("#inqTitle").val("${inq.inqTitle}");
	$("#inqContent").val("${inq.inqContent}");
	$("#inqWriter").val("${inq.inqWriter}");
	$("#inqEmail").val("${inq.inqEmail}");
	$("#inqPhone").val("${inq.inqPhone}");
	
	//취소버튼
	$("#cancel").click(function(){
		swal({
			text: "수정을 취소 하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  buttons: ["취소", "확인"],
			})
			.then((yes) => {
			  if (yes) {
				  window.history.back();
			  }else{
				  return;
			  }
			});
	});
});

function isValid() {
	if($("#inqTitle").val() == "" ||
			$("#inqContent").val() == "" ||
			$("#inqWriter").val() == "" ||
			$("#inqEmail").val() == "" ||
			$("#inqPhone").val() == "")
		alert("양식을 모두 작성해주세요", "warning" );
	else if(validateEmail())
		alert("이메일을 정확히 작성해주세요", "warning" );
	else
		confirm();
}

function validateEmail() {
	var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	varemail = $("#inqEmail").val();
	
	if (re.test(varemail) == false)
		return true;
	else
		return false;
}

function confirm(){
	swal({
		text: "작성한 내용으로 문의 하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  buttons: ["취소", "확인"],
		})
		.then((yes) => {
		  if (yes) {
			  submit();
		  }else{
			  return;
		  }
		});
}

function submit() {
	var inqNumber = ${inq.inqNum};
	$.ajax({
		url:"submitModInq",
		method:"GET",
		data: {					
			inqTitle:$("#inqTitle").val(),
			inqContent:$("#inqContent").val(),
			inqWriter:$("#inqWriter").val(),
			inqEmail:$("#inqEmail").val(),
			inqPhone:$("#inqPhone").val(),
			inqNum: inqNumber
		},
		success:function(){
			swal( {
				title: "문의가 수정 되었습니다.",
				text: "답변완료까지 평균 2일 소요됩니다.",
				icon: "success",
				buttons: "확인",
		    }).then((willDelete) => {
		    	location.href = "boardInq";
		  });
		},
		error:function(a, b, errMsg){
			alert("작성  오류" + errMsg);
		}
	 });  
}
</script>
</head>
<body>
	<div>
		<jsp:include page="../common/header.jsp" />
		<jsp:include page="../common/gnb.jsp" />
		
		<div id="contents">
			<section>
				<!-- 섹션 타이틀 -->
				<div class="container center-block">
					<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a> <a>고객문의</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;문의수정</h3>
					</div>
					<br> <br>
				</div>
				<!-- 섹션 타이틀 끝-->
				<div class="container center-block">
					<form class="form-inline">
						<div class="panel panel-default">
							<!-- 테이블 -->
							<div class="table-responsive">
								<table class="table">
									<tbody>
										<tr>
										<td class="col">&emsp;제목</td>
										<td><input type="text" class="form-control" id="inqTitle" name="inqTitle"></td>
									</tr>
									<tr>
										<td class="col">&emsp;내용</td>
										<td><textarea class="form-control" rows="12" cols="60" id="inqContent" name="inqContent"></textarea></td>
									</tr>
									<tr>
										<td class="col">&emsp;이름</td>
										<td><input type="text" class="form-control" id="inqWriter" name="inqWriter"></td>
									</tr>
									<tr>
										<td class="col">&emsp;이메일</td>
										<td><input type="text" class="form-control" id="inqEmail" name="inqEmail"></td>
									</tr>
									<tr>
										<td class="col">&emsp;연락처</td>
										<td><input type="text" class="form-control" id="inqPhone" name="inqPhone"></td>
									</tr>
			
									</tbody>
								</table>
							</div>
						</div>
						<!-- 테이블 끝-->
						<div class="buttongroup pull-right">
							<button class="btn btn-default" type="button" onclick="isValid();">수정완료</button>
							<a class="btn btn-default" id="cancel" role="button">취소하기</a>
						</div>
					</form>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>