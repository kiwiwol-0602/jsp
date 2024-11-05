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
		location.href= "BoardList.bo?pageSize="+pageSize+"&pag=1&idx=${idx}";
		}
	
	  function cursorMove() {
   	 document.getElementById("searchString").focus();
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">게시판 조건별 리스트</h2>
 	<div>
 		(<font color="blue">${searchTitle}</font>(으)로 <font color="blue">${searchString}</font>(를)을 검색한 결과 <font color="red">${searchCnt}</font>건이 검색되었습니다. )
 	</div>
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
    <%-- <c:set var="curScrStartNo" value="${curScrStartNo}"/> --%>
    <c:set var="curScrStartNo" value="${searchCnt}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
    	<c:if test="${vo.openSw == '공개' || sMid == vo.mid }">
		    <tr>
		      <td>${curScrStartNo}</td>
		      <td class="text-left">
		      	<c:if test="${vo.claim == 'NO' || sMId == vo.mid || sLevel == 0}"><a href="BoardContent.bo?idx=${vo.idx}&pag=${pag}">${vo.title}</a></c:if>
		      	<c:if test="${vo.claim != 'NO'&& sMId != vo.mid && sLevel != 0}"><a href="javascript:alert('현재글은 신고된 글입니다.')">${vo.title}</a></c:if>
		      </td>
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
<!-- 블록페이지 끝 -->
<br/>
<!-- 검색기 시작 -->
<!-- <div class="container text-center">
  <form name="searchForm" method="post" action="BoardSearchList.bo">
    <b>검색 : </b>
    <select name="search" id="search" onchange="cursorMove()">
      <option value="title">글제목</option>
      <option value="nickName">글쓴이</option>
      <option value="content">글내용</option>
    </select>
    <input type="text" name="searchString" id="searchString" required />
    <input type="submit" value="검색" class="btn btn-secondary btn-sm"/>
  </form>
</div> -->
<!-- 검색기 끝 -->

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">자기소개</h3>
        <button type="button" class="close" data-dismiss="modal">×</button>
      </div>
      <div class="modal-body">
        <span id="modalContent">${vo.content}</span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>