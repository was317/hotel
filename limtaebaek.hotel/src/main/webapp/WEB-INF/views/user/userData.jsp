<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script src='<c:url value="/js/validationUser.js"/>'></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	div.hTitS{
		margin-top: 50px;
	}
	table.table.table-bordered{
		margin-bottom: 0px;
	}
	table.table.table-bordered th{
		padding-top: 12px;
		background-color:#f8f8f8; 
	}
	
	.ast{
		color: red;
		font-size: 18px;
		font-style: normal;
	}
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
//alert & confirm
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

var confirm = function(msg, type) {
	   swal(msg, {buttons: true,
    	  dangerMode: true,
    	})
    	.then((willDelete) => {
    	  if (willDelete) {
    		  secede();
    	  }
    	});
}


// data, correct datas
function dataIn(user, myPointSum){
	$("#data #userNum").text(user.userNum);
	$("#data #userRegDate").text(user.userRegDate);
	$("#data #userEmail").text(user.userEmail);
	$("#data #userGrade").text(user.userGrade);
	$("#data #userPassword").text(user.userPassword);
	$("#data #point").text(myPointSum);
	$("#data #userName").text(user.userName);
	$("#data #userEngFirstName").text(user.userEngFirstName);
	$("#data #userEngLastName").text(user.userEngLastName);
	$("#data #userBirth").text(user.userBirth);
	$("#data #userPhone").text(user.userPhone);
	$("#data #userTel").text(user.userTel);
	$("#data #userZip").text(user.userZip);
	$("#data #userAdd").text(user.userAdd);
	$("#data #userAddDetail").text(user.userAddDetail);
}


function dataIn_correct(user, myPointSum){
	$("#correct #userNum").text(user.userNum);
	$("#correct #userRegDate").text(user.userRegDate);
	$("#correct #userEmail").text(user.userEmail);
	$("#correct #userGrade option:eq(" + (user.grade - 1) + ")").prop("selected", true)
	$("#correct #userPassword").val(user.userPassword);
	$("#correct #point").val(myPointSum);
	$("#correct #userName").val(user.userName);
	$("#correct #userEngFirstName").val(user.userEngFirstName);
	$("#correct #userEngLastName").val(user.userEngLastName);
	
	var birth = user.userBirth.split("-");
	$("#correct #birthYear option[value=" + Number(birth[0]) + "]").prop("selected", true);
	$("#correct #birthMonth option[value=" + Number(birth[1]) + "]").prop("selected", true);
	$("#correct #birthDay option[value=" + Number(birth[2]) + "]").prop("selected", true);

	var phone = user.userPhone.split("-");
	$("#correct #userPhone1 option[value=" + phone[0] + "]").prop("selected", true);
	$("#correct #userPhone2").val(phone[1]);
	$("#correct #userPhone3").val(phone[2]);
	if(user.userTel != null){
		var tel = user.userTel.split("-");
		$("#correct #userCall1 option[value=" + tel[0] + "]").prop("selected", true);
		$("#correct #userCall2").val(tel[1]);
		$("#correct #userCall3").val(tel[2]);
	}
	$("#correct #userAddressCode").val(user.userZip);
	$("#correct #userAddress1").val(user.userAdd);
	$("#correct #userAddress2").val(user.userAddDetail);
}

// correct user validation
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
	
	if(!regUserKorName.test($("#correct #userName").val())){
		alert(msgUserKorName);
		result = false;
	}else if(!regUserEngFirst.test($("#correct #userEngFirstName").val())){
		alert(msgUserEngFirst);
		result = false;
	}else if(!regUserEngLast.test($("#correct #userEngLastName").val())){
		alert(msgUserEngLast);
		result = false;
	}else if(!regUserPhoneNumSecond.test($("#correct #userPhone2").val())){
		alert(msgUserPhoneNumSecond);
		result = false;
	}else if(!regUserPhoneNumThird.test($("#correct #userPhone3").val())){
		alert(msgUserPhoneNumThird);
		result = false;
	}else if(!regtestCall()){
		result = false;
	}else if(!regUserPw.test($("#correct #userPassword").val())){
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
            $("#correct #userAddressCode").val(data.zonecode);
            $("#userAddress1").val(addr);
            $("#userAddress2").attr("readonly",false);
            // 커서를 상세주소 필드로 이동한다.
            $("#userAddress2").attr("required", "required");
            $("#userAddress2").focus();
        }
    }).open();
}


