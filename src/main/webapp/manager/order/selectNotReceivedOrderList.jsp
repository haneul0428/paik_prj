<%@page import="kr.co.sist.chipher.DataDecryption"%>
<%@page import="manager.paik.util.OrderUtil"%>
<%@page import="manager.paik.order.OrderVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="manager.paik.order.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="주문 관리 페이지"
    %>
<%--관리자 세션을 검증하는 jsp include--%>
<%-- <jsp:include page="../common/jsp/manager_session_chk.jsp"/> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/orderStateList.css">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/orderDetails.css">
    <title>미수령 주문 상태 확인</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/dashboard/">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/project_main.css">
    <!-- Custom styles for this template -->
    <link href="http://localhost/paik_prj/manager/common/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="http://localhost/paik_prj/manager/common/css/dashboard.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    
	<!-- bootstrap -->
    <link href="bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />

	<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>  
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
        
        form { max-width: 900px; margin: 0 auto; }
        th { text-align: center; }
        
		 /* 상태에 따른 색상 */
		.status {
		    font-weight: bold;
		    border-radius: 20px;
		    padding: 10px;
		}
		
		.completed {
		    background-color: #4CAF50;
		    color: white;
		}
		
		.pending {
		    background-color: #FFA500;
		    color: white;
		}       
    </style>
    <style>
        .search-bar { margin-bottom: 20px; }
        .search-bar input { padding: 8px; width: 300px; }
        .search-bar button { padding: 8px 16px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        .actions button { margin-right: 5px; padding: 6px 12px; cursor: pointer; border: none; color: white; }
        .edit-btn { background-color: #FFD700; }
        .delete-btn { background-color: #FF0000; }
        .add-member { background-color: #4CAF50; color: white; border: none; padding: 10px 20px; cursor: pointer; }
        .orderCode { cursor: pointer; }
        
        .received { padding: 10px; color: #000; background-color: #00F200; border-radius: 45% }
		.not-received { padding: 10px; color: #000; background-color: #F20000; border-radius: 45% }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; }
        .close:hover, .close:focus { color: black; text-decoration: none; cursor: pointer; }
        .confirm-delete { background-color: #FF0000; color: white; border: none; }
        .cancel-delete { background-color: #f2f2f2; color: black; border: 1px solid #ddd; }
        #drinkImg { width: 40px; height: 50px;}
        a { text-decoration: none; }
    </style>

    <script type="text/javascript">
	    // 탭을 보여주는 함수
	    $(function(){
			$(".changeReceive").click(function(){
				//alert("asdf");
				
				if(confirm("상태를 변경하시겠습니까?")){
					var cartItemNumber = $(this).parent().find(".cartItemNumber").val();
					var cartNum = $(this).parent().find(".cartNum").val();
					//alert(cartItemNumber);
					//alert(cartNum);
					
					var param = { "cartItemNumber" : cartItemNumber, "cartNum" : cartNum };
					
					$.ajax({
						url: "change_receive_process.jsp",
						type: "post",
						data: param,
						dataType: "json",
						error:function(xhr){
							console.log(xhr.status);
						},
						success:function(jsonObj){
							if(jsonObj.result){//post 방식으로 잘 실행되었을 경우
								if(jsonObj.update){//양 변경에 성공했을 경우
									alert("상태를 변경했습니다.");
									var url = "http://localhost/paik_prj/manager/order/selectNotReceivedOrderList.jsp";
									if(${ not empty param.currentPage }){
										url += "?currentPage=${ param.currentPage }"
									}//end if
									location.href=url;
								} else {
									alert("상태 변경에 실패했습니다.");
								}
							}//end if
						}//success
					});//ajax
				}
			});//click
	    });//ready
	    

	    // 테이블 정렬 함수
	    let sortDirection = true; // true는 오름차순, false는 내림차순
	    function sortTable(columnIndex, tableId) {
	        let table = document.getElementById(tableId);
	        let rows = Array.from(table.querySelectorAll('tbody tr'));
	        let isDateColumn = columnIndex === 1; // 날짜 정렬
	
	        rows.sort((rowA, rowB) => {
	            let cellA = rowA.cells[columnIndex].innerText;
	            let cellB = rowB.cells[columnIndex].innerText;
	
	            if (isDateColumn) {
	                // 날짜 형식 비교 (YYYY-MM-DD)
	                return sortDirection ? new Date(cellA) - new Date(cellB) : new Date(cellB) - new Date(cellA);
	            } else {
	                // 문자열을 숫자로 변환해서 비교 (주문 ID)
	                return sortDirection ? cellA.localeCompare(cellB, undefined, {numeric: true}) : cellB.localeCompare(cellA, undefined, {numeric: true});
	            }
	        });
	
	        // 정렬된 행들을 테이블에 다시 추가
	        let tbody = table.querySelector('tbody');
	        tbody.innerHTML = '';
	        rows.forEach(row => tbody.appendChild(row));
	
	        // 다음 정렬 방향 반전
	        sortDirection = !sortDirection;
	    }
    </script>
    <script type="text/javascript">
        function openPopup() {
            document.getElementById('popupBackground').style.display = 'block';
        }

        function closePopup() {
            document.getElementById('popupBackground').style.display = 'none';
        }
    </script>
    
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
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/menu/selectCoffeeList.jsp">
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
                            <a class="nav-link d-flex align-items-center gap-2 active" href="http://localhost/paik_prj/manager/order/selectNotReceivedOrderList.jsp">
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
        
        <jsp:useBean id="sVO" class="manager.paik.order.SearchVO" scope="page"/>
        <jsp:setProperty property="*" name="sVO"/>
        <%
        //게시판 리스트 구현
        //1-1. 총 커피 레코드 수 구하기
        
        int totalCount = 0;
        OrderDAO oDAO = OrderDAO.getInstance();
        try{
        	totalCount = oDAO.selectTotalCountNotReceived(sVO);
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
        
        //out.print(sVO);
               
        //System.out.println(csVO.getStartNum() + ", " + csVO.getEndNum());
        
        List<OrderVO> listBoard = null;
        try{
        	listBoard = oDAO.selectNotReceivedList(sVO);//시작 번호, 끝 번호를 사용한 게시글 조회
        	
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
        
        DataDecryption dd = new DataDecryption("abcdef0123456789");
   	 	pageContext.setAttribute("totalCount", totalCount);
    	pageContext.setAttribute("pageScale", pageScale); 
    	pageContext.setAttribute("totalPage", totalPage);
     	pageContext.setAttribute("currentPage", currentPage);
    	pageContext.setAttribute("startNum", startNum);
    	pageContext.setAttribute("endNum", endNum);	 
    	pageContext.setAttribute("listBoard", listBoard);	
    	pageContext.setAttribute("dd", dd);	
        
        %>
        
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	    <h1 class="h2"><strong>주문 상태 리스트</strong></h1>
	</div>
    
	<div class="btn-group" role="group" aria-label="Basic radio toggle button group" style="margin-bottom: 30px;">
	  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
	  <label class="btn btn-outline-primary" for="btnradio1"><a href="selectNotReceivedOrderList.jsp" style="color:#FFF; font-weight: bold;">미수령 주문</a></label>
	
	  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
	  <label class="btn btn-outline-primary" for="btnradio2"><a href="selectReceivedOrderList.jsp" style="color:#0d6efd;">수령한 주문</a></label>
	</div>
	
    <form action="change_receipt_" name="notReceivedList" id="notReceivedList" method="post">
    <!-- 미수령 주문 -->
    <table id="not-received">
        <thead>
            <tr>
                <th class="sortable" onclick="sortTable(0, 'not-received')">번호 @</th>
                <th>상품 이름</th>
                <th class="orderPopup" onclick="openPopup()">주문자</th>
                <th class="sortable" onclick="sortTable(3, 'not-received')">주문 시간 @</th>
                <th>주문 수량</th>
                <th>주문 상태</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        <c:if test="${ empty listBoard }">
        <tr>
        	<td style="text-align: center" colspan="6">
        	현재 미수령한 주문이 없습니다.<br>
        	</td>
        </tr>
        </c:if>
        <c:forEach var="oVO" items="${ listBoard }" varStatus="i">
        <tr>
        	<!-- var.VO의 변수명 -->
        	<!-- 번호, 상품 이름, 주문자, 주문 시간, 주문 수량, 주문 상태 -->
        	<td>ON_<c:out value="${ oVO.cartItemNum }"/></td>
        	<td><a href="selectDetailCoffee.jsp?cartItemNum=${ oVO.cartItemNum }&currentPage=${ currentPage }">
        	<c:out value="${ oVO.iNameK }"/></a></td>
        	<td><c:out value="${ dd.decrypt(oVO.name) }"/></td>
        	<td><c:out value="${ oVO.inputDate }"/></td>
        	<td><c:out value="${ oVO.quantity }"/></td>
        	<td>
        	<c:if test="${ oVO.receiptFlag eq 'N' }">
        	<span class="status pending">미수령</span>
        	</c:if>
        	</td>
        	<td>
        	<input type="button" class="changeReceive btn btn-warning btn-sm" value="변경">
        	<input type="hidden" class="cartItemNumber" value="${ oVO.cartItemNumber }">
        	<input type="hidden" class="cartNum" value="${ oVO.cartNum }">
        	</td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
   	<!-- pagination -->
	<ul class="pagination justify-content-center">
	<% sVO.setUrl("selectNotReceivedOrderList.jsp"); %>
	<%= new OrderUtil().pagination(sVO) %>
	</ul>
	<!-- pagination end -->
    </form>
			<canvas class="my-4 w-100" id="myChart" width="900" height="650"></canvas>
        </main>
    </div>
</div>
	
    <!-- 팝업 배경 -->
    <div id="popupBackground" class="popup-background">
        <!-- 팝업 창 -->
        <div class="popup">
            <h1>주문 상세 정보</h1>

            <div class="order-info">
                <span>주문 번호: ON_001</span>
                <span>주문일자: 2024-10-11</span>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>상품명</th>
                        <th>수량</th>
                        <th>가격</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>아이스 아메리카노</td>
                        <td>1</td>
                        <td>₩3,000</td>
                    </tr>
                    <tr>
                        <td>사라다 빵</td>
                        <td>2</td>
                        <td>₩5,000</td>
                    </tr>
                </tbody>
            </table>

            <div class="customer-info">
                <span>주문자: 한잔만</span>
                <span>회원 등급: 실버</span>
            </div>

            <div class="total-amount">총 결제 금액: ₩13,000</div>

            <button class="close-btn" onclick="closePopup()">확인</button>
        </div>
    </div>
</body>
</html>
