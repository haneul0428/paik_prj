<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="사용자 회원가입화면"
    %>
<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">

<title>빽스커피 | 회원가입</title>

<style type="text/css">
	.headHTxt{
		text-align: center;
		margin-top: 20px;
		margin-bottom: 20px;
	}
	table {
		width: 100%;
		border-collapse: collapse;
	}
	td {
		padding: 10px;
		vertical-align: top;
	}
	.contentTxt{
		padding-top: 38px;
		width: 130px;
		color: #333;
	}
 	.inputContainer {
		display: flex;
		flex-direction: column;
		margin-bottom: 5px;
	}
	.inputPhoneContainer{
		flex-direction: row;
		align-items: center;
	}
	.inputBox {
		width: calc(100% - 20px);
		padding: 10px;
		border: 1px solid #ccc;
		font-size: 16px;
		margin-top: 15px;
		padding: 10px;
		height: 46px;
	}
	.inputIdContainer {
		flex-direction: row;
		align-items: center;
	}
	.idDupBtn{
		width: 75px;
		margin-left: 5px;
		font-size: 13px;
		background-color: white;
		height: 46px;
		border: 1px solid #C9C9C9;
		color: #797979;
		cursor: pointer;
		padding-top: 4px;
	}
	.inputPhoneBox{
		width: calc(34% - 20px);
		padding: 10px;
		border: 1px solid #ccc;
		font-size: 16px;
		margin-top: 15px;
		padding: 10px;
	}
	.dash{
		margin-top: 7px;
		margin-left: 5px;
		margin-right: 5px;
	}
	.txt{
		color: #C9C9C9;
		font-size: 12px;
		margin-top: 5px;
	}
	.required {
		color: red;
	}
	.msg{
		margin-top: 5px;
		display: block;
		min-height: 20px;
	}
	.errorMsg {
		color: red;
		font-size: 12px;
		min-height: 20px;
	}
	.chkPassMsg{
		color: green;
		font-size: 12px;
		display: none;
		min-height: 20px;
	}
	.btnSubmit {
		width: 48%;
		padding: 10px;
		border: none;
		background-color: #FFE800;
		color: #FFFFFF;
		font-size: 16px;
		cursor: pointer;
		margin-top: 20px;
	}
	.btnReset{
		width: 48%;
		padding: 10px;
		border: 1px solid #FFE800;
		background-color: #FFFFFF;
		color: #FFE800;
		font-size: 16px;
		cursor: pointer;
		margin-top: 20px;
	}
	.sub_visual {
		background-size: cover;
		padding: 100px 0;
		text-align: center;
		min-height: 300px;
	}
	.sub_section {
		padding: 20px;
	}
</style>

