<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울호텔:마이페이지</title>
<script src='<c:url value="/js/validationUser.js"/>'></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<jsp:include page="../common/import.jsp"></jsp:include>
<!-- 
	- res/js 추가 시
	<script src="<c:url value="/js/common.js"/>"></script>  
-->
<style>    
	div.Btns{
		text-align: center;
		margin: 30px 0 30px 0;
	}
	
	.btn{
		border-radius: 0;
		font-size: 16;
		font-weight: 800;
	}
</style>
<script>
var alert_reload = function(msg, type) {
	swal({
		  title: "",
		  text: msg,
		  icon: type,
		  button: "확인",
		}).then((value) => {
			location.reload();
		});
}

var loadUser = function(userNum) {
	$.ajax({
		url:"/hotel/user/getUser",
		method:"POST",
		data: {userNum: userNum},
		success:function(User){
			var myPointSum = 0;
			if(User.myPoints != null){
				User.myPoints.forEach(function(point) {
					myPointSum += point.pointChange;
				})
			}
			dataIn(User, myPointSum)
		},
		error:function(a, b, errMsg){
			alert("유저 데이터 불러오기에 실패했습니다.");
		}
	});
}

function dataIn(user, myPointSum){
	$("#userRegDate").text(user.userRegDate);
	$("#userEmail").text(user.userEmail);
	$("#userPassword").val(user.userPassword);
	$("#point").text(myPointSum);
	$("#userName").text(user.userName);
	$("#userEngFirstName").text(user.userEngFirstName);
	$("#userEngLastName").text(user.userEngLastName);
	$("#userBirth").text(user.userBirth);
	
	var phone = user.userPhone.split("-");
	$("#userPhone1 option[value=" + phone[0] + "]").prop("selected", true);
	$("#userPhone2").val(phone[1]);
	$("#userPhone3").val(phone[2]);
	if(user.userTel != null){
		var tel = user.userTel.split("-");
		$("#userCall1 option[value=" + tel[0] + "]").prop("selected", true);
		$("#userCall2").val(tel[1]);
		$("#userCall3").val(tel[2]);
	}
	$("#userAddressCode").val(user.userZip);
	$("#userAddress1").val(user.userAdd);
	$("#userAddress2").val(user.userAddDetail);
}

//correct user validation
function regtestCall(){
	if($("#userCall1 option:selected").val() != ""){
		if(!regUserCallNumSecond.test($("#userCall2").val())) {
			alert(msgUserCallNumSecond); 
			return false;
			}
		else if(!regUserCallNumThird.test($("#userCall3").val())){
			alert(msgUserCallNumThird);
			return false;
			}
	}else {
		if($("#userCall2").val() != "" || $("#userCall3").val() != ""){
			alert("자택 전화번호의 지역번호를 선택해주세요.");
			return false;
			}
	}
	
	return true;
}

function regtest(){
	var result = true;
	
	if(!regUserPhoneNumSecond.test($("#userPhone2").val())){
		alert(msgUserPhoneNumSecond);
		result = false;
	}else if(!regUserPhoneNumThird.test($("#userPhone3").val())){
		alert(msgUserPhoneNumThird);
		result = false;
	}else if(!regtestCall()){
		result = false;
	}else if(!regUserPw.test($("#userPassword").val())){
		alert(msgUserPw);
		result = false;
	}

	return result;
}

// daum 주소찾기
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $("#userAddressCode").val(data.zonecode);
            $("#userAddress1").val(addr);
            $("#userAddress2").attr("readonly",false);
            // 커서를 상세주소 필드로 이동한다.
            $("#userAddress2").attr("required", "required");
            $("#userAddress2").focus();
        }
    }).open();
}

