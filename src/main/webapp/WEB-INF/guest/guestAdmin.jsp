<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>guestAdmin.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<jsp:include page="/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <h2>로그인</h2>
       <form name="myform" method="post" action="GuestAdminOk.gu">
     <div>아이디를 입력하세요.
  	   <input type='text' name='mid' value='admin' class='form-control mb-2' autofocus required/>
     </div>
     <div>비밀번호를 입력하세요
     	<input type='password' name='pwd' value='1234' class='form-control mb-2' required/>
     </div>
     <div>
     <button type="submit" class="btn btn-success form-control mb-2">로그인</button>
     <button type="reset" class="btn btn-warning form-control mb-2">다시입력</button>
     <button type="button" onclick="location.href='GuestList.gu'" class="btn btn-info form-control mb-2">돌아가기</button>
     </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>