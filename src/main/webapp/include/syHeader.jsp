<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <!-- <title>syHeader.jsp</title> -->
<%
	String mid = (String) request.getAttribute("mid");
	String part = (String) session.getAttribute("part");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t02_resS.jsp</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">
	<script>
		'use strict';
		
		if('${mid}' == ''){
			alert("로그인후 사용하세요");
		}
	</script>
</head>
<jsp:include page="/include/bs4.jsp"/>
<body>
	<div style = "text-align:center; margin-bottom:2px;">
	    <div>
	        <h1 style="font-family: 'Lobster', cursive">SoYeon</h1>
	    </div>
	    <div>
	        <span>접속자 : <b>${mid}</b>  ||</span>
	        <span>접속부서 : <b>${part}</b></span>
	    </div>
	</div>
	<nav style="text-align: center; padding-top:10px;">
		<a href="/javaGroup/study/exam/t02_login/t02_login.jsp" style="color: gray;"> 로그아웃</a>
	</nav>
</body>
</html>