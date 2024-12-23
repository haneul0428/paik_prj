<%@page import="customer.paik.CustomVO"%>
<%@page import="customer.paik.CartItemDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.ItemDAO"%>
<%@page import="customer.paik.ItemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="ciVO" class="customer.paik.CartItemVO" scope="session"/>
<jsp:setProperty name="ciVO" property="*"/>
<jsp:useBean id="iVO" class="customer.paik.ItemVO" scope="session"/>
<jsp:setProperty name="iVO" property="*"/>
<%
	CustomVO userData = (CustomVO)session.getAttribute("userData");
	
	if ("post".equalsIgnoreCase(request.getMethod())) {
		JSONObject jsonObj = new JSONObject();
		boolean addFlag = false;
		String addMsg = "";
		
		if(userData == null){
			jsonObj.put("addFlag", false);
			jsonObj.put("addMsg", "로그인 후 이용하실 수 있습니다.");
			out.print(jsonObj.toJSONString());
			return;
		}//if~el
		
		String itemNumParam = request.getParameter("item_num");
		String quantityParam = request.getParameter("quantity");
		
		//System.out.println(itemNumParam);
		//System.out.println(quantityParam);
		
		if(itemNumParam != null && quantityParam != null){
			int itemNum = Integer.parseInt(itemNumParam);
			int quantity = Integer.parseInt(quantityParam);
			
			ItemDAO iDAO = ItemDAO.getInstance();
			
			try{
				iDAO.insertCartItem(userData.getCusId(), itemNum, quantity);
				CartItemDAO ciDAO = CartItemDAO.getInstance();
				
				jsonObj.put("addFlag", true);
				jsonObj.put("addMsg", "장바구니에 상품을 추가했습니다.");
				
			} catch(SQLException se){
				jsonObj.put("addFlag", false);
				jsonObj.put("addMsg", "장바구니에 상품을 추가하는데 실패했습니다.");
				se.printStackTrace();
			}//try~ca
			
			//System.out.println(jsonObj);	//확인용
			
			out.print(jsonObj.toJSONString());
		}//if
		
	}//if
%>