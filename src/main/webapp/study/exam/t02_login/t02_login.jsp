<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String login = request.getParameter("login")==null ? "" : request.getParameter("login");

  Cookie[] cookies = request.getCookies();
  
  if(cookies != null) {
  	for(int i=0; i<cookies.length; i++){
  		if(cookies[i].getName().equals("cMid")){
  			pageContext.setAttribute("mid", cookies[i].getValue());
  			break;
  		}
  	}
  }
  %>	
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t02_login.jsp</title>
   <jsp:include page="/include/bs4.jsp"/>
   <script>
    'use strict'
    if('${message}' !="") alert("${message}");
    
    if('<%=login%>' == 'no'){
    	alert("사용할 수 없는 계정입니다.");
    }
    </script>
</head>
   <body>
   <p><br/></p>
   <div class="container">
      <h2>로그인</h2>
      <p>(부서명 : 인사과(I), 자재과(J), 생산과(S), 총무과(C))</p>
  <form name="myform" method="post" action="${ctp}/exam/t02_loginOk">
   	<div> 아이디를 입력하세요
   	  <input type='text' name='mid' value='${mid}' class='form-control mb-2' autofocus required/>
   	</div>
    <div> 비밀번호를 입력하세요 
     	<input type="password" name='pwd' id="pwd" value='1234' class='form-control mb-2' required/>
    </div>
    <div>
   		<div><input type="checkbox" name="idSave" class="mt-2 mb-2" checked/>아이디저장</div>
    	<button type="submit" class="btn btn-success mb-2">로그인</button>
    	<button type="reset" class="btn btn-success mb-2">다시입력</button>
    </div>
  </form>
  </div>
  <p><br/></p>
  </body>
</html>