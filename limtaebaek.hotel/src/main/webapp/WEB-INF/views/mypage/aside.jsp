<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<style>
/* aside 섹션 */
.aside-section .aside_logo {
	text-decoration: none;
	font-size: 25px;
	font-weight: bold;
	color: #AAAAAA;
	font-family: Sans-Serif;
}

.aside_logo:hover {
	color: white;
}

.aside-section {
	margin-top: 30px;
	background-color: #3C3C3C;
	width: 23%;
	
	height: 1000px;
	float: left;
}

.aside-section div {
	width: 90%;
	margin-left: 10%;
	margin-top: 7%;
}

.aside-section .aside_a {
	text-decoration: none;
	font-size: 16px;
	color: #AAAAAA;
	font-family: Sans-Serif;
	font-weight: bold;
}

.aside-section .aside_a:hover {
	color: white;
}

/* aside 섹션 끝*/
</style>
<body>
	<div class="aside-section">
		<div>
			<a href="/hotel/mypage/myPage" class="aside_logo">Seoul Hotel</a>
		</div>
		<hr style="background-color: white; height: 1px">
		<div>
			<a href="/hotel/mypage/myBooking" class="aside_a">예약 확인/취소</a>
		</div>
		<br>
		<div>
			<a href="/hotel/mypage/myPoint" class="aside_a">포인트 사용 내역</a>
		</div>
		<br>
		<div>
			<a href="/hotel/mypage/myComment" class="aside_a">후기 작성 내역</a>
		</div>
		<br>
		<div>
			<a class="aside_logo" style="font-size: 16px" href="/hotel/mypage/myInfo">개인정보</a>
		</div>
		<br>
		<hr style="margin-top: -10px">
		<div>
			<a href="/hotel/mypage/myInfoChange" class="aside_a" style="font-size: 14px;">&nbsp;&nbsp;&nbsp;개인정보
				수정</a>
		</div>
		<div>
			<a href="/hotel/mypage/mySecede" class="aside_a" style="font-size: 14px;">&nbsp;&nbsp;&nbsp;탈퇴
				신청</a>
		</div>
		<hr>
		<div>
			<a href="/hotel/mypage/boardInq" class="aside_a">문의 내역</a>
		</div>
	</div>			
</body>
</html>