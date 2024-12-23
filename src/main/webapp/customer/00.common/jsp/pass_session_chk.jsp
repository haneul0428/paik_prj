<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    // 현재 접속하고 있는 URL을 저장한다. ( 꼭 리다이렉트 전에 해야함 )
    String currentUrl = request.getRequestURI().toString();
    pageContext.setAttribute("currentUrl", currentUrl);

%>
<%-- 관리자 세션 체크--%>
<c:if test="${empty cusPass}" >
    <script type="text/javascript">
        // 현재 URL 저장
        localStorage.setItem("returnUrl","${currentUrl}");
        //alert("이 페이지는 로그인이 필요한 페이지입니다.");
        location.href="http://localhost/paik_prj/customer/customer/modify/chkPass.jsp"
    </script>
</c:if>
