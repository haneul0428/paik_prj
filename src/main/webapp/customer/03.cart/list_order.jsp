<%@ page import="customer.paik.OrderDAO" %>
<%@ page import="customer.paik.ItemDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="customer.paik.OrderVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" info="사용자 수정화면"%>

<%

	// 현재 접속하고 있는 URL을 저장 (반드시 리다이렉트 전에 수행)
	String currentUrl = request.getRequestURI();
	session.setAttribute("currentUrl", currentUrl); // 세션에 현재 URL 저장
	// 로그인 여부 체크
	String cusId = (String) session.getAttribute("cusId"); // 로그인된 사용자의 ID 세션에서 가져오기
	// 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
	if (cusId == null || cusId.isEmpty()) {
		// 로그인되지 않았을 때 로컬 스토리지에 현재 URL을 저장하고 로그인 페이지로 리다이렉트
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write("<script type=\"text/javascript\">\n" +
				"    localStorage.setItem('returnUrl', '" + currentUrl + "');\n" +
				"    alert('이 페이지는 로그인이 필요한 페이지입니다.');\n" +
				"    location.href = 'http://localhost/paik_prj/customer/06.customer/loginPage.jsp';\n" +
				"</script>");
		return;
	}
%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">
	<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_kl.css">
	<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_extend.css">
	<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_normal.css">
	<link rel='stylesheet' href='https://paikdabang.com/wp-content/themes/paikdabang/assets/css/style.css?ver=4.9.4' type='text/css' media='all' />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
	<title>빽스커피 | 주문내역</title>
<style type="text/css">
	/* 기본 바디 스타일 */
	body {
		background-color: #fff;
		color: #333;
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}

	/* 컨테이너 레이아웃 */
	#content-wrap {
		min-height: 100vh;
		display: flex;
		flex-direction: column;
		position: relative;
	}

	/* 헤더/푸터 고정 */
	#header, #footer {
		flex-shrink: 0;
	}

	/* 리스트 컨테이너 스타일 */
	.list_container {
		max-width: 800px;
		width: 100%;
		height: 100%;
		margin: 20px auto;
		padding: 20px;
		background-color: #fff;
		border-radius: 8px;
		box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
		position: relative;
		flex: 1;
	}

	/* 주문 아이템 스타일 */
	.order-item {
		border: 1px solid #e0e0e0;
		border-radius: 8px;
		margin: 15px 0;
		padding: 15px;
		background: #fff;
		min-height: 200px ;
	}

	/* 주문 날짜 스타일 */
	.order-date {
		font-size: 14px;
		color: #666;
		margin-bottom: 10px;
		padding-bottom: 10px;
		border-bottom: 1px solid #eee;
	}

	/* 아이템 상세 스타일 */
	.item-details {
		display: flex;
		flex-direction: column;
		gap: 15px;
	}

	.item-info {
		display: flex;
		gap: 15px;
	}

	.item-image {
		width: 80px;
		height: 80px;
		object-fit: cover;
		border-radius: 4px;
	}

	.item-text {
		flex: 1;
	}

	.item-name {
		font-size: 16px;
		font-weight: bold;
		margin: 0 0 5px 0;
	}

	.item-description {
		font-size: 14px;
		color: #666;
		margin: 5px 0;
		line-height: 1.4;
	}

	.item-price-qty {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-top: 10px;
	}

	/* 가격 관련 스타일 */
	.price {
		font-weight: bold;
	}

	.quantity {
		color: #666;
	}

	.order-total {
		display: flex;
		justify-content: space-between;
		padding-top: 10px;
		border-top: 1px solid #eee;
		font-weight: bold;
	}

	.total-price {
		color: #d41200;
	}

	.total {
		position: absolute;
		bottom: 20px;
		right: 20px;
		font-size: 20px;
		margin: 0;
	}

	h1 {
		text-align: center;
		margin-bottom: 20px;
	}

