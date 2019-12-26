<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<style>
	/*헤더*/
	header{
		padding-top: 15px;
	}
	header a.logo { 
		text-decoration: none;
		font-size: 30px;
		color: black;
		font-family: Cursive
	}
	.container{
		padding-right:0px;
		padding-left:0px;
	}
	.title{
		font-size: 30px;
	}
	.header_a{
		font-size: 14px;
		color: #A0A0A0;
		font-weight:normal;
	}
	.header_a:hover{
		text-decoration: none;
		color: black;
		background-color: yellow;
	}
	/*헤더 끝*/
</style>
<body>
	<header>
		<!-- 타이틀 -->
		<div class="container">
			<div class="center-block title">
				<c:if test="${sessionScope.page != 'admin'}">
					<a class="logo" href="/hotel/" style="margin-left:42%">Seoul HOTEL</a>
				</c:if>
				<c:if test="${sessionScope.page == 'admin'}">
					<a class="logo" href="/hotel/admin" style="margin-left:36%">Seoul HOTEL Admin</a>
				</c:if>
				<!-- 예약조회, 로그인, 회원가입 -->
				<ul class="nav navbar-nav navbar-right">
					<c:choose>
						<c:when test="${sessionScope.user == null || sessionScope.user.userNum == 0}">
				   	  		<li><a href="/hotel/admin" style="font-size: 9px; color: gray;">관리자 로그인</a></li>
						  	<li><a href="/hotel/loginUser" class="header_a">예약조회</a></li>
						  	<li><a href="/hotel/loginUser" class="header_a">로그인</a></li>
						  	<li><a href="/hotel/user/userTerms" class="header_a">회원가입</a></li>
						</c:when>
						<c:when test="${(sessionScope.user.userGrade == '2' && sessionScope.page == 'admin')}">
						  	<li><a href="/hotel/logout" class="header_a">로그아웃</a></li>
						  	<li><a href="/hotel/switchMain" class="header_a">이용자 화면 보기</a></li>	
						</c:when>
						<c:otherwise>		
							<c:if test="${sessionScope.user.userGrade == '2'}">
				   	  			<li><a href="/hotel/switchAdmin" style="font-size: 9px; color: gray;">관리자 화면으로</a></li>
							</c:if>
						  	<li><a href="/hotel/mypage/myBooking" class="header_a">예약조회</a></li>
						  	<li><a href="/hotel/logout" class="header_a">로그아웃</a></li>
						  	<li><a href="/hotel/mypage/myPage" class="header_a">마이페이지</a></li>	
						</c:otherwise>
				  	</c:choose>
				</ul>
				<!--예약조회, 로그인, 회원가입 끝 -->
			</div>
		</div>
		<!--타이틀 끝 -->
	</header>
	<br>
</body>
</html>