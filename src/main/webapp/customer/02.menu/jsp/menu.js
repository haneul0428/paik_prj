$(function(){
	const swiper = new Swiper('.swiper-container', {
		loop: true,
		centeredSlides: true,
		slidesPerView: 2,
		spaceBetween: 0,
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},
		on: {
			init: function () {
				$('.swiper-button-next').css('color', 'yellow');
				$('.swiper-button-prev').css('color', 'yellow');
			}
		}
	});
	
	const menuItems = $(".menuItem");
	const menuInfo = $(".menuInfo");
	const closeInfo = $(".closeInfo");
	
	var selectItemNum = null;
	
	//menuItem에 클릭 이벤트 설정
	menuItems.on("click", function() {
		const itemNum = $(this).closest("li").data("item-num");
		const clickedImage = this;	//클릭한 이미지 저장
		selectItemNum = itemNum;
		
		$.ajax({
			url: "./menuDetails.jsp",
			type: "get",
			data: { item_num: itemNum },
			dataType: "json",
			error: function(xhr) {
				alert("아이템 정보를 불러오는데 실패했습니다.");
			},
			success: function (data) {
				//메뉴 정보 표시
				menuInfo.find(".itemName").text(data.iNameKor);
				menuInfo.find(".itemEngName").text(data.iNameEng);
				menuInfo.find(".itemContent").text(data.description);
				menuInfo.find(".itemPrice").text(data.price);
				if(data.ingredientFlag == 'N'){
					menuInfo.find(".ingredientsTable").html(
						"<tr>" + 
							"<td>카페인(mg)</td><td>" + (data.caffeine) + "</td>" +
							"<td>칼로리</td><td>" + (data.calorie) + "</td>" +
						"</tr>" +
						"<tr>" +
							"<td>나트륨</td><td>" + (data.natrium) + "</td>" +
				    		"<td>당류</td><td>" + (data.sugar) + "</td>" +
				    	"</tr>" +
						"<tr>" +
							"<td>포화지방</td><td>" + (data.fatty_acid) + "</td>" +
							"<td>단백질</td><td>" + (data.protein) + "</td>" +
				    	"</tr>"
					);
				} else {
					menuInfo.find(".ingredientsTable").html("");
				}//if~el
				
				//이미지 중앙값 계산
				const rect = clickedImage.getBoundingClientRect();
				const containerRect = $(".mainContainer").get(0).getBoundingClientRect();
				
				const centerX = rect.left + rect.width / 2 - menuInfo.outerWidth() / 2 - containerRect.left;
				const centerY = rect.top + rect.height / 2 - menuInfo.outerHeight() / 2 - containerRect.top;
				
				menuInfo.css({
					left: centerX + "px",
					top: centerY + "px",
					display: "block"
				});
			}
		});//ajax
	});
	
	//닫기(X) 클릭
	closeInfo.on("click", function() {
		menuInfo.hide();
	});
	
	//menuInfo 클릭
	menuInfo.on("click", function(evt) {
		if(evt.target != closeInfo[0]){
			menuInfo.hide();
		}//if
	});
	
	//담기 클릭
	$("#putBtn").click(function() {
		if(confirm("장바구니에 담으시겠습니까?")){
			if(!loginFlag){	//비로그인, 로그인 창으로 이동
				alert("로그인 후 이용하실 수 있습니다.");
				location.href = "http://localhost/paik_prj/customer/06.customer/loginPage.jsp";
			} else {	//로그인 성공
				//장바구니 상품 추가 코드
				//console.log(selectItemNum);	//선택한 아이템 번호 가져오기
				$.ajax({
					url: "http://localhost/paik_prj/customer/02.menu/addToCart.jsp",
					type: "post",
					data: { item_num: selectItemNum, quantity: 1 },
					dataType: "json",
					error: function(xhr) {
						console.log(xhr.status);
						alert("장바구니에 상품을 추가하는데 실패했습니다.");
					},
					success: function(jsonObj) {
						if(jsonObj.addFlag){
							//alert(jsonObj.addMsg);	//성공
							if(confirm("장바구니에 상품을 추가했습니다.\n장바구니로 이동하시겠습니까?")){
								location.href="http://localhost/paik_prj/customer/03.cart/cart.jsp";
							}//if
						} else {
							alert(jsonObj.addMsg);	//실패
						}
					}
				});//ajax
			}//if~el
		}//if
	});
});//ready()