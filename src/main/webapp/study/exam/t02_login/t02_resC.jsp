<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
	String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");

	pageContext.setAttribute("mid", mid);
	pageContext.setAttribute("pwd", pwd);
	session.setAttribute("part", "총무과");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t02_resC.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/include/syHeader.jsp"/>
<p><br/></p>
<div class="container">
	<hr/>
  <h2>총무과 방</h2>
  <hr/>
  <h2>회원정보</h2>
	<p>아이디 : ${mid}</p>
	<p>비밀번호 : ${pwd}</p>
	<hr/>
</div>
<p><br/></p>
<jsp:include page="/include/syFooter.jsp"/>
</body>
</html>