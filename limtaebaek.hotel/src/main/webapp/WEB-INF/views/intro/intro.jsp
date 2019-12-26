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
	/* aside 섹션 */
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
    	height: auto;
		overflow-y: hidden;
	}
	.main-section table{
		width:75%;
	}
	.main-section table a{
		text-decoration:none;
		text-align:center;
		color:#8c8c8c;
	}
	.main-section table a:hover{
		color:black;
	}
	.inform_form table th{
		background-color: #3C3C3C;
		color:white;
	}
    /* main 섹션 끝*/
</style>
<script>

//이미지 추가

var imgView = function(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.addEventListener("load", function() {
			console.log(reader);
			$('#filename').attr('value', $(input)[0].files[0].name);
			$('#introImg').attr('src', reader.result);
		}, false);
		reader.readAsDataURL(input.files[0]);
	}
}
	
$(document).ready(function(){
	$.ajax({
		url: "introImgLoad",
		method: "post",
		success:function(result){
			if(result)
				$('#introImg').attr('src', "<c:url value='/img/" + result.introImg + "'/>");
		},
		error:function(a, b, errMsg){
			alert(errMsg);
			return;
		}
	});
	
})

$(function(){

	$("#introForm").bind("submit", function(e){
		e.preventDefault();	
		var formData = new FormData();
		formData.append("file", $("#introImage1")[0].files[0] );
		
		$.ajax({
			url: "addintroImgLoad",
			method: "post",
			data: formData,
			processData: false,
			contentType: false,
			success:function(){
    			location.reload();
			},
			error:function(a, b, errMsg){
				alert(errMsg);
				return;
			}
		});
	})
})
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
							<a>호텔소개 > </a>
							<a>OverView</a>
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
							<div>
								<c:if test="${sessionScope.user.userGrade == '2'}">
									<form id="introForm" class="form-inline">
										<div class="form-group">
											<input type="file" id="introImage1" onchange="imgView(this)" style="display: none">
											<input class="form-control" type="text" id="filename" readonly="readonly">
											<label class="btn btn-default" for="introImage1">이미지 지정</label>
											<button class="btn btn-default" type="submit" id="introAdd">이미지 저장</button>
										</div>
									</form>
								</c:if>
								<img id="introImg" style="width:100%; margin-top: 5%; margin-bottom: 5%;">
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