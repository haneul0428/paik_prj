<%@page import="java.sql.SQLException"%>
<%@page import="customer.paik.CartItemDAO"%>
<%@page import="java.util.List"%>
<%@ page import="customer.paik.CartItemVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="장바구니 페이지"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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

<jsp:useBean id="ciVO" class="customer.paik.CartItemVO" scope="page"/>
<jsp:useBean id="iVO" class="customer.paik.ItemVO" scope="page"/>
<jsp:useBean id="sVO" class="customer.paik.SearchVO" scope="page"/>
<jsp:setProperty name="ciVO" property="*"/>
<jsp:setProperty name="iVO" property="*"/>
<jsp:setProperty name="sVO" property="*"/>
<%
//장바구니 리스트 구현
//1. 총 장바구니 레코드 수 구화기
//System.out.println(cusId);
int totalCount = 0;
CartItemDAO ciDAO = CartItemDAO.getInstance();

ciVO.setCusId(cusId);

try{
	totalCount = ciDAO.selectTotalCountOrder(ciVO);
} catch(SQLException se){
	se.printStackTrace();
}

//2. 한 화면에 보여줄 주문 레코드의 수
int pageScale = 10;

//3. 총 주문 페이지 수
int totalPage = (int)Math.ceil((double)totalCount/pageScale);

//4. 시작 번호 구하기
String paramPage = request.getParameter("currentPage");

int currentPage = 1;
if(paramPage != null){
	try{
		currentPage = Integer.parseInt(paramPage);
	} catch(NumberFormatException nfe) {
		nfe.printStackTrace();
	}//end catch
}//end if

int startNum = currentPage * pageScale - pageScale + 1;// 주문 시작 번호

//5. 끝 번호 구하기
int endNum = startNum + pageScale - 1;// 주문 끝 번호

sVO.setCurrentPage(currentPage);
sVO.setStartNum(startNum);
sVO.setEndNum(endNum);
sVO.setTotalPage(totalPage);
sVO.setTotalCount(totalCount);

List<CartItemVO> cartList = null;
try {
	cartList = ciDAO.selectCartList(cusId);
} catch(SQLException se){
	se.printStackTrace();
}

pageContext.setAttribute("totalCount", totalCount);
pageContext.setAttribute("pageScale", pageScale); 
pageContext.setAttribute("totalPage", totalPage);
pageContext.setAttribute("currentPage", currentPage);
pageContext.setAttribute("startNum", startNum);
pageContext.setAttribute("endNum", endNum);	 
pageContext.setAttribute("cartList", cartList);

%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<title>빽스커피 | 장바구니</title>

<style type="text/css">
.cart { width: 100%; margin-bottom: 50px; }
.none { height: 170px; }
.mainContainer{
	max-width: 1150px;
	margin: 0 auto;
	position: relative;
	overflow: hidden;
}

.text { background-color: #EFEFEF; text-align: center; font-weight: normal; }
.dual_col { width: 650px; }
.item_img { width: 150px; margin-bottom: 10px; margin-top: 10px; margin-right: 10px; }
.item_name { width: 500px; }
.item_quant { text-align: center; min-width: 150px; }
.item_price { text-align: center; min-width: 150px; }
.item_order { text-align: center; min-width: 160px; }
.itemOrder { text-align: center; }
.itemImg { width: 80px; }

.inputNum { width: 50px; text-align: center }

.modal { display: none; position: fixed; justify-content: center; top:0; left:0; width:100%; height: 100%;
		 background-color: rgba(0,0,0,0.4);}
.modal_body { position:relative; top:50%; width: 400px; height: 400px; padding: 40px; 
			text-align: center; background-color: #FFFFFF; border-radius: 10px;
			box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);
            transform:translateY(-50%); }
/* 옵션 설정 체크박스 */
.option {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 2px;
    border-radius: 5px;
    margin-top: 20px;
    margin-bottom: 20px;
    transition: background-color 0.3s ease;
}

