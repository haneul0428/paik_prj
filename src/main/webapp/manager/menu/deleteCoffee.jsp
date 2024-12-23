<%@page import="java.sql.SQLException"%>
<%@page import="manager.paik.menu.DrinkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="음료 정보 삭제"
    %>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--관리자 세션을 검증하는 jsp include--%>
<jsp:include page="../common/jsp/manager_session_chk.jsp"/>

<jsp:useBean id="pVO" class="manager.paik.menu.ProductVO" scope="page"/>
<jsp:setProperty name="pVO" property="*"/>

<%
	//음료 DAO 호출
	DrinkDAO dDAO = DrinkDAO.getInstance();
	int rowCnt = 0;
	
	try {
		rowCnt = dDAO.deleteItem(pVO);//삭제 진행, rowCnt = 1
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

//외부 임의 실행 등으로 DAO 거치지 않고 삭제되었을 경우
if(cnt == 0){
	msg="삭제 과정은 외부에서 임의로 진행할 수 없습니다."
}//end if

//삭제 성공시
if(cnt == 1){
	flag = true;
	msg="${ param.itemNum }번 상품을 성공적으로 삭제했습니다."
}//end if

//alert 메시지 출력
alert(msg);

if(flag){// 삭제 성공
	location.href="selectCoffeeList.jsp?currentPage=${param.currentPage}";
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