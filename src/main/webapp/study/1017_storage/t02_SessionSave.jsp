<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t02_sessionSave.jsp -->
<%
   request.setCharacterEncoding("utf-8");


   session.setAttribute("sMid", request.getParameter("mid"));
   session.setAttribute("sName", request.getParameter("name"));
   session.setAttribute("sNickName", request.getParameter("nickName"));
%>
<script>
   alert("세션이 저장되었습니다.")
   location.href = "t02_Session.jsp"
</script>