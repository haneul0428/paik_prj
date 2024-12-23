<%@page import="java.sql.SQLException"%>
<%@page import="manager.paik.menu.DessertIceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="디저트 정보 수정"
    %>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
%>
<%--관리자 세션을 검증하는 jsp include--%>
<%-- <jsp:include page="../common/jsp/manager_session_chk.jsp"/> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="pVO" class="manager.paik.menu.ProductVO" scope="page"/>
<jsp:useBean id="iVO" class="manager.paik.menu.IngredientVO" scope="page"/>
<jsp:setProperty name="pVO" property="*"/>
<jsp:setProperty name="iVO" property="*"/>
<%-- <%= pVO %> --%>
<%
	DessertIceDAO diDAO = DessertIceDAO.getInstance();
	int cnt1 = 0;//product
	//int cnt2 = 0;//ingredient
	
	//product
	try{
		if(pVO.getImage() == null){
			cnt1 = diDAO.updateItemImageless(pVO);			
		} else {
			cnt1 = diDAO.updateItem(pVO);
		}
	} catch(SQLException se){
		cnt1 = -1;
		System.out.println("상품 정보 수정 과정에서 문제 발생!");
		se.printStackTrace();
	}// end catch

	/* //ingredient
	try{
		cnt2 = diDAO.updateIngredient(iVO);		
	} catch(SQLException se){
		cnt2 = -1;
		System.out.println("상품 영양 정보 수정 과정에서 문제 발생!");
		se.printStackTrace();
	}// end catch */
	
	//System.out.println(cnt1);
	pageContext.setAttribute("cnt1", cnt1);
	//pageContext.setAttribute("cnt2", cnt2);
%>

<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
<script src="/docs/5.3/assets/js/color-modes.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/orderStateList.css">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/orderDetails.css">
    <title>디저트 상세 확인</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/dashboard/">
    
	<!-- bootstrap -->
    <link href="bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />

	<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>  

    <meta name="theme-color" content="#712cf9">    

	<script type="text/javascript">
	var msg = "DB에서 문제가 발생했습니다." // cnt = -1
	var cnt1 = ${ cnt1 };//product
	//var cnt2 = ${ cnt2 };//ingredient
		
/* 	if(cnt1 == 0 || cnt2 == 0) {
		msg = "상품 정보가 외부에서 임의로 편집되었습니다.";
	}// end if
		
	if(cnt1 == 1 && cnt2 == 1){
		msg = "상품 정보가 수정되었습니다.";
	}//end if
		 */
	if(cnt1 == 0) {
		msg = "상품 정보가 외부에서 임의로 편집되었습니다.";
	}// end if
		
	if(cnt1 == 1){
		msg = "상품 정보가 수정되었습니다.";
	}//end if
		
	alert(msg);
	
	if( (cnt1 == 0 || cnt1 == -1) ){
		history.back();
	} else {
		location.href="selectDessertList.jsp?currentPage=${ param.currentPage }";
	}	
	</script>

</head>
<body>

</body>
</html>