<%@ page contentType="text/html;charset=UTF-8" language="java" info=""  trimDirectiveWhitespaces="true" %>
<%@ page import="kr.co.sist.chipher.DataEncryption" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="customer.paik.CustomDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // 비밀번호 대문자 처리
    String inputPassword = request.getParameter("password").toLowerCase();
    String cusId = (String) session.getAttribute("cusId");

    try {
        inputPassword = DataEncryption.messageDigest("SHA-1", inputPassword);
    } catch (NoSuchAlgorithmException e) {
        e.printStackTrace();
    }

    boolean isVerified = false;

    if (cusId != null && inputPassword != null) {
        CustomDAO cDAO = CustomDAO.getInstance();
        try {
            isVerified = cDAO.compareToPass(inputPassword,cusId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (isVerified) {
            session.setAttribute("passwordVerified", true);

            // 이전 페이지로 리다이렉트
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            if (redirectUrl != null) {
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect("mypage.jsp");
            }
        } else {
%>
<script>
    alert("비밀번호 검증에 실패하셨습니다.");
    window.location.href = "http://localhost/paik_prj/";
</script>
<%
        }
    } else {
        response.sendRedirect("http://localhost/paik_prj/index.jsp");
    }
%>