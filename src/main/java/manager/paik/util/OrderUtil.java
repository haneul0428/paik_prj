package manager.paik.util;

import manager.paik.order.SearchVO;

public class OrderUtil {

	/**
	 * 페이지네이션을 사용하려면 매개변수로 입력되는 객체의
	 * currentPage 번호,totalPage 수,totalCount 수
	 * 검색을 수행하면 field 값, keyword, url이 반드시 입력되어야 한다.
	 * @param sVO
	 * @return
	 */
	public String pagination(SearchVO sVO) {
		StringBuilder pagination = new StringBuilder();

		if(sVO.getTotalCount() != 0) {
			//1. 한 화면에 보여줄 페이지 인덱스의 수 설정
			int pageNumber = 3; // [1][2][3]
			//2. 화면에 보여줄 시작페이지 번호
			int startPage = ((sVO.getCurrentPage() - 1) / pageNumber)*pageNumber + 1;
			//3. 화면에 보여줄 마지막 페이지 번호
			int endPage = startPage + pageNumber - 1;
			//4. 총 페이지 수가 연산된 마지막 페이지 수보다 작다면 총 페이지 수가 마지막 페이지 수로 설정
			if(sVO.getTotalPage() <= endPage){
				endPage = sVO.getTotalPage();
			}//end if
			//5. 첫 페이지가 인덱스 화면이 아닌 경우(3보다 큰 경우)
			int movePage = 0;
			StringBuilder prevMark = new StringBuilder();
			prevMark.append("<li class=\"page-item\"><a class=\"page-link\" href=\"#\"><i class=\"bi bi-chevron-double-left\" title=\"이전으로\"></i></a>");
			
			//prevMark = "<li class=\"page-item\"><a class=\"page-link\" href=\"selectCoffeeList.jsp?currentPage="+movePage
				//	+"\"><i class=\"bi bi-chevron-double-left\" title=\"이전으로\"></i></a>";
			if(sVO.getCurrentPage() > pageNumber){// 현재 페이지가 pagination의 수보다 크면
				prevMark.delete(0, prevMark.length());
				//이전으로 가기 링크를 활성화
				movePage = startPage - 1;//1,4,7,...
				prevMark.append("<li class=\"page-item\"><a class=\"page-link\" href=\"")
				.append(sVO.getUrl())
				.append("?currentPage=")
				.append(movePage);
				
				//검색 keyword가 존재할 때
				if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
					prevMark.append("&field=")
					.append(sVO.getField())
					.append("&keyword=")
					.append(sVO.getKeyword())
					;
				}// end if
				
				prevMark.append("\"><i class=\"bi bi-chevron-double-left\" title=\"이전으로\"></i></a>");
			}//end if
			
			pagination.append(prevMark);
			//pagination.append("");
			
			//1,2,3
			//6. 시작 페이지 번호부터 끝 페이지 번호까지 화면에 출력
			movePage = startPage;
			StringBuilder pageLink = new StringBuilder();
			while(movePage <= endPage){
				if(movePage == sVO.getCurrentPage()){ // 현재 페이지는 링크 설정 X
					pageLink.append("<li class=\"page-item\"><a class=\"page-link active\" href='#'>")
					.append(movePage).append("</a>");
				} else {// 현재 페이지가 아니면 링크 설정
					pageLink.append("<li class=\"page-item\"><a class=\"page-link\" href=\"")
					.append(sVO.getUrl())
					.append("?currentPage=")
					.append( movePage);
					
					//검색 keyword가 존재할 때
					if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
						pageLink.append("&field=")
						.append(sVO.getField())
						.append("&keyword=")
						.append(sVO.getKeyword())
						;
					}// end if
					
					pageLink.append("\">").append(movePage).append("</a>");
				}// end else
				movePage++;
			}// end while
			pagination.append(pageLink);
			
			//7. 뒤에 페이지가 더 있는 경우
			StringBuilder nextMark = new StringBuilder();
			nextMark.append("<li class=\"page-item\"><a class=\"page-link\" href='#'><i class=\"bi bi-chevron-double-right\" title=\"다음으로\"></i></a>");
			
			if(sVO.getTotalPage() > endPage){
				nextMark.delete(0, nextMark.length());
				movePage = endPage + 1;
				nextMark.append("<li class=\"page-item\"><a class=\"page-link\" href=\"")
				.append(sVO.getUrl())
				.append("?currentPage=")
				.append(movePage)
				;
				
				//검색 keyword가 존재할 때
				if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
					nextMark.append("&field=")
					.append(sVO.getField())
					.append("&keyword=")
					.append(sVO.getKeyword())
					;
				}// end if
				
				nextMark.append("\"><i class=\"bi bi-chevron-double-right\" title=\"다음으로\"></i></a>");
			}// end if
			
			pagination.append(nextMark);
			
		}// end if
		
		return pagination.toString();
	}
	
}