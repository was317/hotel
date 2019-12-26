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
.custom-checkbox {
	float: left;
}

input[type="checkbox"] {
	display: none;
	float: left;
}

input[type="checkbox"]+label {
	display: inline-block;
	cursor: pointer;
	position: relative;
	padding-left: 25px;
	padding-right: 15px;
	font-size: 13px
}

input[type="checkbox"]+label:BEFORE {
	content: "";
	display: inline-block;
	width: 20px;
	height: 20px;
	margin-right: 10px;
	position: absolute;
	left: 0;
	bottom: 1px;
	background-color: #ccc;
}

input[type="checkbox"]:checked+label:BEFORE {
	content: "\2713";
	text-shadow: 1px 1px 1px raba(0, 0, 0 .2);
	font-size: 18px;
	font-weight: 800;
	color: #fff;
	background: #2187c1;
	text-align: center;
	line-height: 18px;
}

.input-group input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

/* 섹션 타이틀 */
.headTit {
	border-bottom: #432c10 solid 2px;
	height: 47px;
	font-style: Sans-Serif;
}
/* 섹션 타이틀 끝 */

/*폼*/
.tableContainer {
	width: 90%;
}

.inputGroup{
margin-left: 5%;

}
.input-group{
	margin: 20px;
}

.priceInput {
	text-align: right;
	width: 120px;
}
/*폼 끝*/
</style>
<script>
$(function() {
	   //취소버튼 클릭시 호출
	   $("#join").click(function() {
	      confirm("등록하시겠습니까","info")
	    	  
	      
	   });
	});
	var alert = function(msg, type) {
		swal({
			title : "",
			text : msg,
			icon : type,
			customClass : "sweet-size",
			showCancelButton : false,
		});
	}


	//이미지 추가
	var imgView = function(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.addEventListener("load", function() {
				$('.previewImg').attr('src', reader.result);
			}, false);
			reader.readAsDataURL(input.files[0]);
		}
	}
	var imgView1 = function(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.addEventListener("load", function() {
				$('.previewImg1').attr('src', reader.result);
			}, false);
			reader.readAsDataURL(input.files[0]);
		}
	}
	var imgView2 = function(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.addEventListener("load", function() {
				$('.previewImg2').attr('src', reader.result);
			}, false);
			reader.readAsDataURL(input.files[0]);
		}
	}
	
$(document).ready(function() {
	$('input[type="checkbox"][name="roomType"]').click(function(){
		if($(this).prop('checked')
		&& $('input[type="checkbox"][name="roomType"]:checked').size()>1) {
			$(this).prop('checked', false);
			alert('두개이상 선택할수없습니다','warning');
		}
	});
	
	$('input[type="checkbox"][name="guests"]').click(function(){
		if($(this).prop('checked')
		&& $('input[type="checkbox"][name="guests"]:checked').size()>1) {
			$(this).prop('checked', false);
			alert('두개이상 선택할수없습니다','warning');
		}
	});
});

