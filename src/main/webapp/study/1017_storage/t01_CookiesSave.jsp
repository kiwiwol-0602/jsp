<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t01_CookiesSave.jsp -->
<%
	String mid = "hkd1234";
	Cookie cookieMid = new Cookie("cMid", mid);
	cookieMid.setMaxAge(60);  //쿠키의 만료시간(초) : 1일=60*60*24=86400
	response.addCookie(cookieMid); //저장

	String pwd = "1234";	
	Cookie cookiePwd = new Cookie("cPwd", pwd);
	cookiePwd.setMaxAge(3600);  //쿠키의 만료시간(초) : 1시간=60*60=3600
	response.addCookie(cookiePwd); //저장
%>

<script>
	alert("쿠키가 생성/저장 되었습니다.");
	location.href = "t01_Cookies.jsp"
</script>