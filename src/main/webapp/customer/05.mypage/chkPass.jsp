<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원 인증 화면"
    %>

<%
	request.setCharacterEncoding("UTF-8");
	// 현재 접속하고 있는 URL을 저장 (반드시 리다이렉트 전에 수행)
	String currentUrl = request.getRequestURI();
	session.setAttribute("currentUrl", currentUrl); // 세션에 현재 URL 저장

	// 로그인 여부 체크
	String cusId = (String) session.getAttribute("cusId"); // 로그인된 사용자의 ID 세션에서 가져오기
	Boolean passwordVerified = (Boolean) session.getAttribute("passwordVerified"); // 비밀번호 검증 여부 세션에서 가져오기

	// 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
	if (cusId == null || cusId.isEmpty()) {
		// 로그인되지 않았을 때 로컬 스토리지에 현재 URL을 저장하고 로그인 페이지로 리다이렉트
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("<script type=\"text/javascript\">\n" +
				"    localStorage.setItem('returnUrl', '" + currentUrl + "');\n" +
				"    alert('이 페이지는 로그인이 필요한 페이지입니다.');\n" +
				"    location.href = 'http://localhost/paik_prj/customer/06.customer/loginPage.jsp';\n" +
				"</script>");
		return;
	}
	// 로그인 되어 있으나 패스워드 검증이 안 된 경우, 비밀번호 인증 페이지로 리다이렉트
	if (passwordVerified == null || !passwordVerified) {
		// 패스워드 인증이 필요하면 인증 페이지로 리다이렉트
		response.sendRedirect("http://localhost/paik_prj/customer/05.mypage/confirm_password.jsp");
		return;
	}
%>


<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">
<title>빽스커피 | 비밀번호변경</title>

<style type="text/css">

</style>

<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/05.mypage/css/paik_chgPass.css">
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
$(function() {
	$("#cusPass").blur(function(){
		cusValidatePass();
	});

	$("#newPass").blur(function(){
		newValidatePass();
	});
	
	$("#chkPass").blur(function(){
		validateChkPass();
	});
	
	$("#btnSubmit").click(function() {
		if($("#cusPass").val().trim() == ""){
			alert("비밀번호를 입력해주세요");
			return;
		}//end if

		if($("#newPass").val().trim() == ""){
			alert("새 비밀번호를 입력해주세요");
			return;
		}//end if
		
		if($("#chkPass").val().trim() == ""){
			alert("새 비밀번호를 확인해주세요");
			return;
		}//end if
		
		/* if(confirm("정말 회원 탈퇴를 진행하시겠습니까?")){
		} */
		$("#memberFrm").submit();			
	});//click
});//ready()

//비밀번호 유효성 검증
function cusValidatePass() {
	var cusPass = $("#cusPass").val().trim();
	
	if (cusPass.length < 8 || cusPass.length > 16 || !/(?=.*?[a-zA-Z])(?=.*?[0-9])/.test(cusPass)) {
		$("#passError1").text("비밀번호는 8~24자이며, 영문 대소문자와 숫자를 모두 포함해야 합니다.").show();
		return false;
	}//if

	
	$("#passError1").hide();
	return true;
}//validatePass()

//비밀번호 유효성 검증
function newValidatePass() {
	var newPass = $("#newPass").val().trim();
	
	if (newPass.length < 8 || newPass.length > 16 || !/(?=.*[a-zA-Z])(?=.*[0-9])/.test(newPass)) {
		$("#passError2").text("비밀번호는 8~24자이며, 영문 대소문자와 숫자를 모두 포함해야 합니다.").show();
		return false;
	}//if
	
	$("#passError2").hide();
	return true;
}//validatePass()

//비밀번호확인 유효성 검증
function validateChkPass() {
	var chkPass = $("#chkPass").val().trim();
	var newPass = $("#newPass").val().trim();
	
	if (chkPass == "") {
		$("#chkPassError").text("비밀번호확인을 입력해주세요.").show();
		$("#chkPassSuccess").hide();
		return false;
	} else if (chkPass != newPass) {
		$("#chkPassError").text("비밀번호가 일치하지 않습니다.").show();
		$("#chkPassSuccess").hide();
		return false;
	}//if~el
	
	$("#chkPassError").hide();
	$("#chkPassSuccess").text("비밀번호가 일치합니다.").show();
	return true;
}//validateChkPass()

</script>

</head>

<body>
<div id="wrap">
<div id="header">
<jsp:include page="/customer/00.common/jsp/header.jsp"/>
</div>

<div id="content-wrap">
<div class="sub_visual bg-paik">
	<div class="txt">
		<h1>비밀번호 변경</h1>
	</div>
</div>

<div class="sub_section cmnt_wrap">
	<div class="container" style="max-width: 600px; margin: 0 auto;">
		<h2 class="headHTxt">비밀번호 변경</h2>
		<form id="memberFrm" action="chkPass_process.jsp" method="post">
		<table>
			<tbody>
				<tr>
					<td class="contentTxt">
						<span class="required">• </span>
						<label for="cusPass">현재 비밀번호</label>
					</td>
					<td>
						<div class="inputContainer">
							<input type="password" id="cusPass" name="cusPass" class="inputBox" placeholder="비밀번호를 입력하세요" maxlength="16"/>
							<span class="txt">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~24자)</span>
						</div>
						<div class="msg">
							<span id="passError1" class="errorMsg"></span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="contentTxt">
						<span class="required">• </span>
						<label for="newPass">새 비밀번호</label>
					</td>
					<td>
						<div class="inputContainer">
							<input type="password" id="newPass" name="newPass" class="inputBox" placeholder="비밀번호를 입력하세요" maxlength="16"/>
							<span class="txt">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~24자)</span>
						</div>
						<div class="msg">
							<span id="passError2" class="errorMsg"></span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="contentTxt">
						<span class="required">• </span>
						<label for="chkPass">비밀번호 확인</label>
					</td>
					<td>
						<div class="inputContainer">
							<input type="password" id="chkPass" name="chkPass" class="inputBox" placeholder="비밀번호를 입력하세요" maxlength="16"/>
						</div>
						<div class="msg">
							<span id="chkPassError" class="errorMsg"></span>
							<span id="chkPassSuccess" class="chkPassMsg"></span>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="deleteBtn">
		<input type="button" id="btnSubmit" class="btnSubmit" value="확인" >
		</div>
	</form>
	</div>
</div>
</div>
<div id="footer">
<jsp:include page="/customer/00.common/jsp/footer.jsp"/>
</div>
</div>
</body>
</html>