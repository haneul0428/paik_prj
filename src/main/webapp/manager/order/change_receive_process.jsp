<%@page import="java.sql.SQLException"%>
<%@page import="manager.paik.order.OrderDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="수령 상태 변경"
    %>
<%
   request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="oVO" class="manager.paik.order.OrderVO" scope="page"/>
<jsp:setProperty property="*" name="oVO"/>
<%
JSONObject jsonObj = new JSONObject();
String method = request.getMethod();
jsonObj.put("result",!"GET".equals(method)); //get 방식일 경우 실패

if("POST".equals(method)){
	String cin = request.getParameter("cartItemNumber") == null? "0":request.getParameter("cartItemNumber");
	String cn = request.getParameter("cartNum") == null? "0":request.getParameter("cartNum");
	int cartItemNumber = Integer.parseInt(cin);
	int cartNum = Integer.parseInt(cn);
	int rowCnt = 0;
	
	oVO.setCartItemNumber(cartItemNumber);
	oVO.setCartNum(cartNum);
	
/* 	System.out.println(quantity);
	System.out.println(cartItemNum); */
	
	
	OrderDAO oDAO = OrderDAO.getInstance();
	try{
		rowCnt = oDAO.changeReceived(oVO);
		if(rowCnt == 1){		
			jsonObj.put("update", true);			
		}
	} catch(SQLException se){
		jsonObj.put("update", false);
		se.printStackTrace();
	}//end catch
	
}//end if

out.print(jsonObj.toJSONString());
%>
