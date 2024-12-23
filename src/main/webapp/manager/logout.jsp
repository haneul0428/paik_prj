<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그아웃"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
localStorage.removeItem("returnUrl");
</script>
<%
	session.invalidate();
	response.sendRedirect("http://localhost/paik_prj/manager/index.jsp");
%>