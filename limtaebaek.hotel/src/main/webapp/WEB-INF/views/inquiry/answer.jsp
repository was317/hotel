<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>서울호텔</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
.modalbtngroup {
	margin-left: 80%;
}
</style>
<script>
$(function() {
	$("#submit").click(function() {
		//var inqNumber = $(this).attr('id').substr(1);
		alert("z");
			 /* $.ajax({
			url:"inquiryMail",
			method:"GET",
			data: {					
				inqCmtContent:inqNumber
			},
			success:function(inq){
				//alert(inq.inqTitle + "/" + inq.inqEmail);
				//alert("${inquiry}");
				 sessionStorage.setItem("inqNum", inq.inqNum);
					 $("#confirmModal").modal({
					remote : "viewInquiry"
				});   
			},
			error:function(a, b, errMsg){
				alert("오류" + errMsg);
			}
		 });   */ 
	});
});
</script>
</head>
<body>
<form method="post" action="inquiryMail">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		<h4 class="modal-title" id="myModalLabel">답변</h4>
	</div>
	<div class="modal-body">
		<div class="panel panel-default">
			<table class="table">
				<tbody>
					<tr>
						<td><textarea id="inqCmtContent" class="form-control" rows="12" cols="60"></textarea></td>
					</tr>
				</tbody>
			</table>

		</div>
		<div class="modalbtngroup">
			<button class="btn btn-default" data-dismiss="modal" type="submit" id="submit">제출</button>
			<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		</div>
	</div>
</form>
</body>
</html>