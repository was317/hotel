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
/* 모달 버튼 */
.modalbtn{
	margin-left:90%;
}

/*문의 제목*/
.inqTitle{
	font-size: 15px;
	cursor:pointer;
}
</style>
<script>
	$(function() {
		//보기 버튼
		$(".myInquiryButton, .inqTitle").click(function() {
			var tr = $(this).parent().parent();
			var inqNumber = tr.children().children().val();
 			$("#inqNumParam").val(inqNumber);
			document.form.setAttribute("action", "myInquiry");
			document.form.submit();
		});

		//수정 버튼
		$(".modifyButton").click(function() {
			var tr = $(this).parent().parent();
			var inqNumber = tr.children().children().val();
			$("#inqNumParam").val(inqNumber);
			document.form.setAttribute("action", "modifyInquiry");
			document.form.submit();
		});

		//답변보기 버튼
		$(".answerModalButton").click(function() {
			var tr = $(this).parent().parent();
			var inqNumber = tr.children().children().val();
			$.ajax({
				url : "getAnswer",
				method : "GET",
				data : {
					inqNum : inqNumber
				},
				success : function(inq) {
					$("#Anscontent").val(inq.inqCmtContent);
					$("#answerModal").modal('show');

/* 					 $("#answerModal").modal({
						remote : "myInqAns"
					});  */
				},
				error : function(a, b, errMsg) {
					alert("오류" + errMsg);
				}
			});
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
				<div class="container center-block">
					<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
							<a>마이페이지 > </a> 
							<a>문의 내역</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;마이페이지</h3>
					</div>
					<jsp:include page="aside.jsp" />
					<!-- 문의 내역 -->
					<div class="main-section">
						<div class="question_form">
							<h4 style="text-align: left; width: 90%; float: left">|
								문의내역</h4>
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th scope="row" width="10%">문의번호</th>
										<th scope="row" width="30%">문의제목</th>
										<th scope="row" width="15%">작성일</th>
										<th scope="row" width="15%">답변상태</th>
										<th scope="row" width="20%">확인</th>
									</tr>
									<c:forEach var="list" items="${inqList}" varStatus="count">
										<tr>
											<c:set var= "num" value="${inqCount.count + 1 - count.count}"/>
											<td><input type="hidden" value="${list.inqNum}"><c:out value="${num}"/></td>
											<td><a class="inqTitle">${list.inqTitle}</a></td>
											<td>${list.inqDate}</td>
											<td>${list.status}</td>
											<td>
												<button class="btn btn-default myInquiryButton" type="button">보기</button>
												<c:if test="${list.status eq '답변 대기'}">
													<button class="btn btn-default modifyButton" type="button">수정</button>
												</c:if>
												<c:if test="${list.status eq '답변완료'}">
													<button class="btn btn-default answerModalButton" type="button">답변 보기</button>
												</c:if>
											</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- paging -->
						<div class="paging" style="margin-left: 27%;">
							<ul class="pagination">
								<li class="page-item"><a class="page-link" href="#"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
								</li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">4</a></li>
								<li class="page-item"><a class="page-link" href="#">5</a></li>
								<li class="page-item"><a class="page-link" href="#"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
								</li>
							</ul>
						</div>
						<!-- paging 끝 -->
					</div>
				</div>
				<!-- 문의 내역 끝-->
			</section>
		</div>
		<form name="form" method="post">
			<input id=inqNumParam name="inqNumber" type="hidden" value="">
		</form>
		<!-- 답변 모달 -->
		<div class="modal fade" id="answerModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<!-- remote call이 되는영역 -->

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">답변</h4>
					</div>
					<div class="modal-body">
						<div class="panel panel-default">
							<table class="table">
								<tbody>
									<tr>
										<td><textarea id="Anscontent" class="form-control" rows="12" cols="60"
												onfocus="this.blur();">
						</textarea></td>
									</tr>
								</tbody>
							</table>

						</div>

							<button type="button" class="btn btn-default modalbtn"
								data-dismiss="modal">확인</button>

					</div>

					<!-- remote call끝 -->
				</div>
			</div>
		</div>
		<!-- 답변 모달 끝 -->
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>