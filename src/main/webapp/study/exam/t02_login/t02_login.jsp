<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t02_login.jsp</title>
   <jsp:include page="/include/bs4.jsp"/>
</head>
   <body>
   <p><br/></p>
   <div class="container">
      <h2>로그인</h2>
      <p>(부서명 : 인사과(I), 자재과(J), 생산과(S), 총무과(C))</p>
       <form name="myform" method="post" action="<%=request.getContextPath()%>/exam/T02loginOk">
     	<div> 아이디를 입력하세요
    	 <input type='text' name='mid' value='admin' class='form-control mb-2' autofocus required/>
    	</div>
      <div> 비밀번호를 입력하세요 
      	<input type="password" name='pwd' id="pwd" value='1234' class='form-control mb-2' required/>
      </div>
     	<div>
     		<button type="submit" class="btn btn-success mb-2">로그인</button>
     		<button type="reset" class="btn btn-success mb-2">다시입력</button>
     		</div>
  </form>
   </div>
   <p><br/></p>
   </body>
</html>