$(function() {
	
	$("#addForm").bind("submit", function(e){	
		e.preventDefault();	
		
	if (($("input:checkbox[name=guests]").is(":checked")==false)
		&& $("input:checkbox[name=roomType]").is(":checked")==false)
		{ alert("선택하세요");}
		
	
	
	/* 	var userCall = null;
	var userAddressCode = null;
	var userAddress = null;
	var validinput = this.checkValidity();
	var validform = regtest();
	var validcall = regCall();
	var validpw = check_pw(); */
/* 	var opt = [];
	$("input[name:option]:checked").each(function(i){
		opt.push($(this).val());
	}); */
	
		var roomImage = [null, null, null];
		for(var i = 0; i < roomImage.length ; i++){
			if($("#roomImage" + (i+1))[0].files[0] != null)
				roomImage[i] = "room/" + $("#roomImage" + (i+1))[0].files[0].name;
		}
		$("input[name=roomImage]").each(function(idx, img){
			if(roomImage[idx] != null){
				var formData = new FormData();
				formData.append( "file", img.files[0] );
				$.ajax({
					url: "addImage",
					method: "post",
					data: formData,
					processData: false,
					contentType: false,
					error:function(a, b, errMsg){
						alert(errMsg);
						return;
					}
				});
			}
		});
		$.ajax({
			url:"add",
			method:"POST",
			data: {		
			
				roomName:$("#roomName").val(),
			 	guests:$("input[name=guests]:checked").val(),
				roomType: $("input[name=roomType]:checked").val(),
				roomContent:$("#roomContent").val(),
				
			
				optNo:$("input[name=option]:checked").serialize(),
				
				roomPrice:$("#roomPrice").val(),
				roomImage1: roomImage[0],
				roomImage2: roomImage[1],
				roomImage3:	roomImage[2] 
			
						
						
			/* 	userCall: userCall,
				userAddressCode:$("#userAddressCode").val(),
				userAddress: userAddress */
			},
			success:function(){
    			location.href = "/hotel/room/roomManager";
			},
			error:function(a, b, errMsg){
				alert(errMsg);
			}
			
		})
	
	
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
				<div class="container">
					<div class="location">
						<p>
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
							<a>객실관리 ></a>
						 	<a>객실등록</a>	
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;객실 등록</h3>
					</div>
					<br><br>
					<form id="addForm" name="addForm" id="add" method="post" class="form-inline" enctype="multiport/form-data">
						<div class="container inputGroup">
							<div class="input-group col-md-3">
								<img width="300" height="200" class="previewImg"> <label
									class="btn btn-default btn-lg btn-block" for="roomImage1">이미지업로드</label>
								<input type="file" id="roomImage1" value="roomImage1" name="roomImage"
									onchange="imgView(this)">
								<button class="btn btn-default btn-lg btn-block btn-image-cancel" type="button"
									value="등록 취소">등록취소</button>
			
							</div>
							<div class="input-group col-md-3">
								<img width="300" height="200" class="previewImg1"> <label
									class="btn btn-default btn-lg btn-block" for="roomImage2">이미지업로드</label>
								<input type="file" id="roomImage2" value="roomImage2" name="roomImage"
									onchange="imgView1(this)">
								<button type="button" class="btn btn-default btn-lg btn-block btn-image-cancel"
									value="등록 취소">등록취소</button>
			
							</div>
			
							<div class="input-group col-md-3">
								<img width="300" height="200" class="previewImg2"> <label
									class="btn btn-default btn-lg btn-block" for="roomImage3">이미지업로드</label>
								<input type="file" id="roomImage3" value="roomImage3" name="roomImage"
									onchange="imgView2(this)">
								<button class="btn btn-default btn-lg btn-block btn-image-cancel" type="button"
									value="등록 취소">등록취소</button>
			
			
			
							</div>
						</div>
						<br>
						<div class="container tableContainer">
							<table class="table table-hover table-bordered">
			
								<tbody>
									<tr>
										<th>객실명</th>
										<td><input type="text" id="roomName" name="roomName" class="form-control roomnameInput"
											placeholder="객실명을 입력하세요" required="required"></td>
									</tr>
									<tr>
										<th>방타입</th>
										<td>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input" id="st"
													name="roomType" value="스탠다드"> <label class="custom-control-label"
													for="st">스탠다드</label>
											</div>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input" id="dt"
													name="roomType" value="디럭스"> <label class="custom-control-label"
													for="dt">디럭스</label>
											</div>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input" id="gt"
													name="roomType" value="그랜드"> <label class="custom-control-label"
													for="gt">그랜드</label>
											</div>
										</td>
									</tr>
									<tr>
										<th>옵션</th>
										<td>
											
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input"
													id="option1" value="1" name="option"> <label
													class="custom-control-label" for="option1">조식</label>
											</div>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input"
													id="option2" value="2" name="option"> <label
													class="custom-control-label" for="option2">스파</label>
											</div>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input"
													id="option3" value="3" name="option"> <label
													class="custom-control-label" for="option3">야외수영장</label>
											</div>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input"
													id="option4" value="4" name="option"> <label
													class="custom-control-label" for="option4">엑스트라베드</label>
											</div>
											<div class="custom-control custom-checkbox col-md-2" >
												<input type=checkbox class="custom-control-input" checked="checked"
													id="option0" value="0" name="option" > 
											</div>
										</td>
									</tr>
									<tr>
			
										<th>가능인원수</th>
										<td>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input" id="count1"
													name="guests" value="1"> <label class="custom-control-label"
													for="count1">1명</label>
											</div>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input" id="count2"
													name="guests" value="2"> <label class="custom-control-label"
													for="count2">2명</label>
											</div>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input" id="count3"
													name="guests" value="3"> <label class="custom-control-label"
													for="count3">3명</label>
											</div>
											<div class="custom-control custom-checkbox col-md-2">
												<input type="checkbox" class="custom-control-input" id="count4"
													name="guests" value="4"> <label class="custom-control-label"
													for="count4">4명</label>
											</div>
										</td>
			
									</tr>
									<tr>
										<th>금액</th>
										<td><input type="number" id="roomPrice" class="form-control priceInput"
											placeholder="(원)"  min="0" max="1000000" required="required"></td>
									</tr>
									<tr>
										<th>상세내용</th>
										<td><textarea id="roomContent" wrap="hard" rows="20" cols="100">
									</textarea></td>
									</tr>
			
								</tbody>
							</table>
						</div>
			
						<div class="container center-block" style="text-align: center;">
							<a class="btn btn-default" href="01.html" role="button">취소</a>
							<button class="btn btn-default" type="submit" value="등록" 
								>등록하기</button>
						</div>
					</form>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>
