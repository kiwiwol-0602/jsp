<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>t01_imageTest.jsp</title>
	<jsp:include page="/include/bs4.jsp"/>
	<script>

		function fCheck() {  
 			let imagesAddr = myform.images.value;
			let img = "<img src='"+imagesAddr+"'width='500px'/>";
			document.getElementById("demo").innerHTML=img;
		}
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
<h2>그림 파일 출력</h2>
<pre>
콤보상자에 출력 할 그림 파일명을 보여주고,
그 그림파일명을 선택하면 demo레이어에 선택된 그림 파일을 출력하시오.
</pre>

	<form name="myform">
		<select name="images" id="images" class="form-control">
			<option value="">선택</option>
			<option value="<%=request.getContextPath()%>/images/11.jpg">11.jpg</option>
			<option value="<%=request.getContextPath()%>/images/12.jpg">12.jpg</option>
			<option value="<%=request.getContextPath()%>/images/13.jpg">13.jpg</option>
			<option value="<%=request.getContextPath()%>/images/14.jpg">14.jpg</option>
			<option value="<%=request.getContextPath()%>/images/15.jpg">15.jpg</option>
			<option value="<%=request.getContextPath()%>/images/16.jpg">16.jpg</option>
		</select>
		<div><input type="button" value="그림출력" onclick="fCheck()" class="btn btn-success mt-2"/></div>
		<hr/>
	</form>
	<div id="demo"></div>
</div>
<p><br/></p>
</body>
</html>