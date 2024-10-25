<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>guestList.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <style>
  	th{
  		text-align: center;
  		background-color: #eee;
  	}
  </style>
  <script>
  	'use strict'
  	
  	function deleteCheck(idx) {
			let ans = confirm("선택한 방명록을 삭제하시겠습니까?");
			if(ans){
				location.href = "GuestDeleteOk.gu?idx="+idx;
			}
	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<jsp:include page="/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <h2 class="text-center">방 명 록 리 스 트</h2>
  
  <!-- 글쓰기 / 관리자 버튼 -->
  <br/>
  <table class="table table-borderless m-0 p-0">
  	<tr>
  		<td class="text-left">
			<!-- <input type="button" value="등록" onclick="location.href=''" class="btn btn-success" /> -->
  			<a href="GuestInput.gu" class="btn btn-outline-success" >등록</a>
	  		<c:if test="${sAdmin == null}">
  				<a href="GuestAdmin.gu" class="btn btn-outline-warning" >관리자</a>
  			</c:if>
	  		<c:if test="${sAdmin != null}">
  				<a href="GuestAdminOut.gu" class="btn btn-outline-warning" >관리자로그아웃</a>
  			</c:if>
  		</td>
  		<td class="text-right">
  			<c:if test="${pag > 1}">
	  			<a href="GuestList.gu?pag=1" title="첫페이지">◁◁</a>
	  			<a href="GuestList.gu?pag=${pag-1}" title="이전페이지">◀</a>
	  		</c:if>
  			<c:if test="${pag <= 1}">
	  			<span class="disabled" style="color:skyblue">◁◁</span>
	  			<span class="disabled" style="color:skyblue">◀</span>
	  		</c:if>
	  		${pag} / ${totPage}
  			<c:if test="${pag < totPage}">
	  			<a href="GuestList.gu?pag=${pag+1}" title="다음페이지">▶</a>
	  			<a href="GuestList.gu?pag=${totPage}" title="마지막페이지">▷▷</a>
	  		</c:if>
  			<c:if test="${pag >= totPage}">
	  			<span class="disabled" style="color:skyblue">▶</span>
	  			<span class="disabled" style="color:skyblue">▷▷</span>
	  		</c:if>
  		</td>
  	</tr>
  </table>
  
  <!-- 방명록 내용 -->
  <c:set var="curScrStartNo" value="${curScrStartNo}"/>
  <c:forEach var="vo" items="${vos}" varStatus="st">
	  <table class ="table table-borderless m-0 p-0">
	  	<tr>
	  		<td class="text-left">
	  			번호 : ${curScrStartNo}
	  			<c:if test="${sAdmin == 'adminOk'}"><a href="javascript:deleteCheck(${vo.idx})" class="btn btn-danger btn=sm">삭제</a></c:if>
	  		</td>
	  		<td class="text-right">
	  			IP : ${vo.hostIp} 
	  		</td>
	  	</tr>
	  </table>
	  <table class ="table table-bordered">
	  	<tr>
	  		<th style="width: 100px">글쓴이</th>
	  		<td> ${vo.name}</td>
	  		<th style="width: 100px">방문일자</th>
	  		<td> ${fn:substring(vo.visitDate,0,19)}</td>
	  	</tr>
	  	<tr>
	  		<th>Email</th>
	  		<td colspan="3"> <!-- vo.email == '' || vo. email == null -->
	  			<c:if test="${empty vo.email || fn:length(vo.email)<6 || fn:indexOf(vo.email,'@')==-1 || fn:indexOf(vo.email,'.')==-1}">- 없음 -</c:if>
	        <c:if test="${!empty vo.email && fn:length(vo.email)>=6 && fn:indexOf(vo.email,'@')!=-1 && fn:indexOf(vo.email,'.')!=-1}">${vo.email}</c:if>
	  		</td>
	  	</tr>
	  	<tr>
	  		<th>HomePage</th>
	  		<td colspan="3">
	  			<c:if test="${empty vo.homePage || fn:length(vo.homePage)<=10 || fn:indexOf(vo.homePage,'.')==-1}">- 없음 -</c:if>
        	<c:if test="${!empty vo.homePage && fn:length(vo.homePage)>10 && fn:indexOf(vo.homePage,'.')!=-1}"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></c:if>
	  		</td>
	  		<!--<td colspan="3"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></td> -->
	  	</tr>
	  	<tr>
	  		<th>Content</th>
	  		<td colspan="3"> ${fn:replace(vo.content, enter, "<br/>")}</td>
	  	</tr>
	  </table>
	  <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
	</c:forEach>
	
<!-- 블록페이지 시작 -->
	 <ul class="pagination justify-content-center" >
	    <li class="page-item">
	    	<c:if test="${pag>1}"><a class="page-link" href="GuestList.gu?pag=1">첫페이지</a></c:if>
				<c:if test="${pag <= 1}"><span class="page-link disabled">첫페이지</span></c:if>
	    </li>
	    <li class="page-item">
	    	<c:if test="${curBlock > 0}"><a class="page-link" href="GuestList.gu?pag=${((curBlock-1)*blockSize)+1}">이전블록</a></c:if>
	    	<c:if test="${curBlock <= 0}"><span class="page-link disabled">이전블록</span></c:if>
	    </li>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
				<c:if test="${i<=totPage && i==pag}"><li class="page-item active"><a class="page-link" href="GuestList.gu?pag=${i}">${i}</a></li></c:if>
				<c:if test="${i<=totPage && i!=pag}"><li class="page-item"><a class="page-link" href="GuestList.gu?pag=${i}">${i}</a></li></c:if>
			</c:forEach>
	    <li class="page-item">
	    	<c:if test="${curBlock < lastBlock}"><a class="page-link" href="GuestList.gu?pag=${((curBlock+1)*blockSize)+1}">다음블록</a></c:if>
	    	<c:if test="${curBlock >= lastBlock}"><span class="page-link disabled">다음블록</span></c:if>
	    </li>
	    <li class="page-item">
	    	<c:if test="${pag<totPage}"><a class="page-link" href="GuestList.gu?pag=${totPage}">마지막페이지</a></c:if>
	    	<c:if test="${pag>=totPage}"><span class="page-link disabled">마지막페이지</span></c:if>
	    </li>
	  </ul>
	<%-- <div class="text-center">
		<c:if test="${pag>1}">
			[<a href="GuestList.gu?pag=1">첫페이지</a>]
		</c:if>
		<c:if test="${curBlock > 0}">
			[<a href="GuestList.gu?pag=${((curBlock-1)*blockSize)+1}">이전블록</a>] 
		</c:if>
			<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
				<c:if test="${i<=totPage && i==pag}">
					[<a href="GuestList.gu?pag=${i}"><font color="red"><b>${i}</b></font></a>]
				</c:if>
				<c:if test="${i<=totPage && i!=pag}">
					[<a href="GuestList.gu?pag=${i}">${i}</a>]
				</c:if>
			</c:forEach>
		<c:if test="${curBlock < lastBlock}">
			[<a href="GuestList.gu?pag=${((curBlock+1)*blockSize)+1}">다음블록</a>]
		</c:if>
		<c:if test="${pag<totPage}">
			[<a href="GuestList.gu?pag=${totPage}">마지막페이지</a>]
		</c:if>
	</div> --%>
<!-- 블록페이지 끝 -->	
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>