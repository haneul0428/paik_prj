<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="manager.paik.customer.CustomerDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/jsp/post_chk.jsp"%>
<%@ include file="../common/jsp/manager_session_chk.jsp"%>
<jsp:useBean id="cVO" class="manager.paik.customer.CustomerVO"/>
<%
    cVO.setCusId(request.getParameter("cusId"));
    cVO.setCusFlag(request.getParameter("cusFlag"));
    CustomerDAO cDAO = CustomerDAO.getInstance();
    int cnt=0;

    try {
        cnt =  cDAO.deleteCustomer(cVO);
    } catch (SQLException e) {
        cnt= -1;
        e.printStackTrace();
    }
    if(cnt==1){%>
    <script type="text/javascript">
        alert("성공적으로 변경했습니다.");
        location.href="http://localhost/paik_prj/manager/customer/list_customer.jsp?currentPage=${param.currentPage}";
    </script>
    <%
    }else {%>
       <script>
           alert("변경 도중에 문제가 발생했습니다. 잠시후 다시시도 해주세요.");
           history.back();
       </script>

    <%}%>

