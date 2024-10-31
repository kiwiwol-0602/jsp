<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberPwdDeleteCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <script>
  'use strict'

  function pwdCheck() {
	  let pwd = $("#pwd").val().trim();
    	if(pwd == "") {
       alert("현재 비밀번호를 입력하세요");
       $("#pwd").focus();
       return false;
    }
    
    $.ajax({
      type  : "get",
      url   : "MemberPwdCheckAjax.mem",
      data  : {pwd : pwd},
      success:function(res) {
        if(res != 0) {
        	let ans = confirm("정말 탈퇴할꺼니 구질구질 하게 붙잡는거 아는데 탈퇴할꺼니?");
        	if(ans){
        		ans = confirm("이대로 탈퇴하면 같은 아이디로 1개월간 못써.");
        		if(ans){
        			 alert("잘가랑~");
               myform.submit();
        		}
        	}
        }
        else alert("비밀번호가 틀립니다. 확인하세요");
      },
      error : function() { alert("전송오류!");   }
    });
  }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<jsp:include page="/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="MemberDeleteCheckOk.mem">
    <table class="table table-bordered">
      <tr>
        <td colspan="2" class="text-center">
          <h4 class="text-center">비밀번호 확인</h4>
          <div>(회원 탈퇴를 하기 위해 현재 비밀번호를 확인합니다. 진짜 탈퇴할꺼니 정말 탈퇴할꺼니 나는 이 현실을 믿을 수가 없어)</div>
        </td>
      </tr>
      <tr>
        <th class="text-center">비밀번호</th>
        <td><input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control mb-3" autofocus required></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
            <button type="button" onclick="pwdCheck()" class="btn btn-success mr-2">회원탈퇴</button>
            <button type="reset" class="btn btn-warning mr-2">다시입력</button>
            <button type="button" onclick="location.href='MemberMain.mem'" class="btn btn-info mr-2">돌아가기</button>
          </td>
        </tr>
      </table>
   </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>