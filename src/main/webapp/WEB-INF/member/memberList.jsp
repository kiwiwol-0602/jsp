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
  
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<jsp:include page="/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <h2>회 원 리 스 트</h2>
  <div class= "row">
  	<div class="col text-right"><a href="MemberList.mem" class="btn btn-primary">전체검색</a></div>
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
 				<th>등급</th>
 				<th>최종방문일</th>
 			</tr>
 			<c:forEach var="vo" items="${vos}" varStatus="st">
	 			<tr>
					<td>${st.count}</td>
					<td>${vo.nickName}</td>
					<c:if test="${vo.userInfor == '공개'}">
						<td><a href="#">${vo.name}</a></td>
						<td>${vo.mid}</td>
						<td>${vo.gender}</td>
						<td>${vo.birthday.substring(0,10)}</td>
						<td>${vo.email}</td>
						<td>${vo.level}</td>
						<td>
							<c:if test="${sMid == vo.mid}">${fn:substring(sLastDate,0,16)}</c:if>
							<c:if test="${sMid != vo.mid}">${fn:substring(vo.lastDate,0,16)}</c:if>
						</td>
					</c:if>
					<c:if test="${vo.userInfor != '공개'}">
						<td colspan="7" class="text-center">비 공 개</td>
					</c:if>
	 			</tr>
 			</c:forEach>
 			<tr><td colspan="9" class="m-0 p-0"></tr>
 		</table>
 	</div>
	<div class="input-group mt-1">
		<div class="input-group-prepend"><div class="input-group-text">성명검색</div></div>
		<input type="text" name="name" id="name" class="form-control" />
		<div class="input-group-append"><input type="button" value="검색" onclick="nameSearch()" class="btn btn-success" /></div>
	</div>
  
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>