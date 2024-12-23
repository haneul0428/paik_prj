<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="사용자 아이디찾기화면"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">
<title>빽스커피 | 아이디찾기</title>

<%
    String foundId= (String) session.getAttribute("foundId");
    String errorMsg = (String) session.getAttribute("errorMsg");
%>

<style type="text/css">

</style>

<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/06.customer/find/css/paik_find.css">
<link rel="stylesheet" id="theme-css-style-css"  href="https://paikdabang.com/wp-content/themes/paikdabang/assets/css/style.css?ver=4.9.4" type="text/css" media="all" />

<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon32x32.png" sizes="32x32" />
<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon192x192.png" sizes="192x192" />
<link rel="apple-touch-icon-precomposed" href="http://localhost/paik_prj/customer/00.common/images/favicon180x180.png" />
<meta name="msapplication-TileImage" content="http://localhost/paik_prj/customer/00.common/images/favicon270x270.png" />

<%-- bootstrap CDN --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<%-- jQuery CDN --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#okBtn").click(function() {
		$.ajax({
			url: 'clear_session.jsp',
			method: 'post',
			success: function() {
				window.location.replace("http://localhost/paik_prj/customer/06.customer/loginPage.jsp");
			}
		});//ajax
	});
});//ready()
</script>

</head>

<body>
<div id="wrap">
<div id="header">
<jsp:include page="/customer/00.common/jsp/header.jsp"/>
</div>

<div id="content-wrap">
<div class="sub_visual bg-class">
    <div class="txt">
        <h1>아이디 찾기</h1>
    </div>
</div>

<div class="sub_section cmnt_wrap">
	<div class="container" style="max-width: 600px; margin: 0 auto; text-align: center;">
		<h2 class="headHTxt">아이디 찾기</h2>
		<div id="findIdContainer">
			<c:choose>
				<c:when test="${not empty errorMsg}">
				<p style="color: red; margin-bottom: 10px;">${errorMsg}</p>
					<p class="txt">입력하신 이름이나 휴대폰 번호를 확인하고 다시 시도해주세요.</p>
				</c:when>
				<c:when test="${not empty foundId}">
					<p class="txt">회원님의 아이디는 <span class="resultTxt">${ foundId }</span>입니다.</p>
				</c:when>
			</c:choose>
			<input type="button" id="okBtn" class="okBtn" value="확인"/>
		</div>
	</div>
</div>
</div>

<div id="footer">
<jsp:include page="/customer/00.common/jsp/footer.jsp"/>
</div>
</div>

</body>
</html>