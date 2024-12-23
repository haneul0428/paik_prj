<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.CartItemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="ciVO" class="customer.paik.CartItemVO" scope="page"/>
<jsp:useBean id="ciaVO" class="customer.paik.CartItemArrVO" scope="page"/>
<jsp:setProperty property="*" name="ciVO"/>
<jsp:setProperty property="*" name="ciaVO"/>
<%-- <%= ciVO %>  --%>
<%-- <%= ciaVO %> --%>
<%
	String[] cartItemNumArr = request.getParameterValues("cartItemNumArr");
	String[] cartNumArr = request.getParameterValues("cartNumArr");
	String[] hiddenChk = request.getParameterValues("hiddenChk");
	int cnt = 0;
	int rowCnt = 0;
		
	CartItemDAO cDAO = CartItemDAO.getInstance();
	try {
		for( String checked : hiddenChk ){
			if(checked.equals("Y")){
				ciVO.setCartItemNum(Integer.parseInt(cartItemNumArr[cnt]));
				ciVO.setCartNum(Integer.parseInt(cartNumArr[cnt]));
				rowCnt = cDAO.orderCart(ciVO);
				
				cnt++;
			}//end if
		}//end for
	} catch(SQLException se){
		rowCnt = -1;
		se.printStackTrace();
	}
	
	pageContext.setAttribute("rowCnt", rowCnt);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://192.168.10.212/jsp_prj/common/css/main_20240911.css">

<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>


<style type="text/css">
/* CSS영역 => CSS 디자인 코드 작성 */

</style>
<script type="text/javascript">
/* JS 영역 => JS 코드 작성 */
var cnt = ${ rowCnt };
var msg = "문제가 발생했습니다. 나중에 다시 시도해주세요.";

if(cnt == 1){
	msg = "주문이 완료되었습니다."
	alert(msg);
	location.href="http://localhost/paik_prj/customer/03.cart/list_order.jsp";
} else if(cnt == 0){
	msg = "주문은 외부에서 실행할 수 없습니다.";
	alert(msg);
	history.back();
} else {
	alert(msg);
	history.back();	
}

$(function(){
	
}); // ready

</script>
</head>
<body>

</body>
</html>