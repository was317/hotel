<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<script>
	var alert = function(msg, type){
	   swal({
	      title:"",
	      text:msg,
	      type:type,

	      customClass:"sweet-size",
	      showConfirmButton:true
	   });
	}
	var alertResult = function(msg, isGood){
	   if(isGood){
	      alert(msg + '성공했습니다', 'success');
	   }
	   else alert(msg + '실패했습니다', 'error');
	}

	function detailPro(proNum){
		var url = "${pageContext.request.contextPath}/promotion/detailPro";
		url = url + "?proNum=" + proNum;
		location.href=url;
	}
	
	function modifyPro(proNum){
		var url = "${pageContext.request.contextPath}/promotion/modPro";
		url = url + "?proNum=" + proNum;
		location.href=url;
	}
	
	function deletePro(proNum){
		//var url = "${pageContext.request.contextPath}/promotion/delPro";
		//url = url + "?proNum=" + proNum;
		//location.href=url;
		$.ajax({
			url:'delPro',
			data: {proNum:proNum},
			success:function(){
				
			   swal('삭제가 완료되었습니다.', {
				        buttons: ["취소", "확인"],
				      }).then((value) => {
				    	  if(value)
				    		  location.reload();
				    	  else
				    		  return;
				      });
			},
			error:function(){
				alert('삭제 실패', 'error');
			}
		});
	}
	
	$(document).on('click', '#schProAdmin', function(e){
		e.preventDefault();
		
		var sdate = $('#schStartDate').val();
		var edate = $('#schEndDate').val();
		var url = "${pageContext.request.contextPath}/promotion/boardProAdmin";
		
		if(sdate == '' && edate == ''){
			$('#schStartDate').val('2001-01-01');
			$('#schStartDate').val('2099-01-01');
			url = url + "?keyword=" + $('#keyword').val() + "&schStartDate=" + "2001-01-01"
					+ "&schEndDate=" + "2030-01-01";
			location.href = url;
		}
		else if(sdate != '' && edate == ''){
			alert('마지막날을 입력하세요.');
		}
		else if(sdate == '' && edate != ''){
			alert('첫날을 입력하세요.');
		}else{ 
			url = url + "?keyword=" + $('#keyword').val() + "&schStartDate=" + sdate
					+ "&schEndDate=" + edate;
			location.href = url;
			console.log(url);	
		}
	});
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

div .searchBar {
	margin-top: 20px;
	margin-bottom: 20px;
}

th {
	text-align: center;
}

.sweet-size{
   width: 320px;
   height: 200px;
}
/*메인 섹션 끝*/
</style>
</head>

<body>
	<div>
		<jsp:include page="../common/header.jsp" />
		<jsp:include page="../common/gnb.jsp" />
		<!-- 프로모션 등록 -->
		<section>
			<div class="container center-block">
				<div class="location">
					<p>
						<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
						<a>프로모션 관리</a>
					</p>
				</div>
				<div class="headTit">
					<h3>&nbsp;프로모션 관리</h3>
				</div>
			</div>
			<div class="container center-block text-center">
				<div class="container">
					<div>
						<input type="button" class="form-control" value="프로모션 등록"
							style="width: 100%; margin-top: 30px;"
							onclick="location.href='/hotel/promotion/addPro'">
					</div>
					<div class="container center-block text-center"
						style="margin-top: 20px;">
						<div class="panel panel-default">
							<form class="form-inline searchBar" role="form" method="get">
								<div class="form-group">
									<div class="input-group date">
										<input type="date" class="form-control" placeholder="체크인" id="schStartDate"
											value="체크인"> <span class="input-group-addon">
											<i class="glyphicon glyphicon-calendar"></i>
										</span>
									</div>
									<p class="form-control-static">&nbsp;~&nbsp;</p>
									<div class="input-group date">
										<input type="date" class="form-control" placeholder="체크아웃" id="schEndDate">
										<span class="input-group-addon"> <i
											class="glyphicon glyphicon-calendar"></i>
										</span>
									</div>
									&nbsp;&nbsp;&nbsp;
									<p class="form-control-static">투숙 기간&nbsp;</p>
									<input type="text" class="form-control" id="keyword"
										placeholder="프로모션 명">
								</div>
								<button class="btn btn-default" name="schProAdmin" id="schProAdmin">검색</button>
							</form>
						</div>
					</div>
					<!-- 프로모션 검색 끝 -->
					<div class="container center-block text-center">
						<form class="form-inline">
							<div class="container">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th width="40%">프로모션명</th>
											<th width="25%">기간</th>
											<th width="10%">등록일자</th>
											<th width="20%"></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${listProsAdmin}" var="pro">
											<tr>
												<td>${pro.proNum}</td>
												<td>${pro.proTitle}</td>
												<td>${pro.proStartDate}~${pro.proEndDate}</td>
												<td>${pro.proRegDate}</td>
												<td>
													<input type="button" class="form-control" id="${pro.proNum}"
														value="보기" onclick="detailPro(${pro.proNum})"> 
													<input type="button" class="form-control" id="${pro.proNum}"
														value="수정" onclick="modifyPro(${pro.proNum})"> 
													<input type="button" class="form-control" id="${pro.proNum}"
														value="삭제" onclick="deletePro(${pro.proNum})">
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</form>
					</div>
					<!-- 프로모션 게시판 끝 -->
					<!-- paging -->
					<div class="paging" style="text-align: center">
						<ul class="pagination">
							<li class="page-item"><a class="page-link" href="#"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
							</li>
							<li class="page-item"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item"><a class="page-link" href="#">4</a></li>
							<li class="page-item"><a class="page-link" href="#">5</a></li>
							<li class="page-item"><a class="page-link" href="#">6</a></li>
							<li class="page-item"><a class="page-link" href="#">7</a></li>
							<li class="page-item"><a class="page-link" href="#">8</a></li>
							<li class="page-item"><a class="page-link" href="#">9</a></li>
							<li class="page-item"><a class="page-link" href="#">10</a></li>
							<li class="page-item"><a class="page-link" href="#"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</div>
					<!-- paging 끝 -->
				</div>
			</div>
			<!-- 프로모션 등록 끝 -->
		</section>
		<hr>
		<br> <br>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
