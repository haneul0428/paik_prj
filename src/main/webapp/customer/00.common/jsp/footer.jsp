<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="공통디자인 - 사용자 페이지 footer"
    %>
<footer>
<div class="container">
	<div class="in_footer">
		<a class="logo" href=""><img src="http://localhost/paik_prj/customer/00.common/images/logo-5.png" alt="빽스커피로고"></a>
		<a class="logo light" href=""><img src="http://localhost/paik_prj/customer/00.common/images/logo-5.png" alt="빽스커피로고"></a>
		<div class="company_info">
			<ul>
				<li>(주)빽스커피</li>
				<li>사업자등록번호: 123-45-67890</li>
				<li>대표: 김현우 김하늘 유조혁 정미영</li>
			</ul>
			<ul>
				<li>주소: 서울특별시 강남구 테헤란로 132(역삼동) 한독약품빌딩 8층 쌍용교육센터 7강의실</li>
			</ul>
			<ul>
				<li>전화: 02-3482-4632-7</li>
				<li>메일: paiks@sist.co.kr</li>
			</ul>
			<p class="copyright">COPYRIGHT&copy; 2024 쌍용교육센터 7강의실. ALL RIGHTS RESERVED</p>
		</div>
	</div>

	<div class="to_top">
		<span></span>
	</div>
</div>
</footer>
<script type="text/javascript">
//MOBILE MENU
jQuery("header .nav .nav-icon").click(function() {
	jQuery(this).toggleClass("active");
	jQuery("header .navbar").toggleClass("active");

	jQuery(".overlay").fadeToggle();
	jQuery(".overlay").css("z-index","1");
});
jQuery(document).on("click","header .navbar.active .menu-item-has-children>a",function() {
	jQuery(this).removeAttr("href");
	jQuery(this).toggleClass("on");
	jQuery(this).next(".sub-menu").slideToggle().parents().siblings().children(".sub-menu").slideUp();
});

//PC MENU
jQuery(".in_header .nav .navbar>.menu-item-has-children").on("mouseenter",function(){
	jQuery(".sub-bg").addClass("on");
});
jQuery(".in_header .nav .navbar>.menu-item-has-children").on("mouseleave",function(){
	jQuery(".sub-bg").removeClass("on");
});

//TOP button
$(window).scroll(function(){
	if($(this).scrollTop() > 1){
		$('.to_top').fadeIn();
	}else{
		$('.to_top').fadeOut();
	}
});
jQuery('.to_top').click(function() {
	jQuery('html, body').animate({
		scrollTop: 0
	}, 400);
	return false;
});
</script>