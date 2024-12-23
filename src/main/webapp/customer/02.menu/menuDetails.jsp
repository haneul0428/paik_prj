<%@page import="org.json.simple.JSONObject"%>
<%@page import="customer.paik.ItemVO"%>
<%@page import="customer.paik.ItemDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
	int itemNum = Integer.parseInt(request.getParameter("item_num"));
	    
    ItemDAO iDAO = ItemDAO.getInstance();
    ItemVO iVO = iDAO.selectDetailItem(itemNum);
    
    //System.out.println(iDAO.selectDetailItem(itemNum));
    
    if (iVO == null) {	//아이템이 없을 경우
        return;
    }//if
    
    // JSON으로 변환
    JSONObject jsonObj = new JSONObject();
    jsonObj.put("iNameKor", iVO.getiNameKor());
    jsonObj.put("iNameEng", iVO.getiNameEng());
    jsonObj.put("description", iVO.getDescription());
    jsonObj.put("price", iVO.getPrice());
    jsonObj.put("ingredientFlag", String.valueOf(iVO.getIngredientFlag()));
    jsonObj.put("caffeine", iVO.getCaff());
    jsonObj.put("calorie", iVO.getCal());
    jsonObj.put("natrium", iVO.getNat());
    jsonObj.put("sugar", iVO.getSugar());
    jsonObj.put("fatty_acid", iVO.getFatAcid());
    jsonObj.put("protein", iVO.getPro());

    //System.out.println(iVO.getPro());
    //System.out.println(jsonObj);
    out.print(jsonObj.toJSONString());
%>
