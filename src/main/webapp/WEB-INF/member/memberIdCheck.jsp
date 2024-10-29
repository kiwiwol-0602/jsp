<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberIdCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <script>
  'use strict';
  $(function(){
	   let mid = "${vo.mid}";
	   let str = "";
	   if(mid != ""){
	      str = mid + "는 이미 사용중입니다.";
	      str += '<form name="childForm" method="post" action="MemberIdCheck.mem">';
	      str += '아이디 : ';
	      str += '<input type="text" name="mid" class="m-2" autofocus required />';
	      str += '<input type="submit" value="아이디 검색" class="btn btn-secondary" />';
	      str += '</form>';
	   }
	   else{
	      str = "${vo.tempMid}는 사용 가능합니다.";
	   }
	   demo.innerHTML = str;
  });
  
  function winClose() {
     opener.window.myform.mid.value = '${vo.tempMid}';
     opener.window.myform.pwd.focus();
     window.close();
  }
   </script>
  
</head>
<body>
<p><br/></p>
<div class="container">
  <h3>아이디 검색결과</h3>
  <div id="demo"></div>
  <hr/>
  <p><input type="button" value="창닫기" onclick="winClose()" /></p>
</div>
<p><br/></p>
</body>
</html>