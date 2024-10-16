<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
   String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
%>
<!-- t01Ok.jsp -->

<!-- <script>
	location.href = "t01Res.jsp"; //Ok에서 멈췄다가 가는것
</script> -->

<!-- //끝까지 가지고 가는것 -->
<jsp:forward page="t01Res.jsp">
	<jsp:param name="member" value="memberOK"/>
	<jsp:param name="pwd" value="<%=pwd %>" />
</jsp:forward> 