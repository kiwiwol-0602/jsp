<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberNickNameCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
    <script>
  'use strict';
  $(function(){
	   let nickName = "${vo.nickName}";
	   let str = "";
	   if(nickName != ""){
	      str = nickName + "는 이미 사용중입니다.";
	      str += '<form name="childForm" method="post" action="MemberNickNameCheck.mem">';
	      str += '닉네임 : ';
	      str += '<input type="text" name="nickName" class="m-2" autofocus required />';
	      str += '<input type="submit" value="닉네임 검색" class="btn btn-secondary" />';
	      str += '</form>';
	   }
	   else{
	      str = "${vo.tempNickName}는 사용 가능합니다.";
	   }
	   demo.innerHTML = str;
  });
  
  function winClose() {
     opener.window.myform.nickName.value = '${vo.tempNickName}';
     //opener.window.myform.pwd.focus();
     window.close();
  }
   </script>
</head>
<body>
<p><br/></p>
<div class="container">
    <h3>닉네임 검색결과</h3>
  <div id="demo"></div>
  <hr/>
  <p><input type="button" value="창닫기" onclick="winClose()" /></p>
</div>
<p><br/></p>
</body>
</html>