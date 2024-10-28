<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberSignUp.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <style>
	  th{
	  	text-align: center;
	  	background-color: #eee;
	  }
   #email2 {
      width: 10px; /* '@' 기호에 맞춰 너비 조정 */
      text-align: center; /* 텍스트 가운데 정렬 */
   }
	</style>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<jsp:include page="/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <h2 class="text-center">회 원 가 입</h2>
  <form name="myform" method="post" action="#">
		<table class="table table-bordered">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" class="form-control" autofocus required /></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control"  required /></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td><input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요"  class="form-control"  required /></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type="text" name="name" id="name" placeholder="성명을 입력하세요" class="form-control"  required /></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender"  value="남자" /> 남자 &nbsp;
					<input type="radio" name="gender"  value="여자" checked/> 여자
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="date" name="birthday" id="birthday" class="form-control"  required /></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<div class="input-group">
						<select class="form-control">
							<option value="010">010</option>
              <option value="011">011</option>
              <option value="016">016</option>
              <option value="017">017</option>
              <option value="018">018</option>
              <option value="019">019</option>
              <option value="031">031</option>
              <option value="032">032</option>
              <option value="033">033</option>
              <option value="041">041</option>
              <option value="042">042</option>
              <option value="043">043</option>
						</select>
						<input type="text" name="tel1" id="te1" placeholder="가운데 번호를 입력하세요" class="form-control" required />
						<input type="text" name="tel2" id="te2" placeholder="끝 번호를 입력하세요" class="form-control" required />
					</div>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="address" id="address" placeholder="주소를 입력하세요" class="form-control" /></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="input-group">
						<input type="text" name="email1" id="email1" placeholder="이메일을 입력하세요" class="form-control"  required />
						<input type="text" name="email2" id="email2" value="@" class="border-less" style="width: 30px; border: none;" required />
						<select class="form-control">
							<option value="naver.com">naver.com</option>
              <option value="daum.net">daum.net</option>
              <option value="gmail.com">gmail.com</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="kakao.com">kakao.com</option>
              <option value="nate.com">nate.com</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th>자기소개</th>
				<td>
					<textarea row ="5" class="form-control" id="content" placeholder="자기소개를 입력해주세요" name="content" style="height: 150px"></textarea>
				</td>
			</tr>
			<tr>
				<th>사진</th>
				<td>
					<input type="file" name="photo" id="photo" class="form-control" style="height: 45px" />	
				</td>
			</tr>
			<tr>
				<th>정보공개여부</th>
				<td>
					<input type="radio" name="userInfor"  value="공개" checked/> 공개 &nbsp;
					<input type="radio" name="userInfor"  value="비공개" /> 비공개
				</td>
			</tr>
	    <tr>
	    	<td colspan="2" class="text-center">
		      <button type="summit" class="btn btn-info mr-2">회원가입</button>
		      <button type="reset" class="btn btn-warning mr-2">다시입력</button>
		      <button type="button" onclick="location.href='MemberLogin.mem'" class="btn btn-primary">돌아가기</button>
		     </td>
		  </tr>
	  </table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>