.btnSubmit {
	width: 48%;
	padding: 10px;
	border: none;
	background-color: #FFE800;
	color: #333;
	font-size: 16px;
	cursor: pointer;
	margin-top: 20px;
	margin-bottom: 20px;
}

.right { text-align: right; }
.total { padding: 15px; }
thead { height: 30px; }
tbody {  }
tfoot { height: 30px; }
</style>

<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/02.menu/css/paik_menu.css">
<link rel="stylesheet" id="theme-css-style-css"  href="https://paikdabang.com/wp-content/themes/paikdabang/assets/css/style.css?ver=4.9.4" type="text/css" media="all" />

<link rel="icon" href="http://localhost/paik_prj/00.common/images/favicon32x32.png" sizes="32x32" />
<link rel="icon" href="http://localhost/paik_prj/00.common/images/favicon192x192.png" sizes="192x192" />
<link rel="apple-touch-icon-precomposed" href="http://localhost/paik_prj/00.common/images/favicon180x180.png" />
<meta name="msapplication-TileImage" content="http://localhost/paik_prj/00.common/images/favicon270x270.png" />

<!-- bootstrap -->
<link href="bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />

<%-- bootstrap CDN --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<%-- jQuery CDN --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<%-- Swiper CDN --%>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<script type="text/javascript">
	$(function(){

		setTotalInfo();// 최종 가격 정보 출력
		chkCheckedAll();//

		$(".chkbox").change(function(){//체크박스의 체크 상태가 변할 경우
		setTotalInfo($(".info"));
		if($(this).is(":checked") === true){
			$(this).parent().find("input[name='hiddenChk']").val("Y");
		} else {
			$(this).parent().find("input[name='hiddenChk']").val("N");
		}
		});//change

	/* 체크박스 전체 선택 */
 		$("input[name=checkAll]").click(function(){
		  if($(this).is(":checked") === true){
			    $(".chkbox").prop("checked", true);
			    $(".hiddenChk").val("Y");
		  } else{
			    $(".chkbox").prop("checked", false);
			    $(".hiddenChk").val("N");
		  }

	  /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
			setTotalInfo($(".info"));
		});

		//orderMenuProcess.jsp으로 파라메터 전달
		$(".btnSubmit").click(function(){
		if(confirm("주문하시겠습니까?")){
			$("#frmCartList").submit();
		}//end if
		});

		/**
		* 변경 버튼 클릭시 수량을 변경하는 이벤트
		*/
		$(".updateBtn").click(function(){
		var presentQuantity = $(this).parent().parent("span").find("input[type=hidden]").val(); // 현재 수량 불러오기
		var price = $(this).parent().parent().parent().parent().find("input[class='itemPrice']").val(); // 해당 상품의 가격 불러오기
		var quantity = $(this).parent().parent("span").find("input[type=number]").val(); // 수량 불러오기
		var total = price * quantity;
		var orderTotal = $(this).parent().parent().parent().parent().parent().parent().find(".finalPrice").val(); // 총 가격의 값
		var cartItemNum = $(this).data("cartitemnum");//data눈 무조건 소문자

		orderTotal = Number(orderTotal);
		price = (quantity - presentQuantity) * price;

		var finalTotal = orderTotal + price;

		if( presentQuantity == quantity ){
			alert("변경된 수량이 없습니다.");
			return;
		}

		var param = { "quantity": quantity, "cartItemNum": cartItemNum };

		$.ajax({
			url:"update_quantity_process.jsp",
			type:"post",
			async: false,
			data: param,
			dataType: "json",
			error:function(xhr){
				console.log(xhr.status);
				alert("수량이 정상적으로 변경되지 않았습니다.");
			},
			success:function(jsonObj){
				var msg = "수량 변경 실패";
				if(jsonObj.result){//post 방식으로 잘 실행되었을 경우
					if(jsonObj.update){//양 변경에 성공했을 경우
						msg = "수량 변경에 성공했습니다.";
					}//end if
				}//end if
				alert(msg);
			}//success
		});//ajax

		$(this).parent().parent("span").find("input[type=hidden]").val(quantity);//hidden의 value를 바꿔 ajax로 수정된 수량의 값과 동일하게 맞춘다.
		$(this).parent().parent().parent().parent().find("td:eq(4)").html(total.toLocaleString() + "원");
		$(this).parent().parent().parent().parent().parent().parent().find("span[class='finalPrice_span']").html(finalTotal.toLocaleString());
		$(this).parent().parent().parent().parent().parent().parent().find(".finalPrice").val(finalTotal);//hidden의 총액도 변경
		});//click

		$(".updateBtn").ajaxSuccess(function(){//수량을 변경하는 ajax전송이 성공했을 경우
			setTotalInfo($(".info"));
		});

		//모달 영역 열기
		$(".btnOption").click(function(){
		var categorynum = $(this).data("categorynum");
		var cartitemnum = $(this).data("cartitemnum");
		const drinkmodal = document.querySelector('.drinkOptionModal');
		const icemodal = document.querySelector('.iceOptionModal');

		if(categorynum > -1 && categorynum < 2) {//커피, 음료일 경우 0
			$(".reCartItemNum").val(cartitemnum);
			drinkmodal.style.display = "flex";
		} else if(categorynum == 3) {
			$(".reCartItemNum").val(cartitemnum);
			icemodal.style.display = "flex";
		}
		});//click

			/**
		* 버튼 클릭시 해당 주문을 삭제하는 일을 하는 메소드
		*/
		$(".btnDelete").click(function(){
		var trElement = $(this).parent().parent().parent("tr");//해당 주문의 tr 태그
		var cartItemNum = $(this).parent().find("input[type=hidden]:eq(0)").val();//카트 아이템 번호
		var cartNum = $(this).parent().find("input[type=hidden]:eq(1)").val();//카트 번호

		//주문 취소를 취소할 경우 얼리 리턴
		if(!confirm("주문을 취소하시겠습니까?")){
			return;
		}

		//ajax로 넘겨줄 파라메터
		var param = { "cartItemNum" : cartItemNum, "cartNum" : cartNum };

		$.ajax({
			url: "remove_order.jsp",
			type: "post",
			data: param,
			dataType: "json",
			error: function(xhr){
				console.log(xhr.status);
				alert("주문이 정상적으로 삭제되지 않았습니다.");
			},
			success: function(jsonObj){
				var msg = "주문 삭제 실패";
				if(jsonObj.result){//post 방식으로 잘 실행되었을 경우
					if(jsonObj.update){//양 변경에 성공했을 경우
						msg = "주문을 삭제하였습니다.";
						trElement.remove();
					}//end if
				}//end if
				alert(msg);
			}//success
		});//ajax

		});//click

		//모달 영역 닫기
		$(".closeModal").click(function(){
		$(".drinkOptionModal").fadeOut();
		$(".iceOptionModal").fadeOut();
		});//click


		//모달 영역 주문 옵션 수정
		//샷, 사이즈, 시럽, 다회용, 초콜릿 토핑, 딸기 베이스
		$("#settingModal").click(function(){
		var shot = $("#shot").val() == null? "0":$("#shot").val(); // 샷 불러오기
		var size = $("#size").val() == null? "M":$("#size").val(); // 사이즈 불러오기
		var syrup = $("#syrup").val() == null? "0":$("#syrup").val(); // 시럽 수량 불러오기
		var multiCup = $("#multiCup").val() == null? "N":$("#multiCup").val(); // 재사용컵 사용 여부 불러오기
		var cartItemNum = $(this).parent().find("input[type=hidden]").val();//카트 아이템 번호 불러오기
		//var quantity = $(this).parent().parent("span").find("input[type=number]").val(); // 수량 불러오기

		var param = { "shot" : shot, "size" : size, "syrup" : syrup, "multiCup" : multiCup, "cartItemNum" : cartItemNum,
		};

		alert(" 음료 눌렸습니다 . \n 초코" +param.addChoco+"\n딸기 "+param.addStraw+"\n 샷 "+param.shot+"\n 사이즈 "+param.size+"\n 시럽"+param.syrup+"\n 다회용"+param.multiCup);

		$.ajax({
			url: "insert_order_detail.jsp",
			type: "post",
			async: true,
			data: param,
			dataType: "json",
			error:function(xhr){
				console.log(xhr.status);
				alert("옵션이 정상적으로 변경되지 않았습니다.");
			},
			success:function(jsonObj){
				var msg = "옵션 변경 실패";

				if(jsonObj.result){//post 방식으로 잘 실행되었을 경우
					if(jsonObj.update){//옵션 변경에 성공했을 경우
						msg = "옵션 변경에 성공했습니다.";
					}//end if
					alert(msg);
					}//end if
				}//success
			});//ajax
		})

		//초콜릿 토핑, 딸기 베이스
		$("#settingModal1").click(function(){
		var addChoco = $("#addChoco").val() == null? "N":$("#addChoco").val(); // 초코 토핑 여부 불러오기
		var addStraw = $("#addStraw").val() == null? "N":$("#addStraw").val(); // 딸기 베이스 여부 불러오기
		var cartItemNum = $(this).parent().find("input[type=hidden]").val();//카트 아이템 번호 불러오기

			//NPE 방지
		var syrup = $("#syrup").val() == null? "0":$("#syrup").val(); // 시럽 수량 불러오기
		var shot = $("#shot").val() == null? "0":$("#shot").val(); // 샷 불러오기

		var param = {"addChoco" : addChoco, "addStraw" : addStraw, "cartItemNum" : cartItemNum, "syrup":syrup,"shot":shot
		};

		alert("아이스크림 눌렸습니다. \n 초코" +param.addChoco+"\n딸기 "+param.addStraw+"\n 샷 "+param.shot+"\n 사이즈 "+param.size+"\n 시럽"+param.syrup+"\n 다회용"+param.multiCup);

		$.ajax({
			url: "insert_order_detail.jsp",
			type: "post",
			async: true,
			data: param,
			dataType: "json",
			error:function(xhr){
				console.log(xhr.status);
				alert("옵션이 정상적으로 변경되지 않았습니다.");
			},
			success:function(jsonObj){
				var msg = "옵션 변경 실패";

				if(jsonObj.result){//post 방식으로 잘 실행되었을 경우
					if(jsonObj.update){//옵션 변경에 성공했을 경우
						msg = "옵션 변경에 성공했습니다.";
					}//end if
					alert(msg);
				}//end if
			}//success
		});//ajax
	});//ready
})
</script>

	<script>
