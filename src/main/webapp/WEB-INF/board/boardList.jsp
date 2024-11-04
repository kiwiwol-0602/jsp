<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardList.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
  	'use strict'
  	
  	function pageSizeChange() {
		let pageSize = document.getElementById("pageSize").value;
		location.href= "BoardList.bo?pageSize="+pageSize+"&pag=${pag}&idx=${idx}";
	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">게 시 판 리 스 트</h2>
  <table class="table table-borderless mt-3 mb-0 p-0">
    <tr>
      <td><a href="BoardInput.bo" class="btn btn-success btn-sm">글쓰기</a></td>
    </tr>
  </table>
  <table class="table table-hover text-center">
    <tr class="table-secondary">
      <th>글번호</th>
      <th>글제목</th>
      <th>글쓴이</th>
      <th>글쓴날짜</th>
      <th>조회수(좋아요)</th>
    </tr>
    <c:set var="curScrStartNo" value="${curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
    	<c:if test="${vo.openSw == '공개' || sMid == vo.mid }">
		    <tr>
		      <td>${curScrStartNo}</td>
		      <td class="text-left"><a href="BoardContent.bo?idx=${vo.idx}&pag=${pag}">${vo.title}</a></td>
		      <td>${vo.nickName}</td>
		      <td>${vo.wDate}</td>
		      <td>${vo.readNum}</td>
		    </tr>
	    </c:if>
	    <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
    <tr><td colspan="5" class="m-0 p-0"></td></tr>
  </table>
  <br/>
</div>
<!-- 블록페이지 -->
<ul class="pagination justify-content-center" style="position: static;">
	<li class="page-item">
  	<c:if test="${pag>1}"><a class="page-link" href="BoardList.bo?pag=1">첫페이지</a></c:if>
		<c:if test="${pag <= 1}"><span class="page-link disabled">첫페이지</span></c:if>
 	</li>
 	<li class="page-item">
		<c:if test="${curBlock > 0}"><a class="page-link" href="BoardList.bo?pag=${((curBlock-1)*blockSize)+1}">이전블록</a></c:if>
 		<c:if test="${curBlock <= 0}"><span class="page-link disabled">이전블록</span></c:if>
 	</li>
	<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
		<c:if test="${i<=totPage && i==pag}"><li class="page-item active"><a class="page-link" href="BoardList.bo?pag=${i}">${i}</a></li></c:if>
		<c:if test="${i<=totPage && i!=pag}"><li class="page-item"><a class="page-link" href="BoardList.bo?pag=${i}">${i}</a></li></c:if>
	</c:forEach>
 	<li class="page-item">
 	 	<c:if test="${curBlock < lastBlock}"><a class="page-link" href="BoardList.bo?pag=${((curBlock+1)*blockSize)+1}">다음블록</a></c:if>
	 	<c:if test="${curBlock >= lastBlock}"><span class="page-link disabled">다음블록</span></c:if>
 	</li>
 	<li class="page-item">
 		<c:if test="${pag<totPage}"><a class="page-link" href="BoardList.bo?pag=${totPage}">마지막페이지</a></c:if>
 		<c:if test="${pag>=totPage}"><span class="page-link disabled">마지막페이지</span></c:if>
 	</li>
	<li style="float:right; padding-left: 50px">
		<select name="pageSize" id="pageSize" onchange="pageSizeChange()" class="form-control" style="width: 100px; height: 38px;" >
			<option value="3"   <c:if test="${pageSize == 3}">selected</c:if>  > 3</option>  		
			<option value="5"   <c:if test="${pageSize == 5}">selected</c:if>  > 5</option>  			
			<option value="10"  <c:if test="${pageSize == 10}">selected</c:if> > 10</option>  			
			<option value="15"  <c:if test="${pageSize == 15}">selected</c:if> > 15</option>  			
			<option value="20"  <c:if test="${pageSize == 20}">selected</c:if> > 20</option>  			
			<option value="30"  <c:if test="${pageSize == 30}">selected</c:if> > 30</option>  			
		</select>
	</li>
</ul>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>