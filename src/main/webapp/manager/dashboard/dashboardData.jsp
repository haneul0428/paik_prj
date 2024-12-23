<%@ page contentType="application/json;charset=UTF-8" language="java" info="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="manager.paik.dashboard.DashboardDAO" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%
    String type = request.getParameter("type");
    DashboardDAO dDAO = DashboardDAO.getInstance();
    JSONObject jsonResult = new JSONObject();

    try {
        if("sales".equals(type)) {
            int[] drinkSales = dDAO.selectDrinkSales();
            int[] dessertSales = dDAO.selectDessertSales();

            JSONArray drinkArray = new JSONArray();
            JSONArray dessertArray = new JSONArray();

            for(int i = 0; i < drinkSales.length; i++) {
                drinkArray.add(drinkSales[i]);
                dessertArray.add(dessertSales[i]);
            }

            jsonResult.put("drinkSales", drinkArray);
            jsonResult.put("dessertSales", dessertArray);

        } else if("members".equals(type)) {
            int[] joins = dDAO.selectJoinCustomer();
            int[] withdraws = dDAO.selectWithdrawCustomer();

            JSONArray joinArray = new JSONArray();
            JSONArray withdrawArray = new JSONArray();

            for(int i = 0; i < joins.length; i++) {
                joinArray.add(joins[i]);
                withdrawArray.add(withdraws[i]);
            }

            jsonResult.put("joins", joinArray);
            jsonResult.put("withdraws", withdrawArray);

        } else if("voc".equals(type)) {
            int[] vocs = dDAO.selectVoc();
            JSONArray vocArray = new JSONArray();

            for(int voc : vocs) {
                vocArray.add(voc);
            }

            jsonResult.put("vocs", vocArray);

        } else if("total".equals(type)) {
            int[] totals = dDAO.selectSales();
            JSONArray totalArray = new JSONArray();

            for(int total : totals) {
                totalArray.add(total);
            }

            jsonResult.put("totals", totalArray);
        }

        out.print(jsonResult.toJSONString());

    } catch(Exception e) {
        jsonResult.put("error", e.getMessage());
        out.print(jsonResult.toJSONString());
    }
%>