<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_kl.css">
<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_normal.css">
<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_extend.css">
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
	var firstClickFlag = false;
	var isIdDupChecked = false;
	var isIdValid = false;
	$(".hidePass").hide();
	$(".hideChkPass").hide();
	
	$("#cusPass").on("keydown", function (event) {
        if (event.originalEvent.getModifierState("CapsLock")) {
            $(".hidePass").show();
        }else {
            $(".hidePass").hide();
        }
    });
	
	$("#chkPass").on("keydown", function (event) {
        if (event.originalEvent.getModifierState("CapsLock")) {
            $(".hideChkPass").show();
        }else {
            $(".hideChkPass").hide();
        }
    });
	
	//아이디 유효성 검증
	function validateId() {
		var cusId = $("#cusId").val().trim();
		
		if (cusId.length < 4 || cusId.length > 20 || !/^[a-z0-9]+$/.test(cusId)) {
			$("#idError").text("아이디는 영문 소문자와 숫자만 포함해야 하며, 4~20자여야 합니다.").css("color", "red").show();
			return false;
		}//if
		
		$("#idError").hide();
		return true;
	}//validateId()
	
	//아이디 중복 확인
	$("#idDupBtn").click(function() {
		isIdDupChecked = true;
		
		if (!validateId()) {
			return; //ID가 유효하지 않으면 중복 확인 X
		}//if

		var cusId = $("#cusId").val().trim();
		
		$.ajax({
			url: "checkIdDuplicate.jsp",
			type: "post",
			data: { cusId: cusId },
		    error: function(xhr) {
		        console.log(xhr.status);
		        alert("오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
		    },
			success: function(response) {
				if (response.trim() == "available") {
					$("#idError").text("사용 가능한 아이디입니다.").css("color", "green").show();
					isIdValid = true; //ID가 유효하고 중복이 아님
				} else {
					$("#idError").text("이미 사용 중인 아이디입니다.").css("color", "red").show();
					isIdValid = false; //ID가 중복됨
				}//if~el
				
				// 아이디 중복 확인을 했는지 확인
		        if (!isIdValid) {
		            alert("아이디가 중복되었습니다.");
		            return;
		        }//if
			}
		});//ajax
	});
	
	//비밀번호 유효성 검증
	function validatePass() {
		var cusPass = $("#cusPass").val().trim();
		
		if (cusPass.length < 8 || cusPass.length > 24 || !/(?=.*[a-zA-Z])(?=.*[0-9])/.test(cusPass)) {
			$("#passError").text("비밀번호는 8~24자이며, 영문 대소문자와 숫자를 모두 포함해야 합니다.").show();
			return false;
		}//if
		
		$("#passError").hide();
		return true;
	}//validatePass()
	
	//비밀번호확인 유효성 검증
	function validateChkPass() {
		var chkPass = $("#chkPass").val().trim();
		var cusPass = $("#cusPass").val().trim();
		
		if (chkPass == "") {
			$("#chkPassError").text("비밀번호확인을 입력해주세요.").show();
			$("#chkPassSuccess").hide();
			return false;
		} else if (chkPass != cusPass) {
			$("#chkPassError").text("비밀번호가 일치하지 않습니다.").show();
			$("#chkPassSuccess").hide();
			return false;
		}//if~el
		
		$("#chkPassError").hide();
		$("#chkPassSuccess").text("비밀번호가 일치합니다.").show();
		return true;
	}//validateChkPass()
	
	//이름 유효성 검증
	function validateName() {
		var name = $("#name").val().trim();
		
		if (name == "") {
			$("#nameError").text("이름을 입력해주세요.").show();
			return false;
		}//if
		
		$("#nameError").hide();
		return true;
	}//validateName()

	//휴대폰 번호 유효성 검증
	function validatePhone() {
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
	}//validatePhone()
	
	//이메일 유효성 검증
	function validateEmail() {
		var email = $("#email").val().trim();
		
		if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
			$("#emailError").text("이메일 형식이 올바르지 않습니다.").show();
			return false;
		}//if
		
		$("#emailError").hide();
		return true;
	}//validateEmail()
	
	//모든 입력칸 값의 유효성 검사 결과 반환
	function validateAll() {
		var isValid = false;
		var errMsg = "";
		var errFields = [];
		
		if(!validateId()){ errMsg += "\n아이디를 확인해주세요."; errFields.push("#cusId"); }//if
		if(!validatePass()){ errMsg += "\n비밀번호를 확인해주세요."; errFields.push("#cusPass"); }//if
		if(!validateChkPass()){ errMsg += "\n비밀번호와 비밀번호확인 입력값이 일치하지 않습니다."; errFields.push("#chkPass"); }//if
		if(!validateName()){ errMsg += "\n이름을 확인해주세요."; errFields.push("#name"); }//if
		if(!validatePhone()){ errMsg += "\n휴대폰번호를 확인해주세요."; errFields.push("#phone2"); }//if
		if(!validateEmail()){ errMsg += "\n이메일을 확인해주세요."; errFields.push("#email"); }//if
		
		//오류가 발생하는 입력칸 chk
		if(errFields.length != 0){
			$(errFields[0]).focus();
			alert("다음 항목을 확인하세요:" + errMsg);	//모든 오류 메시지를 alert로 표시
		} else {
			isValid = true;
		}//if~el
		
		return isValid;
	}//validateAll()

	$("#btnSubmit").click(function() {
		firstClickFlag = true;
		
		//모든 입력칸 값의 유효성 검사
		var isValids = validateAll();
		
		if (!isIdValid) {
            alert("아이디 중복 확인을 해주세요.");
            return;
        }//if
		
		if (isValids) {
			$("#memberFrm").submit();	//유효성 검사를 통과했을 경우 제출
		}//if
	});//#btnSubmit - click
	
	//각 입력칸 값 실시간 검증 수행
	$("#cusId, #cusPass, #chkPass, #name, #phone2, #phone3, #email").on("input", function() {
		//처음 클릭한 이후 실시간 검증 수행
		if (firstClickFlag) {
			validateId();
			validatePass();
			validateChkPass();
			validateName();
			validatePhone();
			validateEmail();
		}//if
	});
	
	$("#btnReset").click(function() {
		$(".errorMsg").hide();
		$("#chkPassSuccess").hide();
		firstClickFlag = false;	//리셋 버튼 클릭 시 모든 msg 초기화
	});//#btnReset - click
});//ready()
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
		<h1>회원가입</h1>
	</div>
