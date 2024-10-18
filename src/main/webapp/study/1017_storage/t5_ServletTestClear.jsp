<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t5_ServletTestClear.jsp -->
<%
	session.invalidate();
	application.removeAttribute("aMid");
%>

<script>
  alert("삭제 되었습니다.");
  location.href = "t5_ServletTest.jsp";
</script>