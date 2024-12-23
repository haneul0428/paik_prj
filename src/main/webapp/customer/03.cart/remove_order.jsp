<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.CartItemDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<jsp:useBean id="ciVO" class="customer.paik.CartItemVO" scope="page"/>
<jsp:setProperty property="*" name="ciVO"/>
<%
	JSONObject jsonObj = new JSONObject();
	String method = request.getMethod();
	jsonObj.put("result",!"GET".equals(method)); //get 방식일 경우 실패

	if("POST".equals(method)){//post 방식일 경우 실행
		//파라메터 값 받아오기 "cartItemNum" : cartItemNum, "cartNum" : cartNum
		String cin = request.getParameter("cartItemNum") == null? "0":request.getParameter("cartItemNum");
		String cn = request.getParameter("cartNum") == null? "0":request.getParameter("cartNum");
		int cartItemNum = Integer.parseInt(cin);
		int cartNum = Integer.parseInt(cn);
		int rowCnt = 0;
		
		ciVO.setCartItemNum(cartItemNum);
		ciVO.setCartNum(cartNum);
		
		CartItemDAO cDAO = CartItemDAO.getInstance();
		try{
			rowCnt = cDAO.deleteCart(ciVO);
			jsonObj.put("update", true);//update 파라메터에 true 설정
		} catch(SQLException se){
			jsonObj.put("update", false);//update 파라메터에 false 설정
			se.printStackTrace();
		}//end catch
	}//end if
	
	out.print(jsonObj.toJSONString());
%>