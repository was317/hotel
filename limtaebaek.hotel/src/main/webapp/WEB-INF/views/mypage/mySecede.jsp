<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔:마이페이지</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<style>
    /* main 섹션*/
	.terms_content{
		border:1px solid black;
		width:95%;
	}
	.terms_content table{
		margin-left:2%;
		width:96%;
	}
	.terms_content table th, .terms_content table td{
		text-align:center;
	}
	.terms_check{
		margin-top: 20px;
		border: 1px solid black;
		width:95%;
		height: 140px;
		text-align:center;
	}
    /* main 섹션 끝*/
	div.secedeBtn{
	    width: fit-content;
	    height: fit-content;
	    margin: 0 auto;
	}
	
	.secede{
		width:180px;
		float:left;
		margin-right: 10px;
	}
</style>
<script>

var alert = function(msg, type) {
	swal({
		  title: "",
		  text: msg,
		  icon: type,
		  button: "확인",
		}).then((value) => {
			return;
		});
}

var alert_gohome = function(msg, type) {
	swal(msg, 
		{buttons: true, 
		dangerMode: true,
		}).then((willDelete) => {
			if (willDelete) {
				location.href="/hotel/logout";
			};
		});
}

$(function(){
	//data btns
	$("#secede").click(function(){
		if(!$("#secedeCkb").is(":checked")){
			alert("회원 탈퇴정책에 동의해주세요.");
			return;
		}
		swal("유저 데이터를 삭제하시겠습니까?", {buttons: true,
	    	  dangerMode: true,
	    	})
	    	.then((willDelete) => {
	    	  if (willDelete) {
 				if($("#secedepw").val() != "${sessionScope.user.userPassword}"){
					alert("비밀번호가 틀렸습니다.");
					return;
	    		  }
	   			$.ajax({
	   				url:"/hotel/user/secede",
	   				method:"POST",
	   				data: {
	   					userNum: "${sessionScope.user.userNum}"
	   					},
	   				success:function(User){
	   					alert_gohome("성공적으로 탈퇴했습니다.");
	   				},
	   				error:function(a, b, errMsg){
	   					alert("회원 탈퇴에 실패했습니다.");
	   				}
	   			});
	    	  };
	    	});
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
							<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
							<a>마이페이지</a>
							<a>회원탈퇴</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;마이페이지</h3>
					</div>
					<jsp:include page="aside.jsp" />
					<div class="main-section">
						<h4 style="text-align: left; width: 90%; float: left">|회원탈퇴</h4>
						<p style="margin: 50px 0 10px 0;">쌍용 호텔 서비스 이용 해지 신청 전, 아래사항을 반드시 읽어주세요.</p>
						<div class="terms_content">
							<br>
							<p>&nbsp;&nbsp;1. 기존 아이디로 재가입이 불가능합니다.</p>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;회원 탈퇴 신청 시 해당 아이디는 즉시 탈퇴 처리되며, 영구적으로 사용이 중지됩니다.</p><br>
							<p>&nbsp;&nbsp;2. 회원 정보 및 게시물 삭제</p>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;게시물 등의 삭제를 원하시면 반드시 직접 삭제 하신 후, 탈퇴를 신청해 주시길 바랍니다.</p>
								<table class="table table-bordered">
									<tr>
										<th width="80%">내용</th>
										<th width="20%">기간</th>
									</tr>
									<tr>
										<td>계약 또는 청약철회 등에 관한 기록</td>
										<td>5년</td>
									</tr>
									<tr>
										<td>대금결제 및 재화 등의 공급에 관한 기록</td>
										<td>5년</td>
									</tr>
									<tr>
										<td>소비자의 불만 또는 분쟁처리에 관한 기록</td>
										<td>3년</td>
									</tr>
								</table>
							<p>&nbsp;&nbsp;3. 문의사항은 1대 1 문의를 이용하시길 바랍니다.</p><br>
						</div>
						<div class="terms_check">
							<div class="form-group">
								<br>
								<input type="checkbox" id="secedeCkb"> 위 정책을 확인하였으며, 내용에 동의합니다.<br><br>
								<div class="secedeBtn">
									<input type="password" class="form-control secede" id="secedepw" placeholder="비밀번호 입력">
									<input type="button" class="form-control" id="secede" value="탈퇴" style="width:80px">
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