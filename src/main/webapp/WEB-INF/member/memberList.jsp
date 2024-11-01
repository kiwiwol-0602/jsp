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
  	'use strict'
  	
  	function contentView(content) {
			$("#myModal #modalContent").text(content);
	}
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
						<td><a href="#" onclick="contentView('${vo.content}')" data-toggle="modal" data-target="#myModal">${vo.name}</a></td>
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
 		<!-- 블록페이지 시작 -->
	 <ul class="pagination justify-content-center" >
	    <li class="page-item">
	    	<c:if test="${pag>1}"><a class="page-link" href="MemberList.mem?pag=1">첫페이지</a></c:if>
				<c:if test="${pag <= 1}"><span class="page-link disabled">첫페이지</span></c:if>
	    </li>
	    <li class="page-item">
	    	<c:if test="${curBlock > 0}"><a class="page-link" href="MemberList.mem?pag=${((curBlock-1)*blockSize)+1}">이전블록</a></c:if>
	    	<c:if test="${curBlock <= 0}"><span class="page-link disabled">이전블록</span></c:if>
	    </li>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
				<c:if test="${i<=totPage && i==pag}"><li class="page-item active"><a class="page-link" href="MemberList.mem?pag=${i}">${i}</a></li></c:if>
				<c:if test="${i<=totPage && i!=pag}"><li class="page-item"><a class="page-link" href="MemberList.mem?pag=${i}">${i}</a></li></c:if>
			</c:forEach>
	    <li class="page-item">
	    	<c:if test="${curBlock < lastBlock}"><a class="page-link" href="MemberList.mem?pag=${((curBlock+1)*blockSize)+1}">다음블록</a></c:if>
	    	<c:if test="${curBlock >= lastBlock}"><span class="page-link disabled">다음블록</span></c:if>
	    </li>	
	    <li class="page-item">
	    	<c:if test="${pag<totPage}"><a class="page-link" href="MemberList.mem?pag=${totPage}">마지막페이지</a></c:if>
	    	<c:if test="${pag>=totPage}"><span class="page-link disabled">마지막페이지</span></c:if>
	    </li>
	  </ul>
<!-- 블록페이지 끝 -->	
 	</div>
<!-- The Modal -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
	    <div class="modal-content">
	    
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h3 class="modal-title">자기소개</h3>
	        <button type="button" class="close" data-dismiss="modal">×</button>
	      </div>
	      
	      <!-- Modal body -->
	      <div class="modal-body">
					<span id = "modalContent">${vo.content}</span>
	      </div>
	      
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	      
	    </div>
	  </div>
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