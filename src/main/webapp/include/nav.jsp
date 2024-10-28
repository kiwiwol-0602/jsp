<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <%-- <a class="navbar-brand" href="${ctp}/">HOME</a> --%>
  <a class="navbar-brand" href="http://192.168.50.55:9090/javaGroup">HOME</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="GuestList.gu">Guest</a>
      </li>
      <c:if test="${!empty sNickName}">
	      <li class="nav-item">
	        <a class="nav-link" href="#">Board</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">Pds</a>
	      </li>
	      <li class="nav-item dropdown">
			    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
		    		Study
		   	  </a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="${ctp}/study2/mapping/Test1">Mapping(Directory Pattern)</a>
			      <a class="dropdown-item" href="${ctp}/study2/mapping/Test2">Mapping(Extension Pattern)</a>
			      <a class="dropdown-item" href="${ctp}/study2/mapping/Storage">Storage</a>
			      <a class="dropdown-item" href="${ctp}/study/1018_JSTL/el.jsp">EL</a>
			      <a class="dropdown-item" href="${ctp}/study2/jstl/JstlMenu">JSTL</a>
			      <a class="dropdown-item" href="${ctp}/study2/database/Dblist">Database</a>
			      <a class="dropdown-item" href="PassCheckForm.st">Encryption</a>
			    </div>
	      </li>
	      <li class="nav-item dropdown">
			    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
		    		MyPage
		   	  </a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="MemberMain.mem">회원메인방</a>
			      <a class="dropdown-item" href="#">쪽지보내기</a>
			      <a class="dropdown-item" href="#">포인트사용내역</a>
			      <a class="dropdown-item" href="#">일정관리</a>
			      <a class="dropdown-item" href="MemberUpdate.mem">회원정보수정</a>
			      <a class="dropdown-item" href="javascript:memberDelete()">회원탈퇴</a>
			      <a class="dropdown-item" href="#">관리자메뉴</a>
			    </div>
	      </li>
      </c:if>
      <li class="nav-item">
        <c:if test="${!empty sNickName}"><a class="nav-link" href="MemberLogout.mem">Logout</a></c:if>
        <c:if test="${empty sNickName}"><a class="nav-link" href="MemberLogin.mem">Login</a></c:if>
        
      </li>
      
    </ul>
  </div>
</nav>