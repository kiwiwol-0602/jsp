<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t02_Session.jsp</title>
   <jsp:include page="/include/bs4.jsp"/>
</head>
   <body>
   <jsp:include page="/include/header.jsp"/>
	<jsp:include page="/include/nav.jsp"/>
   <p><br/></p>
   <div class="container">
      <h2>세션 연습 메인 메뉴</h2>
       <form name="myform" method="post" action="t02_SessionSave.jsp">
     	<div> 아이디를 입력하세요
    	 <input type='text' name='mid' value='' class='form-control mb-2' autofocus required/>
    	</div>
      <div> 닉네임을 입력하세요 
      	<input type="text" name='nickName' id="nickName" value='' class='form-control mb-2' required/>
      </div>
      <div> 성명을 입력하세요 
      	<input type="text" name='name' id="name" value='' class='form-control mb-2' required/>
      </div>
     	<div class="row">
     		<div class="col"><button type="submit" class="btn btn-success mb-2">세션저장</button></div>
  			<div class="col"><a href="t02_SessionCheck.jsp" class="btn btn-primary mb-2">세션확인</a></div>
  			<div class="col"><a href="t02_SessionAllDelete.jsp" class="btn btn-danger mb-2">전체세션삭제</a></div>
  			<div class="col"><a href="t02_SessionDelete.jsp" class="btn btn-warning mb-2" >부분세션삭제</a></div>
     	</div>
  </form>
   </div>
   <p><br/></p>
   <jsp:include page="/include/footer.jsp"/>
   </body>
</html>