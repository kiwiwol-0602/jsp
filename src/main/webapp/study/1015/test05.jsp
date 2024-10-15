<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<script>
   function fCheck(){
      let name = myform.name.value;
      let age = myform.age.value;
      
      if(name.trim() == ""){
         alert("성명을 입력하세요");
         myform.name.focus();
      }
      else if(age.trim() == ""){
         alert("나이을 입력하세요");
         myform.age.focus();
      }
      else{
         myform.submit();
      }
   }
</script>
<body>
<p><br/></p>
<div class="container">
   <h2>성명, 나이 입력받기</h2>
  <form action="test05Ok.jsp" method="get" name="myform">
<!--   <form action="test05Ok.jsp" method="post" name="myform"> -->
     <div>성명 : <input type='text' id='name' name='name' value="김키위" class='form-control'/></div>
      <div>나이 : <input type='number' id='age' name='age' min='1' max='150' value="3" class='form-control mb-2'/></div>
     <div><input type="submit" value="입력" onclick="fCheck()" class="btn btn-success"></div>
  </form>
</div>
<p><br/></p>
</body>
</html>