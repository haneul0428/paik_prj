<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="사용자 비밀번호찾기화면"
    %>
<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">
<title>빽스커피 | 비밀번호찾기</title>

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
	var firstClickFlag = false;
	
	//아이디 입력 null 체크
	function chkId(){
		var cusId = $("#cusId").val().trim();
		
		if(cusId == ""){
			$("#idError").text("아이디를 입력해주세요.").show();
			return false;
		}//if
		
		$("#idError").hide();
		return true;
	}//chkId()
	
	//이름 입력 null 체크
	function chkName() {
		var name = $("#name").val().trim();
		
		if(name == ""){
			$("#nameError").text("이름을 입력해주세요.").show();
			return false;
		}//if
		
		$("#nameError").hide();
		return true;
	}//chkName()

	//휴대폰 입력 null 체크
	function chkPhone() {
		var phone2 = $("#phone2").val().trim();
		var phone3 = $("#phone3").val().trim();
		
		if (phone2 == "") {
			$("#phoneError").text("휴대폰 번호 중간자리를 입력해주세요.").show();
			return false;
		}//if
		
		if (phone2.length != 4 || !/^\d{4}$/.test(phone2)) {
			$("#phoneError").text("휴대폰 번호 중간자리는 숫자 4자입니다.").show();
			return false;
		}//if
		
		if (phone3 == "") {
			$("#phoneError").text("휴대폰 번호 끝자리를 입력해주세요.").show();
			return false;
		}//if
		
		if (phone3.length != 4 || !/^\d{4}$/.test(phone3)) {
			$("#phoneError").text("휴대폰 번호 끝자리는 숫자 4자입니다.").show();
			return false;
		}//if
		
		$("#phoneError").hide();
		return true;
	}//chkPhone()

	//모든 입력 null 체크
	function chkAll() {
		var isValid = false;
		var errMsg = "";
		var errFields = [];
		
		if(!chkId()){ errMsg += "\n아이디를 확인해주세요."; errFields.push("#cusId"); }//if
		if(!chkName()){ errMsg += "\n이름을 확인해주세요."; errFields.push("#name"); }//if
		if(!chkPhone()){ errMsg += "\n휴대폰번호를 확인해주세요."; errFields.push("#phone2"); }//if
		
		if(errFields.length != 0){
			$(errFields[0]).focus();
			alert("다음 항목을 확인하세요:" + errMsg);
		} else {
			isValid = true;
		}//if~el
		
		return isValid;
	}//chkAll()

	$("#findPassBtn").click(function() {
		firstClickFlag = true;
		
		var isChks = chkAll();
		
		if(isChks){
			$("#findPassFrm").submit();
		}//if~el
	});//findPassBtn - click

	//실시간 입력 검증
	$("#cusId, #name, #phone2, #phone3").on("input", function() {
		if (firstClickFlag) {
			chkId();
			chkName();
			chkPhone();
		}//if
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
        <h1>비밀번호 찾기</h1>
    </div>
</div>

<div class="sub_section cmnt_wrap">
    <div class="container" style="max-width: 600px; margin: 0 auto; text-align: center;">
        <h2 class="headHTxt">비밀번호 찾기</h2>
        <form action="findPass_process.jsp" id="findPassFrm" method="post">
            <div id="findPassContainer">
            <table>
            	<tr>
            		<td>
            			<label for="cusId" class="contentTxt">아이디</label>
            			<input type="text" id="cusId" name="cusId" class="inputBox" maxlength="20"/>
            			<div class="msg">
            				<span id="idError" class="idError"></span>
            			</div>
            		</td>
            	</tr>
            	<tr>
            		<td>
            			<label for="name" class="contentTxt">이름</label>
            			<input type="text" id="name" name="name" class="inputBox"/>
            			<div class="msg">
            				<span id="nameError" class="nameError"></span>
            			</div>
            		</td>
            	</tr>
            	<tr>
            		<td>
            			<label for="phone1" class="contentTxt">휴대폰 번호</label>
            			<select id="phone1" name="phone1" class="inputPhoneBox">
            				<option value="010" selected>010</option>
            				<option value="011">011</option>
            				<option value="016">016</option>
            				<option value="017">017</option>
            				<option value="018">018</option>
            				<option value="019">019</option>
            			</select>
            			 - <input type="text" id="phone2" name="phone2" class="inputPhoneBox" style="height: 48px;" maxlength="4"/>
            			 - <input type="text" id="phone3" name="phone3" class="inputPhoneBox" style="height: 48px;" maxlength="4"/>
            			 <div class="msg">
            			 	<span id="phoneError" class="phoneError"></span>
            			 </div>
            		</td>
            	</tr>
            	<tr>
            		<td><input type="button" id="findPassBtn" class="findPassBtn" value="확인"/></td>
            	</tr>
            </table>
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