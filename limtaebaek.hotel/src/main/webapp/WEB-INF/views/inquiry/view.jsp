<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>서울호텔</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
.modalbtn{
	margin-left: 90%;
}
</style>
</head>
<body>
<div class="modal-body">
		<div class="panel panel-default">
			<!-- 테이블 -->
			<div class="table-responsive">
				<table class="table">
					<tbody>
						<tr>
							<td>제목</td>
							<td><input type="text" class="form-control" onfocus="this.blur();" value="${user.userName}"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea class="form-control" rows="12" cols="60" onfocus="this.blur();">${inq.inqContent}</textarea></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input type="text" class="form-control" onfocus="this.blur();" value="${inquiry.inqWriter}"></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td><input type="text" class="form-control" onfocus="this.blur();" value="${inq.inqEmail}"></td>
						</tr>
						<tr>
							<td>연락처</td>
							<td><input type="text" class="form-control" onfocus="this.blur();" value="${inq.inqPhone}"></td>
						</tr>

					</tbody>
				</table>
				<!-- 테이블 끝 -->
			</div>
		</div>

		<button type="button" class="btn btn-default modalbtn" data-dismiss="modal">확인</button>

	</div>
</body>
</html>