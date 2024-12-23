<%@ page language="java" contentType="text/html; charset=UTF-8"
		    pageEncoding="UTF-8"
		    info="공통 디자인을 사용하는 페이지"
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
	
	<!-- SweetAlert -->	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

	<!-- jQuery -->
  	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    

    <meta name="theme-color" content="#712cf9">
    <style type="text/css">		
		form { max-width: 900px; margin: 0 auto; }
				
		th, td { text-align: left; }
		
		a { text-decoration: none; color: #FFF; }
		label { display: block; margin-top: 10px; }
        input, select { width: 100%; padding: 8px; margin-top: 5px; box-sizing: border-box; }
		textarea { width: 100%; height: 200px; overflow: auto; }


        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }
        
        .answer { border-radius: 10%; }

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
        
    </style>
    
    <script type="text/javascript">
    $(function(){
     	$("#delete").click(function(){
			window.close();
     	});//click
     	$("#answer").click(function(){
     		//chkNull();
     		
     		Swal.fire({
				icon: 'success',
				title: '수정 완료',
				text: '메뉴가 수정되었습니다.',
			}); 
     	});//click
     	
     	$("#cancel").click(function(){
            Swal.fire({
                title: '현재 메뉴를 삭제하시겠습니까?',
                text: "다시 되돌릴 수 없습니다. 신중하세요.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '삭제',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire(
                       '삭제 완료 !',
                       '메뉴가 삭제 되었습니다 !'
                    )//fire
                }// end if
            })//fire
		});//click
    });//ready
    
/*     function chkNull(){
    	if($("#adminAnswer").val().length==0){
    		$("#answer-alert").modal("show");
    	} else if($("#adminAnswer").val().replaceAll(/ /g, "") == ""){
    		$("#adminAnswer").val(""); // " " 넣는 경우 방지
    		$("#answer-alert").modal("show");
	  	} else if($("#adminAnswer").val().replaceAll("\n", "") == ""){
    		$("#adminAnswer").val(""); // "\n" 넣는 경우 방지
    		$("#answer-alert").modal("show");
	  	} else {
    		$("#answer-confirm").modal("show");
    	}
    } */
    
/*     var myModalEl = document.getElementById('modify-confirm')
    myModalEl.addEventListener('hidden.bs.modal', function (event) {
  	// do something...
  	
	}); */
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
                            <a class="nav-link d-flex align-items-center gap-2" aria-current="page" href="http://localhost/paik_prj/manager/dashboard/dashboard.jsp">
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
                <h1 class="h2"><strong>고객의 소리 상세보기</strong></h1>
            </div>
            
        		<form>
        		<table>
        			<tbody>
	        			<tr>
	        				<td colspan="2">
						        <label for="memberNo"><strong>문의유형</strong></label>
						        <select name="inquiry_t" required>
						        	<option value="">--분류--</option>
						        	<option value="칭찬">칭찬</option>
						        	<option value="불만">불만</option>
						        	<option value="문의">문의</option>
						        	<option value="제안" selected="selected">제안</option>
						        </select>
	        				</td>
	        			</tr>
	        			<tr>
	        				<td>
						        <label for="name"><strong>이름</strong></label>
						        <input type="text" id="name" name="name" value="이사용자" readonly>
	        				</td>
	        				<td>
						        <label for="name"><strong>연락처</strong></label>
						        <input type="text" id="phone" name="phone" value="010-1234-5678" readonly>
	        				</td>
	        			</tr>
	        			<tr>
	        				<td>
						        <label for="name"><strong>이메일</strong></label>
						        <input type="text" id="email" name="email" value="qwer1234@qwert.com" readonly>
	        				</td>
	        				<td>
						        <label for="name"><strong>답변 여부</strong></label>
						        <input type="text" id="ans_al" name="ansAl" value="Y" readonly>
	        				</td>
	        			</tr>
	        			<tr>
	        				<td colspan="2">
						        <label for="memberNo"><strong>제목</strong></label>
						        <input type="text" id="title" name="title" value="" readonly>
	        				</td>
	        			</tr>
	        			<tr>
	        				<td colspan="2">
						        <label for="memberNo"><strong>내용</strong></label>
						        <input type="textarea" id="content" name="content" style="height: 200px;" readonly/>
	        				</td>
	        			</tr>
	        			<tr>
	        				<td colspan="2">
						        <label for="memberNo"><strong>관리자 답변</strong></label>
						        <textarea rows="200" id="adminAnswer" name="ans"></textarea>
	        				</td>
	        			</tr>
        			</tbody>
        		</table>		
			        <div style="text-align: center;">
			        <button type="button" class="confirm" id="confirm">
			        <a href="http://localhost/paik_prj/manager/voc/getListCustomSound.jsp">확인</a></button>
			        <button type="button" class="answer" id="answer">수정</button>
			        <button type="button" class="cancel" id="cancel">탈퇴</button>
			        </div>
			    </form>

        </main>
    </div>
</div>
<script src="bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script src="chart.umd.js" integrity="sha384-eI7PSr3L1XLISH8JdDII5YN/njoSsxfbrkCTnJrzXt+ENP5MOVBxD+l6sEG4zoLp" crossorigin="anonymous"></script><script src="dashboard.js"></script></body>
</body>

<!-- 모달 버튼 -->
    <!-- 
        btn : [bootstrap] 버튼 사용
        btn-sm : [bootstrap] 작은 버튼
        btn-info : [bootstrap] 버튼 테마 적용(청색)
        ml-2 : [bootstrap] margin left의 줄임말, - 뒤 숫자 만큼 margin을 줌
        mt-2 : [bootstrap] margin top의 줄임말, - 뒤 숫자 만큼 margin을 줌
        modalBtn : 작성자는 클릭 이벤트에 사용, 여러 버튼을 사용할 때 주로 이용함
     -->
<!-- modal 공간 -->
<div class="modal fade" id="delete-confirm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">경고</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align: center;">
      	<span style="font-size: 20px;"><strong>고객의 소리를 삭제하시겠습니까?</strong></span><br><br>
      	이 작업은 되돌릴 수 없습니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger" id="delete">삭제</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="answer-confirm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
  
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">알림</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align: center;">
      	<span style="text-align: center;">답변이 등록되었습니다.</span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="answer-alert" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
  
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">알림</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align: center;">
      	<span style="text-align: center;">답변을 입력해주세요.</span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
<!-- <div id="dialog-confirm" title="경고" style='display:none'>
  <strong>고객의 소리를 삭제하시겠습니까?</strong><br/>
	이 작업은 되돌릴 수 없습니다.
</div> -->
</html>