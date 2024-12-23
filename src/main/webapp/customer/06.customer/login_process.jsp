<%@page import="kr.co.sist.chipher.DataDecryption"%>
<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.CustomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<jsp:useBean id="cVO" class="customer.paik.CustomVO" scope="session"/>
<jsp:setProperty name="cVO" property="*"/>
<%
	//비밀번호 hash
	cVO.setCusPass(DataEncryption.messageDigest("SHA-1", cVO.getCusPass()));
	
	CustomDAO cDAO = CustomDAO.getInstance();
	boolean loginFlag = false;
	
	try{
		cDAO.login(cVO);
		loginFlag = cVO.getName() != null;
		
		if(loginFlag){
			if("Y".equals(cVO.getCusFlag())){
				session.invalidate();
				out.print("<script>alert('이미 탈퇴된 계정입니다.');");
				out.print("location.href='http://localhost/paik_prj/index.jsp';</script>");
				return;
			}//if
			
			DataDecryption dd = new DataDecryption("abcdef0123456789");
			cVO.setName(dd.decrypt(cVO.getName()));
			
			session.setAttribute("userData", cVO);	//사용자 데이터 저장
			session.setAttribute("cusId", cVO.getCusId());
			response.sendRedirect("http://localhost/paik_prj/index.jsp");
			
		} else {
			out.print("<script>alert('아이디 또는 비밀번호가 잘못 입력되었습니다.');");
			out.print("history.back();");
			out.print("</script>");
		}//if~el
		
	} catch(SQLException se){
		se.printStackTrace();
	}//try~ca
%>