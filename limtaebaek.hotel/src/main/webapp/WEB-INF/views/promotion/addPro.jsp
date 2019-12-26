<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<script type="text/javascript">
	var cnt = 0;

	function add_image_onchange(){
		$("#field input[name=promotionImage]").each(
			function(idx, imgInput){
				$(imgInput).attr("id", idx);
				$(imgInput).change(function(){
					if ($(this)[0].files && $(this)[0].files[0]) {
						var reader = new FileReader();
						reader.addEventListener("load", function() {
							$($(imgInput).parent().children()[0]).attr('src', reader.result);
						}, false);
						reader.readAsDataURL($(imgInput)[0].files[0]);
					}
				})
			});

		$("#field label[name=imglabel]").each(
			function(idx, label){
				$(label).attr("for", idx);
			});
	}
	
	
	function add_promotion() {
		var div = document.createElement('div');
		cnt = Number($("#cnt").val());
		cnt = cnt + 1;
		$("#cnt").val(cnt);
		console.log($("#cnt").val());
		div.innerHTML = document.getElementById('pre_set').innerHTML;
		document.getElementById('field').appendChild(div);
		
		add_image_onchange();
	}
	
	function del_promotion(obj) {
		document.getElementById('field').removeChild(obj.parentNode);
	}

	//이미지 업로드
	var imgView = function(input) {
		console.log(input);
		inputss = input;
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.addEventListener("load", function() {
				$(input.parent().children()[0]).attr('src', reader.result);
			}, false);
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	
	//이미지 등록취소
	$("#imgCancel").bind("click", function(){
		$("#imgUpLoad").val('');
	});
	
	$(function() {
		
		$("#addProForm").bind(
			"submit",
			function(e) {
				e.preventDefault();
				var prodTitle = new Array();
				var location = new Array();
				var prodPic = new Array();
				var serviceHour = new Array();
				var notice = new Array();
				var prodContent = new Array();

				for (var i = 0; i < cnt; i++) {
					prodTitle.push($(
						"#field input[name=prodTitle]:eq(" + (i - 1) + ")").val());
					location.push($(
						"#field input[name=location]:eq(" + (i - 1) + ")").val());
					serviceHour.push($(
						"#field input[name=serviceHour]:eq(" + (i - 1) + ")").val());
					notice.push($(
						"#field input[name=notice]:eq(" + (i - 1) + ")").val());
					prodContent.push($(
						"#field textarea[name=prodContent]:eq(" + (i - 1) + ")").val());
					prodPic.push("promotion/" + $(
						"#field input[name=promotionImage]:eq(" + (i - 1) + ")")[0].files[0].name);
				}
				
				$("#field input[class=promotionImage]").each(function(idx, img){
					var formData = new FormData();
					formData.append("file", img.files[0]);
					$.ajax({
						url: "addImage",
						method: "post",
						data: formData,
						processData: false,
						contentType: false,
						success:function(result){
						},
						error:function(a, b, errMsg){
							alert("이미지" + errMsg);
							return;
						}
					});
				});

				$.ajax({
					url : "addPromotion",
					method : "GET",
					data : {
						proTitle : $("#proTitle").val(),
						proContent : $("#proContent").val(),
						proStartDate : $("#proStartDate").val(),
						proEndDate : $("#proEndDate").val(),
						proDetail : $("#proDetail").val(),
						
						prodTitle : prodTitle,
						location : location,
						prodPic : prodPic,
						serviceHour : serviceHour,
						notice : notice,
						prodContent : prodContent
					},
					traditional : true,
					success:function(result) {
						window.location.href = "/hotel/promotion/boardProAdmin";
					},
					error : function(a, b, errMsg) {
						alert("등록에 실패하셨습니다.");
						window.location.href = "/hotel/promotion/boardProAdmin";
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
	<form class="form-inline" id="addProForm" method="post">
		<div>
			<jsp:include page="../common/header.jsp" />
			<jsp:include page="../common/gnb.jsp" />
			<!-- 프로모션 등록 -->
			<section>
				<div class="container center-block">
					<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
							<a>프로모션 등록</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;프로모션 등록</h3>
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
										<td><input type="text" class="form-control"
											style="width: 100%; float: left" id="proTitle"></td>
									</tr>
									<tr>
										<th style="vertical-align: middle"><p>프로모션 기간</p></th>
										<td>
											<div class="input-group date">
												<input type="date" class="form-control" placeholder="체크인"
													id="proStartDate"> <span class="input-group-addon">
													<i class="glyphicon glyphicon-calendar"></i>
												</span>
											</div>
											<p class="form-control-static">&nbsp; ~ &nbsp;</p>
											<div class="input-group date">
												<input type="date" class="form-control" placeholder="체크아웃"
													id="proEndDate"> <span class="input-group-addon">
													<i class="glyphicon glyphicon-calendar" style="float: left"></i>
												</span>
											</div>
										</td>
									</tr>
									<tr>
										<th style="vertical-align: middle"><p>프로모션 내용</p></th>
										<td><textarea class="form-control"
												style="width: 100%; height: 100px; float: left;"
												id="proContent"></textarea></td>
									</tr>
								</table>
							</div>
						</div>

						<div class="adddel_pro">
							<input type="button" onclick="add_promotion()"
								class="form-control" value="프로모션 구성 추가" style="width: 60%;"><br>
							<br>
						</div>

						<div class="detail_pro" id="pre_set" style="display: none">
							<div class="img_section">
								<img class="promotionImg" style="height: 230px; width: 100%">
								<label class="btn btn-default btn-lg btn-block" for="imgUpLoad"
									style="width: 50%; margin-top: 2px; font-size: 13px; float: left" name="imglabel">이미지
									업로드</label>
								<button class="btn btn-default btn-lg btn-block" id="imgCancel"
									value="등록 취소"
									style="width: 50%; font-size: 13px; margin-top: 2px;">등록취소</button>
								<input type="file" id="imgUpLoad" value="imgUpLoad" name="promotionImage"
									class="promotionImage" style="display: none">
							</div>
							<div class="content_section">
								<table class="table table-bordered">
									<tr>
										<th style="vertical-align: middle">프로모션명</th>
										<td><input type="text" class="form-control"
											name="prodTitle" style="width: 100%" id="prodTitle"></td>
									</tr>
									<tr>
										<th style="vertical-align: middle">위치</th>
										<td><input type="text" class="form-control"
											name="location" style="width: 100%" id="location"></td>
									</tr>
									<tr>
										<th style="vertical-align: middle">이용시간</th>
										<td><input type="text" class="form-control"
											name="serviceHour" style="width: 100%" id="serviceHour"></td>
									</tr>
									<tr>
										<th style="vertical-align: middle">유의사항</th>
										<td><input type="text" class="form-control" name="notice"
											style="width: 100%" id="notice"></td>
									</tr>
									<tr>
										<th style="vertical-align: middle">설명</th>
										<td><textarea class="form-control" name="prodContent"
												style="width: 100%; height: 178px" id="prodContent"></textarea></td>
									</tr>
								</table>
							</div>
							<input type="button" onclick="del_promotion(this)"
								class="form-control" value="프로모션 구성 취소"
								style="width: 60%; margin-top: 20px;">
							<hr style="border: 1px solid black">
						</div>
						<div id="field">
							<input type="hidden" id="cnt" value="0">
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
										<td><textarea class="form-control"
												style="width: 100%; height: 400px" id="proDetail"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div style="margin-top: 25px">
							<input type="submit" value="작성하기" class="form-control"
								style="width: 100px; float: right;"> 
							<input type="reset" value="다시쓰기" class="form-control"
								style="width: 100px; float: right; margin-right: 5px">
						</div>
					</div>
				</div>
				<!-- 프로모션 등록 끝 -->
			</section>
			<hr>
			<br> <br>
		</div>
	</form>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
