<%@page import="kr.co.sist.chipher.DataEncryption"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="customer.paik.CustomDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String cusId = request.getParameter("cusId");
	
	if (cusId != null && !"".equals(cusId)) { //id가 비어있지 않다면
		try {
			CustomDAO cDAO = CustomDAO.getInstance();
			boolean dupIdFlag = cDAO.duplicationId(cusId);
			
			if (dupIdFlag) {
				out.print("unavailable"); //사용중입니다
			} else {
				out.print("available"); //사용가능합니다
			}//if~el
		} catch (SQLException e) {
			e.printStackTrace();
			out.print("error");
		}//try~ca
	}//if
%>
