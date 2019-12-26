<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<!-- 
	- res/js 추가 시
	<script src="<c:url value="/js/common.js"/>"></script>  
-->
<style>
	/*
	- res/css 추가 시
	@import url("<c:url value="/css/section.css" />");
	*/
.star_rating {
	font-size: 0;
	letter-spacing: -4px;
}

.star_rating a {
	font-size: 22px;
	letter-spacing: 0;
	display: inline-block;
	margin-left: 5px;
	color: gray;
	background-color:;
	text-decoration: none;
}

.star_rating a:first-child {
	margin-left: 0;
}

.star_rating a.on {
	color: yellow;
}

/* 체크박스*/
.custom-checkbox{
	float: left;
}
input[type="checkbox"]{
	display: none;
	float: left;
	
	
}
input[type="checkbox"] + label{
	display: inline-block;
	cursor: pointer;
	position: relative;
	padding-left: 25px;
	padding-right: 15px;
	font-size: 13px
	
	
}
input[type="checkbox"] + label:BEFORE{
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


input[type="checkbox"]:checked + label:BEFORE{
	content: "\2713";
	text-shadow: 1px 1px 1px raba(0,0,0 .2);
	font-size: 18px;
	font-weight: 800;
	color: #fff;
	background: #2187c1;
	text-align: center;
	line-height: 18px;
}
.input-group{
padding: 20px;
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

table.table-sm {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-top: 3px solid #036;

}
table.table-sm thead th {
    padding: 10px;
    margin: 10px;
    font-weight: bold;
    vertical-align: middle;
    color: #369;
    border-bottom: 1px solid #036;
}
table.table-sm tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #f3f6f7;
}
table.table-sm td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
.table-sm th{
	text-align:;
	/* //background-color: lightgray; */
	
}

/* 섹션 타이틀 */
.location {
	float: right;
	height: 47px;
	padding: 40px 0 0 0;
}

.location a {
	text-decoration: none;
	color: #4C4A4A;
}

.headTit {
	border-bottom: #432c10 solid 2px;
	height: 47px;
	font-style: Sans-Serif;
}
/* 섹션 타이틀 끝 */
</style>
<script>
$(document).ready(function() {
	$("#header").load("main01.html");
	$("#nav").load("main04.html");
	$("#footer").load("main09.html");
});
var alert = function(msg, type) {
	swal({
		title : "",
		text : msg,
		icon : type,
		//timer:1000,
		customClass : "sweet-size",
		showCancelButton : true,
		confirmButtonText: "Yes",

	});
}

//별 평점주기
$(document).ready(function() {
	$(".star_rating a").click(function() {

		$(this).parent().children("a").removeClass("on");

		$(this).addClass("on").prevAll("a").addClass("on");

		return false;

	});
	
	var roomtype = ("${comment.roomType}");
	$("input:checkbox[name=roomType]").each(function(){
		if(this.value == roomtype){
			this.checked =true;
		}
	});
		$('input[type="checkbox"][name="roomType"]').click(function(){
		if($(this).prop('checked')
		&& $('input[type="checkbox"][name="roomType"]:checked').size()>1) {
			$(this).prop('checked', false);
			alert('두개이상 선택할수없습니다','warning');
		}
	});
	

});
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
function imgdel() {
	alert("ddd", "warning");

	$('.previewImg').remove();

}

var confirm = function(msg, type) {
	   swal(msg, {
		   icon: type,
	        buttons: ["취소", "확인"],
	      }).then((value) => {
	    	 if(value){ 
	    		 document.location.href="04.html";
	    	 }else{
	    		 alert("취소하였습니다.", "warning" );
	    		 return;
	    	 }
	         });
	}

	
	$(function() {
	   
		 $("#updateForm").bind("submit", function(e){		
				e.preventDefault();

				
					$.ajax({
						url:"updateView",
						method:"GET",
						data: {		
							revNum:$("#revNum").val(),
							revTitle:$("#revTitle").val(),
					
							roomType: $("input[name=roomType]:checked").val(),
							revContent:$("#revContent").val()
	
			
						
									
									
					
						},
						success:function(){
							
			    			location.href = "/hotel/comment/commentLookUp";
						},
						error:function(a, b, errMsg){
							alert("수정 불가 에러", 'warning');
						}
						
					})
				
			});
	   
		   $("#back").click(function() {
			   window.history.back();
			    	  
			      
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
					<a><span class="glyphicon glyphicon-home">&nbsp;></span></a> <a>후기수정</a>
				</p>
			</div>
			<div class="headTit">
				<h3>&nbsp;후기 수정</h3>
			</div>
			<br> <br>
		</div>
		<div class=" container">
	
		<section>
			<form id="updateForm" name="updateForm" method="post" >
				<div class="container center-block" style="width: 70%;">

					
					<div class="center-block">
						<table class="table table-sm">
							<thead>
								<tr>
									<th class="table-active">제목</th>
									<th  scope="col">
									<input type="hidden" id="revNum" value="${comment.revNum }">
									<input type="text" id="revTitle" class="form-control"
										placeholder="제목을 입력하세요." value="${comment.revTitle}" required id="revTitle"/></th>
								</tr>
								<tr>
									<th class="table-active">평점</th>
									<th scope="col">
										<p class="star_rating">
											<a class="on" href="#">★</a> <a class="on" href="#">★</a> <a
												href="#">★</a> <a href="#">★</a> <a href="#">★</a>
										</p>
									</th>
								</tr>
								<tr>
									<th class="table-active">방타입</th>
									<th scope="col">
										<div class="custom-control custom-checkbox">
											<input type="checkbox" class="custom-control-input" id="st"
												name="roomType" value="스탠다드"> <label class="custom-control-label"
												for="st">스탠다드</label>
										</div>
										<div class="custom-control custom-checkbox">
											<input type="checkbox" class="custom-control-input" id="dt"
												name="roomType" value="디럭스"> <label class="custom-control-label"
												for="dt">디럭스</label>
										</div>
										<div class="custom-control custom-checkbox">
											<input type="checkbox" class="custom-control-input" id="gt"
												name="roomType" value="그랜드"> <label class="custom-control-label"
												for="gt">그랜드</label>
										</div>

									</th>
								</tr>
								<tr>
									<th class="table-active" style="vertical-align: middle;">내용</th>
									<th scope="col"><textarea class="form-control" rows="10"
											cols="80%" placeholder="후기 내용을 작성하세요." id="revContent">${comment.revContent}</textarea></th>
								</tr>
							</thead>
						</table>
					</div>






					<div class="col-sm-2 col-md-4">
						<div class="input-group">
							<img width="250" height="200" class="previewImg"> <label class="btn btn-default btn-lg btn-block"
								for="ex_file">이미지업로드</label> <input type="file" id="ex_file"
								value="이미지업로드" onchange="imgView(this)">
							<button class="btn btn-default btn-lg btn-block" type="button" value="등록 취소">등록취소</button>

						</div>
					</div>
					<div class="col-sm-2 col-md-4">

						<div class="input-group">
							<img width="250" height="200" class="previewImg1"> <label class="btn btn-default btn-lg btn-block"
								for="ex_file1">이미지업로드</label> <input type="file"  id="ex_file1" value="이미지업로드"
								onchange="imgView1(this)">
							<button class="btn btn-default btn-lg btn-block" type="button" value="등록 취소">등록취소</button>
						</div>
					</div>
					<div class="col-sm-2 col-md-4">
						<div class="input-group">
								<img width="250" height="200" class="previewImg2"> <label class="btn btn-default btn-lg btn-block"
								for="ex_file2">이미지업로드</label> <input type="file" id="ex_file2" value="이미지업로드"
								onchange="imgView2(this)">
							<button class="btn btn-default btn-lg btn-block" type="button" value="등록 취소">등록취소</button>


						</div>
						
					</div>
				</div>
				<br>
				<br> <br>
				<div class="container center-block" style="text-align: center;">
					<button class="btn btn-primary" type="submit" value="수정" 
						>수정</button>
					
					<button class="btn btn-warning" type="button" value="취소"
						id="back" >취소</button>

				</div>
			</form>
		</section>
	</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>
