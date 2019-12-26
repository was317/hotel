<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<script type="text/javascript">
	//var cnt = $("input:hidden[id='proCnt']").length;
	var cnt = $(modPro.promotionDetails).length;
	
	//이미지 업로드
	var imgView = function(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.addEventListener("load", function() {
				$('.promotionImg').attr('src', reader.result);
			}, false);
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	//이미지 등록취소
	$("#imgCancel").bind("click", function(){
		$("#imgUpLoad").val('');
	});
	
	$(function() {
		$("#modProForm").bind(
			"submit",
			function(e) {
				e.preventDefault();
				alert(cnt);
				var prodTitle = new Array();
				var location = new Array();
				//var prodPic = new Array();
				var serviceHour = new Array();
				var notice = new Array();
				var prodContent = new Array();

				for (var i = 0; i < cnt; i++) {
				prodTitle.push($(
					"input[name=prodTitle]:eq(" + (i - 1) + ")").val());
				location.push($(
					"input[name=location]:eq(" + (i - 1) + ")").val());
					//prodPic.push($("#field input[name=prodPic]:eq(" + (i - 1) + ")").val());
				serviceHour.push($(
					"input[name=serviceHour]:eq(" + (i - 1) + ")").val());
				notice.push($(
					"input[name=notice]:eq(" + (i - 1) + ")").val());
				prodContent.push($(
					"textarea[name=prodContent]:eq(" + (i - 1) + ")").val());
				}

				$.ajax({
					url : "modPromotion",
					method : "GET",
					data : {
						proTitle : $("#proTitle").val(),
						proContent : $("#proContent").val(),
						proStartDate : $("#proStartDate").val(),
						proEndDate : $("#proEndDate").val(),
						proDetail : $("#proDetail").val(),
	
						prodTitle : prodTitle,
						location : location,
						//prodPic:$(".prodPic").val(),
						serviceHour : serviceHour,
						notice : notice,
						prodContent : prodContent
					},
					traditional : true,
					success : function() {
						alert("수정에 성공하셨습니다.");
						location.href = "/hotel/promotion/boardProAdmin";
					},
					error : function(a, b, errMsg) {
						alert("수정에 실패하셨습니다.");
						location.href = "#";
					}
				})
			});
		})
</script>
<style>
/*섹션 타이틀*/
div.headTit {
	border-bottom: #432c10 solid 2px;
	height: 47px;
	margin: 0 auto;
	position: relative;
	z-index: 8;
	font-style: Sans-Serif;
}

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
/*섹션 타이틀 끝 */
/*메인 섹션*/
section {
	margin: 0px 0 50px 0;
}

.detail_pro {
	margin-top: 30px;
	width: 100%;
	height: 400px;
}

.detail_pro th {
	text-align: center;
}

.img_section {
	width: 34%;
	height: 400px;
	float: left;
	margin-left: 0.5%;
}

.content_section {
	margin-left: 36%;
	width: 63.5%;
	height: 400px;
}

.content_section th {
	color: white;
	background-color: #3c3c3c;
	width: 23%;
	text-align: center;
}

#btn_up, #btn_down {
	width: 47%;
	float: left;
	margin-left: 2%;
	margin-top: -3%;
}
/*메인 섹션 끝*/
</style>
</head>
<body>
	<form class="form-inline" id="modProForm" method="post">
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
								<a>프로모션 수정</a>
							</p>
						</div>
						<div class="headTit">
							<h3>&nbsp;프로모션 수정</h3>
						</div>
					</div>
					<div class="container center-block text-center">
						<div class="container">
							<div class="write_pro">
								<div class="inline-group"
									style="width: 60%; margin-top: 20px; margin-left: 20%;">
									<table class="table table-bordered">
										<tr>
											<th style="vertical-align: middle"><p>프로모션 명</p></th>
											<td><input type="text" class="form-control" value="${modPro.proTitle}"
												style="width: 100%; float: left" id="proTitle"></td>
										</tr>
										<tr>
											<th style="vertical-align: middle"><p>프로모션 기간</p></th>
											<td>
												<div class="input-group date">
													<input type="date" class="form-control" placeholder="체크인"
														id="proStartDate" value="${modPro.proStartDate}"> <span class="input-group-addon">
														<i class="glyphicon glyphicon-calendar"></i>
													</span>
												</div>
												<p class="form-control-static">&nbsp; ~ &nbsp;</p>
												<div class="input-group date">
													<input type="date" class="form-control" placeholder="체크아웃"
														id="proEndDate" value="${modPro.proEndDate}"> <span class="input-group-addon">
														<i class="glyphicon glyphicon-calendar" style="float: left"></i>
													</span>
												</div>
											</td>
										</tr>
										<tr>
											<th style="vertical-align: middle"><p>프로모션 내용</p></th>
											<td>
												<textarea class="form-control" style="width: 100%; height: 100px; float: left;"
													id="proContent">${modPro.proContent}
												</textarea>
											</td>
										</tr>
									</table>
								</div>
							</div>
							<c:forEach items="${modPro.promotionDetails}" var="prod">
								<div class="board_pro" style="margin-top:20px">
									<div class="img_section">
										<img class="promotionImg" style="height: 230px; width: 100%">
										<label class="btn btn-default btn-lg btn-block" for="imgUpLoad"
											style="width: 50%; margin-top: 2px; font-size: 13px; float: left">이미지
											업로드</label>
										<button class="btn btn-default btn-lg btn-block" id="imgCancel"
											value="등록 취소"
											style="width: 50%; font-size: 13px; margin-top: 2px;">등록취소</button>
										<input type="file" id="imgUpLoad" value="imgUpLoad"
											onchange="imgView(this)" style="display: none;">
									</div>
									<div class="content_section">
										<table class="table table-bordered">
											<tr>
												<th style="vertical-align: middle">프로모션명</th>
												<td><input type="text" class="form-control" value="${prod.prodTitle}"
													name="prodTitle" style="width: 100%" id="prodTitle"></td>
											</tr>
											<tr>
												<th style="vertical-align: middle">위치</th>
												<td><input type="text" class="form-control" value="${prod.location}"
													name="location" style="width: 100%" id="location"></td>
											</tr>
											<tr>
												<th style="vertical-align: middle">이용시간</th>
												<td><input type="text" class="form-control" value="${prod.serviceHour}"
													name="serviceHour" style="width: 100%" id="serviceHour"></td>
											</tr>
											<tr>
												<th style="vertical-align: middle">유의사항</th>
												<td><input type="text" class="form-control" value="${prod.notice}"
													name="notice" style="width: 100%" id="notice"></td>
											</tr>
											<tr>
												<th style="vertical-align: middle">설명</th>
												<td>
													<textarea class="form-control" name="prodContent" style="width: 100%; height: 178px" 
														id="prodContent">${prod.prodContent}
													</textarea>
												</td>
											</tr>
										</table>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="detail_pro">
							<table class="table table-bordered">
								<colgroup>
									<col width="25%" class="col1">
									<col width="75%" class="col2">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"
											style="text-align: center; vertical-align: middle"><p>상세내용</p></th>
										<td><textarea class="form-control" style="width: 100%; height: 400px" 
												id="proDetail">${modPro.proDetail}
											</textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div style="margin-top: 25px">
							<input type="submit" value="수정하기" class="form-control"
								style="width: 100px; float: right;"> 
							<input type="button" value="목록으로" class="form-control" 
								onclick="location.href='/hotel/promotion/boardProAdmin'"
								style="width: 100px; float: right; margin-right: 5px">
						</div>
					</div>
				</section>
			</div>
			<jsp:include page="../common/footer.jsp" />
		</div>
	</form>
</body>
</html>