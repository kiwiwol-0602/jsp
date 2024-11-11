<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%  pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pdsContent.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script src="https://kit.fontawesome.com/0c69fdf2c0.js" crossorigin="anonymous"></script>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
    h6 {
			position: fixed;
			right: 1rem;
			bottom: -50px;
			transition: 0.7s ease;
		}
		.on {
			opacity: 0.8;
			cursor: pointer;
			bottom: 0;
		}
		
		/*별점에 스타일 설정하기*/
		#reviewForm fieldset{
			direction: rtl;
		}
		
		#reviewForm input[type=radio]{
			display: none;
		}

		#reviewForm label {
			color: transparent;
			text-shadow: 0 0 0 #f0f0f0;
		}
		
		#reviewForm label:hover {
			text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
		}
		
		#reviewForm label:hover ~ label{
			text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
		}
		#reviewForm input[type=radio]:checked ~ label{
			text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
		}
		
		
  </style>
  <script>
  	'use strict'
  	
  	//	화살표클릭시 화면 상단이동(부드럽게)
  	$(window).scroll(function(){
      if($(this).scrollTop() > 50){
         $("#topBtn").addClass("on");
      }
      else{
         $("#topBtn").removeClass("on");
      }
      $("#topBtn").click(function() {
				window.scrollTo({top:0, behavior: "smooth"});	
			});
   	});
  	
  	//리뷰 등록하기
  	function reviewCheck() {
			let star = reviewForm.star.value;
			let review = reviewForm.review.value;
			
			if(star == ""){
				alert("별점을 부여해 주세요");
			}
			/* else if(review.trim() == ""){
				alert("리뷰를 입력해 주세요");
				reviewForm.review.focus();
			} */
			alert("별점 : "+star);
	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">자료실 내용 상세보기</h2>
  <br/>
  <table class="table table-bordered text-center">
    <tr>
      <th>올린이</th>
      <td>${vo.nickName}</td>
      <th>올린날짜</th>
      <td>${vo.fDate}</td>
    </tr>
    <tr>
      <th>파일명</th>
      <td>
				<c:set var="fNames" value="${fn:split(vo.fName,'/')}"/>
        <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
        <c:forEach var="fName" items="${fNames}" varStatus="st">
          <c:if test="${sLevel != 1}"><a href="${ctp}/images/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/></c:if>
          <c:if test="${sLevel == 1}">${fName}<br/></c:if>
        </c:forEach>          
        (<fmt:formatNumber value="${vo.fSize/1024}" pattern="#,##0" />KByte)
      </td>
      <th>다운횟수</th>
      <td>${vo.downNum}</td>
    </tr>
    <tr>
      <th>분류</th>
      <td>${vo.part}</td>
      <th>접속아이피</th>
      <td>${vo.hostIp}</td>
    </tr>
    <tr>
      <th>상세내역</th>
      <td colspan="3" class="text-left">
      	${fn:replace(vo.content,newLine,"<br/>")}
      </td>
    </tr>
  </table>
  <br/>
  <div class="text-center"><a href="PdsList.pds" class="btn btn-warning">돌아가기</a></div>
  <hr/>
  
  <!-- 리뷰 작성하기 -->
  <div>
  	<form name="reviewForm" id="reviewForm" action="#">
  		<fieldset style="border:0px">
  			<div class="text-left">
  				<input type="radio" name="star" value="5" id="start1"><label for="start1"><i class="fa-solid fa-star fa-2x"></i></label> 
  				<input type="radio" name="star" value="4" id="start2"><label for="start2"><i class="fa-solid fa-star fa-2x"></i></label> 
  				<input type="radio" name="star" value="3" id="start3"><label for="start3"><i class="fa-solid fa-star fa-2x"></i></label> 
  				<input type="radio" name="star" value="2" id="start4"><label for="start4"><i class="fa-solid fa-star fa-2x"></i></label> 
  				<input type="radio" name="star" value="1" id="start5"><label for="start5"><i class="fa-solid fa-star fa-2x"></i></label> 
  			</div>
  		</fieldset>
  		<div class="m-0 p-0">
  			<textarea rows="3" name="review" id="review" class="form-control mb-1" placeholder="후기를 남겨주시면 포인트를 지급합니다."></textarea>
  		</div>
  		<div>
  			<input type="button" value="별점/리뷰등록" onclick="reviewCheck()" class="btn-primary form-control"/>
  		</div>
  	</form>
  </div>
  <br/>
  <!-- 자료실에 등록된 자료가 사진이라면, 아래쪽에 사진들을 모두 보여준다. -->
  <div class="text-center">
    <c:forEach var="fSName" items="${fSNames}" varStatus="st">
    	${st.count}. ${fNames[st.index]}<br/>
    	<c:set var="len" value="${fn:length(fSName)}" />
    	<c:set var="ext" value="${fn:substring(fSName, len-3, len)}" />
    	<c:set var="extLower" value="${fn:toLowerCase(ext)}" />
    	<c:if test="${extLower == 'jpg' || extLower == 'gif' || extLower == 'png'}">
    	  <img src="${ctp}/images/pds/${fSName}" width="90%" />
    	</c:if>
    	<hr/>
    </c:forEach>
  </div>
  
  <!-- 위로가기 버튼 -->
  <h6 id="topBtn" class="text-right mr-3"><i class="fa-solid fa-circle-chevron-up fa-2x"></i></h6>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>