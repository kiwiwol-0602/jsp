<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <!-- <title>testHeader.jsp</title> -->
<%
	//String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
	String mid = (String) request.getAttribute("mid"); // request 서버저장소에서 불러와서 string으로 강제 형변환

%>
<script>
	'use strict';
  /*if('${mid}' :EL == ''){ */
	<%-- if('<%=mid%>:표현식이라는 서블릿코드' == ''){ --%>
	if('<%=mid%>' == ''){
		alert("로그인후 사용하세요");
		location.href = "<%=request.getContextPath()%>/study/1015/test10.jsp";
	}
	
</script>
<div style="width: 100%; height: 80px; background-color: skyblue;">
	<div>접속자 : <font color="red"><b><%=mid %></b></font></div>
	<nav style="text-align: center; padding-top:10px;">
		<a href="test10Member.jsp?mid=<%=mid%>">홈으로</a>
		|<a href="test10Board.jsp?mid=<%=mid%>"> 게시판</a>
		|<a href="test10Guest.jsp?mid=<%=mid%>"> 방명록</a>
		|<a href="test10Pds.jsp?mid=<%=mid%>"> 자료실</a>
		|<a href="javascript:logoutCheck();"> 로그아웃</a>
	
	</nav>

</div>