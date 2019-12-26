<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="../common/import.jsp"></jsp:include>
<style type="text/css">
	@import url("<c:url value="/css/joinstep.css"/>");
	
	div.Btns{
		text-align: center;
		margin: 30px 0 30px 0;
	}
	
	.btn{
		border-radius: 0;
		font-size: 16;
		font-weight: 800;
	}
	
	.terms {
		margin: 0 auto;
	    width: 80%;
	    margin-top: 50px;
	}
	
	.term-header button{
		background-color: black;
		color: white;
		float: right;
		border-width: 0px;
	}
	
	.term-body {
		border: 1px solid black;
	    display: block;
	    margin-top: 10px;    
	    height: 80px;
	    overflow: auto;
	    overflow-x: hidden;
	    padding: 20px;
	}
	
	.term-body box{
	    color: gray;
	}
	
	.term-body box p{
	    margin: 0;
	    padding: 0;
	    font-size: 12px;
	    color: #101010;
	}
	
	.term-footer {
		text-align: right;
	}
	
	.allcheck {
		margin: 0 auto;
	    width: 80%;
	    border: 1px solid black;
	    padding: 10px;
	    border-style: dotted;
	    margin-top: 50px;
    }
    
    .allcheck div{
    	font-size: 12px;
	    margin-top: 5px;
	    margin-bottom: 20px;
    }
    
    .tableTypeD_2 {
   	    margin: 0 0 0px 0;
	    border: none;
	    border-top: #cdcbbe solid 1px;
	    width: 100%;
	    border-collapse: collapse;
	    table-layout: fixed;
	    border-left: 1px solid #eceae1;
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

	function allcheck(ckb){
		var s = 0;
		if(ckb.checked) s = 0;
		else s = 1;
	
		for(var i = 1; i < 5; i++){
			var radios = document.getElementsByName("termRadio" + i);
			radios[s].checked = true;
		}
	}
	
	function check(){
		var tmp = 4;
		
		for(var i = 1; i < 4; i++){
			var radio = $("input[name='termRadio" + i + "']:radio:checked").val();
			if(radio == "no" || !radio){
				tmp = i;
				break;
			}
		}
		
		switch (tmp) {
   			case 1:
   				alert("서비스 이용약관에 대한 동의는 필수입니다.");
   				return;
       		case 2:
   				alert("개인정보 수집, 이용에 대한 동의는 필수입니다.");
   				return;
       		case 3:
   				alert("개인정보 제3자 제공에 대한 동의는 필수입니다.");
   				return;
       		case 4:
       			break;
   		}

		if(!$("input[name='termRadio4']:radio:checked").val()){
			alert("개인정보 마케팅 활용 동의에 대해 동의 선택눌러주세요.");
			return;
		}else{
			location.href = "/hotel/user/userJoin";
		}
	}
	
	$(function(){
		$("#nextBtn").click(function(){
			check()
			});
		$("#cancleBtn").click(function(){
			location.href = "/hotel/";
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
							<a>회원가입</a>
						</p>
					</div>
					<div class="headTit">
						<h3>&nbsp;회원가입</h3>
					</div>
				   	<div class="joinStep">
						<ul class="step">
							<li class="t1 first on"><span>약관동의</span></li>
							<li class="t2 second"><span>회원정보 입력</span></li>
							<li class="t3 last"><span>가입완료</span></li>
						</ul>
					</div>
					<div class="terms" id="serviceTerm">
						<div class="term-header">
							서비스 이용약관에 대한 동의(필수)
							<button type="button" name="termBtn">전체 보기</button>
						</div>
						<div class="term-body">
							<div class="box">
								<jsp:include page="../terms/service.jsp"></jsp:include>
							</div>
						</div>
						<div class="term-footer">
							<label>동의함</label>
							<input type="radio" name="termRadio1" value="yes"/>
							<label>동의하지 않음</label>
							<input type="radio" name="termRadio1" value="no"/>
						</div>
					</div>
					<div class="terms" id="userdataTerm">
						<div class="term-header">
							개인정보 수집, 이용에 대한 동의(필수)
							<button type="button" name="termBtn">전체 보기</button>
						</div>
						<div class="term-body">
							<div class="box">
								<jsp:include page="../terms/userdata.jsp"></jsp:include>
							</div>
						</div>
						<div class="term-footer">
							<label>동의함</label>
							<input type="radio" name="termRadio2" value="yes"/>
							<label>동의하지 않음</label>
							<input type="radio" name="termRadio2" value="no"/>
						</div>
					</div>
					<div class="terms" id="datashareTerm">
						<div class="term-header">
							개인정보 제3자 제공에 대한 동의(필수)
							<button type="button" name="termBtn">전체 보기</button>
						</div>
						<div class="term-body">
							<div class="box">
								<jsp:include page="../terms/datashare.jsp"></jsp:include>
							</div>
						</div>
						<div class="term-footer">
							<label>동의함</label>
							<input type="radio" name="termRadio3" value="yes"/>
							<label>동의하지 않음</label>
							<input type="radio" name="termRadio3" value="no"/>
						</div>
					</div>
					<div class="terms" id="marketingTerm">
						<div class="term-header">
							개인정보 마케팅 활용 동의(선택)
							<button type="button" name="termBtn">전체 보기</button>
						</div>
						<div class="term-body">
							<div class="box">							
								<jsp:include page="../terms/marketing.jsp"></jsp:include>
							</div>
						</div>
						<div class="term-footer">
							<label>동의함</label>
							<input type="radio" name="termRadio4" value="yes"/>
							<label>동의하지 않음</label>
							<input type="radio" name="termRadio4" value="no"/>
						</div>
					</div>				
					<div class="allcheck">
						<input type="checkbox" name="allcheck" onChange="allcheck(this)">
						<label>가입 약관 전체 동의</label>
						<br>
						<div>
							※ 전체 동의는 선택사항(동의 내용을 확인한 후 개별 동의 가능)이며 전체 동의 버튼을 체크하면 선택적 수집동의도 동시에 진행됩니다.
						</div>
					</div>
					<div class="Btns">
						<button class="btn btn-default" type="button" id="nextBtn" style="padding:10px 70px">다음</button>
						<button class="btn btn-default" type="button" id="cancleBtn" style="padding:10px 70px">취소</button>
					</div>
				</div>
			</section>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>