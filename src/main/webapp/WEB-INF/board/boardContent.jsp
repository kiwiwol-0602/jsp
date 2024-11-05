<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardContent.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
    function boardDelete() {
    	let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
    	if(ans) location.href = "BoardDelete.bo?idx=${vo.idx}";
    }
    
    // 좋아요 처리(중복 허용)
    function goodCheck1() {
    	$.ajax({
    		type : "post",
    		url  : "BoardGoodCheck.bo",
    		data : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res != "0") location.reload();
    		},
    		error : function() {
    			alert('전송오류');
    		}
    	});
    }
    
    // 좋아요/싫어요 처리(중복 허용)
    function goodCheck2(goodCnt) {
    	$.ajax({
    		type : "post",
    		url  : "BoardGoodCheck.bo",
    		data : {
    			idx : ${vo.idx},
    			goodCnt : goodCnt
    		},
    		success:function(res) {
    			if(res != "0") location.reload();
    		},
    		error : function() {
    			alert('전송오류');
    		}
    	});
    }
    
    // 좋아요 처리(중복 불허)
    function goodCheck3() {
    	$.ajax({
    		type : "post",
    		url  : "BoardGoodCheck3.bo",
    		data : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res != "0") location.reload();
    			else alert("이미 좋아요 버튼을 클릭하셨습니다.");
    		},
    		error : function() {
    			alert('전송오류');
    		}
    	});
    }
    
    // 모달에 기타내용 입력창 보여주기
    function etcShow() {
    	$("#claimTxt").show();
    }
    
    // 모달창에서 신고항목 선택후 '확인'버튼 클릭시 수행처리(ajax) 
    function claimCheck() {
    	if(!$("input[type=radio][name=claim]:checked").is(':checked')) {
    		alert("신고항목을 선택하세요");
    		return false;
    	}
    	if($("input[type=radio]:checked").val() == '기타' && $("#claimTxt").val() == '') {
    		alert("기타 사유를 입력해 주세요");
    		return false;
    	}
    	let claimContent = modalForm.claim.value;
    	if(claimContent == '기타'){
    		claimContent += '/' + $("#claimTxt").val();
    	}
    	
    	let query = {
    			part : 'board',
    			partIdx : ${vo.idx},
    			claimMId : '${sMid}',
    			claimContent : claimContent
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "BoardClaimInput.ad",
    		data : query,
    		success:function(res){
    			if(res != "0"){
    				alert("신고 되었습니다.");
    				location.reload();
    			}
    			else alert("신고 실패");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    	
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">글 내용 보기</h2>
  <table class="table table-bordered mt-5">
  	<tr>
      <td colspan="4">
      	<c:if test="${sMid != vo.mid && vo.claim == 'NO'}"><a href="#" data-toggle="modal" data-target="#myModal" class="btn btn-danger">신고하기</a></c:if>
      	<c:if test="${vo.claim != 'NO'}"><font color="red">현재 게시글은 신고된 글입니다.</font></c:if>
      </td>
  	</tr>
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글조회수</th>
      <td>${vo.readNum}</td>
    </tr>
    <tr>
      <th>글쓴날짜</th>
      <td>${vo.wDate}</td>
      <th>접속IP</th>
      <td>${vo.hostIp}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">
        ${vo.title}
        (<a href="javascript:goodCheck1()" title="좋아요">❤</a>(${vo.good})) /
        (<a href="javascript:goodCheck2(1)" title="좋아요">👍</a>(${vo.good})) /
        (<a href="javascript:goodCheck2(-1)" title="싫어요">👎</a>(${vo.good})) /
        (<a href="javascript:goodCheck3()" title="좋아요"><font color='blue'>♥</font></a>(${vo.good}))
      </td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:240px;">${fn:replace(vo.content, newLine, '<br/>')}</td>
    </tr>
  </table>
  <table class="table table-borderless">
    <tr>
      <c:if test="${sMid == vo.mid || sLevel == 0}">
	      <td colspan="2" class="text-left">
	        <c:if test="${sMid == vo.mid}">
	        	<input type="button" value="수정하기" onclick="location.href='BoardUpdate.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}'" class="btn btn-primary"/>
	        </c:if>
	        <input type="button" value="삭제하기" onclick="boardDelete()" class="btn btn-danger"/>
	      </td>
	      <td colspan="2" class="text-right">
	        <input type="button" value="돌아가기" onclick="location.href='BoardList.bo?pag=${pag}&pageSize=${pageSize}'" class="btn btn-warning"/>
	      </td>
      </c:if>
      <c:if test="${sMid != vo.mid && sLevel != 0}">
	      <td colspan="4" class="text-center">
	        <input type="button" value="돌아가기" onclick="location.href='BoardList.bo?pag=${pag}&pageSize=${pageSize}'" class="btn btn-warning"/>
	      </td>
      </c:if>
    </tr>
  </table>
</div>

<!-- The Modal 시작 -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">현재 게시글을 신고합니다.</h3>
        <button type="button" class="close" data-dismiss="modal">×</button>
      </div>
      <div class="modal-body">
        <b>신고사유 선택</b>
        <hr/>
        <form name="modalForm">
        	  <div><input type="radio" name="claim" id="claim1" value="광고,홍보,영리목적"/> 광고,홍보,영리목적</div>
            <div><input type="radio" name="claim" id="claim2" value="욕설,비방,차별,혐오"/> 설,비방,차별,혐오</div>
            <div><input type="radio" name="claim" id="claim3" value="불법정보"/> 불법정보</div>
            <div><input type="radio" name="claim" id="claim4" value="음란,청소년유해"/> 음란,청소년유해</div>
            <div><input type="radio" name="claim" id="claim5" value="개인정보노출,유포,거래"/> 개인정보노출,유포,거래</div>
            <div><input type="radio" name="claim" id="claim6" value="도배,스팸"/> 도배,스팸</div>
            <div><input type="radio" name="claim" id="claim7" value="기타" onclick="etcShow()"/> 기타</div>
            <div id="etc"><textarea rows="2" id="claimTxt" class="form-control" style="display:none"></textarea></div>
            <hr/>
            <input type="button" value="확인" onclick="claimCheck()" class="btn btn-success form-control" />
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- The Modal 끝 -->

<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>