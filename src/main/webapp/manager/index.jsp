<%@ page contentType="text/html;charset=UTF-8" language="java" info="EL에서 vo를 사용하는 방법" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/main_20240911.css">
<link rel="icon" type="image/png" sizes="16x16" href="../common/images/favicon-16x16.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<title>빽스커피 관리자 로그인</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #1a1a1a;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        color: #e0e0e0;
    }
    .login-container {
        background-color: #2c2c2c;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
        text-align: center;
        width: 300px;
    }
    h1 {
        color: #253F85;
        margin-bottom: 1.5rem;
        font-size: 1.5rem;
    }
    input {
        display: block;
        width: 100%;
        padding: 0.7rem;
        margin-bottom: 1rem;
        border: 1px solid #253F85;
        border-radius: 4px;
        background-color: #3a3a3a;
        color: #e0e0e0;
        box-sizing: border-box;
    }
    input::placeholder {
        color: #aaa;
    }
    .submitBtn{
        background-color: #253F85;
        color: white;
        border: none;
        padding: 0.7rem 1rem;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
        width: 100%;
        font-size: 1rem;
    }
    button:hover {
        background-color: #253F85;
    }
    .logo {
        width: 80px;
        height: 80px;
        margin-bottom: 1rem;
        background-color: #253F85;
        border-radius: 50%;
        display: inline-flex;
        justify-content: center;
        align-items: center;
        font-size: 2rem;
        color: white;
    }
</style>

<script>
    $(function () {
        $("#submitBtn").click(function () {
            chk_NotEmpty();
        });
    });

    function chk_NotEmpty() {
        if ($("#managerId").val().replace(/ /g,"")==""){
            alert("아이디를 입력하지 않으셨습니다.");
            $("#managerId").focus();
            return;
        }
        if($("#managerPass").val().replace(/ /g,"")=="") {
            alert("비밀번호를 입력하지 않으셨습니다.");
            $("#managerPass").focus();
            return;
        }
        chk_IdPass();
    }
    // 폼 전송
    function chk_IdPass() {
        $("#loginFrm").submit();
    }
</script>
</head>
<body>
<div class="login-container">
    <div class="logo">관</div>
    <h1>빽스커피 관리자 로그인</h1>
    <form method="post" action="login_process.jsp" id="loginFrm" name="loginFrm" >
        <input type="text" placeholder="아이디" required id="managerId" name="managerId"><%-- value="test" --%>
        <input type="password" placeholder="비밀번호" required id="managerPass" name="managerPass"><%-- value="test" --%>
        <input type="button" value="로그인" class="submitBtn" id="submitBtn"/>
    </form>
</div>
</body>
</html>