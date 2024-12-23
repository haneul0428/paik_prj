<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="../00.common/jsp/member_session_chk.jsp"/>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_normal.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <title>비밀번호 확인</title>
    <style>
        body {
            background-color: #e9ecef;
            font-family: 'Arial', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            width: 100%;
            max-width: 600px;
            padding: 40px;
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        h1 {
            font-size: 30px;
            color: #333;
            margin-bottom: 30px;
        }
        label {
            display: block;
            font-size: 18px;
            color: #555;
            margin-bottom: 10px;
        }
        input[type="password"] {
            width: 100%;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 18px;
            margin-bottom: 30px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        input[type="password"]:focus {
            border-color: #FFC300;
            outline: none;
        }
        .confirmBtn {
            width: 100%;
            padding: 15px;
            font-size: 20px;
            font-weight: bold;
            color: #fff;
            background-color: #FFC300;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .confirmBtn:hover {
            background-color: #FFA500;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#hideDiv").hide();

            $("#confirmBtn").click(function () {
                $("#confirmPass").submit();
            });

            $("#password").on("keydown", function (event) {
                if (event.originalEvent.getModifierState("CapsLock")) {
                    $("#hideDiv").show();
                }else {
                    $("#hideDiv").hide();
                }
            });
        })
    </script>
</head>
<body>
<div class="container">
    <h1>비밀번호 확인</h1>
    <form action="confirm_password_process.jsp" method="post" id="confirmPass">
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" required />
        <input type="button" id="confirmBtn" class="confirmBtn" value="확인"/>
    </form>
    <div id="hideDiv" ><p><strong style="color: red">Caps Lock이 켜져있습니다.</strong></p></div>
</div>
</body>