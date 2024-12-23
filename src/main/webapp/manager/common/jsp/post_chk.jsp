<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
String method=request.getMethod().toUpperCase();
pageContext.setAttribute("method", method);
%>
<c:if test="${ method eq 'GET'}">
<c:redirect url="http://localhost/paik_prj/manager/index.jsp"/>
</c:if>
