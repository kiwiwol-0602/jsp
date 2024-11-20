<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>uuidForm.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
  	'use strict'
  	
  	let str = '';
  	function uuidCheck() {
  		$.ajax({
  			type : "get",
  			url  : "UuidFormOk.st",
  			success:function(res){
  				str += res + "<br/>";
  				demo.innerHTML = str;
    		},
    		error : function() {
    			alert("전송오류");
  			}
  		});
		
	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2>UUID란</h2>
  <pre>
  	UUID(Universally Unique Identifier)는 네트워크상에서 고유성이 보장되는 id를 만들기 위한 규약.
  	128Bit의 16진수로 32자리의 문자로 표시된다. (8-4-4-4-12)
		예) 1234asdf-qwer-tyui-fghi-1234567890as
  </pre>
	<div>
		<form name="myform">
			<input type="button" value="UUID생성" onclick="uuidCheck()" class="btn btn-success"/>
			<input type="button" value="다시하기" onclick="location.reload()" class="btn btn-warning"/>			
		</form>
	</div>
	<hr/>
  <div>
    <h4>출력결과</h4>
    <div id="demo"></div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>