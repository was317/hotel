<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<style>
	/*메인 섹션*/
	section {
		margin: 0px 0 50px 0;
	}
	
	div .searchBar {
		margin-top: 20px;
		margin-bottom: 20px;
	}
	/* 섹션 타이틀 */
	div.location {
		float: right;
		height: 47px;
		padding: 40px 0 0 0;
		margin: 0 0 -30px 0;
		z-index: 9;
		position: relative;
		text-align: right;
	}
	
	.location a {
		text-decoration: none;
		color: #4C4A4A;
	}
	
	div.headTit {
		border-bottom: #432c10 solid 2px;
		height: 47px;
		margin: 0 auto;
		position: relative;
		z-index: 8;
		font-style: Sans-Serif;
	}
	/* 섹션 타이틀 끝 */
	.board_pro {
		height: 300px;
		width: 100%;
	}
	
	.image_pro {
		height: 300px;
		width: 500px;
		margin-left: 10px;
		float: left;
	}
	.content_pro {
		margin-left: 560px;
		margin-right:20px;
	}
	.detail_pro{
		margin-top:40px;
		margin-left:20px;
		margin-right:20px;
	}
	.detail_pro table{
		width:100%;
	}
	.detail_pro th{
		vertical-align:middle;
		text-align:center;
		font-size:18px;
		background-color:#787878;
		color:white;
		height:400px;
	}
	.detail_pro th td{
		font-size:13px;
		color:black
	}
	.thumbnail {
		margin-left: 10px;
		height: 300px;
		width: 500px;
	}
	table th{
		height:40px;
		vertical-align:top;
	}
	table td{
		vertical-align:top;
	}
	/*메인 섹션 끝*/
</style>
<script>
</script>
</head>
<body>
	<div>
		<jsp:include page="../common/header.jsp" />
		<jsp:include page="../common/gnb.jsp" />
		<!-- 예약정보 검색 -->
		<div id="contents">
			<section>
				<!-- 프로모션 상세보기 -->
				<div class="container center-block">
					<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
							<a>프로모션 상세보기</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;프로모션 상세보기</h3>
					</div>
				</div>
				<div class="container" style="text-align:center; padding:20px;">
					<h1 style="font-style:Sans-Serif; color:#3C3C3C">${listPro.proTitle}</h1><br>
					<h3 style="font-style:Sans-Serif; color:#3C3C3C">${listPro.proStartDate} ~
						${listPro.proEndDate}</h3><br>
					<h4 style="font-style:Sans-Serif; color:#3C3C3C">${listPro.proContent}</h4>
				</div>
				<div class="container" style="margin-top:20px">
					<c:forEach items="${listPro.promotionDetails}" var="prod">
						<div class="board_pro" style="margin-top:20px">
							<div class="image_pro">
								<img class="thumbnail" src="<c:url value="/img/${prod.prodPic}"/>"></img>
							</div>
							<div class="content_pro">
								<p style="font-style:Sans-Serif; font-size:20px; font-weight:bold;">
									${prod.prodTitle}</p><br>
								<table>
									<colgroup>
										<col width="25%" class="col1">
										<col width="75%" class="col2">
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><p>위치</p></th>
											<td>
												<p>${prod.location}</p>
											</td>
										</tr>
										<tr>
											<th scope="row"><p>이용시간</p></th>
											<td>
												<p>${prod.serviceHour}</p>
											</td>
										</tr>
										<tr>
											<th scope="row"><p>유의사항</p></th>
											<td>
												<p>${prod.notice}</p>
											</td>
										</tr>
										<tr>
											<th scope="row"><p>설명</p></th>
											<td>
												<textarea wrap="VIRTUAL" style="width:400px; height:100px; border:0;overflow-y:hidden;
													font-weight:bold; background:clear;" onfocus="this.blur()"
													readonly>${prod.prodContent}</textarea>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</c:forEach>
					<div class="detail_pro">
						<table>
							<colgroup>
								<col width="25%" class="col1">
								<col width="75%" class="col2">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><p>상세내용</p></th>
									<td>
										<textarea wrap="VIRTUAL" style="width:100%; height:450px; border:0;overflow-y:hidden;
											font-weight:bold; background:clear;" onfocus="this.blur()"
											readonly>${listPro.proDetail}</textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 프로모션 게시판 끝 -->
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>