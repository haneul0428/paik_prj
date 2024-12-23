<%@page import="manager.paik.util.ProductUtil"%>
<%@page import="manager.paik.menu.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.SQLClientInfoException"%>
<%@page import="manager.paik.menu.DrinkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="음료 관리"
    %>
<%--관리자 세션을 검증하는 jsp include--%>
<jsp:include page="../common/jsp/manager_session_chk.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en" data-bs-theme="auto">
<head><script src="/docs/5.3/assets/js/color-modes.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">
    <title>음료 관리 페이지</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/dashboard/">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/project_main.css">
    <!-- Custom styles for this template -->
    <link href="http://localhost/paik_prj/manager/common/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="http://localhost/paik_prj/manager/common/css/dashboard.css" rel="stylesheet">
    
	<!-- bootstrap -->
    <link href="bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />

	<!-- jQuery -->
  	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <meta name="theme-color" content="#712cf9">
    <style>

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }
        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }

        .bd-mode-toggle .dropdown-menu .active .bi {
            display: block !important;
        }
        form { max-width: 750px; margin: 0 auto; }
        a {	text-decoration: none; color: #333;	}
		a:hover { text-decoration: underline; }
        span.active { padding: 10px; background-color: #00F200; border-radius: 45% }
		span.inactive { padding: 10px; background-color: #F20000; border-radius: 45% }
		#subject { width: 150px; height: 44px; }
		th, td {
			border: 1px solid #ddd;
			padding: 12px;
			text-align: left;
		}
		#drinkImg { width: 40px; height: 50px;}
		
		/* 숨기기 */
		.hidden {
		    display: none;
		}
        
    </style>

<script type="text/javascript">
//탭을 보여주는 함수
$(function(){
	$("#keyword").keyup(function(evt){
		if(evt.which == 13){
			chkNull();
		}//end if
	});//keyup
	
	$("#btn").click(function(){
		chkNull();
	});//click
	
	// 검색으로 선택한 컬럼명과 키워드 설정, JSP 코드로 작성 가능
	if(${ not empty param.keyword }){
		$("#keyword").val("${ param.keyword }");
	}
});//ready

function chkNull(){
	var keyword = $("#keyword").val();
	if(keyword.length < 2){
		alert("검색 키워드는 한 글자 이상 입력하셔야 합니다.");
		return;
	}//end if
	
	$("#searchFrm").submit();
}//chkNull

function loginMove(){
	if(confirm("로그인 한 사용자만 메뉴 추가가 가능합니다.\n로그인 하시겠습니까?")){
		location.href="../index.jsp";
	}//end if
}// loginMove
</script>

    <!-- Custom styles for this template -->
    <link href="bootstrap-icons.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="dashboard.css" rel="stylesheet">

</head>
<body>
<jsp:include page="../common/svg.jsp"/> <!-- svg -->
<jsp:include page="../common/headbar.jsp"/> <!-- headbar -->

<div class="container-fluid">
    <div class="row">
        <div class="border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
            <div class="offcanvas-md offcanvas-end bg-body-tertiary" tabindex="-1" id="sidebarMenu" aria-labelledby="sidebarMenuLabel">

                <div class="offcanvas-body d-md-flex flex-column p-0 pt-lg-3 overflow-y-auto">
                    <ul class="nav nav-pills flex-column">
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" aria-current="page" href="http://localhost/paik_prj/manager/dashboard/dashboard.jsp">
                                <i class="bi bi-house"></i>
                                관리자 대시보드
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2 active" href="http://localhost/paik_prj/manager/menu/selectCoffeeList.jsp">
                                <svg class="bi"><use xlink:href="#cup-hot"/></svg>
                                음료 관리
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/menu/selectDessertList.jsp">
                            	<svg class="bi"><use xlink:href="#cake"/></svg>
                                디저트&아이스크림 관리
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/order/selectNotReceivedOrderList.jsp">
                                <i class="bi bi-cart"></i>
                                	주문 관리
                            </a>                                                        
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/customer/list_customer.jsp">
                                <i class="bi bi-people"></i>
                                회원 관리
                            </a>
                        </li>
                    </ul>

                    <hr class="my-3">
                    <ul class="nav flex-column mb-auto">
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="#">
                                <svg class="bi"><use xlink:href="#door-closed"/></svg>
                                로그아웃
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        
        <jsp:useBean id="sVO" class="manager.paik.menu.SearchVO" scope="page"/>
        <jsp:setProperty property="*" name="sVO"/>
        <%
        //게시판 리스트 구현
        //1-1. 총 음료 레코드 수 구하기
        
        int totalCount = 0;
        DrinkDAO dDAO = DrinkDAO.getInstance();
        try{
        	totalCount = dDAO.selectTotalCountDrink(sVO);
        	//System.out.println(totalCount);
        } catch(SQLException se){
        	se.printStackTrace();
        }
        //2-1. 한 화면에 보여줄 커피 레코드의 수
        int pageScale = 10;
        
        //3-1. 총 커피 페이지 수
        int totalPage = (int)Math.ceil((double)totalCount/pageScale);
        
        //4-1 커피 검색의 시작 번호를 구하기(pagination의 번호)
        String paramPage = request.getParameter("currentPage");
        
        int currentPage = 1;
        if(paramPage != null){
        	try{
        		currentPage = Integer.parseInt(paramPage);
        	} catch(NumberFormatException nfe) {
        		nfe.printStackTrace();
        	}// end catch
        }//end if
        
        int startNum = currentPage * pageScale - pageScale + 1; // 커피 시작 번호
        
        // 5-1. 끝 번호 구하기
        int endNum = startNum + pageScale - 1; // 커피 끝 번호
        
        sVO.setCurrentPage(currentPage);
        sVO.setStartNum(startNum);
        sVO.setEndNum(endNum);
        sVO.setTotalPage(totalPage);
        sVO.setTotalCount(totalCount);
               
        //System.out.println(csVO.getStartNum() + ", " + csVO.getEndNum());
        
        List<ProductVO> listBoard = null;
        try{
        	listBoard = dDAO.selectDrinkBoard(sVO);//시작 번호, 끝 번호를 사용한 게시글 조회
        	
/*         	String tempName="";
        	for(ProductVO tempVO : listBoard){
        		tempName = tempVO.getiNameK();
        		if(tempName.length() > 30){
        			tempVO.setiNameK(tempName.substring(0,29) + "...");
        		}// end if
        	}// end for */
        } catch(SQLException se){
        	se.printStackTrace();
        }//end catch
        
   	 	pageContext.setAttribute("totalCount", totalCount);
    	pageContext.setAttribute("pageScale", pageScale); 
    	pageContext.setAttribute("totalPage", totalPage);
     	pageContext.setAttribute("currentPage", currentPage);
    	pageContext.setAttribute("startNum", startNum);
    	pageContext.setAttribute("endNum", endNum);	 
    	pageContext.setAttribute("listBoard", listBoard);	
        
        %>
<%-- 	총 게시물의 수: <c:out value="${ totalCount }"/><br>
	한 화면에 보여줄 게시물의 수: <c:out value="${ pageScale }"/><br>
	총 페이지 수: <c:out value="${ totalPage }"/><br>
	현재 페이지: <c:out value="${ currentPage }"/><br>
	게시글의 시작 번호: <c:out value="${ startNum }"/><br>
	게시글의 끝 번호: <c:out value="${ endNum }"/><br> --%>	
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2"><strong>음료 메뉴 관리</strong></h1>
            </div>
      	<div class="btn-group" role="group" aria-label="Basic radio toggle button group" style="margin-bottom: 30px;">
		  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off">
		  <label class="btn btn-outline-primary" for="btnradio1"><a href="selectCoffeeList.jsp" style="color:#0d6efd;">커피 메뉴</a></label>
		
		  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" checked>
		  <label class="btn btn-outline-primary" for="btnradio2"><a href="selectDrinkList.jsp" style="color:#FFF; font-weight: bold;">음료 메뉴</a></label>
		</div>
		<div id="drinkList" style="width: 750px; margin: 0 auto;">
        <table id="coffeeChart">
        <thead>
            <tr>
                <th style="width: 100px;">상품번호</th>
                <th>음료 이름</th>
                <th style="width: 100px;">가격</th>
                <th style="width: 100px;">카테고리</th>
            </tr>
        </thead>
        <tbody>
        <c:if test="${ empty listBoard }">
        <tr>
        	<td style="text-align: center" colspan="4">
        	현재 메뉴가 없습니다.<br>
        	<a href="insertDrink.jsp">메뉴 추가</a>
        	</td>
        </tr>
        </c:if>
        
        <c:if test="${ not empty param.keyword }"> <!-- 파라메터 변수가 있을 경우 -->
		<c:set var="searchParam" value="&keyword=${ param.keyword }"/>
		</c:if>
		        
        <c:forEach var="pVO" items="${ listBoard }" varStatus="i">
        <tr>
        	<!-- var.VO의 변수명 -->
        	<td><c:out value="${ pVO.itemNum }"/></td>
        	<td><a href="selectDetailDrink.jsp?itemNum=${ pVO.itemNum }&currentPage=${ currentPage }${ searchParam }">
        	<c:out value="${ pVO.iNameK }"/></a></td>
        	<td><c:out value="${ pVO.price }"/></td>
        	<td><c:out value="${ pVO.categorieName }"/></td>
        </tr>
        </c:forEach>
        </tbody>
        </table>
        <!-- search -->
		<div id="search" style="width: 750px; height: 60px; text-align: center;">
		<form action="selectDrinkList.jsp" method="get" id="searchFrm" name="searchFrm">
			<input type="text" name="keyword" id="keyword" style="width: 200px"/>
			<input type="button" value="검색" id="btn"  class="btn btn-primary btn-sm"/>
		</form>
			<input type="text" name="keyword" style="display: none"/><!-- 엔터키 눌러도 검색되는 것을 방지 -->
		</div> 
		<!-- search end -->
		<!-- pagination -->
		<ul class="pagination justify-content-center">
		<% sVO.setUrl("selectDrinkList.jsp"); %>
		<%= new ProductUtil().pagination(sVO) %>
		</ul>
		<!-- pagination end -->
		</div>	
			<c:set var="loginFlag" value="javascript:loginMove()"/>
			<c:if test="${ not empty managerId }">
			<c:set var="loginFlag" value="insertDrink.jsp"/>
			</c:if>
        	<button class="btn btn-primary" style="border:none; float: right; margin-left: 10px; border-radius: 20px; padding: 10px;">
        		<a href="${ loginFlag }" style="color:#FFF; font-weight: bold;">
        		<svg class="bi"><use xlink:href="#plus-circle"/></svg> 음료 추가</a>
        	</button>
            <canvas class="my-4 w-100" id="myChart" width="900" height="380"></canvas>
        </main>
    </div>
</div>
<script src="bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script src="chart.umd.js" integrity="sha384-eI7PSr3L1XLISH8JdDII5YN/njoSsxfbrkCTnJrzXt+ENP5MOVBxD+l6sEG4zoLp" crossorigin="anonymous"></script><script src="dashboard.js"></script>
</body>
</html>