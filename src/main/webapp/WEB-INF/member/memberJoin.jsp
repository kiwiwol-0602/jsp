<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String today = LocalDate.now().toString();
	pageContext.setAttribute("today", today);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberJoin.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
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
  <script>
	  'use strict';
			let regMid = /^[a-zA-Z0-9_]{4,20}$/;
			let regNickName = /^[가-힣0-9_]{2,20}$/;
			let regName = /^[가-힣a-zA-Z]{2,20}$/
			let regEmail = /^[0-9a-zA-Z]([\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			let regTel = /^([0-9]{3})[-]([0-9]{3,4})[-]([0-9]{4})$/;
	  
	  function fCheck(){
		  // 전화번호, 이메일, 주소생성
	    let tel2 = myform.tel2.value.trim(); 
	    let tel3 = myform.tel3.value.trim(); 
	    if(tel2 == ""){
	       tel2 = " ";
	    }
	    if(tel3 == ""){
	       tel3 = " ";
	    }
	    
	    let tel = myform.tel1.value + "-" + tel2 + "-" + tel3; 
	    let email = myform.email1.value + myform.email2.value + myform.email3.value; 
	    let address = myform.postcode.value + " /" + myform.address.value + " /" + myform.detailAddress.value + " /" + myform.extraAddress.value;
	    
	    /* 유효성 검사(정규식으로 처리) */
 	    myform.tel.value = tel;
 	    myform.email.value = email;
	    myform.address2.value = address;
	   
		  /*정규식 처리*/
			let mid = myform.mid.value;
			let pwd = myform.pwd.value;
			let nickName = myform.nickName.value;
			let name = myform.name.value;
			
			
		  if (!regMid.test(mid.trim())) {
	      alert("아이디는 영문 대/소문자와 숫자, 그리고 밑줄(_)을 포함하여 4~20자까지 가능합니다.");
	      document.getElementById("mid").value = "";  // 수정
	      document.getElementById("mid").focus();  // 수정
	      return false;
    	} else if(pwd.length < 2 || pwd.length > 20) {
        alert("비밀번호는 2~20 자리로 작성해주세요.");
        myform.pwd.focus();
        return false;
  		} else if (!regNickName.test(nickName.trim())) {
        alert("닉네임은 한글만 사용 가능합니다.");
        document.getElementById("nickName").value = "";  // 수정
        document.getElementById("nickName").focus();  // 수정
        return false;
    	} else if (!regName.test(name.trim())) {
        alert("성명은 한글, 영어, 숫자만 사용 가능합니다.");
        document.getElementById("name").value = "";  // 수정
        document.getElementById("name").focus();  // 수정
        return false;
   		 } else if (!regEmail.test(email.trim())) {
        alert("이메일주소는 이메일 형식에 맞도록 작성해 주세요.");
        myform.email.value = "";
        document.getElementById("email1").focus();  // 수정
        return false;
    	} else if (!regTel.test(tel.trim())) {
        alert("전화번호는 지역번호(3)-국번호(3~4)-전화번호(4) 형식을 맞춰주세요. 예) 010-1234-5678");
        document.getElementById("tel").focus();  // 수정
        return false;
   	  }
		  // 중복체크
    	if (!myform.idCk || myform.idCk.value < 1) {
        alert("아이디 중복체크를 진행해주세요.");
        return false;
   	  } else if (!myform.nickCk || myform.nickCk.value < 1) {
        alert("닉네임 중복체크를 진행해주세요.");
        return false;
		        }
		  //-------------------------------------//
	    myform.submit();
  	}
	  
	  // 아이디 중복체크
	  function idCheck() {
			let mid = myform.mid.value;
			
			if(mid.trim()==""){
				alert("아이디를 입력하세요");
				myform.mid.focus();
			}
			else {
				let url = "MemberIdCheck.mem?mid="+mid;
				window.open(url, "idCheckWindow", "width=500px, height=400px");
				myform.idCk.value = 1;//중복 체크 완료
			}
	  }
	  function nickNameCheck() {
			let nickName = myform.nickName.value;
			
			if(nickName.trim()==""){
				alert("닉네임을 입력하세요");
				myform.nickName.focus();
			}
			else {
				let url = "MemberNickNameCheck.mem?nickName="+nickName;
				window.open(url, "nickNameCheckWindow", "width=500px, height=400px");
				myform.nickCk.value = 1;//중복 체크 완료
			}
	  }
	  
	  function nickNameajaxCheck() {
			let nickName = myform.nickName.value;
			if (!regNickName.test(nickName.trim())) {
	      alert("닉네임은 한글만 사용 가능합니다.");
	      document.getElementById("nickName").value = "";  // 수정
	      document.getElementById("nickName").focus();  // 수정
	      return false;
			}
			
			$.ajax({
				type : "get",
				url  : "NickNameAjaxCheck.mem",
				data : {nickName : nickName},
				success : function (res) {
					if(res != "0"){
						alert("닉네임이 중복되었습니다.\n다른 닉네임을 사용하세요.");
					}
					else {
						alert("사용하실 수 있는 닉네임 입니다.")
					}
				},
				error : function () {
					alert("전송오류");
				}
			});
	}
   </script>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<jsp:include page="/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <h2 class="text-center">회 원 가 입</h2>
  <form name="myform" method="post" action="MemberJoinOk.mem" onsubmit="return fCheck()">
		<table class="table table-bordered">
			<tr>
        <th>아이디</th>
        <td>
          <div class="input-group">
            <input type="text" name="mid" id="mid" class="form-control" placeholder="아이디를 입력하세요" autofocus required />
            <div class="input-group-append">
            	<input type="button" value="아이디 중복체크" onclick="idCheck()" class="btn btn-outline-success ml-2"/>
            </div>
          </div>
        </td> 
      </tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control" required /></td>
			</tr>
			<tr>
				<th>성명</th>
				<td>
					<input type="text" name="name" id="name" placeholder="성명을 입력하세요" class="form-control" required />
					<div class="checkName" id="checkName"></div>
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
        <td>
          <div class="input-group">
            <input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요"  class="form-control" required />
            <div class="input-group-append">
            	<!-- <input type="button" value="닉네임 중복체크" onclick="nickNameCheck()" class="btn btn-outline-success ml-2"/> -->
            	<input type="button" value="닉네임 중복체크" onclick="nickNameajaxCheck()" class="btn btn-outline-success ml-2"/>
            </div>
          </div>
        </td> 
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender" id="male" value="남자" /> 남자 &nbsp;
					<input type="radio" name="gender" id="female" value="여자" checked/> 여자
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="date" name="birthday" id="birthday" value="${today}" class="form-control" /></td>
			</tr>
			<tr>
				<th>전화번호</th> <!-- 정규식 4자리만 가능하게 -->
				<td>
					<div class="input-group">
						<select class="form-control" name="tel1" id="tel1">
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
						<span style="margin: 5px;" >-</span>
						<input type="text" name="tel2" id="tel2" placeholder="가운데 번호를 입력하세요" class="form-control" required />
						<span style="margin: 5px;" >-</span>
						<input type="text" name="tel3" id="tel3" placeholder="끝 번호를 입력하세요" class="form-control" required />
					</div>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<div class="input-group mb-2">
						<input type="text" name="postcode" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="우편번호" class="form-control" style="width: 14%; margin-right: 1%;" readonly>
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="form-control btn-outline-secondary" style="width: 15%;">
						<input type="text" class="border-less" style="width: 70%; border: none;">
					</div>
					<input type="text" name="address" id="sample6_address" onclick="sample6_execDaumPostcode()"placeholder="주소" class="form-control mb-2" readonly>
					<div class="input-group">					
						<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"style="width: 70%;">
						<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control"style="width: 30%;">
					</div>
					<!-- <input type="text" name="address" id="address" placeholder="주소를 입력하세요" class="form-control" /> -->
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="input-group">
						<input type="text" name="email1" id="email1" placeholder="이메일을 입력하세요" class="form-control"  required />
						<input type="text" name="email2" id="email2" value="@" class="border-less" style="width: 30px; border: none;" required />
						<select class="form-control" name="email3" id="email3">
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
					<input type="radio" name="userInfor" id="release" value="공개" checked/> 공개 &nbsp;
					<input type="radio" name="userInfor" id="private"  value="비공개" /> 비공개
				</td>
			</tr>
	    <tr>
	    	<td colspan="2" class="text-center">
	    	<!-- (숙제) 중복체크 버튼 눌렀는지 확인후 회원가입 가능하게 -->
		      <button type="submit" class="btn btn-info mr-2">회원가입</button>
		      <button type="reset" class="btn btn-warning mr-2">다시입력</button>
		      <button type="button" onclick="location.href='MemberLogin.mem'" class="btn btn-primary">돌아가기</button>
		     </td>
		  </tr>
	  </table>
  	<input type="hidden" name="tel" id="tel" />
		<input type="hidden" name="email" id="email" />
		<input type="hidden" name="address2" id="address2" />
		<input type="hidden" name="idCk" id="idCk" value="0" />
		<input type="hidden" name="nickCk" id="nickCk" value="0"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>