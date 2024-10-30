<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String mid = (String) session.getAttribute("sMid");
	pageContext.setAttribute("mid", mid);
	//if(mid == null || mid.equals("")) response.sendRedirect(request.getContextPath()+"/");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>.ajaxTest.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <script>
  	'use strict'
  	
		if(('${mid}' == null) || ('${mid}' == '')) {
       alert("로그인후 사용하세요");
       location.href = '${ctp}/';
    }
  	
  	function idCheck(mid) {
  		if(mid == ""){
  			alert("아이디를 입력하세요");
  			myform.mid.focus();
  			return "0";
  		}
  	}
  
  	function idCheck0() {
  		let mid = myform.mid.value.trim();
  		let flag = idCheck(mid);
  		if(flag != "0"){
  			location.href = "AjaxIdCheck0.st?mid="+mid;
  		}
		}
  	// 브라우저 프로토콜 중 하나인 XMLHttpRequest 이용 방법
  	function idCheck1() {
      let mid = myform.mid.value.trim();
      let flag = idCheck(mid);
      if(flag == "0") return false;
      
      let xhr = new XMLHttpRequest(); 
      xhr.open("GET", "AjaxIdCheck1.st?mid="+mid);
      xhr.send();
      
      xhr.onreadystatechange = function(){
        if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
          document.getElementById("demo").innerHTML = xhr.responseText;
        }
      };
    }
  	// jQuery의 비동기식 ($.ajax())
  	function idCheck2() {
      let mid = myform.mid.value.trim();
      let flag = idCheck(mid);
      if(flag == "0") return false;
      
      $.ajax({
    	//key : value, key : value, key : value - json방식
    		type : "get", // type,url만 필수 입력자료
    		url  : "AjaxIdCheck2", // 디렉토리 패턴
				data : {"mid" : mid}, // 필수아님 
			//dataType : "json", 여기부터 밑에는 다 생략 가능 왜 적는거냐 하
			//contextType : "application/json",
			//charset : "utf-8",
			//timeout : 10000,
				beforeSend : function () {
					console.log("mid(전) : ", mid);
				},
				success : function (res) {
					console.log("mid(ajax처리후) : ", res);
					let str = "<font color='blue'>검색아이디 : "+mid+", 성명 : <b>"+res+"</b></font>"
					$("#demo").html(str);
				},
				error : function () {
					alert("전송오류");
				},
				complete : function () {
					console.log("mid(후) : ", mid);
				}
      });
    }
  	// 1. 최대포인트를 가진 사람을 구하시오
  	function pointCheck1() {
      $.ajax({
    		type : "get", // type,url만 필수 입력자료
    		url  : "AjaxPointCheck", // 디렉토리 패턴
			
				success : function (res) {
					$("#demo").html(res);
				},
				error : function () {
					alert("전송오류");
				}
      });
    }
  	// 2.최대포인트를 가진 사람을 구하시오
  	function pointCheck2() {
      $.ajax({
    		type : "get", // type,url만 필수 입력자료
    		url  : "AjaxPointCheck.st", // 확장자 패턴
			
				success : function (res) {
					let str = "";
					let resArray = res.split("/");
					str += '<div class="bg-secondary p-2"><font color="white">';
					str += '아이디: <b>'+resArray[0]+'</b></br>';
					str += '성명: <b>'+resArray[1]+'</b></br>';
					str += '포인트: <b>'+resArray[2]+'</b></br>';
					str += '</font></div>';
					$("#demo").html(str);					
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
  <h2>HTTP통신</h2>
  <div>
  	<form name="myform" action="#">
  		아이디:
  		<input type="text" name="mid" id="mid" class="form-control mb-2"/>
  		<div>
  			<input type="button" value="아이디검색(동기식)" onclick="idCheck0()" class="btn btn-success mr-2"/>
  			<input type="button" value="아이디검색(비동기식-XMLHttpRequest)" onclick="idCheck1()" class="btn btn-primary mr-2"/>
  			<input type="button" value="아이디검색(비동기식-jQuery(ajax))" onclick="idCheck2()" class="btn btn-secondary mr-2"/>
  			<input type="button" value="최대포인트수혜자1" onclick="pointCheck1()" class="btn btn-info mr-2"/>
  			<input type="button" value="최대포인트수혜자2" onclick="pointCheck2()" class="btn btn-info mr-2"/>
  		</div>
  	</form>
		<hr/>
		<div id="demo"><font color="blue">출력결과(검색된 성명) : <b>${param.name}</b></font></div>  
  </div>
  <hr/>
  <pre>
  	<h4>HTTP통신</h4>
  	▶ 동기식(Synchronous) : 먼저 시작된 하나의 작업이 끝날때까지 다른 작업들은 시작하지않고 기다렸다가,
  	앞의 작업이 모두 완료되면 새로운 작업을 시작하는 방식이다.
  	▶ 비동기식 (Asynchronous) : 먼저 시작된 작업의 완료여부와 상관없이 새로운 작업을 시작하는 방식
  		- 바닐라 자바스크립트의 비동기식 : 브라우저의 XMLHttpRequest
  		- ECMA6 자바스크립트의 비동기식 : 콜백함수, Promise, Promise를 활용한 async/await, 그리고 fetch(방식)
  		- JQuery에서 제공해주는 비동기식 : $.ajax()
  		
  	<h4>AJax</h4>
  	▶ AJAX(Asynchronous Javascript And Xml)
  		자바스크립 라이브러리중의 하나이며, 브라우저의 XMLHttpRequest를 이용하지않고도 페이지 일부를 새로고칠 수 있도록 하는 기술
  		예전에는 XML방식을 많이 사용하였으나, 지금은 JSON방식을 주로 사용하기에 AJAX기법이 많이 사용되고 있다.
  		
  	<h5>AJAX에서 사용(RestAPI)하는 메소드 종류</h5>
  	- GET : 데이트를 읽거나 주로 검색시에 사용한다.
  	- POST : 새로운 리소스를 생성할 때 사용한다.
  	- PUT : 리소스를 생성/업데이트할 때 사용한다.
  	- DELETE : 지정된 리소스를 삭제할 때 사용한다.
  </pre>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>