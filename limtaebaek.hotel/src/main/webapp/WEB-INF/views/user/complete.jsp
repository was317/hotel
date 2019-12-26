<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<style type="text/css">
	@import url("<c:url value="/css/joinstep.css"/>");
	div.complete{
	   width: 50%;
	   text-align: center;
	   margin: 0 auto;
	}
	div.Btns{
		text-align: center;
		margin: 30px 0 30px 0;
	}
	.btn{
		border-radius: 0;
		font-size: 16;
		font-weight: 800;
	}
</style>
<script>
$(function(){
	$("#gomain").bind("click",function(){
		location.href = "/hotel/";
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
				<div class="container center-block">
					<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
							<a>회원가입</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;가입완료</h3>
					</div>
				   	<div class="joinStep">
						<ul class="step">
							<li class="t1 first"><span>약관동의</span></li>
							<li class="t2 second"><span>회원정보 입력</span></li>
							<li class="t3 last on"><span>가입완료</span></li>
						</ul>
					</div>
				   	<div class="complete">
						<h3>쌍용 호텔의 회원이 되신 것을 환영합니다.</h3>
						<br>
				      	<p>회원 혜택과 약관은 홈페이지 확인 가능합니다.</p>
						메인 페이지에서 로그인 해주세요.
						<div class="Btns">
							<button class="btn btn-default" type="button" id="gomain" name="gomain" style="padding:10px 70px">메인으로</button>
						</div>
			      	</div>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>