</style>
</head>
<body>
<div id="header"><jsp:include page="/customer/00.common/jsp/header.jsp"/></div>
<div id="content-wrap">
	<div class="sub_visual bg-paik">
		<div class="txt">
			<h1>주문내역</h1>
		</div>
	</div>

	<%
		ItemDAO iDAO = ItemDAO.getInstance();
		OrderDAO oDAO = OrderDAO.getInstance();
		List<OrderVO> orderList = null;

		int cartNum=0;
		try {
			cartNum = iDAO.fetchCartNum(cusId);
			orderList = oDAO.selectAllOrder(cartNum);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pageContext.setAttribute("orderList", orderList);
	%>

	<div class="list_container">
		<h1>최근 주문 내역</h1>

		<c:if test="${empty orderList}">
			<div class="order-item empty-order" style="text-align: center; font-size: 20px; padding: 50px 0;">
				<strong style="font-size: 24px; color: #333; font-weight: bold; display: block; margin-bottom: 20px;">주문하신 상품이 없습니다.</strong>
				<!-- 메뉴 보러가기 버튼 -->
				<div class="order-button">
					<a href="http://localhost/paik_prj/customer/02.menu/newMenuPage.jsp" class="btn btn-order" style="padding: 15px 30px; background-color: #f8a541; color: #fff; font-size: 18px; border-radius: 25px; text-decoration: none; transition: all 0.3s ease;">
						따끈 따끈한 신메뉴 보러가기
					</a>
				</div>
			</div>
		</c:if>
		<c:forEach var="oVO" items="${orderList}" varStatus="i">
			<div class="order-item">
				<div class="order-date" style="font-size: 18px;"> 주문일 <fmt:formatDate value="${oVO.inputDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
				<div class="item-details">
					<div class="item-info">
						<img src="${oVO.image}" alt="${oVO.iNameK}" class="item-image" style="width: 135px; height: 135px; object-fit: cover;">
						<div class="item-text" style="min-height: 150px;">
							<h3 class="item-name" style="font-size: 22px;margin-top: 10px;margin-bottom: 20px"><c:out value="${oVO.iNameK}"/></h3>
							<p class="item-description" style="font-size: 16px; margin-bottom: 20px;">
								<c:if test="${oVO.ingredient_flag eq 'N'}">
								<c:choose>
									<c:when test="${empty oVO.topping and empty oVO.base and oVO.categories_num eq 0 or oVO.categories_num eq 1}">
		                              <strong>사이즈 [${oVO.drinkSize == null? "M":oVO.drinkSize}] </strong><br>
		                              <strong>샷추가 [${oVO.shot}] 번 </strong><br>
		                              <strong>시럽추가 [${oVO.syrup}] 번 </strong><br>
		                           </c:when>
		                           <c:when test="${empty oVO.drinkSize  and oVO.categories_num eq 3}">
		                              <strong>토핑&베이스 : <br>${oVO.base=='Y'?"딸기 베이스 추가 <br>":"베이스 추가 없음"}  ${oVO.topping=='Y'?"초코 토핑 추가 <br>":"토핑 추가 없음"}</strong>
		                           </c:when>
								</c:choose>
								</c:if>
							</p>
						</div>
					</div>
					<div class="item-price-qty" style="margin-bottom: 10px;">
						<span class="price" style="font-size: 18px;"><fmt:formatNumber value="${oVO.price}" pattern="#,###"/>원</span>
						<span class="quantity" style="font-size: 18px;"><c:out value="${oVO.quantity}"/>개</span>
					</div>
					<div class="order-total" style="height: 40px; border-top: 1px solid #ddd; padding-top: 10px;">
						<span style="font-size: 18px;">총 결제 금액</span>
						<span class="total-price" style="font-size: 18px;"> <fmt:formatNumber value="${oVO.total}" pattern="#,###"/>원</span>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<div id="footer"><jsp:include page="/customer/00.common/jsp/footer.jsp"/></div>
</body>
</html>