</div>

<div class="sub_section cmnt_wrap">
	<div class="container" style="max-width: 600px; margin: 0 auto;">
		<h2 class="headHTxt">회원가입</h2>
		<form id="memberFrm" action="signup_process.jsp" method="post">
		<table>
			<tbody>
				<tr>
					<td class="contentTxt">
						<span class="required">• </span>
						<label for="cusId">아이디</label>
					</td>
					<td>
						<div class="inputContainer">
							<div class="inputIdContainer">
							<input type="text" id="cusId" name="cusId" class="inputBox" placeholder="아이디를 입력하세요" maxlength="20" style="width: calc(80% - 20px);"/>
							<input type="button" id="idDupBtn" class="idDupBtn" name="idDupBtn" value="ID중복확인"/>
							</div>
							<span class="txt">(영문소문자/숫자, 4~20자)</span>
						</div>
						<div class="msg">
							<span id="idError" class="errorMsg"></span>
						</div>
					</td>
				</tr>

				<tr>
					<td class="contentTxt">
						<span class="required">• </span>
						<label for="cusPass">비밀번호</label>
					</td>
					<td>
						<div class="inputContainer">
							<input type="password" id="cusPass" name="cusPass" class="inputBox" placeholder="비밀번호를 입력하세요" maxlength="24"/>
							<span class="txt">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~24자)</span>
						</div>
						<div class="msg" style="min-height: 40px;">
							<span id="passError" class="errorMsg"></span>
							<div class="hidePass"><p style="color: red; font-size: 12px;">Caps Lock이 켜져있습니다.</p></div>
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
							<input type="password" id="chkPass" name="chkPass" class="inputBox" placeholder="비밀번호를 확인하세요" maxlength="24"/>
						</div>
						<div class="msg" style="min-height: 40px;">
							<span id="chkPassError" class="errorMsg"></span>
							<span id="chkPassSuccess" class="chkPassMsg"></span>
							<div class="hideChkPass"><p style="color: red; font-size: 12px;">Caps Lock이 켜져있습니다.</p></div>
						</div>
					</td>
				</tr>
				
				<tr>
					<td class="contentTxt">
						<span class="required">• </span>
						<label for="name">이름</label>
					</td>
					<td>
						<div class="inputContainer">
							<input type="text" id="name" name="name" class="inputBox" placeholder="이름을 입력하세요"/>
						</div>
						<div class="msg">
							<span id="nameError" class="errorMsg"></span>
						</div>
					</td>
				</tr>
				
				<tr>
					<td class="contentTxt">
						<span class="required">• </span>
						<label for="phone1">휴대폰 번호</label>
					</td>
					<td>
						<div class="inputContainer inputPhoneContainer">
	            			<select id="phone1" name="phone1" class="inputPhoneBox">
	            				<option value="010" selected>010</option>
	            				<option value="011">011</option>
	            				<option value="016">016</option>
	            				<option value="017">017</option>
	            				<option value="018">018</option>
	            				<option value="019">019</option>
	            			</select>
	            			<span class="dash">-</span>
	            			<input type="text" id="phone2" name="phone2" class="inputPhoneBox" style="height: 48px;" maxlength="4"/>
	            			<span class="dash">-</span>
	            			<input type="text" id="phone3" name="phone3" class="inputPhoneBox" style="height: 48px;" maxlength="4"/>
						</div>
						<div class="msg">
							<span id="phoneError" class="errorMsg"></span>
						</div>
					</td>
				</tr>
				
				<tr>
					<td class="contentTxt">
						<span class="required">• </span>
						<label for="email">이메일</label>
					</td>
					<td>
						<div class="inputContainer">
							<input type="email" id="email" name="email" class="inputBox" placeholder="이메일을 입력하세요 (예. example@email.com)"/>
						</div>
						<div class="msg">
							<span id="emailError" class="errorMsg"></span>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<input type="reset" id="btnReset" class="btnReset" value="취소">
		<input type="button" id="btnSubmit" class="btnSubmit" value="가입하기">
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