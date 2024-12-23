<%@page import="java.sql.SQLException"%>
<%@page import="manager.paik.menu.DessertIceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="디저트/아이스크림 정보 삭제"
    %>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--관리자 세션을 검증하는 jsp include--%>
<%-- <jsp:include page="../common/jsp/manager_session_chk.jsp"/> --%>

<jsp:useBean id="pVO" class="manager.paik.menu.ProductVO" scope="page"/>
<jsp:setProperty name="pVO" property="*"/>

<%
	DessertIceDAO diDAO = DessertIceDAO.getInstance();
	int rowCnt = 0;
	
	try {
		rowCnt = diDAO.deleteItem(pVO);
	} catch(SQLException se){
		rowCnt = -1;
		System.out.println("상품 삭제 과정에서 문제 발생!");
		se.printStackTrace();
	}
	
	pageContext.setAttribute("rowCnt", rowCnt);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
var msg="문제가 발생했습니다. 잠시 후 다시 시도해주세요.";
var cnt = ${ rowCnt };
var flag = false;

if(cnt == 0){
	msg="삭제 과정은 외부에서 임의로 진행할 수 없습니다."
}//end if

if(cnt == 1){
	flag = true;
	msg="${ param.itemNum }번 상품을 성공적으로 삭제했습니다."
}//end if

alert(msg);

if(flag){// 삭제 성공
	location.href="selectIcecreamList.jsp?currentPage=${param.currentPage}";
} else {// 삭제 실패
	history.back();
}//end else
	
$(function(){
	
}); // ready	
</script>
</head>
<body>

</body>
</html>