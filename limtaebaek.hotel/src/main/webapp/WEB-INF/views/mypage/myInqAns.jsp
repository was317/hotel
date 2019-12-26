<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>서울호텔:마이페이지</title>
<meta charset="UTF-8">
<style>
.modalbtngroup {
	margin-left: 90%;
}
</style>
<script>
	
</script>
</head>
<body>
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
						<td><textarea id="Anscontent" class="form-control" rows="12"
								cols="60" onfocus="this.blur();">${inq.inqCmtContent}
						</textarea></td>
					</tr>
				</tbody>
			</table>

		</div>

		<button type="button" class="btn btn-default modalbtn"
			data-dismiss="modal">확인</button>

	</div>
</body>
</html>