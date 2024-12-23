<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="교육이야기 화면"
    %>
<jsp:include page="/customer/00.common/jsp/remove_password_verified.jsp"/>
<!DOCTYPE html>
<html lang="ko-KR">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
<link rel="shortcut icon" type="image/x-icon" href="http://localhost/paik_prj/customer/00.common/images/btnImg.png">

<title>빽스커피 | 교육이야기</title>

<style type="text/css">
	
</style>

<link rel="stylesheet" id="theme-css-style-css" href="https://paikdabang.com/wp-content/themes/paikdabang/assets/css/paiks_style.css" type="text/css" media="all">
<link rel="stylesheet" id="theme-css-style-css"  href="https://paikdabang.com/wp-content/themes/paikdabang/assets/css/style.css?ver=4.9.4" type="text/css" media="all" />

<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon32x32.png" sizes="32x32" />
<link rel="icon" href="http://localhost/paik_prj/customer/00.common/images/favicon192x192.png" sizes="192x192" />
<link rel="apple-touch-icon-precomposed" href="http://localhost/paik_prj/customer/00.common/images/favicon180x180.png" />
<meta name="msapplication-TileImage" content="http://localhost/paik_prj/customer/00.common/images/favicon270x270.png" />

<%-- bootstrap CDN --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<%-- jQuery CDN --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	
});//ready()
</script>

</head>

<body>
<div id="wrap">

<div id="header">
<jsp:include page="/customer/00.common/jsp/header.jsp"/>
</div>

<script>
jQuery(document).ready(function(){
	jQuery('.menu-item-1019 a').attr('target','_blank');
	jQuery('.menu-item-17246 a').attr('target','_blank');
	jQuery('.menu-item-17247 a').attr('target','_blank');
});
</script>

<div id="content-wrap">
<div id="primary" class="content-area">
<main id="main" class="site-main" role="main">
<article id="post-17763" class="post-17763 page type-page status-publish hentry">
<div class="entry-content">
<p><%-- 서브타이틀 --%></p>
	<div class="sub_visual bg-paik">
	<div class="txt">
		<h1>빽스커피</h1>
		<p>합리적인 가격, 놀라운 퀄리티의 커피전문점 &#8220;빽스커피&#8221;입니다.</p>
	</div>
	<ul class="page_tab st-2">
		<li><a href="http://localhost/paik_prj/customer/01.paik/introduction.jsp">빽스커피 소개</a></li>
		<li><a href="http://localhost/paik_prj/customer/01.paik/coffeeStory.jsp">커피 이야기</a></li>
		<li class="on"><a href="http://localhost/paik_prj/customer/01.paik/educationStory.jsp">교육 이야기</a></li>
	</ul>
	</div>
<p><%-- //서브타이틀 --%></p>

<div class="edu_story">
	<div class="barista_con">
		<h2 class="con_tt">빽<em>&#8216;S</em> 바리스타란?</h2>
		<dl class="bari_info">
			<dt><em>빽스커피만의 자격검정제도</em>로, <span class="block_txt">커피 추출, 메뉴 제조, 위생, 고객 응대 및 서비스 등</span> 빽스커피 바리스타로서의 역량을 섬세하게 평가하는 제도입니다.</dt>
			<dd>한국산업인력공단에서 인증을 완료한 사업 내 자격검정 제도입니다. (2급 : 19년 9월 / 1급 : 20년 7월 인증 완료)</dd>
		</dl>
		
		<ul>
			<li>
				<div class="bari_img"><img src="http://localhost/paik_prj/customer/01.paik/images/barista_img01.jpg" alt="바리스타 2급" /></div>
				<div class="bari_txt">
					<span>바리스타 2급</span>
					<p>커피 추출, 스티밍, 메뉴 제조 및 응대 관련 기술 평가</p>
					<dl>
						<dt>응시 자격</dt>
						<dd>빽<em>&#8216;S</em> 바리스타 2급 특강을 이수한 모든 가맹점 점주와 직원</dd>
					</dl>
					<dl>
						<dt>검정 과목 및 방법</dt>
						<dd><span>커피 이론 기초교육</span><span>기본 추출 실습 교육</span><span>필기테스트</span><span>실기테스트</span></dd>
					</dl>
				</div>
			</li>
			
			<li>
				<div class="bari_img"><img src="http://localhost/paik_prj/customer/01.paik/images/barista_img02.jpg" alt="바리스타 1급" /></div>
				<div class="bari_txt">
					<span>바리스타 1급</span>
					<p>2급의 기술을 더 정확하고 신속하게 이행할 수 있도록 하며, <span class="block_txt">라떼 아트를 적용한 메뉴 제공이 가능한지를 평가</span></p>
					<dl>
						<dt>응시 자격</dt>
						<dd>바리스타 2급을 취득하고 빽<em>&#8216;S</em> 바리스타 1급 특강 교육과정을 이수한 가맹점 점주와 직원 <p>(* 바리스타 2급 취득 후 1년 이내 응시 가능)</p></dd>
					</dl>
					<dl>
						<dt>검정 과목 및 방법</dt>
						<dd><span>커피 이론 기초교육</span><span>라떼아트 실습 교육</span><span>필기테스트</span><span>실기테스트</span></dd>
					</dl>
				</div>
			</li>
		</ul>
	</div>
	
	<div class="qualifying_con">
		<div class="con_align">
			<dl class="qualif_info">
				<dt class="qualif_tt">&#8220;빽&#8217;S 바리스타&#8221;라는 사업 내 자격검정을 통하여 <span class="block_txt">더 전문적인 바리스타의 커피를 빽스커피에서 만날 수 있습니다.</span></dt>
				<dd><em>* 사업 내 자격검정이란?</em>
					<p>사업주가 근로자의 직무능력 향상을 위해 자체 자격검정제도를 도입, 운영하는 것</p>
					<p>국가 자격으로 검정하기 어려운 특수 직무를 한국산업인력공단에서 평가하여 사업 내 자격으로 인증하는 제도</p>
				</dd>
			</dl>
			
			<div class="goal_con">
				<h3 class="qualif_tt">도입목표</h3>
				<ul>
					<li>
						<div class="goal_img"><img src="http://localhost/paik_prj/customer/01.paik/images/goal_img01.jpg" alt="브랜드 일관성" /></div>
						<dl>
							<dt>브랜드 일관성</dt>
							<dd>빽스커피의 생산성과 품질의 상향평준화로 <span class="block_txt">일관성 있는 서비스를 제공합니다.</span></dd>
						</dl>
					</li>
					
					<li>
						<div class="goal_img"><img src="http://localhost/paik_prj/customer/01.paik/images/goal_img02.jpg" alt="고객 신뢰" /></div>
						<dl>
							<dt>고객 신뢰</dt>
							<dd>전문 바리스타를 양성하여 <span class="block_txt">고객 응대 서비스 및 소통 수준과</span> 브랜드에 대한 고객 이해도를 높입니다.</dd>
						</dl>
					</li>
					
					<li>
						<div class="goal_img"><img src="http://localhost/paik_prj/customer/01.paik/images/goal_img03.jpg" alt="직원 성장" /></div>
						<dl>
							<dt>직원 성장</dt>
							<dd>차별화된 교육을 통해 인재를 양성하고, <span class="block_txt">소속감을 증진하며, 자부심을 부여해</span> 즐거운 근무환경을 조성합니다.</dd>
						</dl>
					</li>
				</ul>
			</div>
		</div>
	</div>

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