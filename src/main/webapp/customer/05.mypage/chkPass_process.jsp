<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.CustomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<jsp:include page="/customer/00.common/jsp/member_session_chk.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cVO" class="customer.paik.CustomVO" scope="page"/>
<jsp:setProperty name="cVO" property="*"/>
<%
	String cusId = (String)session.getAttribute("cusId");
	String cusPass = request.getParameter("cusPass");
	String newPass = request.getParameter("newPass");
	
	int rowCnt = 0;
	
	cVO.setCusId(cusId);
	cVO.setCusPass(DataEncryption.messageDigest("SHA-1", cusPass));
	cVO.setNewPass(DataEncryption.messageDigest("SHA-1", newPass));

	CustomDAO cDAO = CustomDAO.getInstance();
	boolean loginFlag = false;
	
	try{
		loginFlag = cDAO.login(cVO); // 비밀번호 확인, rowCnt = 1
	}catch(SQLException se){
		System.out.println("인증 과정에서 문제 발생!");
		se.printStackTrace();
	}
	
	try{
		rowCnt = cDAO.updatePass(cVO); // 비밀번호 확인, rowCnt = 1
	}catch(SQLException se){
		rowCnt = -1;
		System.out.println("인증 과정에서 문제 발생!");
		se.printStackTrace();
	}
	
	System.out.println(rowCnt);
	pageContext.setAttribute("loginFlag", loginFlag);
	pageContext.setAttribute("rowCnt", rowCnt);
%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">
<title>빽스커피 | 비밀번호 인증</title>

<style type="text/css">

</style>

<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/05.mypage/css/paik_chgPass.css">
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
/* CSS영역 => CSS 디자인 코드 작성 */

</style>
<script type="text/javascript">
var loginFlag = ${ loginFlag };
var cnt = ${ rowCnt };
var flag = false
var msg="문제가 발생했습니다. 잠시 후 다시 시도해주세요.";

//외부 임의 실행 등으로 DAO 거치지 않고 삭제되었을 경우
if(!loginFlag){
	msg="아이디나 비밀번호가 잘못 입력되었습니다.\n다시 확인해주세요."
	alert(msg);
	history.back();
}//end if


if(cnt == 1){
	msg="비밀번호 변경에 성공했습니다.";
	flag = true;
}//end if

alert(msg);

//외부 임의 실행 등으로 DAO 거치지 않고 삭제되었을 경우
if(!flag){
	history.back();
} else {
	location.href="http://localhost/paik_prj/index.jsp";
}
</script>
</head>
<body>
</body>
</html>