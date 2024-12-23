<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="customer.paik.CustomDAO" %>
<%@ page import="customer.paik.CustomVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="cVO" class="customer.paik.CustomVO" scope="request"/>
<jsp:setProperty name="cVO" property="*" />
<%
	if ("post".equalsIgnoreCase(request.getMethod())) {
	    
	    String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
	    cVO.setPhone(phone); //전화번호만 따로 설정
	
	    CustomDAO cDAO = CustomDAO.getInstance();
	    //out.println(cVO);	//cVO값 체크
	    
	    //password 해시
	    String hashedPass = DataEncryption.messageDigest("SHA-1", cVO.getCusPass());
	    cVO.setCusPass(hashedPass);
	    
	    //name, email, phone 암호화
	    DataEncryption de = new DataEncryption("abcdef0123456789");
	    String encryptedName = de.encrypt(cVO.getName());
	    String encryptedEmail = de.encrypt(cVO.getEmail()); 
	    String encryptedPhone = de.encrypt(phone);
	    
	    cVO.setCusId(cVO.getCusId());
	    cVO.setName(encryptedName);
	    cVO.setEmail(encryptedEmail);
	    cVO.setPhone(encryptedPhone);
	    /* 
	    System.out.println(cVO.getCusId());
	    System.out.println(encryptedName);
	    System.out.println(encryptedEmail);
	    System.out.println(encryptedPhone);
	     */
	    try {
	        cDAO.signUp(cVO);
	        out.print("<script>alert('회원가입에 성공했습니다. 로그인 화면으로 이동합니다.'); location.href='loginPage.jsp';</script>");
	    } catch (SQLException se) {
	        //out.print("회원가입에 실패했습니다.<br/>" + se.getMessage());
	        System.out.println(se.getMessage());
	        out.print("<script>alert('회원가입에 실패했습니다'); history.back();</script>");
	    }//try~ca
	}//if
%>
