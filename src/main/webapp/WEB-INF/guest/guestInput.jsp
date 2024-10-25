<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>guestInput.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<jsp:include page="/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <h2 style="text-align: center;">방 명 록 글 쓰 기</h2>
  <form name="myform" method="post" action="GuestInputOk.gu" class="was-validated">
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" id="name" value="${sNickName}" placeholder="성명을 입력하세요" name="name" autofocus required>
      <div class="valid-feedback">확인</div>
      <div class="invalid-feedback">성명을 입력하세요</div>
    </div>
    <div class="form-group">
      <label for="email">E-mail</label>
      <input type="text" class="form-control" id="email" placeholder="이메일을 입력하세요" name="email">
    </div>
    <div class="form-group">
      <label for="homePage">HomePage</label>
      <input type="text" class="form-control" id="homePage" value="http://"  name="homePage">
    </div>
    <div class="form-group">
      <label for="content">방문소감</label>
      <textarea row ="5" class="form-control" id="content" placeholder="Enter content" name="content" required></textarea>
      <div class="valid-feedback">확인</div>
      <div class="invalid-feedback">방문소감을 입력하세요</div>
    </div>
    <div class="form-group text-center">
    	<button type="submit" class="btn btn-outline-success mr-3">등록</button>
    	<button type="reset" class="btn btn-outline-primary mr-3">다시입력</button>
    	<button type="button" onclick="location.href = 'GuestList.gu'" class="btn btn-outline-danger">돌아가기</button>
    </div>
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>