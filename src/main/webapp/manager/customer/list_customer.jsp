<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="manager.paik.customer.CustomerDAO" %>
<%@ page import="manager.paik.customer.CustomerVO" %>
<%@ page import="java.util.List" %>
<%@ page import="manager.paik.customer.CustomerUtil" %>
<%@ page import="kr.co.sist.chipher.DataDecryption" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%--관리자 세션을 검증하는 jsp include--%>
<%@ include file="../common/jsp/manager_session_chk.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!doctype html>
<html lang="kor" data-bs-theme="auto">
<head><script src="/docs/5.3/assets/js/color-modes.js"></script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">
    <title>회원 관리 페이지</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/dashboard/">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/project_main.css">
    <!-- Custom styles for this template -->
    <link href="http://localhost/paik_prj/manager/common/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="http://localhost/paik_prj/manager/common/css/dashboard.css" rel="stylesheet">

    <!-- bootstrap -->
    <link href="bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
    <!-- jQuery CDN 시작 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

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
        #listCustomerDiv { max-width: 900px; margin: 0 auto  }
        a {	text-decoration: none; color: #333;	}
        a:hover { text-decoration: underline; }
        span.active { padding: 10px; color: #FFF; background-color: #4CAF50; border-radius: 20px }
        span.inactive { padding: 10px; color: #FFF; background-color: #CC0000; border-radius: 20px }
        #subject { width: 150px; height: 44px; }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        #none{display: none}
    </style>
    <script>
        $(function () {
            // 엔터 + 클릭일 떄 chknull();
            $("#keyword").keyup(function (evt) {
                if(evt.which==13){
                    chkNull();
                }
            });

            $("#searchBtn").click(function () {
                chkNull();
            });

            // 검색으로 선택한 컬럼명과 키워드를 설정(JSP코드로 작성가능하다.)
            if(${not empty param.keyword}){
                $("#field").val("${param.field}");
                $("#keyword").val("${param.keyword}");
            }
        });

        function chkNull() {
            var keyword = $("#keyword").val();
            if(keyword.length<1){
                alert("검색 키워드는 1글자 이상 입력하셔야 합니다.");
                return;
            }
            $("#searchFrm").submit();
        }

    </script>

</head>
<body>
<jsp:include page="../common/svg.jsp"/> <!-- svg -->
<jsp:include page="../common/headbar.jsp"/> <!-- headbar -->

<div class="container-fluid">
    <div class="row">
        <div class="border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary" style="height: 910px">
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
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/order/selectNotReceivedOrderList.jsp">
                                <i class="bi bi-cart"></i>
                                주문 관리
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2 active" href="http://localhost/paik_prj/manager/customer/list_customer.jsp">
                                <i class="bi bi-people"></i>
                                회원 관리
                            </a>
                        </li>
                    </ul>

                    <hr class="my-3">
                    <ul class="nav flex-column mb-auto">
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/logout.jsp">
                                <svg class="bi"><use xlink:href="#door-closed"/></svg>
                                로그아웃
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2"><strong>회원관리</strong></h1>
                <jsp:useBean id="sVO" scope="page" class="manager.paik.customer.SearchVO"/>
                <jsp:setProperty name="sVO" property="*"/>
            </div>
            <%
                sVO.setField(CustomerUtil.numToField(sVO.getField()));


                int totalCount = 0;
                CustomerDAO cDAO = CustomerDAO.getInstance();
                try {
                    totalCount = cDAO.countCustomer(sVO);
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                //한 페이지에 회원 10명 보여줄 것.
                int pageScale = 10;
                int totalPage = (int) Math.ceil(((double) totalCount / pageScale));
                String paramPage = request.getParameter("currentPage");

                int currentPage = 1;

                if (paramPage != null) {
                    try {
                        currentPage = Integer.parseInt(paramPage);
                    } catch (NumberFormatException e) {
                    }
                }
                // 시작 레코드 번호
                int startNum = currentPage * pageScale - pageScale + 1;
                // 마지막 레코드 번호
                int endNum = startNum + pageScale - 1;

                // 그걸 sVO에 담는다.
                sVO.setStartNum(startNum);
                sVO.setEndNum(endNum);
                sVO.setCurrentPage(currentPage);
                sVO.setTotalPage(totalPage);
                sVO.setTotalCount(totalCount);

                List<CustomerVO> listCustomer = null;
                try {
                    listCustomer = cDAO.selectAllCustomer(sVO); // 시작 번호, 끝 번호를 사용한 게시글을 조회한다.

                } catch (SQLException e) {
                    e.printStackTrace();
                }
                DataDecryption dd = new DataDecryption("abcdef0123456789");
                pageContext.setAttribute("startNum", startNum);
                pageContext.setAttribute("endNum", endNum);
                pageContext.setAttribute("currentPage", currentPage);
                pageContext.setAttribute("totalPage", totalPage);
                pageContext.setAttribute("totalCount", totalCount);
                pageContext.setAttribute("listCustomer", listCustomer);
                pageContext.setAttribute("pageScale", pageScale);
                pageContext.setAttribute("dd", dd);
            %>
            <div class="search-bar">
                <form action="list_customer.jsp" method="get" name="searchFrm" id="searchFrm">
                    <select id="field" name="field" style="width: 100px; height: 44px;">
                        <option value="0" >ID</option>
                        <option value="1">이름</option>
                    </select>
                    <input type="text" class="keyword" name="keyword" id="keyword" placeholder="검색..."/>
                    <input type="text" id="none">
                    <button type="button" name="searchBtn" class="answer" id="searchBtn">검색</button>
                </form>
            </div>
            <div id="listCustomerDiv" style="width: 900px;">
                <table>
                    <thead>
                    <tr>
                        <th class="id">ID</th>
                        <th class="name">이름</th>
                        <th class="phone">휴대전화</th>
                        <th class="email">이메일</th>
                        <th class="inputDate">가입날짜</th>
                        <th class="grade">회원 등급</th>
                        <th class="cusFlag">회원 상태</th>
                    </tr>
                    </thead>
                    <c:if test="${empty listCustomer}">
                        <td style="text-align: center" colspan="7">
                            가입한 회원이 없거나, DB 문제가 발생했습니다.
                            <a href="http://localhost/paik_prj/manager/dashboard/dashboard.jsp">돌아가기</a>
                        </td>
                    </c:if>

                    <c:if test="${ not empty param.keyword }"> <!-- 파라메터 변수가 있을 경우 -->
                        <c:set var="searchParam" value="&keyword=${ param.keyword }"/>
                    </c:if>

                    <tbody>
                    <c:forEach var="cVO" items="${listCustomer}" varStatus="i">
                        <tr>
                            <td class="id">
                                <a href="detail_customer.jsp?cusId=${cVO.cusId}&currentPage=${currentPage}">
                                    <c:out value="${cVO.cusId}" escapeXml="true"/>
                                </a>
                            </td>
                            <td class="name"><c:out value="${dd.decrypt(cVO.name)}" escapeXml="true"/></td>
                            <td class="phone"><c:out value="${dd.decrypt(cVO.phone)}" escapeXml="true"/></td>
                            <td class="email"><c:out value="${dd.decrypt(cVO.email)}" escapeXml="true"/></td>
                            <td class="inputDate">
                                <fmt:formatDate value="${cVO.inputDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            <td class="grade"><c:out value="${cVO.grade}" escapeXml="true"/></td>
                            <td class="cusFlag">
                                <c:if test="${cVO.cusFlag eq 'N'}">
                                    <span class="active">활동</span>
                                </c:if>
                                <c:if test="${cVO.cusFlag eq 'Y'}">
                                    <span class="inactive">비활동</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <%
                //1. 한 화면에 보여줄 페이지 인덱스 [1][2][3]
                int pageNumber = 3;
                //2. 화면에 보여줄 시작 페이지 번호
                int startPage = ((currentPage-1)/pageNumber)*pageNumber+1;
                //3. 화면에 보여줄 마지막 페이지 번호를 얻어라
                int endPage = startPage+pageNumber-1;
                //4. 총 페이지수가 연산된 마지막 페이지수보다 작다면 총페이지 수가 마지막 페이지 수가 된다.
                if(totalPage<=endPage){
                    endPage=totalPage;
                }
            %>
            <ul class="pagination justify-content-center">
                <% sVO.setUrl("list_customer.jsp"); %>
                <%= new CustomerUtil().pagination(sVO) %>
            </ul>
        </main>
    </div>
</div>
<script src="bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script src="chart.umd.js" integrity="sha384-eI7PSr3L1XLISH8JdDII5YN/njoSsxfbrkCTnJrzXt+ENP5MOVBxD+l6sEG4zoLp" crossorigin="anonymous"></script><script src="dashboard.js"></script></body>
</html>