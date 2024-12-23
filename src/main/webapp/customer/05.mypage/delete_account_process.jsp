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
<%
	String cusId = request.getParameter("cusId");
	String cusPass = request.getParameter("cusPass");
	
	cVO.setCusId(cusId);
	cVO.setCusPass(DataEncryption.messageDigest("SHA-1", cusPass));

	CustomDAO cDAO = CustomDAO.getInstance();
	int rowCnt = 0;
	
	try{
		rowCnt = cDAO.deleteAccount(cVO); // 계정 삭제 진행, rowCnt = 1
	}catch(SQLException se){
		rowCnt = -1;
		System.out.println("회원 탈퇴 과정에서 문제 발생!");
		se.printStackTrace();
	}
	
	out.print(rowCnt);
	pageContext.setAttribute("rowCnt", rowCnt);
%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">
<title>빽스커피 | 회원탈퇴</title>

<style type="text/css">

</style>

<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/05.mypage/css/paik_delete.css">
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
	msg = "아이디나 비밀번호가 잘못 입력되었습니다.\n다시 확인해주세요.";
}//end if

//삭제 성공시
if(cnt == 1){
	flag = true;
}//end if

if(!flag){// 삭제 성공
	//alert 메시지 출력
	alert(msg);
	history.back();
}//end if

</script>
</head>
<%
session.invalidate();
%>
<body>
<div id="wrap">
<div id="header">
<jsp:include page="/customer/00.common/jsp/header.jsp"/>
</div>

<div id="content-wrap">
<div class="sub_visual bg-paik">
	<div class="txt">
		<h1>탈퇴 완료</h1>
	</div>
</div>

<div class="sub_section cmnt_wrap">
<div class="container">
	<div class="deleteNotice">
	회원 탈퇴가 완료되었습니다.
	</div>
	<div class="deleteNotice">
	그 동안 빽스커피을 이용해주셔서 감사합니다.
	</div>
</div>
</div>
</div>

<div id="footer">
<jsp:include page="/customer/00.common/jsp/footer.jsp"/>
</div>
</div>

</body>
</html>