$(function(){
	$("#addsearch").bind("click", function(){
		execDaumPostcode();
	});
	$("#correctForm").bind("submit", function(e){
		e.preventDefault();
		if(regtest()) {
			var userTel = null;
			if($("#userCall1").val() != "") userTel = ($("#userCall1").val() +"-"+ $("#userCall2").val() +"-"+ $("#userCall3").val());
			$.ajax({
				url:"/hotel/user/cerrect",
				method:"GET",
				data: {
					userNum:			"${sessionScope.user.userNum}",
					userEmail:			$("#userEmail").text(),
					userGrade:			"${sessionScope.user.userGrade}",
					userPassword:		$("#userPassword").val(),
					userName:			$("#userName").text(),
					userEngFirstName:	$("#userEngFirstName").text(),
					userEngLastName:	$("#userEngLastName").text(),
					userBirth:			$("#userBirth").text(),
					userPhone:			($("#userPhone1").val() +"-"+ $("#userPhone2").val() +"-"+ $("#userPhone3").val()),
					userTel:			userTel,
					userZip: 			($("#userAddressCode").val()),
					userAdd: 			($("#userAddress1").val()),
					userAddDetail: 		($("#userAddress2").val())
				},
				success:function(){
						alert_reload("정보 수정에 성공하였습니다.");
				},
				error:function(a, b, errMsg){
					alert("정보 수정에 실패하였습니다.");
				}
			});
		}
	})
})
$(document).ready(loadUser("${sessionScope.user.userNum}"));

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
							<a>개인정보 수정</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;마이페이지</h3>
					</div>
					<jsp:include page="aside.jsp" />
					<div class="main-section">
						<h4 style="text-align: left; width: 90%; float: left">|개인정보 수정</h4>
						<div class="inform_form">
							<form class="form-inline" id="correctForm" name="correctForm" method="POST">
								<table class="table table-bordered">
									<colgroup>
										<col class="col1" width="15%">
										<col class="col2" width="85%">
									</colgroup>
									<tbody>
										<tr>
											<th scope="row" class="first">이메일</th>
											<td>		
												<div class="form-group">	
													<label id="userEmail" class="control-label"></label> 
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row" class="first">비밀번호</th>
											<td>		
												<div class="form-group">	
													<div class="form-group">
														<label for="userPassword" class="control-label"></label>
														<input type="password" class="form-control" id="userPassword" name="userPassword" maxlength="20" required="required">
														<span class="">8~20자  이내 영문/숫자 조합(특수문자 입력 가능)</span>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row" class="first">포인트</th>
											<td>		
												<div >	
													<label id="point" class="control-label"></label> 
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row" class="first">이름(국문)</th>
											<td>		
												<div>	
													<label id="userName" class="control-label"></label> 
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row" class="first">이름(영문)</th>
											<td>		
												<div>	
													<label id="userEngFirstName" class="control-label"></label> 
													<label id="userEngLastName" class="control-label"></label> 
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row" class="first">생년월일</th>
											<td>		
												<div>	
													<label id="userBirth" class="control-label"></label> 
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row" class="first">휴대전화</th>
											<td>			
												<div class="form-group">	
													<label for="userPhone1" class="control-label"></label>
													<span style="width: 67px;">
														<select class="form-control" id="userPhone1" name="userPhone1" required="required">
															<option value="010" title="010">010</option>
															<option value="011" title="011">011</option>
															<option value="016" title="016">016</option>
															<option value="017" title="017">017</option>
															<option value="018" title="018">018</option>
															<option value="019" title="019">019</option>
														</select>
													</span>
													- 
													<label for="userPhone2" class="control-label"></label> 
													<input type="text" class="form-control" id="userPhone2" name="userPhone2" maxlength="4" required="required"> 
													- 
													<label for="userPhone3" class="control-label"></label>
													<input type="text" class="form-control" id="userPhone3" name="userPhone3" maxlength="4" required="required">
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row" class="first">자택전화</th>
											<td>		
												<div class="form-group">	
													<label for="userCall1" class="control-label"></label>
													<span style="width: 74px;">
														<select class="form-control" id="userCall1" name="userCall1">
															<option value="">선택</option>
															<option value="02" title="02">02</option>
															<option value="031" title="031">031</option>
															<option value="032" title="032">032</option>
															<option value="033" title="033">033</option>
															<option value="041" title="041">041</option>
															<option value="042" title="042">042</option>
															<option value="043" title="043">043</option>
															<option value="044" title="044">044</option>
															<option value="051" title="051">051</option>
															<option value="052" title="052">052</option>
															<option value="053" title="053">053</option>
															<option value="054" title="054">054</option>
															<option value="055" title="055">055</option>
															<option value="061" title="061">061</option>
															<option value="062" title="062">062</option>
															<option value="063" title="063">063</option>
															<option value="064" title="064">064</option>
															<option value="0130" title="0130">0130</option>
															<option value="080" title="080">080</option>
															<option value="070" title="070">070</option>
															<option value="0506" title="0506">0506</option>
															<option value="0502" title="0502">0502</option>
															<option value="0503" title="0503">0503</option>
															<option value="0504" title="0504">0504</option>
															<option value="0507" title="0507">0507</option>
															<option value="0505" title="0505">0505</option>
															<option value="0303" title="0303">0303</option>
														</select>
													</span> - 
													<label for="userCall2" class="control-label"></label> 
													<input type="text" class="form-control" id="userCall2" name="userCall2" maxlength="4"> 
													- 
													<label for="userCall3" class="control-label"></label> 
													<input type="text" class="form-control" id="userCall3" name="userCall3" maxlength="4">
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row" class="first">자택주소</th>
											<td>			
													<div class="form-group col-sm-10"> 
														<input type="text" class="form-control" id="userAddressCode" name="userAddressCode"  readonly="readonly">
														<button type="button" class="btn btn-default" id="addsearch">주소찾기</button>
													</div>
													<div class="form-group col-sm-10" style="margin: 10px 0 10px 0">
														<input type="text" class="form-control" id="userAddress1" name="userAddress1" maxlength="100" size="80"  readonly="readonly">
													</div>
													<div class="form-group col-sm-10" >
														<input type="text" class="form-control" id="userAddress2" name="userAddress2" maxlength="100" size="80"  readonly="readonly">
													</div>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="Btns" style="width: 95%;">
									<button class="btn btn-default" type="submit" name="submitBtn" style="padding:10px 70px">수정</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>