/**
 * 전체 체크박스 활성화시 모든 하위 체크박스 활성화, 그 후 가격 정보 
 */
function chkCheckedAll(){
	
	if($("input[name=checkAll]").is(":checked") === true){
	    $(".chkbox").prop("checked", true);		  
	  }
	
	setTotalInfo($(".info"));
}//chkCheckedAll

/**
 * 최종 가격 정보를 보여주는 메소드
 */
function setTotalInfo(){
	let totalPrice = 0;	// 총 가격
	let totalCnt = 0;	// 총 개수
	let finalPrice = 0;	// 최종 가격
	
	$(".info").each(function(index, element){

		if($(element).find(".chkbox").is(":checked") === true){// 해당 체크 박스가 체크되었을 경우
			//총 가격
			totalPrice += parseInt($(element).find(".totalPrice").val());
			//총 개수
			totalCnt += parseInt($(element).find(".itemCnt").val());
		}//end if
		
	});//each
	
	finalPrice = totalPrice;
	//최종 가격
	$(".finalPrice").val(finalPrice);
	$(".finalPrice_span").text(finalPrice.toLocaleString());

}//setTotalInfo
</script>

</head>

<body>

<div id="wrap">
<div id="header">
<jsp:include page="/customer/00.common/jsp/header.jsp"/>
</div>

