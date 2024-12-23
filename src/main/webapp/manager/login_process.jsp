<%@ page import="manager.paik.manager.ManagerDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="kr.co.sist.chipher.DataEncryption" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" info="매니저 아이디 정보를 조회" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="mVO" class="manager.paik.manager.ManagerVO" scope="page"/>
<jsp:setProperty name="mVO" property="*"/>
<%
	String managerId = request.getParameter("managerId");
	String managerPass = request.getParameter("managerPass");
	
	DataEncryption de = new DataEncryption("abcdef0123456789");

    ManagerDAO mDAO = ManagerDAO.getInstance();
    mVO.setManagerId(de.encrypt(managerId));
    mVO.setManagerPass(DataEncryption.messageDigest("SHA-1", managerPass));
    
    boolean loginFlag = false;
    try{
        loginFlag = mDAO.selectManager(mVO);
        System.out.println(loginFlag);
        //System.out.println(!loginFlag);
    } catch(SQLException se){
    	se.printStackTrace();
    }
    
    pageContext.setAttribute("loginFlag", loginFlag);
    pageContext.setAttribute("managerId", managerId);    
%>

<!DOCTYPE html>
<html lang="ko">
<jsp:include page="common/jsp/post_chk.jsp"/>
<jsp:useBean id="managerVO" class="manager.paik.manager.ManagerVO" scope="page"/>
<jsp:setProperty name="managerVO" property="*"/>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="icon" type="image/png" sizes="16x16" href="../common/images/favicon-16x16.png">
    <!--bootstrap CDN-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <!-- jQuery CDN 시작 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

    <script type="text/javascript">
    var loginFlag = ${ loginFlag };
    var url="http://localhost/paik_prj/manager/dashboard/dashboard.jsp";
    localStorage.removeItem("returnUrl");
    const returnUrl = localStorage.getItem("returnUrl");
	
    if(!loginFlag){
    	alert("아이디나 비밀번호가 잘못 입력되었습니다.\n다시 확인해주세요.");
    	history.back();
    } else {
	    <%
	    // 로그인에 성공했으니 세션에 두고두고 저장
	    // 테스트 코드
	    session.setMaxInactiveInterval(1800);  // 30분 = 1800초
	    session.setAttribute("managerId", "${managerId}");
	    %>
	    if(returnUrl != null){
    		url = returnUrl;
    		location.href = url;
    	}
    	
    	location.href = url;
    }
    
    
/*     if(!flag){
    	alert(msg);
    	history.back();
    } else{
     	if(returnUrl != null){
    		url = returnUrl;
    		location.href = url;
    	}
    	
    	location.href = url;
    } */
    </script>
</head>
<body>

</body>
</html>
