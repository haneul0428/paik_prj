<%@page import="java.sql.SQLException"%>
<%@page import="manager.paik.menu.DrinkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="음료 추가 폼의 입력 정보 받기"
    %>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="pVO" class="manager.paik.menu.ProductVO" scope="page"/>
<jsp:useBean id="iVO" class="manager.paik.menu.IngredientVO" scope="page"/>
<jsp:useBean id="oVO" class="manager.paik.menu.DrinkOptionVO" scope="page"/>
<jsp:setProperty property="*" name="pVO"/>
<jsp:setProperty property="*" name="iVO"/>
<jsp:setProperty property="*" name="oVO"/>
<%-- <%= pVO %> --%>
<%
	boolean insertFlag = false;
	String categorieName = "";
	try {
		DrinkDAO dDAO = DrinkDAO.getInstance();
		dDAO.insertItem(pVO);			// item 테이블에 insert
		dDAO.insertIngredient(iVO);		//ingredient 테이블에 insert
		dDAO.insertDrinkOption(oVO);	//drink_option 테이블에 insert
		insertFlag = true;
		if(pVO.getCategoriesNum() == 0){
			pVO.setCategorieName("커피");
			categorieName = pVO.getCategorieName();
		} else if(pVO.getCategoriesNum() == 1){
			pVO.setCategorieName("음료");
			categorieName = pVO.getCategorieName();
		}
		//pVO.setCategorieName(categorieName);
	} catch(SQLException se){
		se.printStackTrace();
	}
	pageContext.setAttribute("insertFlag", insertFlag);
	pageContext.setAttribute("categorieName", categorieName);
%>
<!DOCTYPE html>
<html>
<head>
<script src="/docs/5.3/assets/js/color-modes.js"></script>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/orderStateList.css">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/orderDetails.css">
    <title>음료 추가</title>
	<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/manager/common/css/main_20240911.css">
    
	<!-- bootstrap -->
    <link href="bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />

    <!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>    
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	   
    <link rel="stylesheet" href="css@3.css">
    <meta name="theme-color" content="#712cf9"> 

	<script type="text/javascript">
	if(${ insertFlag } && ${ categorieName == "커피" } ){
		alert("커피 메뉴 추가에 성공했습니다.");
		location.href="selectCoffeeList.jsp"
	} else if(${ insertFlag } && ${ categorieName == "음료" } ){
		alert("음료 메뉴 추가에 성공했습니다.");
		location.href="selectDrinkList.jsp"		
	} else {
		alert("메뉴 추가에 문제가 발생했습니다. 잠시 후에 다시 시도해주세요.");
		history.back();
	}
    </script>
</head>
<body>
<script src="bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script src="chart.umd.js" integrity="sha384-eI7PSr3L1XLISH8JdDII5YN/njoSsxfbrkCTnJrzXt+ENP5MOVBxD+l6sEG4zoLp" crossorigin="anonymous"></script><script src="dashboard.js"></script></body>
</body>
</html>