<div id="content-wrap">
<div class="sub_visual bg-menu2">
	<div class="txt">
		<h1>장바구니</h1>
		<!-- <p>뉴 크롭 원두를 사용해 더 신선한 커피 메뉴를 만나보세요.</p> -->
	</div>
</div>
<div class="sub_section menu_wrap">
	<div class="mainContainer">
		<h2 class="main_tit3 color-1">주문 목록</h2>
		
		
		<div class="all_chk">
			<!-- 전체 체크박스(활성화) -->
			<input type="checkbox" id="checkAll" name="checkAll" checked="checked"/><span class="all_chk_span">전체선택</span>
		</div>
		
		<form action="orderMenuProcess.jsp" id="frmCartList" name="frmCartList" method="post" accept-charset="UTF-8">
		<table class="cart">
		<thead>
		<tr>
			<th colspan="3" class="text dual_col">정보</th>
			<th class="text item_quant">수량</th>
			<th class="text item_price">계산금액</th>
			<th class="text item_order">주문</th>
		</tr>
		</thead>
		<tbody>
		<c:choose>
			<%-- 해당 사용자의 주문 내역이 없을 경우 --%>
			<c:when test="${ empty cartList }">
			<tr>
	        	<td style="text-align: center" colspan="6" class="none">
				<h3 style="text-align: center;">주문 내역이 없습니다.</h3>
	        	</td>
	        </tr>
			</c:when>
			<%-- 해당 사용자의 주문 내역이 있을 경우 --%>
			<c:otherwise>
			<c:forEach var="ciVO" items="${ cartList }" varStatus="i">
			<tr>
				<td class="info">
					<input type="checkbox" name="chkbox" class="chkbox"/>
					<input type="hidden" name="hiddenChk" class="hiddenChk" value="Y"/>
					<input type="hidden" name="chkPrice" class="itemPrice" value="${ ciVO.price }">				
					<input type="hidden" name="chkCount" class="itemCnt" value="${ ciVO.quantity }">				
					<input type="hidden" name="chkTotal" class="totalPrice" value="${ ciVO.price * ciVO.quantity }">				
				</td>
				<td class="item_img">
					<img src="${ ciVO.image }" class="itemImg">
				</td>
				<td class="item_name"><c:out value="${ ciVO.itemName }"/></td>
				<td class="item_quant">
					<span class="opt_num">
						<input type="number" name="inputNumArr" class="inputNum" min="1" max="9" value="${ ciVO.quantity }" />
						<input type="hidden" name="preNum" class="preNum" value="${ ciVO.quantity }" />
						<div class="update" style="text-align: center; margin-top: 5px;">
						<input type="button" class="btn btn-secondary updateBtn" value="변경" data-cartitemnum="${ ciVO.cartItemNum }" style="display: inline-block;"/>
						</div>
					</span>
				</td>
				<td class="item_price"><fmt:formatNumber value="${ ciVO.price * ciVO.quantity }" pattern="###,###원"/></td>
				<td class="item_order">
					<div class="itemOrder">
						<c:if test="${ ciVO.categoriesNum ne 2 }">
						<input type="button" class="btn btn-primary btnOption" value="옵션설정" data-categorynum="${ ciVO.categoriesNum }"
							data-cartitemnum="${ ciVO.cartItemNum }" style="display: inline-block; margin-bottom: 5px"/><br>
						</c:if>
						<input type="button" class="btn btn-primary btnDelete" value="삭제하기" style="display: inline-block; margin-bottom: 5px"/><br>
						<input type="hidden" name="cartItemNumArr" class="cartItemNum" value="${ ciVO.cartItemNum }" />
						<input type="hidden" name="cartNumArr" class="cartNum" value="${ ciVO.cartNum }" />
						<input type="hidden" name="categoriesNumArr" class="categoriesNum" value="${ ciVO.categoriesNum }" />
					</div>
				</td>
			</tr>		
			</c:forEach>
			</c:otherwise>		
		</c:choose>
		</tbody>
		<tfoot>
		<tr>
		<td class="text right total" colspan="6">
		상품 총 금액: 
		<strong><span class="finalPrice_span">0</span>원</strong></td>
		<input type="hidden" class="finalPrice" />
		</tr>
		</tfoot>
		</table>
		<div style="text-align: center;">
		<input type="button" class="btnSubmit" value="주문하기" />
		</div>
		</form>
	</div>
