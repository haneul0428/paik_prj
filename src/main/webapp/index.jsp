<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="사용자 메인화면"
    %>
<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<title>빽스커피</title>

<style type="text/css">
.main_section section a.view_btn:hover{
	background-image: url('http://localhost/paik_prj/customer/00.common/images/btnImg.png') !important;
    background-repeat: no-repeat;
    background-position: center;
    background-color: #FFF;
}
</style>

<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_kl.css">
<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_normal.css">
<link rel="stylesheet" type="text/css" href="http://localhost/paik_prj/customer/00.common/css/paik_extend.css">
<link rel="stylesheet" id="theme-css-style-css"  href="https://paikdabang.com/wp-content/themes/paikdabang/assets/css/style.css?ver=4.9.4" type="text/css" media="all" />

<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png" sizes="32x32" />
<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png" sizes="192x192" />
<link rel="apple-touch-icon-precomposed" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png" />
<meta name="msapplication-TileImage" content="http://localhost/paik_prj/customer/00.common/images/btnImg.png" />

<%-- bootstrap CDN --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<%-- jQuery CDN --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

</head>

<body>
<div id="wrap">
<div id="header">
<jsp:include page="/customer/00.common/jsp/header.jsp"/>
</div>

<div id="content-wrap">
<div id="primary" class="content-area">
<main id="main" class="site-main" role="main">

<article id="post-13" class="post-13 page type-page status-publish hentry">
<div class="entry-content">
<div class="main_visual_wrap">
    <div class="swiper-wrapper">
        <div class="swiper-slide">
        	<img src="http://localhost/paik_prj/customer/00.common/images/swipe_slider01.jpg" alt="">
        </div>
        <div class="swiper-slide">
        	<img src="http://localhost/paik_prj/customer/00.common/images/swipe_slider02.jpg" alt="">
        </div>
        <div class="swiper-slide">
        	<img src="http://localhost/paik_prj/customer/00.common/images/swipe_slider03.png" alt="">
        </div>
        <div class="swiper-slide">
        	<img src="http://localhost/paik_prj/customer/00.common/images/swipe_slider04.jpg" alt="">
        </div>
        <!-- <div class="swiper-slide">
        	<img src="http://localhost/paik_prj/customer/00.common/images/swipe_slider05.jpg" alt="">
        </div> -->
        <div class="swiper-slide">
        	<img src="http://localhost/paik_prj/customer/00.common/images/swipe_slider06.jpg" alt="">
        </div>
        <div class="swiper-slide">
        	<img src="http://localhost/paik_prj/customer/00.common/images/swipe_slider07.jpg" alt="">
        </div>
	</div>
    <div class="swiper-pagination"></div>
</div>

<script>
    const swiper = new Swiper('.main_visual_wrap', {
        loop: true,
        autoplay: {
            delay: 5000,
        },
        pagination: {
            el: '.swiper-pagination', 
            clickable: true,
        },
    });
</script>

<div class="main_section">
	<section class="main_sec01 sec_hover">
		<div class="left_wrap sec_hover">
			<a href="http://localhost/paik_prj/customer/01.paik/coffeeStory.jsp">
				<dl>
					<dt>PAIK’S COFFEE<br/>STORY</dt>
					<dd>균형잡힌 바디감으로 긴 여운을 남기는 빽스커피를 만나보세요.</dd>
				</dl>
				<a class="view_btn" href="http://localhost/paik_prj/customer/01.paik/coffeeStory.jsp"><span>커피 이야기 보러가기</span></a>
			</a>
		</div>
		<div class="right_wrap sec_hover">
			<a href="http://localhost/paik_prj/customer/01.paik/introduction.jsp">
				<dl>
					<dt>PAIK’S BRAND<br/>STORY</dt>
					<dd>합리적인 가격으로 만나는 맛있고 든든한 빽스커피</dd>
				</dl>
				<a class="view_btn" href="http://localhost/paik_prj/customer/01.paik/introduction.jsp"><span>빽다방 소개 보러가기</span></a>
			</a>
		</div>
	</section>
	
	<section class="main_sec02 sec_hover">
		<a href="http://localhost/paik_prj/customer/02.menu/coffeeMenuPage.jsp">
			<dl class="main_tt">
				<dt>FRESH<br/>COFFEE</dt>
				<dd>신선한 뉴크롭 원두를 사용하여<br/>추출한 커피메뉴!</dd>
			</dl>
			<img class="pc" src="http://localhost/paik_prj/customer/00.common/images/main_sec2.jpg" alt="">
			<img class="mo" src="http://localhost/paik_prj/customer/00.common/images/mmain_sec2.jpg" alt="">
		</a>
		<a class="view_btn" href="http://localhost/paik_prj/customer/02.menu/coffeeMenuPage.jsp"><span>커피 메뉴 보러가기</span></a>
	</section>
  
	<section class="main_sec02 sec_hover">
		<a href="http://localhost/paik_prj/customer/02.menu/drinkMenuPage.jsp">
			<dl class="main_tt">
				<dt>VARIOUS<br/>BEVERAGE</dt>
				<dd>에이드, 티, 주스 등 취향대로<br/>골라 먹는 즐거움!</dd>
			</dl>
			<img class="pc" src="http://localhost/paik_prj/customer/00.common/images/main_sec3.jpg" alt="">
			<img class="mo" src="http://localhost/paik_prj/customer/00.common/images/mmain_sec3.jpg" alt="">
		</a>
		<a class="view_btn" href="http://localhost/paik_prj/customer/02.menu/drinkMenuPage.jsp"><span>음료 메뉴 보러가기</span></a>
	</section>
  
	<section class="main_sec02 sec_hover">
		<a href="http://localhost/paik_prj/customer/02.menu/icecreamDessertMenuPage.jsp">
			<dl class="main_tt">
				<dt>TASTY<br/>ICE CREAM /<br/>DESSERT</dt>
				<dd>달콤한 아이스크림부터<br/>든든한 브레드까지!</dd>
			</dl>
			<img class="pc" src="http://localhost/paik_prj/customer/00.common/images/main_sec5.jpg" alt="">
			<img class="mo" src="http://localhost/paik_prj/customer/00.common/images/mmain_sec5.jpg" alt="">
		</a>
		<a class="view_btn" href="http://localhost/paik_prj/customer/02.menu/icecreamDessertMenuPage.jsp"><span>아이스크림/디저트 메뉴 보러가기</span></a>
	</section>
	
	<!-- <div class="main_sns">
		<dl class="sns_tt">
			<dt>빽스커피</dt>
			<dd><span>#빽스커피</span><span>#빽스</span><span>#이름</span></dd>
		</dl>
	    <div class="feed_box">
	    	<ul></ul>
	  	</div>
	</div> -->
</div>

</div>
</article>
</main>

</div>
</div>

<div id="footer">
<jsp:include page="/customer/00.common/jsp/footer.jsp"/>
</div>
</div>

</body>
</html>