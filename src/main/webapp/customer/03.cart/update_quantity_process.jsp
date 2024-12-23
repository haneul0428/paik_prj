<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.CartItemDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="수량 업데이트"
    %>
<jsp:useBean id="ciVO" class="customer.paik.CartItemVO" scope="page"/>
<jsp:setProperty property="*" name="ciVO"/>
<%
   request.setCharacterEncoding("utf-8");
%>
<%
JSONObject jsonObj = new JSONObject();
String method = request.getMethod();
jsonObj.put("result",!"GET".equals(method)); //get 방식일 경우 실패

if("POST".equals(method)){
	String quant = request.getParameter("quantity") == null? "0":request.getParameter("quantity");
	String cim = request.getParameter("cartItemNum") == null? "0":request.getParameter("cartItemNum");
	int quantity = Integer.parseInt(quant);
	int cartItemNum = Integer.parseInt(cim);
	int rowCnt = 0;
	
	ciVO.setQuantity(quantity);
	ciVO.setCartItemNum(cartItemNum);
	
/* 	System.out.println(quantity);
	System.out.println(cartItemNum); */
	
	
	CartItemDAO cDAO = CartItemDAO.getInstance();
	try{
		rowCnt = cDAO.updateQuantity(ciVO);
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