</div>
</div>

<!-- 수량 조절 영역 -->

<!-- 모달 영역 -->
<div class="modal drinkOptionModal">
	<div class="modal_body">
		<h2>옵션 설정</h2>
		<input type="hidden" class="reCartItemNum" value=""/>
			<div class="option">
		        <label for="shot-option">샷 추가</label>
		        <select size="1" id="shot" name="shotArr" class="inputBox">
		           	<option value="">--선택--</option>
		           	<option value="0" selected="selected">0</option>
		          	<option value="1">1</option>
		           	<option value="2">2</option>
		           	<option value="3">3</option>
		           	<option value="4">4</option>
		           	<option value="5">5</option>
		           	<option value="6">6</option>
		           	<option value="7">7</option>
		           	<option value="8">8</option>
		           	<option value="9">9</option>
		    	</select>
		    </div>
			<div class="option">
		    <label for="size-option">사이즈 선택</label>
		    <select size="1" id="size" name="sizeArr" class="inputBox">
		    	<option value="">--선택--</option>
		    	<option value="S">S</option>
		    	<option value="M" selected="selected">M</option>
		    	<option value="L">L</option>
		    </select>
		    </div>
		    <div class="option">
		    	<label for="syrup-option">시럽 추가</label>
		        <select size="1" id="syrup" name="syrupArr" class="inputBox">
		           	<option value="">--선택--</option>
		           	<option value="0" selected="selected">0</option>
		            <option value="1">1</option>
		            <option value="2">2</option>
		            <option value="3">3</option>
		            <option value="4">4</option>
		            <option value="5">5</option>
		            <option value="6">6</option>
		            <option value="7">7</option>
		            <option value="8">8</option>
		            <option value="9">9</option>
		      	</select>
	    	</div>
		    <div class="option">
		    	<label for="reusable-cup">다회용 컵 사용</label>
		       	<select size="1" id="multiCup" name="cupArr" class="inputBox">
		       		<option value="">--선택--</option>
		       		<option value="Y">사용</option>
		       		<option value="N" selected="selected">사용하지 않음</option>
		       	</select>
			</div>
			<input type="button" class="settingModal" id="settingModal" value="설정" style="display: inline;"/>
			<input type="button" class="closeModal" value="닫기" style="display: inline-block;"/>
	</div>
</div>
<div class="modal iceOptionModal">
	<div class="modal_body">
		<h2>옵션 설정</h2>
		<input type="hidden" class="reCartItemNum" />
			<div class="option">
		        <label for="extra-shot">초콜릿 토핑 추가</label>
		        <select size="1" id="addChoco" name="addChocoArr" class="inputBox">
		           	<option value="">--선택--</option>
		       		<option value="Y">추가</option>
		       		<option value="N" selected="selected">추가하지 않음</option>
		    	</select>
		    </div>
			<div class="option">
		        <label for="extra-shot">딸기 베이스 추가</label>
		        <select size="1" id="addStraw" name="addStrawArr" class="inputBox">
		           	<option value="">--선택--</option>
		       		<option value="Y">추가</option>
		       		<option value="N" selected="selected">추가하지 않음</option>
		    	</select>
		    </div>
			<input type="button" class="settingModal" id="settingModal1" value="설정" style="display: inline;"/>
			<input type="button" class="closeModal" value="닫기" style="display: inline-block;"/>
	</div>
</div>


<div id="footer">
<jsp:include page="/customer/00.common/jsp/footer.jsp"/>
</div>
</div>

</body>
</html>