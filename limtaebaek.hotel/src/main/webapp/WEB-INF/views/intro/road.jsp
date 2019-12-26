<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
<style>
	.aside-section {
		height: 100%;
	}
	.aside-section .aside_logo{
		text-decoration:none;
		font-size:25px;
		font-weight:bold;
		color:#AAAAAA;
		font-family:Sans-Serif;
	}
	.aside_logo:hover{
		color:white;
	}
	.aside-section{
		margin-top:30px;
		background-color:#3C3C3C;
		width:23%;
		height:800px;
		float:left;
	}
	.aside-section div{
		width:90%;
		margin-left:10%;
		margin-top:7%;
	}
	.aside-section .aside_a{
		text-decoration:none;
		font-size:16px;
		color:#AAAAAA;
		font-family: Sans-Serif;
		font-weight: bold;
	}
	.aside-section .aside_a:hover{
		color:white;
	}

	/* aside 섹션 끝*/
    
    /* main 섹션*/
    .main-section{
		margin-top:30px;
		margin-left:25%;
	}
	.info {
		width: 800px;
		border: 1px solid black;
		padding: 10px;
		margin: 20px 0 20px 0;
	}
    /* main 섹션 끝*/
</style>

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
							<a>호텔소개 > </a>
							<a>오시는 길</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;서울호텔 소개</h3>
					</div>
					<div class="container">
						<div class="aside-section">
							<div><a href="/hotel/intro/" class="aside_logo">Seoul Hotel</a></div>
							<hr style="background-color:white; height:1px">
							<div><a href="/hotel/intro/" class="aside_a">개요</a></div><br>
							<div><a href="/hotel/intro/road" class="aside_a">오시는 길</a></div><br>
						</div>
						<div class="main-section">
							<div class="container">
								<div id="daumRoughmapContainer1574586900507" class="root_daum_roughmap root_daum_roughmap_landing"></div>
								<script charset="UTF-8">
									new daum.roughmap.Lander({
										"timestamp" : "1574586900507",
										"key" : "vyfa",
										"mapWidth" : "800",
										"mapHeight" : "360"
									}).render();
								</script>
								<div class="container">
									<div class="info">
										<b>서울호텔 주소</b>  서울시 중구 동호로 249 (우편번호 : 04605)&nbsp;&nbsp;&nbsp;
										<b>대표전화</b> 02-2231-3131
									</div>
									<h3><b>교통편</b></h3><br>
									<b>자가용 이용시</b><br>
									&nbsp;분당 방면: 한남대교 -> 장충단길 -> 서울호텔 후문<br>
									&nbsp;강남 방면: 동호대교 -> 장충체육관 앞 사거리에서 좌회전 -> 서울호텔<br>
									&nbsp;용산 방면: 남산2호터널 통과 후 죄회전 -> 서울호텔 후문<br>
									<br>
									<b>버스 이용시</b><br>
									&nbsp;장충체육관 앞 하차(노선번호:ㅣ 144, 301, 407, 7271)<br>
									<br>
									<b>지하철 이용시</b><br>
									&nbsp;지하철 3호선 동대입구역 5번출구<br>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>