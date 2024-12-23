<%@ page contentType="text/html;charset=UTF-8" language="java" info="" trimDirectiveWhitespaces="true"%>
<%
    Boolean passwordVerified = (Boolean) session.getAttribute("passwordVerified"); // 비밀번호 검증 여부 세션에서 가져오기
    if(passwordVerified !=null) {
        session.removeAttribute("passwordVerified");
    }
%>
