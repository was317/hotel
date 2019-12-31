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
		<h2><span class="glyphicon glyphicon-ban-circle" aria-hidden="true"></span>
		요청하신 페이지를 찾을 수 없습니다.</h2>
		<p>입력하신 페이지의 주소와 경로가 정확한지 확인해주시기 바랍니다.</p>
		<br>
		<p><a class="btn btn-default btn-lg" href="#" role="button" onclick="history.back(); return false;">이전 페이지로 돌아가기</a></p>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>