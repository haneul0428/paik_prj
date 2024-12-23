<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.CartItemDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="옵션 업데이트"
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

if("POST".equals(method)){//post 방식일 경우 실행
	//파라메터 값 받아오기
	String reqShot = request.getParameter("shot");
	String size = request.getParameter("size");
	String reqSyrup = request.getParameter("syrup");
	String multiCup = request.getParameter("multiCup");
	String addChoco = request.getParameter("addChoco");
	String addStraw = request.getParameter("addStraw");
	String cim = request.getParameter("cartItemNum");
	int shot =0;
	int syrup=0;
	if(reqShot!=null && reqSyrup!=null) {
		shot = Integer.parseInt(reqShot);
		syrup = Integer.parseInt(reqSyrup);
	}

	int cartItemNum = Integer.parseInt(cim);
	int rowCnt = 0;
	
	//파라메터 값 vo에 설정
	ciVO.setShot(shot);
	ciVO.setSize(size);
	ciVO.setSyrup(syrup);
	ciVO.setCup(multiCup);
	ciVO.setAddChoco(addChoco);
	ciVO.setAddStraw(addStraw);
	ciVO.setCartItemNum(cartItemNum);
	
	CartItemDAO cDAO = CartItemDAO.getInstance();
	try{
		//설정한 옵션을 order_detail 테이블에 insert
		cDAO.insertOrderDetail(ciVO);

		jsonObj.put("update", true);


	} catch(SQLException se){
		jsonObj.put("update", false);
		se.printStackTrace();
	}//end catch
	
}//end if

out.print(jsonObj.toJSONString());
%>