$(function(){
	//data btns
	$("#secede").click(function(){
	   swal("유저 데이터를 삭제하시겠습니까?", {buttons: true,
	    	  dangerMode: true,
	    	})
	    	.then((willDelete) => {
	    	  if (willDelete) {
	   			$.ajax({
	   				url:"secede",
	   				method:"POST",
	   				data: {userNum: $("#data #userNum").text()},
	   				success:function(User){
	   					alert_reload("유저 데이터를 삭제했습니다.");
	   				},
	   				error:function(a, b, errMsg){
	   					alert("유저 데이터 불러오기에 실패했습니다.");
	   				}
	   			});
	    	  };
	    	});
	});
	$("#correctChange").click(function(){
		$("div #data").css('display', 'none');
		$("div #correct").css('display', 'initial');
	});
	
	//correct zip
	$("#addsearch").bind("click", function(){
		execDaumPostcode();
	});
	
	//correct btns
	$("#correctForm").bind("submit", function(e){
		e.preventDefault();
		if(regtest()) {
			$.ajax({
				url:"/hotel/point/resetPoint",
				method:"GET",
				data:{
					userNum: $("#correct #userNum").text(),
					pointContent:		"관리자 포인트 변경"
				},
				error:function(a, b, errMsg){
					alert("유저 정보 수정에 실패하였습니다.");
					return;
				}
			});
			$.ajax({
				url:"/hotel/point/addPoint",
				method:"GET",
				data:{
					pointChange:		$("#correct #point").val(),
					pointContent:		"관리자 포인트 변경",
					userNum:			$("#correct #userNum").text()
				},
				error:function(a, b, errMsg){
					alert("유저 정보 수정에 실패하였습니다.");
					return;
				}
			});
			var userTel = null;
			if($("#correct #userCall1").val() != "") userTel = ($("#correct #userCall1").val() +"-"+ $("#correct #userCall2").val() +"-"+ $("#correct #userCall3").val());
			$.ajax({
				url:"cerrect",
				method:"GET",
				data: {
					userNum:			$("#correct #userNum").text(),
					userEmail:			$("#correct #userEmail").text(),
					userGrade:			$("#correct #userGrade").val(),
					userPassword:		$("#correct #userPassword").val(),
					userName:			$("#correct #userName").val(),
					userEngFirstName:	$("#correct #userEngFirstName").val(),
					userEngLastName:	$("#correct #userEngLastName").val(),
					userBirth:			($("#correct #birthYear").val() +"-"+ $("#correct #birthMonth").val() +"-"+ $("#correct #birthDay").val()),
					userPhone:			($("#correct #userPhone1").val() +"-"+ $("#correct #userPhone2").val() +"-"+ $("#correct #userPhone3").val()),
					userTel:			userTel,
					userZip: 			($("#correct #userAddressCode").val()),
					userAdd: 			($("#correct #userAddress1").val()),
					userAddDetail: 		($("#correct #userAddress2").val())
				},
				success:function(){
   					alert_reload("유저 정보 수정에 성공하였습니다.");
				},
				error:function(a, b, errMsg){
					alert("유저 정보 수정에 실패하였습니다.");
				},
				complete:function(){
					$("div #data").css('display', 'initial');
					$("div #correct").css('display', 'none');
				}
				
			});
		}
	});
	$("#cencelBtn").click(function(){
		$("div #data").css('display', 'initial');
		$("div #correct").css('display', 'none');
	});
});
</script>
<div id="dataModal" class="modal fade">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<!-- 모달 바디 -->
			<div id="data">
				<div class="modal-body">
					<table class="table table-bordered">
						<colgroup>
							<col width="16%" class="col1">
							<col class="col2">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row" class="first">번호</th>
								<td>		
									<div>	
										<label id="userNum" class="control-label"></label> 
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">가입일</th>
								<td>		
									<div >	
										<label id="userRegDate" class="control-label"></label> 
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">이메일</th>
								<td>		
									<div >	
										<label id="userEmail" class="control-label"></label> 
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">권한</th>
								<td>		
									<div >	
										<label id="userGrade" class="control-label"></label> 
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">비밀번호</th>
								<td>		
									<div >	
										<label id="userPassword" class="control-label"></label> 
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
									<div>	
										<label id="userPhone" class="control-label"></label> 
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">자택전화</th>
								<td>		
									<div>	
										<label id="userTel" class="control-label"></label> 
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">자택주소</th>
								<td>		
									<div>	
										<label id="userZip" class="control-label"></label><br>
										<label id="userAdd" class="control-label"></label><br>
										<label id="userAddDetail" class="control-label"></label> 
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" id="correctChange">수정하기</button>
					&nbsp;&nbsp;
					<button type="button" class="btn btn-danger " id="secede" data-dismiss="modal">삭제하기</button>
				</div>
			</div>
			<div id="correct" style="display: none">
				<form class="form-inline" id="correctForm" name="correctForm" method="POST">
					<div class="modal-body">
						<table class="table table-bordered">
							<colgroup>
								<col width="16%" class="col1">
								<col class="col2">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" class="first">번호</th>
									<td>		
										<div class="form-group">	
											<label id="userNum" class="control-label"></label> 
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">가입일</th>
									<td>		
										<div class="form-group">	
											<label id="userRegDate" class="control-label"></label> 
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">이메일</th>
									<td>		
										<div class="form-group">	
											<label id="userEmail" class="control-label"></label> 
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">권한</th>
									<td>		
										<div class="form-group">	
											<label for="userGrade" class="control-label"></label>
											<select class="form-control" id="userGrade" name="userGrade" required="required">
												<option value="1">회원</option>
												<option value="2">관리자</option>
											</select>
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
										<div class="form-group">	
											<label for="point" class="control-label"></label> 
											<input type="text" class="form-control" id="point" name="point" maxlength="20" required="required">
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">이름(국문)</th>
									<td>		
										<div class="form-group">	
											<input type="text" class="form-control" id="userName" name="userName" maxlength="30" required="required">
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">이름(영문)</th>
									<td>			
										<div class="form-group">	
											<label for="userEngFirstName" class="control-label">First name(이름)</label> 
											<input id="userEngFirstName" name="userEngFirstName" type="text" class="form-control" maxlength="30" required="required"> 
											&nbsp;
											<label for="userEngLastName" class="control-label">Last name(성)</label> 
											<input id="userEngLastName" name="userEngLastName" type="text" class="form-control" maxlength="30" required="required">
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">생년월일</th>
									<td>
										<div class="form-group">	
											<span style="width: 74px;">
												<select class="form-control" id="birthYear" name="birthYear" required="required">
													<option value="">선택</option>
													<option value="2000" title="2000">2000</option>
													<option value="1999" title="1999">1999</option>
													<option value="1998" title="1998">1998</option>
													<option value="1997" title="1997">1997</option>
													<option value="1996" title="1996">1996</option>
													<option value="1995" title="1995">1995</option>
													<option value="1994" title="1994">1994</option>
													<option value="1993" title="1993">1993</option>
													<option value="1992" title="1992">1992</option>
													<option value="1991" title="1991">1991</option>
													<option value="1990" title="1990">1990</option>
													<option value="1989" title="1989">1989</option>
													<option value="1988" title="1988">1988</option>
													<option value="1987" title="1987">1987</option>
													<option value="1986" title="1986">1986</option>
													<option value="1985" title="1985">1985</option>
													<option value="1984" title="1984">1984</option>
													<option value="1983" title="1983">1983</option>
													<option value="1982" title="1982">1982</option>
													<option value="1981" title="1981">1981</option>
													<option value="1980" title="1980">1980</option>
													<option value="1979" title="1979">1979</option>
													<option value="1978" title="1978">1978</option>
													<option value="1977" title="1977">1977</option>
													<option value="1976" title="1976">1976</option>
													<option value="1975" title="1975">1975</option>
													<option value="1974" title="1974">1974</option>
													<option value="1973" title="1973">1973</option>
													<option value="1972" title="1972">1972</option>
													<option value="1971" title="1971">1971</option>
													<option value="1970" title="1970">1970</option>
													<option value="1969" title="1969">1969</option>
													<option value="1968" title="1968">1968</option>
													<option value="1967" title="1967">1967</option>
													<option value="1966" title="1966">1966</option>
													<option value="1965" title="1965">1965</option>
													<option value="1964" title="1964">1964</option>
													<option value="1963" title="1963">1963</option>
													<option value="1962" title="1962">1962</option>
													<option value="1961" title="1961">1961</option>
													<option value="1960" title="1960">1960</option>
													<option value="1959" title="1959">1959</option>
													<option value="1958" title="1958">1958</option>
													<option value="1957" title="1957">1957</option>
													<option value="1956" title="1956">1956</option>
													<option value="1955" title="1955">1955</option>
													<option value="1954" title="1954">1954</option>
													<option value="1953" title="1953">1953</option>
													<option value="1952" title="1952">1952</option>
													<option value="1951" title="1951">1951</option>
													<option value="1950" title="1950">1950</option>
													<option value="1949" title="1949">1949</option>
													<option value="1948" title="1948">1948</option>
													<option value="1947" title="1947">1947</option>
													<option value="1946" title="1946">1946</option>
													<option value="1945" title="1945">1945</option>
													<option value="1944" title="1944">1944</option>
													<option value="1943" title="1943">1943</option>
													<option value="1942" title="1942">1942</option>
													<option value="1941" title="1941">1941</option>
													<option value="1940" title="1940">1940</option>
													<option value="1939" title="1939">1939</option>
													<option value="1938" title="1938">1938</option>
													<option value="1937" title="1937">1937</option>
													<option value="1936" title="1936">1936</option>
													<option value="1935" title="1935">1935</option>
													<option value="1934" title="1934">1934</option>
													<option value="1933" title="1933">1933</option>
													<option value="1932" title="1932">1932</option>
													<option value="1931" title="1931">1931</option>
													<option value="1930" title="1930">1930</option>
													<option value="1929" title="1929">1929</option>
													<option value="1928" title="1928">1928</option>
													<option value="1927" title="1927">1927</option>
													<option value="1926" title="1926">1926</option>
													<option value="1925" title="1925">1925</option>
													<option value="1924" title="1924">1924</option>
													<option value="1923" title="1923">1923</option>
													<option value="1922" title="1922">1922</option>
													<option value="1921" title="1921">1921</option>
													<option value="1920" title="1920">1920</option>
													<option value="1919" title="1919">1919</option>
													<option value="1918" title="1918">1918</option>
													<option value="1917" title="1917">1917</option>
													<option value="1916" title="1916">1916</option>
													<option value="1915" title="1915">1915</option>
													<option value="1914" title="1914">1914</option>
													<option value="1913" title="1913">1913</option>
													<option value="1912" title="1912">1912</option>
													<option value="1911" title="1911">1911</option>
													<option value="1910" title="1910">1910</option>
													<option value="1909" title="1909">1909</option>
												</select>
											</span> 
											<label for="birthYear" class="control-label">년</label>
											<span style="width: 71px;">
												<select class="form-control" id="birthMonth" name="birthMonth" required="required">
													<option value="">선택</option>
													<option value="1" title="1">1</option>
													<option value="2" title="2">2</option>
													<option value="3" title="3">3</option>
													<option value="4" title="4">4</option>
													<option value="5" title="5">5</option>
													<option value="6" title="6">6</option>
													<option value="7" title="7">7</option>
													<option value="8" title="8">8</option>
													<option value="9" title="9">9</option>
													<option value="10" title="10">10</option>
													<option value="11" title="11">11</option>
													<option value="12" title="12">12</option>
												</select>
											</span> 
											<label for="birthMonth" class="control-label">월</label>
											<span style="width: 71px;">
												<select class="form-control" id="birthDay" name="birthDay" required="required">
													<option value="">선택</option>
													<option value="1" title="1">1</option>
													<option value="2" title="2">2</option>
													<option value="3" title="3">3</option>
													<option value="4" title="4">4</option>
													<option value="5" title="5">5</option>
													<option value="6" title="6">6</option>
													<option value="7" title="7">7</option>
													<option value="8" title="8">8</option>
													<option value="9" title="9">9</option>
													<option value="10" title="10">10</option>
													<option value="11" title="11">11</option>
													<option value="12" title="12">12</option>
													<option value="13" title="13">13</option>
													<option value="14" title="14">14</option>
													<option value="15" title="15">15</option>
													<option value="16" title="16">16</option>
													<option value="17" title="17">17</option>
													<option value="18" title="18">18</option>
													<option value="19" title="19">19</option>
													<option value="20" title="20">20</option>
													<option value="21" title="21">21</option>
													<option value="22" title="22">22</option>
													<option value="23" title="23">23</option>
													<option value="24" title="24">24</option>
													<option value="25" title="25">25</option>
													<option value="26" title="26">26</option>
													<option value="27" title="27">27</option>
													<option value="28" title="28">28</option>
													<option value="29" title="29">29</option>
													<option value="30" title="30">30</option>
													<option value="31" title="31">31</option>
												</select>
											</span> 
											<label for="birthDay" class="control-label">일</label>
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
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-warning" id="correctBtn">수정하기</button>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary " value="${room.roomNum }" id="cencelBtn">취소하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</html>
