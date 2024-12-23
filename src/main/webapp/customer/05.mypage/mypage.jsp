<%@page import="java.sql.SQLException" %>
<%@page import="customer.paik.CustomDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         info="마이페이지 화면" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<jsp:useBean id="cVO" class="customer.paik.CustomVO" scope="request"/>
<jsp:setProperty name="cVO" property="*"/>

<%
    CustomDAO cDAO = CustomDAO.getInstance();

    try {
        cVO = cDAO.selectCustomer(cusId);
    } catch (SQLException se) {
        se.printStackTrace();
    }//end catch

    if(cusId!=null){
        String phone1 = cVO.getPhone().substring(0, 3);
        String phone2 = cVO.getPhone().substring(4, 8);
        String phone3 = cVO.getPhone().substring(9, 13);
        pageContext.setAttribute("phone2", phone2);
        pageContext.setAttribute("phone3", phone3);
        pageContext.setAttribute("cVO", cVO);
    }

%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

    <link rel="shortcut icon" type="image/x-icon"
          href="http://localhost/paik_prj/customer/00.common/images/favicon.png">
    <title>빽스커피 | 마이페이지</title>


    <link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/05.mypage/css/paik_mypage.css">
    <link rel="stylesheet" id="theme-css-style-css"
          href="https://paikdabang.com/wp-content/themes/paikdabang/assets/css/style.css?ver=4.9.4" type="text/css"
          media="all"/>

    <link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon32x32.png" sizes="32x32"/>
    <link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon192x192.png" sizes="192x192"/>
    <link rel="apple-touch-icon-precomposed"
          href="http://localhost/paik_prj/customer/00.common/images/favicon180x180.png"/>
    <meta name="msapplication-TileImage"
          content="http://localhost/paik_prj/customer/00.common/images/favicon270x270.png"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $("#btnSubmit").click(function () {
                location.href = "http://localhost/paik_prj/customer/05.mypage/modify.jsp";
            });

            $("#changePass").click(function () {
                location.href = "http://localhost/paik_prj/customer/05.mypage/chkPass.jsp";
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
        <div class="sub_visual bg-paik">
            <div class="txt">
                <h1>마이페이지</h1>
            </div>
        </div>

        <div class="sub_section cmnt_wrap">
            <div class="container" style="max-width: 600px; margin: 0 auto;">
                <h2 class="headHTxt">마이페이지</h2>
                <form action="mypage_update_process.jsp" id="updateForm" method="post" style="margin-top: 50px;">
                    <div class="status">
                        <label for="id">아이디</label>
                        <input type="text" id="id" class="inputBox" value="${ cVO.cusId }" readonly/>
                    </div>
                    <div class="status">
                        <label for="name">이름</label>
                        <input type="text" id="name" class="inputBox" value="${ cVO.name }" readonly/>
                    </div>
                    <div class="status">
                        <label for="name">비밀번호</label>
                        <input type="button" class="btn btn-warning" id="changePass" value="비밀번호 변경"
                               style="margin-top: 15px; margin-bottom: 15px;">
                    </div>
                    <div class="status">
                        <label for="email">이메일</label>
                        <input type="email" id="email" name="email" class="inputBox" value="${ cVO.email }" readonly/>
                    </div>
                    <div class="status">
                        <label for="phone">휴대폰 번호</label>
                        <div class="inputContainer inputPhoneContainer">
                            <select id="phone1" name="phone1" class="inputPhoneBox" disabled>
                                <option value="010" <c:if test="${ phone1 eq 010 }">selected="selected"</c:if>>010
                                </option>
                                <option value="011" <c:if test="${ phone1 eq 011 }">selected="selected"</c:if>>011
                                </option>
                                <option value="016" <c:if test="${ phone1 eq 016 }">selected="selected"</c:if>>016
                                </option>
                                <option value="017" <c:if test="${ phone1 eq 017 }">selected="selected"</c:if>>017
                                </option>
                                <option value="018" <c:if test="${ phone1 eq 018 }">selected="selected"</c:if>>018
                                </option>
                                <option value="019" <c:if test="${ phone1 eq 019 }">selected="selected"</c:if>>019
                                </option>
                            </select>
                            <span class="dash">-</span>
                            <input type="text" id="phone2" name="phone2" class="inputPhoneBox" value="${ phone2 }"
                                   style="height: 48px;" maxlength="4" readonly/>
                            <span class="dash">-</span>
                            <input type="text" id="phone3" name="phone3" class="inputPhoneBox" value="${ phone3 }"
                                   style="height: 48px;" maxlength="4" readonly/>
                        </div>
                    </div>
                    <div class="status">
                        <label for="grade">회원 등급</label>
                        <c:if test="${ cVO.grade eq '0' }">
                            <input type="text" id="grade" class="inputBox" value="실버" readonly/>
                        </c:if>
                        <c:if test="${ cVO.grade eq '1' }">
                            <input type="text" id="grade" class="inputBox" value="골드" readonly/>
                        </c:if>
                    </div>
                    <div class="deleteBtn">
                        <input type="button" id="btnSubmit" class="btnSubmit" value="수정">
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