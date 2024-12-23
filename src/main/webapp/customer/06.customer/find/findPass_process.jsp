<%@page import="kr.co.sist.chipher.DataDecryption"%>
<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.CustomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="cVO" class="customer.paik.CustomVO" scope="request"/>
<jsp:setProperty name="cVO" property="*"/>
<%
	if ("post".equalsIgnoreCase(request.getMethod())) {
		
		if(session.getAttribute("tempPasswordIssued") != null){
			response.sendRedirect("findPassResult.jsp");
			return;
		}//if
		
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
	    cVO.setPhone(phone); //전화번호만 따로 설정
	    
	    DataEncryption de = new DataEncryption("abcdef0123456789");
	    String encryptedName = de.encrypt(cVO.getName());
	    String encryptedPhone = de.encrypt(cVO.getPhone());
	    
	    CustomDAO cDAO = CustomDAO.getInstance();
	    String tempPassword = null;
	    String errorMsg = null;
	    
	    try{
	    	cVO.setCusId(cVO.getCusId());
	    	cVO.setName(encryptedName);
	    	cVO.setPhone(encryptedPhone);
	    	
	    	tempPassword = cDAO.searchPass(cVO);
	    	
		    if("이미 탈퇴된 계정입니다.".equals(tempPassword)){
		    	session.invalidate();
	    		out.print("<script>alert('이미 탈퇴된 계정입니다.'); location.href='http://localhost/paik_prj/index.jsp';</script>");
				return;
	    	} else if("일치하는 회원 정보가 존재하지 않습니다.".equals(tempPassword)) {
	    		errorMsg = "회원 정보를 찾을 수 없습니다.";
	    	}//el~if

	    	if(tempPassword != null && tempPassword.length() % 16 == 0){
	    		DataDecryption dd = new DataDecryption("abcdef0123456789");
	    		
	    		try{
		    		tempPassword = dd.decrypt(tempPassword);
	    		} catch (Exception e){
	    			e.printStackTrace();
			    	session.invalidate();
		    		out.print("<script>alert('문제가 발생했습니다. 다시 시도해주세요.'); location.href='http://localhost/paik_prj/index.jsp';</script>");
	    			return;
	    		}//try~ca
	    		
	    		session.setAttribute("tempPasswordIssued", "true");	//새로고침 시 임시비밀번호 재발급 방지
	    	}//if
	    	
	    } catch(SQLException se){
	    	se.printStackTrace();
	    }//try~ca
	    
	    if(errorMsg != null){
	    	session.setAttribute("errorMsg", errorMsg);
	    }//if
	    
  		if(tempPassword != null){
	    	session.setAttribute("tempPassword", tempPassword);
  		}//if
  		
    	response.sendRedirect("findPassResult.jsp");

	}//if
%>