<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
var confirm = function(msg, type) {
	   swal(msg, {
	        buttons: ["취소", "확인"],
	      }).then((value) => {
	    	  if(value)
	    		  return;
	    	  else
	    		  return;
	      });
}

$(function(){
	$("#adminlogin").bind("click", function(e){
		e.preventDefault();
		$.ajax({
			url:"user/adminLogin",
			method:"GET",
			data: {
				userEmail:$("#userEmail").val(),
				userPassword:$("#userPassword").val()
			},
			success:function(result){
				if(result == true)  location.href = "/hotel/admin/?page=admin";
				else alert("이메일 및 비밀번호가 정확하지 않습니다. \n다시 입력해 주세요")
			},
			error:function(a, b, errMsg){
				if(!$("#userEmail").val()) alert("이메일을 입력하세요.");
				else if(!$("#userPassword").val()) alert("비밀번호를 입력하세요.");
				else {
					alert("로그인에 실패하였습니다.");
					};
			}
		})
	});
})
</script>
<style>
fieldset.login{
   width: 50%;
   text-align: center;
   margin: 0 auto;
}

button.login{
   left: 60%;
}

.login-input{
   margin: 0 auto;
   width: 300px;
}

.login-name{
   left: 50%;
   width: 147px;
}
.login-panel a{
	text-decoration:none;
	color:#A0A0A0;
	font-size:14px;
	font-weight:bold;
}
.login-panel a:hover{
	color:black;
}
.login-btn{
   margin: 0 auto;
   height: 70px; position: absolute; left: 50%;
   margin-left: 150px;
}
.admin-info{
	width: 50%;
    border: 2px solid black;
    padding-top: 0px;
    padding-bottom: 0px;
    margin-left: 315px;
    margin-top: 50px;
}

.admin-info div{
	text-align: center;
	border-bottom: 2px solid black;
	padding-top: 15px;
	padding-bottom: 10px;
	background-color: black;
	color: white;
    font-weight: bold;
    font-size: 16px;
}

.admin-info ul{
	margin: 0 auto;
    padding-top: 20px;
    padding-bottom: 20px;
}

.admin-info li{
	padding-top: 5px;
   	padding-bottom: 5px;
}
   /*메인 섹션 끝*/
</style>
<section>
	<div class="container center-block" style="height: 600px">
		<div class="location">
			<p>
				<a><span class="glyphicon glyphicon-home">&nbsp;></span></a>
				<a>로그인</a>
			</p>
		</div>
		<div class="headTit">
			<h3>&nbsp;관리자 로그인</h3>
		</div>
		<br><br><br>
	   	<fieldset class="login">
	     	<div class="login-panel">
	        	<button type="submit" class="btn btn-default login-btn" id="adminlogin">로그인</button>
	         	<input type="email" class="form-control login-input" id="userEmail" placeholder="이메일">
				<input type="password" class="form-control login-input" id="userPassword" placeholder="비밀번호 입력">
	         	<br>
	      	</div>
		</fieldset>
		<div class="admin-info">
			<div>
				관리자 계정 생성 안내
			</div>
			<ul>
				<li>회원가입 후 아래의 연락처로 연락 바랍니다.</li>
				<li>정진성과장 / 010-1234-5678 / wlstjd@naver.com</li>
				<li>아이디와 비밀번호는 회원 로그인 화면에서 찾을 수 있습니다.</li>
			</ul>
		</div>
	</div>
</section>
</html>