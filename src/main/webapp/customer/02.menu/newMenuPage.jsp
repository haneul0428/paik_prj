<%@page import="customer.paik.CustomVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.List"%>
<%@page import="customer.paik.ItemDAO"%>
<%@page import="customer.paik.ItemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="메뉴 - 신메뉴 페이지"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="iVO" class="customer.paik.ItemVO" scope="page"/>
<jsp:setProperty name="iVO" property="*"/>
<jsp:include page="/customer/00.common/jsp/remove_password_verified.jsp"/>
<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">

<title>빽스커피 | 신메뉴</title>

<style type="text/css">

</style>

<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/02.menu/css/paik_menu.css">
<link rel="stylesheet" id="theme-css-style-css"  href="https://paikdabang.com/wp-content/themes/paikdabang/assets/css/style.css?ver=4.9.4" type="text/css" media="all" />

<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon32x32.png" sizes="32x32" />
<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon192x192.png" sizes="192x192" />
<link rel="apple-touch-icon-precomposed" href="http://localhost/paik_prj/customer/00.common/images/favicon180x180.png" />
<meta name="msapplication-TileImage" content="http://localhost/paik_prj/customer/00.common/images/favicon270x270.png" />

<%-- bootstrap CDN --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<%-- jQuery CDN --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<%-- Swiper CDN --%>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<%
	CustomVO userData = (CustomVO)session.getAttribute("userData");
%>
<script src="http://localhost/paik_prj/customer/02.menu/jsp/menu.js"></script>
<script type="text/javascript">
var loginFlag = <%= (userData != null) ? "true" : "false" %>;
//console.log(loginFlag);

$(function(){
	
});//ready()
</script>

</head>

<body>

<div id="wrap">
<div id="header">
<jsp:include page="/customer/00.common/jsp/header.jsp"/>
</div>

<%
	ItemDAO iDAO = ItemDAO.getInstance();
	List<ItemVO> coffeeItems = iDAO.selectMainItem(0);	//0 - 커피
	List<ItemVO> drinkItems = iDAO.selectMainItem(1);	//1 - 음료
	List<ItemVO> breadItems = iDAO.selectMainItem(2);	//2- 빵
	List<ItemVO> icecreamItems = iDAO.selectMainItem(3);	//3-아이스크림
	
	//커피 + 음료 + 빵 + 아이스크림
	List<ItemVO> itemAll = new ArrayList<ItemVO>();
	itemAll.addAll(coffeeItems);
	itemAll.addAll(drinkItems);
	itemAll.addAll(breadItems);
	itemAll.addAll(icecreamItems);
	
	Random ranItem = new Random();
	int selectItemRan = Math.min(5, itemAll.size());	//최대 5개의
	List<Integer> selectInd = new ArrayList<Integer>();
	
	while(selectInd.size()<selectItemRan){
		int ranInd = ranItem.nextInt(itemAll.size());
		if(!selectInd.contains(ranInd)){
			selectInd.add(ranInd);
		}//if
	}//w
%>

<div id="content-wrap">
<div class="sub_visual bg-menu">
	<div class="txt">
		<h1>신메뉴</h1>
		<p>새로운 메뉴가 추가되었습니다. 지금 바로 확인해보세요.</p>
		<div class="tabMenu">
			<ul class="pageTab">
				<li class="on"><a href="http://localhost/paik_prj/customer/02.menu/newMenuPage.jsp">신메뉴</a></li>
				<li><a href="http://localhost/paik_prj/customer/02.menu/coffeeMenuPage.jsp">커피</a></li>
				<li><a href="http://localhost/paik_prj/customer/02.menu/drinkMenuPage.jsp">음료</a></li>
				<li><a href="http://localhost/paik_prj/customer/02.menu/icecreamDessertMenuPage.jsp">아이스크림/디저트</a></li>
			</ul>
		</div>
	</div>
</div>

<div class="sub_section menu_wrap">
	<div class="mainContainer">
		<h2 class="main_tit3 color-1">신메뉴</h2>
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<%
				for(int i=0; i<selectInd.size(); i++){
					int ind = selectInd.get(i);
					ItemVO item = itemAll.get(ind);
				%>
				<div class="swiper-slide">
					<ul>
						<li data-item-num="<%= item.getItemNum()%>">
							<img src="<%= item.getImage() %>" class="menuItem" />
							<p><strong><%= item.getiNameKor() %></strong></p>
						</li>
					</ul>
				</div>
				<% }//f %>
			</div>
			<div class="swiper-button-next" style="position: absolute; top: 30%;"></div>
			<div class="swiper-button-prev" style="position: absolute; top: 30%;"></div>
		</div>
		
		<div class="menuList">
			<ul class="menuItems">
				<% 
				for(int i=0; i<selectInd.size(); i++){
					int ind = selectInd.get(i);
					ItemVO item = itemAll.get(ind);
				%>
				<li data-item-num="<%= item.getItemNum()%>">
					<img src="<%= item.getImage() %>" class="menuItem" />
					<p><strong><%= item.getiNameKor() %></strong></p>
				</li>
				<% }//f %>
			</ul>
		</div>
		
		<div class="menuInfo" style="display: none;">
			<button class="closeInfo">X</button>
			<h2 class="itemName"></h2>
			<h4 class="itemEngName"></h4>
			<p class="itemContent"></p>
			<div class="ingredientsContainer">
				<input type="button" class="putBtn" id="putBtn" value="담기"/>
				<span style="font-size: 15px;">가격: <span class="itemPrice"></span>원</span>
				<table class="ingredientsTable">
				</table>
			</div>
			<p></p>
		</div>
	</div>
</div>
</div>

<div id="footer">
<jsp:include page="/customer/00.common/jsp/footer.jsp"/>
</div>
</div>

</body>
</html>