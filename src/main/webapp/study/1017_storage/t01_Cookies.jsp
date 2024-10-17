<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t01_Cookies.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>쿠키 연습 메인 메뉴</h2>
  <hr/>
  <div class="row">
  	<div class="col"><a href="t01_CookiesSave.jsp" class="btn btn-success">쿠키저장</a></div>
  	<div class="col"><a href="t01_CookiesCheck.jsp" class="btn btn-primary">쿠키확인</a></div>
  	<div class="col"><a href="t01_CookiesAllDelete.jsp" class="btn btn-danger">전체쿠키삭제</a></div>
  	<div class="col"><a href="t01_CookiesPwdDelete.jsp" class="btn btn-warning">비밀번호쿠키삭제</a></div>
  </div>
</div>
<p><br/></p>
</body>
</html>