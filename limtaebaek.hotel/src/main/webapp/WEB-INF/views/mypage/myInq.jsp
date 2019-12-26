<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔:마이페이지</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<style>
/* 본문 컨테이너 */
.container {
	width: 70%;
	margin: 0 auto;
}

.panel {
	width: 70%;
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
	$(document).ready(function() {
		//수정 버튼
		$("#modifyButton").click(function() {
			var inqNumber = ${inq.inqNum};
			$("#inqNumParam").val(inqNumber);
			document.form.setAttribute("action", "modifyInquiry");
			document.form.submit();
		});

		//목록 버튼
		$("#gomypage_inquiry").click(function() {
			window.history.back();
		});
	});
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
						<h3>&nbsp;문의조회</h3>
					</div>
					<br> <br>
				</div>
				<!-- 섹션 타이틀 끝-->
				<div class="container center-block">
					<div class="panel panel-default">
						<!-- 테이블 -->
						<div class="table-responsive">
							<table class="table">
								<tbody>
									<tr>
										<td class="active col">&emsp;작성일</td>
										<td>${inq.inqDate}</td>
									</tr>
									<tr>
										<td class="active col">&emsp;제목</td>
										<td>${inq.inqTitle}</td>
									</tr>
									<tr class="tr2">
										<td class="active col">&emsp;내용</td>
										<td>${inq.inqContent}</td>
									</tr>
									<tr>
										<td class="active col">&emsp;이름</td>
										<td>${inq.inqWriter}</td>
									</tr>
									<tr>
										<td class="active col">&emsp;이메일</td>
										<td>${inq.inqEmail}</td>
									</tr>
									<tr>
										<td class="active col">&emsp;연락처</td>
										<td>${inq.inqPhone}</td>
									</tr>

								</tbody>
							</table>
						</div>

						<!-- 테이블 끝-->
						<div class="buttongroup pull-right">
							<c:if test="${inq.status eq 0}">
								<button class="btn btn-default" id="modifyButton">수정하기</button>
							</c:if>
							<button type="button" class="btn btn-default"
								id="gomypage_inquiry">목록보기</button>
						</div>
					</div>
				</div>
			</section>
		</div>
		<form name="form" method="post">
			<input id=inqNumParam name="inqNumber" type="hidden" value="">
		</form>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>