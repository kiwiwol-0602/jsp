<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberList.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <script>
  function levelChange(e) {
	  //let level = document.getElementById("level").value;
	  let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
	  if(!ans){
		  location.reload();
		  return false;
	  }
	  //alert("레벨 : "+e.value);
		let items = e.value.split("/");
	  
	  $.ajax({
		  type : "post",
		  url  : "MemberLevelChange.ad",
		  data : {
			  level : items[0],
			  idx   : items[1]
		  },
		  success : function(res) {
				if(res !=0){
					alert("등급 수정 완료");
					location.reload();
				}
				else alert("등급 수정 실패")
			},
		  error : function() {
				alert("전송오류");
			}
	  });
	}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>회 원 리 스 트</h2>
  <hr/>
  <div class= "row">
  	<div class="col text-right"><a href="#" class="btn btn-primary">전체검색</a></div>
  </div>
  <hr/>
 	<div>
 		<table class="table table-hover text-center">
 			<tr class="table-secondary">
 				<th>번호</th>
 				<th>닉네임</th>
 				<th>성명</th>
 				<th>아이디</th>
 				<th>성별</th>
 				<th>생년월일</th>
 				<th>이메일</th>
 				<th>최종방문일</th>
 				<th>활동여부</th>
 				<th>등급</th>
 			</tr>
 			<c:forEach var="vo" items="${vos}" varStatus="st">
	 			<tr<c:if test="${vo.userInfor != '공개'}"> style="background-color:skyblue"</c:if>>
					<td>${vo.idx}</td>
					<td>${vo.nickName}</td>
					<td>${vo.name}</td>
					<td>${vo.mid}</td>
					<td>${vo.gender}</td>
					<td>${vo.birthday.substring(0,10)}</td>
					<td>${vo.email}</td>
					<td>
						<c:if test="${sMid == vo.mid}">${fn:substring(sLastDate,0,16)}</c:if>
						<c:if test="${sMid != vo.mid}">${fn:substring(vo.lastDate,0,16)}</c:if>
					</td>
					<td>
            <c:if test="${vo.userDel == 'NO'}">활동 중</c:if>
            <c:if test="${vo.userDel != 'NO'}"><font color="red">탈퇴 신청</font></c:if>
         </td>
					<td>
						<select name="level" id="level"	onchange="levelChange(this)">
							<option value="1/${vo.idx}" ${vo.level == 1 ? 'selected' : '' }>준회원</option>						
							<option value="2/${vo.idx}" ${vo.level == 2 ? 'selected' : '' }>정회원</option>						
							<option value="3/${vo.idx}" ${vo.level == 3 ? 'selected' : '' }>우수회원</option>						
							<option value="0/${vo.idx}" ${vo.level == 0 ? 'selected' : '' }>관리자</option>						
							<option value="99/${vo.idx}" ${vo.level == 99 ? 'selected' : '' }>탈퇴예정회원</option>						
						</select>
					</td>
	 			</tr>
 			</c:forEach>
 			<tr><td colspan="10" class="m-0 p-0"></tr>
 		</table>
 	</div>
	<div class="input-group mt-1">
		<div class="input-group-prepend"><div class="input-group-text">성명검색</div></div>
		<input type="text" name="name" id="name" class="form-control" />
		<div class="input-group-append"><input type="button" value="검색" onclick="nameSearch()" class="btn btn-success" /></div>
	</div>
  
</div>
<p><br/></p>
</body>
</html>