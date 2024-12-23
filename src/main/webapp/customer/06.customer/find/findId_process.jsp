<%@page import="kr.co.sist.chipher.DataDecryption"%>
<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="customer.paik.CustomDAO "%>
<%@ page import="customer.paik.CustomVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="cVO" class="customer.paik.CustomVO" scope="request"/>
<jsp:setProperty name="cVO" property="*"/>
<%
	if ("post".equalsIgnoreCase(request.getMethod())) {
		
		if(session.getAttribute("idFound") != null){
			response.sendRedirect("findIdResult.jsp");
			return;
		}//if
		
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
	    cVO.setPhone(phone); //전화번호만 따로 설정
	    
	    DataEncryption de = new DataEncryption("abcdef0123456789");
	    String encryptedName = de.encrypt(cVO.getName());
	    String encryptedPhone = de.encrypt(cVO.getPhone());
	    
	    CustomDAO cDAO = CustomDAO.getInstance();
	    String foundId = null;
	    String errorMsg = null;
	    
	    try{
	    	cVO.setName(encryptedName);
	    	cVO.setPhone(encryptedPhone);
	    	
	    	foundId = cDAO.searchId(cVO);
	    	
	    	//System.out.println(cVO.getName() + " / " + cVO.getPhone());	//chk용
	    	//System.out.println("id: " + foundId);
	    	
	    	if("이미 탈퇴된 계정입니다.".equals(foundId)){
	    		session.invalidate();
	    		out.print("<script>alert('이미 탈퇴된 계정입니다.'); location.href='http://localhost/paik_prj/index.jsp';</script>");
	    		return;
	    	} else if("일치하는 회원 정보가 존재하지 않습니다.".equals(foundId)) {
	    		errorMsg = "회원 정보를 찾을 수 없습니다.";
	    	}//el~if
			
    		session.setAttribute("idFound", "true");	//F5했을 때 다시 id가 찾아지지 않도록
	    	
	    } catch (SQLException se){
	    	se.printStackTrace();
	    }//try~ca
    	
	    if(errorMsg != null){
	    	session.setAttribute("errorMsg", errorMsg);
	    }//if
	    
    	if(foundId != null){
    		session.setAttribute("foundId", foundId);
    	}//if
    	
	    response.sendRedirect("findIdResult.jsp");
	}//if
%>