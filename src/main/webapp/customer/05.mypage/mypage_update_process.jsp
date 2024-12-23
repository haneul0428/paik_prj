<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.CustomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%--로그인 여부를 검증하는 jsp include--%>
<jsp:include page="/customer/00.common/jsp/member_session_chk.jsp"/>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cVO" class="customer.paik.CustomVO" scope="page"/>
<jsp:setProperty name="cVO" property="*"/>
<%-- <%= cVO %> --%>
<%
	if ("post".equalsIgnoreCase(request.getMethod())) {
		int rowCnt = 0;
		
		String cusId = (String)session.getAttribute("cusId");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
	    cVO.setPhone(phone); //전화번호만 따로 설정
	    
	    CustomDAO cDAO = CustomDAO.getInstance();
	    //out.println(cVO);	//cVO값 체크
	    
	  //name, email, phone 암호화
	  DataEncryption de = new DataEncryption("abcdef0123456789");
	  String encryptedEmail = de.encrypt(email); 
	  String encryptedPhone = de.encrypt(phone);
	  
	  cVO.setPhone(encryptedPhone);
	  cVO.setEmail(encryptedEmail);
	  cVO.setCusId(cusId);
	  
	  System.out.println(encryptedEmail);
	  System.out.println(encryptedPhone);
	  
	  try {
		  rowCnt = cDAO.updateAccount(cVO);
	  } catch(SQLException se){
		  rowCnt = -1;
		  System.out.println("계정 정보 갱신 과정에서 문제 발생!");
		  se.printStackTrace();
	  }
	  
		pageContext.setAttribute("rowCnt", rowCnt);
	}//end if
%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">
<title>빽스커피 | 마이페이지</title>

<style type="text/css">

</style>

<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/05.mypage/css/paik_mypage.css">
<link rel="stylesheet" id="theme-css-style-css"  href="https://paikdabang.com/wp-content/themes/paikdabang/assets/css/style.css?ver=4.9.4" type="text/css" media="all" />

<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon32x32.png" sizes="32x32" />
<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon192x192.png" sizes="192x192" />
<link rel="apple-touch-icon-precomposed" href="http://localhost/paik_prj/customer/00.common/images/favicon180x180.png" />
<meta name="msapplication-TileImage" content="http://localhost/paik_prj/customer/00.common/images/favicon270x270.png" />

<%-- bootstrap CDN --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<%-- jQuery CDN --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style type="text/css">

</style>
<script type="text/javascript">
var msg = "문제가 발생했습니다. 잠시 후 다시 시도해주세요.";
var cnt = ${ rowCnt };
var flag = false;

//외부 임의 실행 등으로 DAO 거치지 않고 삭제되었을 경우
if(cnt == 0){
	msg = "개인 정보 변경은 외부에서 임의로 진행할 수 없습니다.";
}//end if

//삭제 성공시
if(cnt == 1){
	msg = "정보 변경에 성공했습니다.";
	flag = true;
}//end if

alert(msg);
history.back();

</script>
</head>
<%-- <%
session.invalidate();
%> --%>
<body>

</body>
</html>