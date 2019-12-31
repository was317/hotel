<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% response.setStatus(200); %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/gnb.jsp" />
	<div class="jumbotron text-center" style="margin:100px 0 100px 0">
		<h2><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
		홈페이지 이용에 불편을 드려 죄송합니다.</h2>
		<h3>잠시 후 다시 시도해 주시기 바랍니다.</h3>
		<br>
		<p><a class="btn btn-default btn-lg" href="#" role="button" onclick="history.back(); return false;">이전 페이지로 돌아가기</a></p>
		<br>
		<h5>관련 문의사항: TEL 010-0000-0000 | Email admin@hotel.co.kr</h5>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>