<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="manager.paik.customer.Grade"%>
<%@ page import="manager.paik.customer.CustomerDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="kr.co.sist.chipher.DataEncryption" %>
<jsp:include page="../common/jsp/manager_session_chk.jsp"/>
<jsp:useBean id="cVO" scope="page" class="manager.paik.customer.CustomerVO"/>

<%
    // 모든 파라미터 수동 설정
    // 암호화 진행
    DataEncryption de = new DataEncryption("abcdef0123456789");

    try {
        cVO.setName(de.encrypt(request.getParameter("name")));
        cVO.setPhone(de.encrypt(request.getParameter("phone")));
        cVO.setEmail(de.encrypt(request.getParameter("email")));
        System.out.println("ssu-!");
    } catch (Exception e) {
        e.printStackTrace();
    }
    cVO.setCusFlag(request.getParameter("cusFlag"));
    cVO.setCusId(request.getParameter("cusId"));
    String gradeValue = request.getParameter("grade");

    if (gradeValue != null) {
        cVO.setGrade(Grade.gradeForDB(Integer.parseInt(gradeValue)));
    }
    CustomerDAO cDAO = CustomerDAO.getInstance();

    int cnt= 0;

    try{

        cnt = cDAO.updateCustomer(cVO);

    }catch (SQLException se){
        cnt=-1;
        se.printStackTrace();
    }
    pageContext.setAttribute("cnt", cnt);

%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript">
        var cnt = ${cnt};
        msg = "수정중에 문제가 발생했습니다. 잠시후 다시 시도해주세요.";
        if(cnt==1){
            msg = "성공적으로 수정했습니다."
            location.href="http://localhost/paik_prj/manager/customer/list_customer.jsp?currentPage=${param.currentPage}";
        }
        if(cnt==0){
            msg = "변경할 수 없는 값은 절대로 변경할 수 없습니다.";
            history.back();
        }

        alert(msg);
        location.href="http://localhost/paik_prj/manager/customer/list_customer.jsp";
        $(function () {

        });
    </script>

