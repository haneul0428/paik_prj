<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="manager.paik.dashboard.DashboardDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    DashboardDAO dDAO = DashboardDAO.getInstance();

    int[] sales = dDAO.selectSales();
    int[] drinks = dDAO.selectDrinkSales();
    int[] desserts = dDAO.selectDessertSales();
    int[] joins= dDAO.selectJoinCustomer();
    int[] withdraws = dDAO.selectWithdrawCustomer();
    int[] vocs = dDAO.selectVoc();

    pageContext.setAttribute("sales", sales);
    pageContext.setAttribute("drinks", drinks);
    pageContext.setAttribute("desserts", desserts);
    pageContext.setAttribute("joins", joins);
    pageContext.setAttribute("withdraws", withdraws);
    pageContext.setAttribute("vocs", vocs);
    // 날짜 포맷 설정
    SimpleDateFormat fileNameDateFormat = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat displayDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat dayOfWeekFormat = new SimpleDateFormat("E"); // 요일

    // 현재 날짜
    Calendar cal = Calendar.getInstance();
    Date currentDate = new Date();

    // 파일명 설정
    String fileName = "dashboard_report_" + fileNameDateFormat.format(currentDate) + ".xls";
    String encodedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");

    // 헤더 설정
    response.setHeader("Content-Disposition", "attachment; filename=" + encodedFileName);
    response.setHeader("Content-Type", "application/vnd.ms-excel");
    response.setHeader("Cache-Control", "no-cache");
%>
<html>
    <head>
        <meta charset="UTF-8">
        <style>
            .excel-table {
            border-collapse: collapse;
            width: 100%;
            }
            .excel-table th, .excel-table td {
            border: 1px solid #000000;
            padding: 5px;
            text-align: center;
            }
            .excel-table th {
            background-color: #e8e8e8;
            font-weight: bold;
            }
            .section-header {
            background-color: #d0d0d0;
            font-weight: bold;
            }
        </style>
    </head>
    <body>
        <!-- 일일 판매 현황 -->
        <table class="excel-table">
            <thead>
                <tr>
                    <th colspan="8" class="section-header">빽스다방 판매 현황 리포트 (<%=displayDateFormat.format(currentDate)%>)</th>
                </tr>
                <tr>
                    <th>구분</th>
                    <%
                        // 최근 7일간의 날짜와 요일 출력
                        for(int i = 1; i < 8; i++) {
                            cal.setTime(currentDate);
                            cal.add(Calendar.DAY_OF_YEAR, -i);
                            out.print("<th>" + dayOfWeekFormat.format(cal.getTime()) + "( "+ displayDateFormat.format(cal.getTime()) +" )"+"</th>");
                        }
                    %>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>음료/커피 판매건수</td>
                    <c:forEach var="drink" items="${drinks}">
                        <td>${drink}</td>
                    </c:forEach>
                </tr>
                <tr>
                    <td>디저트/아이스크림 판매건수</td>
                    <c:forEach var="dessert" items="${desserts}">
                        <td>${dessert}</td>
                    </c:forEach>
                </tr>
                <tr>
                    <td>총 매출(천원)</td>
                    <c:forEach var="sale" items="${sales}">
                        <td>${sale}</td>
                    </c:forEach>
                </tr>
                <tr>
                    <td>신규 회원수</td>
                    <c:forEach var="join" items="${joins}">
                        <td>${join}</td>
                    </c:forEach>
                </tr>
                <tr>
                    <td>탈퇴 회원수</td>
                    <c:forEach var="withdraw" items="${withdraws}">
                        <td>${withdraw}</td>
                    </c:forEach>
                </tr>
            </tbody>
        </table>
    </body>
</html>