<%@page import="customer.paik.CustomVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="공통디자인 - 사용자 페이지 header"
    %>
<%
   CustomVO username = (CustomVO)session.getAttribute("userData");   //사용자정보 저장
%>
<header id="header">
   <div class="in_header">
      <div class="sub-bg"></div>
      <div class="container">
         <ul class="topbar">
            <% if(username != null){ %>
               <li><a href="http://localhost/paik_prj/customer/05.mypage/mypage.jsp"><%= username.getName() %>님 안녕하세요</a></li>
               <li><a href="http://localhost/paik_prj/customer/03.cart/list_order.jsp">주문현황</a></li>
               <li><a href="http://localhost/paik_prj/customer/06.customer/logout.jsp">로그아웃</a></li>
            <% } else {%>
               <li><a href="http://localhost/paik_prj/customer/06.customer/loginPage.jsp">로그인</a></li>
            <% }//if~el %>
         </ul>
         <div class="nav_wrap">
            <a href="http://localhost/paik_prj/index.jsp" class="logo">
               <img src="http://localhost/paik_prj/customer/00.common/images/logo-5.png" alt="빽스커피">
            </a>
            <a href="http://localhost/paik_prj/index.jsp" class="logo light">
               <img src="http://localhost/paik_prj/customer/00.common/images/logo-5.png" alt="빽스커피">
            </a>
            <div class="nav">
               <div class="nav-icon"><div></div></div>
               <ul class="navbar">
               <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-95">
                  <a href="http://localhost/paik_prj/customer/01.paik/introduction.jsp" style="margin-right: 50px;">빽스커피</a>
                  <ul class="sub-menu">
                  <li>
                     <a href="http://localhost/paik_prj/customer/01.paik/introduction.jsp">빽다방소개</a>
                  </li>
                  <li>
                     <a href="http://localhost/paik_prj/customer/01.paik/coffeeStory.jsp">커피이야기</a>
                  </li>
                  <li>
                     <a href="http://localhost/paik_prj/customer/01.paik/educationStory.jsp">교육이야기</a>
                  </li>
                  </ul>
               </li>
               
               <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-95">
                  <a href="http://localhost/paik_prj/customer/02.menu/newMenuPage.jsp" style="margin-right: 50px;">메뉴</a>
                  <ul class="sub-menu">
                     <li>
                        <a href="http://localhost/paik_prj/customer/02.menu/newMenuPage.jsp">신메뉴</a>
                     </li>
                     <li>
                        <a href="http://localhost/paik_prj/customer/02.menu/coffeeMenuPage.jsp">커피</a>
                     </li>
                     <li>
                        <a href="http://localhost/paik_prj/customer/02.menu/drinkMenuPage.jsp">음료</a>
                     </li>
                     <li>
                        <a href="http://localhost/paik_prj/customer/02.menu/icecreamDessertMenuPage.jsp">아이스크림/디저트</a>
                     </li>
                  </ul>
               </li>
               <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-95">
                  <a href="http://localhost/paik_prj/customer/03.cart/cart.jsp" style="margin-right: 50px;">장바구니</a>
                  <ul class="sub-menu">
                     <li>
                        <a href="http://localhost/paik_prj/customer/03.cart/cart.jsp">장바구니</a>
                     </li>
                  </ul>
               </li>
               <%--
               <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-95">
                  <a href="" style="margin-right: 30px;">고객의소리</a>
                  <ul class="sub-menu">
                     <li>
                        <a href="">고객의소리</a>
                     </li>
                     <li>
                        <a href="">답변내역</a>
                     </li>
                  </ul>
               </li>
               --%>
               <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-95">
                  <a href="http://localhost/paik_prj/customer/05.mypage/mypage.jsp" style="margin-right: 180px;">마이페이지</a>
                  <ul class="sub-menu">
                     <li>
                        <a href="http://localhost/paik_prj/customer/05.mypage/mypage.jsp">마이페이지</a>
                     </li>
                     <li>
                        <a href="http://localhost/paik_prj/customer/05.mypage/chkPass.jsp">비밀번호변경</a>
                     </li>
                     <li>
                        <a href="http://localhost/paik_prj/customer/05.mypage/modify.jsp">개인정보변경</a>
                     </li>
                     <li>
                        <a href="http://localhost/paik_prj/customer/05.mypage/deleteAccount.jsp">회원탈퇴</a>
                     </li>
                     <li>
                        <a href="http://localhost/paik_prj/customer/03.cart/list_order.jsp">주문현황(내역)</a>
                     </li>
                  </ul>
               </li>
               </ul>
            </div>
         </div>
      </div>
   </div>
</header>