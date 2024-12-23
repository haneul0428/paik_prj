<%@ page language="java" contentType="text/html; charset=UTF-8"
		    pageEncoding="UTF-8"
		    info="고객의 소리 관리 페이지"
		    %>
<%--관리자 세션을 검증하는 jsp include--%>
<jsp:include page="../common/jsp/manager_session_chk.jsp"/>

<!doctype html>
<html lang="en" data-bs-theme="auto">
<head><script src="/docs/5.3/assets/js/color-modes.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">
    <title>고객의 소리 관리</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/dashboard/">
    <link rel="stylesheet" href="http://localhost/paik_prj/manager/common/css/project_main.css">
    <!-- Custom styles for this template -->
    <link href="http://localhost/paik_prj/manager/common/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="http://localhost/paik_prj/manager/common/css/dashboard.css" rel="stylesheet">
    
	<!-- bootstrap -->
    <link href="bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />

	<!-- jQuery -->
  	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <meta name="theme-color" content="#712cf9">
    <style type="text/css">		
		form { max-width: 900px; margin: 0 auto; }
				
		th, td { border: 1px solid #ddd; padding: 12px;	text-align: left; }
		
		a {	text-decoration: none; color: #333;	}
		
		a:hover { text-decoration: underline; }
		
		span.res { padding: 10px; color: #FFF; background-color: #4CAF50; border-radius: 20px; }
		span.non-res { padding: 10px; color: #FFF; background-color: #FFA500; border-radius: 20px; }
		
		
        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }
        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }

        .bd-mode-toggle .dropdown-menu .active .bi {
            display: block !important;
        }
        
        .search-bar { width: 200px; height: 40px; }
        #subject { width: 150px; height: 40px; }
        #status { width: 150px; height: 40px; }
        .hidden { display: none; }
    </style>
    
    <script type="text/javascript">
  //탭을 보여주는 함수
    $(function(){
    	$("#btnradio1").click(function(){
    		showTab('non-res');
    	});//click
    	
    	$("#btnradio2").click(function(){
    		showTab('res');
    	});//click
    });//ready

    function showTab(tab) {
        document.getElementById('non-res').classList.add('hidden');
        document.getElementById('res').classList.add('hidden');
        document.getElementById(tab).classList.remove('hidden');
        
        let tabs = document.querySelectorAll('.tab');
        tabs.forEach(t => t.classList.remove('active'));
        event.target.classList.add('active');
    }
    </script>

</head>
<body>
<jsp:include page="../common/svg.jsp"/> <!-- svg -->
<jsp:include page="../common/headbar.jsp"/> <!-- headbar -->

<div class="container-fluid">
    <div class="row">
        <div class="border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
            <div class="offcanvas-md offcanvas-end bg-body-tertiary" tabindex="-1" id="sidebarMenu" aria-labelledby="sidebarMenuLabel">

                <div class="offcanvas-body d-md-flex flex-column p-0 pt-lg-3 overflow-y-auto">
                    <ul class="nav nav-pills flex-column">
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" aria-current="page" href="http://localhost/jsp_prj/manager/dashboard/dashboard.jsp">
                                <i class="bi bi-house"></i>
                                관리자 대시보드
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/menu/getListDrink.jsp">
                                <svg class="bi"><use xlink:href="#cup-hot"/></svg>
                                음료 관리
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/menu/getListDessertIcecream.jsp">
                            	<svg class="bi"><use xlink:href="#cake"/></svg>
                                디저트&아이스크림 관리
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/order/getListOrder.jsp">
                                <i class="bi bi-cart"></i>
                                	주문 관리
                            </a>                                                        
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="http://localhost/paik_prj/manager/customer/list_customer.jsp">
                                <i class="bi bi-people"></i>
                                회원 관리
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2 active" href="http://localhost/paik_prj/manager/voc/getListCustomSound.jsp">
								<i class="bi bi-file-earmark-bar-graph"></i>
                                고객의 소리
                            </a>
                        </li>
                    </ul>

                    <hr class="my-3">
                    <ul class="nav flex-column mb-auto">
                        <li class="nav-item">
                            <a class="nav-link d-flex align-items-center gap-2" href="#">
                                <svg class="bi"><use xlink:href="#door-closed"/></svg>
                                로그아웃
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2"><strong>고객의 소리 관리</strong></h1>
            </div>
				<select id="subject">
					<option val="">--유형--</option>
					<option val="칭찬">칭찬</option>
					<option val="불만">불만</option>
					<option val="문의">문의</option>
					<option val="제안">제안</option>
				</select>
				<input type="text" name="search" class="search-bar" placeholder="검색어 입력" />
				<button type="submit" class="answer">확인</button>
                
			<div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups" style="margin-bottom: 10px;">
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
					  <label class="btn btn-outline-primary" for="btnradio1" class="btnradio1">미답변</label>
					
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
					  <label class="btn btn-outline-primary" for="btnradio2" class="btnradio2">답변</label>
				</div>
			</div>
                <form>
                <table id="non-res">
				        <thead>
				            <tr>
				                <th class="code">번호</th>
				                <th class="subject">문의 유형</th>
				                <th class="title">제목</th>
				                <th class="writer">작성자</th>
				                <th class="date">문의 날짜</th>
				                <th class="status">답변</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
				                <td class="code">2</td>
				                <td class="subject">제안사항</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">새로운 기능 추가 요청</a></td>
				                <td class="writer">user22</td>
				                <td class="date">2024-10-08</td>
				                <td class="status"><span class="non-res">미답변</span></td>
				            </tr>
   				            <tr>
				                <td class="code">4</td>
				                <td class="subject">불만</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">가가가각가가가각가ㅏ가가가각ㅁ...</a></td>
				                <td class="writer">user4th</td>
				                <td class="date">2024-10-08</td>
				                <td class="status"><span class="non-res">미답변</span></td>
				            </tr>
				            <tr>
				                <td class="code">8</td>
				                <td class="subject">문의</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">ㅇㅅㅇ</a></td>
				                <td class="writer">user88</td>
				                <td class="date">2024-10-07</td>
				                <td class="status"><span class="non-res">미답변</span></td>
				            </tr>
				            <tr>
				                <td class="code">10</td>
				                <td class="subject">불편사항</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">여긴 인사가 없네요</a></td>
				                <td class="writer">user0000</td>
				                <td class="date">2024-10-06</td>
				                <td class="status"><span class="non-res">미답변</span></td>
				            </tr>
				        </tbody>
				    </table>
				    
				<table id="res" class="hidden">
				        <thead>
				            <tr>
				                <th class="code">번호</th>
				                <th class="subject">문의 유형</th>
				                <th class="title">제목</th>
				                <th class="writer">작성자</th>
				                <th class="date">문의 날짜</th>
				                <th class="status">답변</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
				                <td class="code">1</td>
				                <td class="subject">불만</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">제품 배송이 늦어요</a></td>
				                <td class="writer">user1</td>
				                <td class="date">2024-10-08</td>
				                <td class="status"><span class="res">답변</span></td>
				            </tr>
				            <tr>
				                <td class="code">3</td>
				                <td class="subject">제안</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">환불 절차 문의</a></td>
				                <td class="writer">userXrd</td>
				                <td class="date">2024-10-08</td>
				                <td class="status"><span class="res">답변</span></td>
				            </tr>
				            <tr>
				                <td class="code">5</td>
				                <td class="subject">불만</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">주문한 거랑 달라요</a></td>
				                <td class="writer">user555</td>
				                <td class="date">2024-10-07</td>
				                <td class="status"><span class="res">답변</span></td>
				            </tr>
				          	<tr>
				                <td class="code">6</td>
				                <td class="subject">칭찬</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">감사합니다</a></td>
				                <td class="writer">6ser</td>
				                <td class="date">2024-10-07</td>
				                <td class="status"><span class="res">답변</span></td>
				            </tr>
				            <tr>
				                <td class="code">7</td>
				                <td class="subject">문의</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">이거 해주세요</a></td>
				                <td class="writer">user777</td>
				                <td class="date">2024-10-07</td>
				                <td class="status"><span class="res">답변</span></td>
				            </tr>
				            <tr>
				                <td class="code">9</td>
				                <td class="subject">제안사항</td>
				                <td class="title"><a href="http://localhost/paik_prj/manager/voc/updateCustomSound.jsp">신메뉴 추가 좀요</a></td>
				                <td class="writer">user999</td>
				                <td class="date">2024-10-07</td>
				                <td class="status"><span class="res">답변</span></td>
				            </tr>
				        </tbody>
				    </table>
                
                
                	<ul class="pagination justify-content-center">
						<li class="page-item active">
						<a class="page-link" href="#">1</a>
						</li>
<!--  						<li class="page-item">
						<a class="page-link" href="#">2</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#">3</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#">4</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#">5</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#">6</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#">7</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#">8</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#">9</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#">10</a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#">
						<i class="bi bi-chevron-right"></i></a>
						</li>
						<li class="page-item">
						<a class="page-link" href="#" title="첫 글 보기">
						<i class="bi bi-chevron-double-right"></i></a> -->
						</li>
					</ul>
			    </form>

            <canvas class="my-4 w-100" id="myChart" width="900" height="380"></canvas>
        </main>
    </div>
</div>
<script src="bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script src="chart.umd.js" integrity="sha384-eI7PSr3L1XLISH8JdDII5YN/njoSsxfbrkCTnJrzXt+ENP5MOVBxD+l6sEG4zoLp" crossorigin="anonymous"></script><script src="dashboard.js"></script></body>
</html>