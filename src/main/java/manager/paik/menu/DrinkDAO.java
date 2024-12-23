package manager.paik.menu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

/**
 * 음료의 리스트, 상세 조회, 추가, 삭제, 수정 업무
 */
public class DrinkDAO {
	private static DrinkDAO dDAO;
	
	private DrinkDAO() { }
	
	public static DrinkDAO getInstance() {
		if(dDAO == null) {
			dDAO = new DrinkDAO();
		}
		
		return dDAO;
	}
	
	/**
	 * DB에 저장된 커피 메뉴의 개수를 세는 일을 하는 메소드
	 * @param sVO
	 * @return totalCount 커피 메뉴의 수
	 * @throws SQLException
	 */
	public int selectTotalCountCoffee(SearchVO sVO)throws SQLException{
		int totalCount = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//1. JNDI 사용 객체 생성
		//2. DBCP에서 DataSource 얻기
		DbConnection dbCon = DbConnection.getInstance();
		try {
		//3. Connection 얻기
			conn = dbCon.getConn();
		//4. 쿼리문 생성 객체 얻기
			StringBuilder selectCount = new StringBuilder();
			selectCount
			.append("	select 	count(categories_num) cnt				")
			.append("	from 	item									")
			.append("	where 	categories_num = 0 AND item_flag='N'	")
			;
			
			//dynamic query: 검색 키워드를 판단 기준으로 where절이 동적으로 생성
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectCount.append("	AND instr(i_name_k,?) != 0"	);
			}// end if
			
			pstmt = conn.prepareStatement(selectCount.toString());
		//5. 바인드 변수 값 설정
			//dynamic query
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(1, sVO.getKeyword());
			}// end if
			
		//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}//end if
		} finally {
		//7. 연결 끊기
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
		
		return totalCount;
	}// selectTotalCount
	
	/**
	 * DB에 저장된 일반 음료 메뉴의 개수를 세는 일을 하는 메소드
	 * @param sVO
	 * @return totalCount 일반 음료 메뉴의 수
	 * @throws SQLException
	 */
	public int selectTotalCountDrink(SearchVO sVO)throws SQLException{
		int totalCount = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//1. JNDI 사용 객체 생성
		//2. DBCP에서 DataSource 얻기
		DbConnection dbCon = DbConnection.getInstance();
		try {
		//3. Connection 얻기
			conn = dbCon.getConn();
		//4. 쿼리문 생성 객체 얻기
			StringBuilder selectCount = new StringBuilder();
			selectCount
			.append("	select 	count(categories_num) cnt				")
			.append("	from 	item									")
			.append("	where 	categories_num = 1 AND item_flag='N'	")
			;
			
			//dynamic query: 검색 키워드를 판단 기준으로 where절이 동적으로 생성
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectCount.append("	AND instr(i_name_k,?) != 0"	);
			}// end if
			
			pstmt = conn.prepareStatement(selectCount.toString());
		//5. 바인드 변수 값 설정
			//dynamic query
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(1, sVO.getKeyword());
			}// end if
			
		//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}//end if
		} finally {
		//7. 연결 끊기
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
		//System.out.println(totalCount);
		
		return totalCount;
	}// selectTotalCount
	
	/**
	 * 커피 메뉴 목록을 조회하는 일
	 * @param csVO
	 * @return
	 * @throws SQLException
	 */
	public List<ProductVO> selectCoffeeBoard(SearchVO sVO) throws SQLException {
		List<ProductVO> list = new ArrayList<ProductVO>();
			
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	      
		DbConnection dbCon = DbConnection.getInstance();

		try {
			//connection 열기
			conn = dbCon.getConn();
			// 쿼리문 생성객체 얻기
			StringBuilder selectCoffeeBoard = new StringBuilder();
			selectCoffeeBoard
					.append("select item_num, item_name, price, category_name ")
					.append("from (select item_num, i_name_k item_name, price, ")
					.append("(select categorie_name from categories where categories.categories_num = item.categories_num) category_name, item_flag, ")
					.append("row_number() over(order by item_num desc) rnum ")
					.append("from item ")
					.append("where categories_num = 0 and item_flag = 'N' ");

			// keyword가 있을 때 먼저 필터링
			if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectCoffeeBoard.append("AND instr(i_name_k, ?) != 0 ");
			}

			selectCoffeeBoard.append(") ")
					.append("where rnum between ? and ?");

			pstmt = conn.prepareStatement(selectCoffeeBoard.toString());

			// 파라미터 설정
			if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(1, sVO.getKeyword()); // 첫 번째 파라미터는 keyword
				pstmt.setInt(2, sVO.getStartNum());   // 두 번째 파라미터는 startNum
				pstmt.setInt(3, sVO.getEndNum());     // 세 번째 파라미터는 endNum
			} else {
				pstmt.setInt(1, sVO.getStartNum());   // startNum이 첫 번째 파라미터
				pstmt.setInt(2, sVO.getEndNum());     // endNum이 두 번째 파라미터
			}

			// 쿼리 실행 후 결과 처리
			rs = pstmt.executeQuery();

			ProductVO pVO = null;
			while (rs.next()) {
				pVO = new ProductVO();
	            pVO.setItemNum(rs.getInt("item_num"));
	            pVO.setiNameK(rs.getString("item_name"));
	            pVO.setPrice(rs.getInt("price"));
	            pVO.setCategorieName(rs.getString("category_name"));

	            list.add(pVO);
			}

	      
		} finally {
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
	      
		return list;
	}// selectCoffeeBoard


	/**
	 * 음료 메뉴 목록을 조회하는 일
	 * @param dsVO
	 * @return
	 * @throws SQLException
	 */
	public List<ProductVO> selectDrinkBoard(SearchVO sVO) throws SQLException {
		List<ProductVO> list = new ArrayList<ProductVO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			//connection 열기
			conn = dbCon.getConn();
			
			// 쿼리문 생성객체 얻기
			StringBuilder selectDrinkBoard = new StringBuilder();
			selectDrinkBoard
					.append("SELECT item_num, item_name, price, category_name ")
					.append("FROM (SELECT item_num, i_name_k AS item_name, price, ")
					.append("(SELECT categorie_name FROM categories ")
					.append("WHERE categories.categories_num = item.categories_num) AS category_name, ")
					.append("item_flag, ")
					.append("ROW_NUMBER() OVER (ORDER BY item_num DESC) AS rnum ")
					.append("FROM item ")
					.append("WHERE categories_num = 1 AND item_flag = 'N' ");

			// keyword가 있을 때 필터링 조건 추가
			if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectDrinkBoard.append("AND instr(i_name_k, ?) != 0 ");
			}
			
			selectDrinkBoard.append(") WHERE rnum BETWEEN ? AND ?");
			
			pstmt = conn.prepareStatement(selectDrinkBoard.toString());
			
			// 바인드 변수에 값 설정
			int paramIndex = 1;
			
			// keyword가 있을 경우
			if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(paramIndex++, sVO.getKeyword()); // 첫 번째 파라미터는 keyword
			}
			
			pstmt.setInt(paramIndex++, sVO.getStartNum()); // 시작 번호
			pstmt.setInt(paramIndex, sVO.getEndNum());     // 종료 번호
			
			// 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			ProductVO pVO = null;
			// while로 받아올 때는 query 테이블 컬럼명 기준으로!
			while (rs.next()) {
				pVO = new ProductVO();
				pVO.setItemNum(rs.getInt("item_num"));
	            pVO.setiNameK(rs.getString("item_name"));
	            pVO.setPrice(rs.getInt("price"));
	            pVO.setCategorieName(rs.getString("category_name"));
	            
	            list.add(pVO);
			}// end while
		
		} finally {
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
		
		return list;
	}//selectDrinkBoard(SearchVO sVO)
	
	/**
	 * 메뉴 이름을 입력받아 DB에서 검색하여 해당 메뉴가 존재하면 true, 그렇지 않으면 false 반환
	 * @param Drink
	 * @return 메뉴 있음-true, 메뉴 없음-false
	 * @throws SQLException
	 */
	public boolean selectName(String name) throws SQLException {
		boolean resultFlag = false;	// 메뉴 유무를 확인하는 flag
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//1. JNDI 사용객체 생성
		//2. DBCP에서 DataSource 얻기
		DbConnection dbCon = DbConnection.getInstance();
		//3. Connection 얻기
		try {
			conn = dbCon.getConn();
			//4. 쿼리문 생성 객체 보여주기
			String selectItem = "select i_name_k from item where id=?";
			pstmt = conn.prepareStatement(selectItem);
			
			//5. 바인드 변수에 값을 설정
			pstmt.setString(1, name);
			//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			resultFlag = rs.next();
		} finally {
			//7. 연결 끊기
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
		
		return resultFlag;
	}
	
	/**
	 * 입력 값을 item 테이블에 추가하는 일
	 * @param pVO
	 * @throws SQLException
	 */
	public void insertItem(ProductVO pVO) throws SQLException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			//connection 얻기
			conn = dbCon.getConn();
			// 쿼리문 생성객체 얻기
			StringBuilder insertItem = new StringBuilder();
			//ITEM_NUM	CATEGORIES_NUM	I_NAME_K	I_NAME_E
			//DESCRIPTION	IMAGE	PRICE	INPUT_DATE	ITEM_FLAG	INGREDIENT_FLAG	
			insertItem
			.append("	insert into item(item_num,categories_num,i_name_k,i_name_e,	")//3
			.append("	description,image,price,input_date,item_flag,ingredient_flag)	")//4-6
			.append("	values(item_seq.nextval,?,?,?,?,?,?,sysdate,'N',?)	")
			//.append("	values(item_seq.nextval,?,?,?,?,?,?,sysdate,'N',?)	")
			;
			
			pstmt = conn.prepareStatement(insertItem.toString());
			//바인드 변수에 값 설정
			//String currentDate = new SimpleDateFormat("yyMMddhhmmss").format(new java.util.Date());
			
			pstmt.setInt(1, pVO.getCategoriesNum());
			pstmt.setString(2, pVO.getiNameK());
			pstmt.setString(3, pVO.getiNameE());
			pstmt.setString(4, pVO.getDescription());
			pstmt.setString(5, pVO.getImage());
			pstmt.setInt(6, pVO.getPrice());
			//pstmt.setDate(7, sqlDate);
			//pstmt.setString(8, itemFlag);
			pstmt.setString(7, pVO.getIngredientFlag());
			
			//쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
	}//insertItem
	
	/**
	 * 입력 값을 ingredient 테이블에 추가하는 일
	 * @param pVO
	 * @throws SQLException
	 */
	public void insertIngredient(IngredientVO iVO) throws SQLException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			//connection 얻기
			conn = dbCon.getConn();
			// 쿼리문 생성객체 얻기
			StringBuilder insertItem = new StringBuilder();
			//ITEM_NUM	CAFFEINE	NATRIUM	FATTY_ACID	CALORIE	SUGAR	PROTEIN	

			insertItem
			.append("	insert into ingredient(item_num,caffeine,natrium,fatty_acid,	")
			.append("	calorie,sugar,protein)	")
			.append("	values(item_seq.currval,?,?,?,?,?,?)	")
			;
			
			pstmt = conn.prepareStatement(insertItem.toString());
			//바인드 변수에 값 설정
			pstmt.setDouble(1, iVO.getCaffeine());
			pstmt.setDouble(2, iVO.getNatrium());
			pstmt.setDouble(3, iVO.getFattyAcid());
			pstmt.setDouble(4, iVO.getCalorie());
			pstmt.setDouble(5, iVO.getSugar());
			pstmt.setDouble(6, iVO.getCaffeine());
			
			//쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
	}//insertItem
	
	/**
	 * 입력 값을 drink_option 테이블에 추가하는 일
	 * @param pVO
	 * @throws SQLException
	 */
	public void insertDrinkOption(DrinkOptionVO oVO) throws SQLException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			//connection 얻기
			conn = dbCon.getConn();
			// 쿼리문 생성객체 얻기
			StringBuilder insertItem = new StringBuilder();
			//ITEM_NUM	CAFFEINE	NATRIUM	FATTY_ACID	CALORIE	SUGAR	PROTEIN	

			insertItem
			.append("	insert into drink_option(drink_option_num,item_num,size_s,size_m,size_l,shot,syrup,multi_cup)	")
			.append("	values(drink_option_seq.nextval,item_seq.currval,?,?,?,?,?,?)	")
			//.append("	values(option_seq.nextval,item_seq.currval,?,?,?,?,?,?)	")
			;
			
			pstmt = conn.prepareStatement(insertItem.toString());
			//바인드 변수에 값 설정
			pstmt.setString(1, oVO.getSizeS());
			pstmt.setString(2, oVO.getSizeM());
			pstmt.setString(3, oVO.getSizeL());
			pstmt.setInt(4, oVO.getShot());
			pstmt.setInt(5, oVO.getSyrup());
			pstmt.setString(6, oVO.getMultiCup());
			
			//쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
	}//insertItem
	
	/**
	 * 특정 아이템 번호의 상품의 상세 정보를 조회하는 일
	 * @param num
	 * @return
	 * @throws SQLException
	 */
	public ProductVO selectDetailItemBoard(int itemNum) throws SQLException {
		ProductVO pVO = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			//connection 얻기
			conn = dbCon.getConn();
			//쿼리문 생성객체 얻기
			StringBuilder selectOneBoard = new StringBuilder();
			selectOneBoard
			.append("	select	item_num,categories_num,i_name_k,i_name_e,description,image,price,input_date,ingredient_flag	")
			.append("	from	item	")
			.append("	where	item_num=?	")
			;
			
			pstmt = conn.prepareStatement(selectOneBoard.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, itemNum);
			
			//쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			//하나만 조회 => if
			if(rs.next()) {
				pVO = new ProductVO();
				pVO.setItemNum(itemNum);
				pVO.setCategoriesNum(rs.getInt("categories_num"));
				pVO.setiNameK(rs.getString("i_name_k"));
				pVO.setiNameE(rs.getString("i_name_e"));
				pVO.setDescription(rs.getString("description"));
				pVO.setImage(rs.getString("image"));
				pVO.setPrice(rs.getInt("price"));
				pVO.setInputDate(rs.getDate("input_date"));
				pVO.setIngredientFlag(rs.getString("ingredient_flag"));
			}//end if
			
			
		} finally {
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
		
		return pVO;
	}
	
	/**
	 * 특정 아이템 번호의 상품의 옵션 정보를 조회하는 일
	 * @param num
	 * @return
	 * @throws SQLException
	 */
	public DrinkOptionVO selectDetailOptionBoard(int itemNum) throws SQLException {
		DrinkOptionVO oVO = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			//connection 얻기
			conn = dbCon.getConn();
			//쿼리문 생성객체 얻기
			StringBuilder selectOneBoard = new StringBuilder();
			selectOneBoard
			.append("	select 	drink_option_num, item_num, size_s, size_m, size_l, shot, syrup, multi_cup	")
			.append("	from		drink_option	")
			.append("	where		item_num=?	")
			;
			
			pstmt = conn.prepareStatement(selectOneBoard.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, itemNum);
			
			//쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			//하나만 조회 => if
			if(rs.next()) {
				oVO = new DrinkOptionVO();
				oVO.setDrinkOptionNum(rs.getInt("drink_option_num"));
				oVO.setItemNum(itemNum);
				oVO.setSizeS(rs.getString("size_s"));
				oVO.setSizeM(rs.getString("size_m"));
				oVO.setSizeL(rs.getString("size_l"));
				oVO.setShot(rs.getInt("shot"));
				oVO.setSyrup(rs.getInt("syrup"));
				oVO.setMultiCup(rs.getString("multi_cup"));
			}//end if

		} finally {
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
		
		return oVO;
	}
	
	/**
	 * 특정 아이템 번호의 성분 정보를 조회하는 일
	 * @param num
	 * @return
	 * @throws SQLException
	 */
	public IngredientVO selectDetailIngredientBoard(int itemNum) throws SQLException {
		IngredientVO iVO = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			//connection 얻기
			conn = dbCon.getConn();
			//쿼리문 생성객체 얻기
			StringBuilder selectOneBoard = new StringBuilder();
			selectOneBoard
			.append("	select	item_num,caffeine,natrium,fatty_acid,calorie,sugar,protein	")
			.append("	from	ingredient	")
			.append("	where	item_num=?	")
			;
			
			pstmt = conn.prepareStatement(selectOneBoard.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, itemNum);
			
			//쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			//하나만 조회 => if
			if(rs.next()) {
				iVO = new IngredientVO();
				iVO.setItemNum(itemNum);
				iVO.setCaffeine(rs.getInt("caffeine"));
				iVO.setNatrium(rs.getInt("natrium"));
				iVO.setFattyAcid(rs.getInt("fatty_acid"));
				iVO.setCalorie(rs.getInt("calorie"));
				iVO.setSugar(rs.getInt("sugar"));
				iVO.setProtein(rs.getInt("protein"));
			}//end if
			
		} finally {
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
		
		return iVO;
	}
	
	/**
	 * 상품의 정보를 갱신하는 일
	 * @param pVO
	 * @return
	 * @throws SQLException
	 */
	public int updateItem(ProductVO pVO) throws SQLException {
		int rowCnt = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			conn = dbCon.getConn();
			
			StringBuilder updateItem = new StringBuilder();
			updateItem
			.append("	update	item	")
			.append("	set		i_name_k=?,i_name_e=?,description=?,image=?,price=?,ingredient_flag=?		")
			.append("	where	item_num=?	")
			;
			
			pstmt = conn.prepareStatement(updateItem.toString());
			//바인드 변수에 값 설정
			pstmt.setString(1, pVO.getiNameK());
			pstmt.setString(2, pVO.getiNameE());
			pstmt.setString(3, pVO.getDescription());
			pstmt.setString(4, pVO.getImage());
			pstmt.setInt(5, pVO.getPrice());
			pstmt.setString(6, pVO.getIngredientFlag());
			pstmt.setInt(7, pVO.getItemNum());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			//0: 다른 사람이 정보 수정하려고 시도, 1: 정보 수정
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
		
		return rowCnt;
	}//updateItem
	
	/**
	 * 이미지 외의 상품의 정보를 갱신하는 일
	 * @param pVO
	 * @return
	 * @throws SQLException
	 */
	public int updateItemImageless(ProductVO pVO) throws SQLException {
		int rowCnt = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			conn = dbCon.getConn();
			
			StringBuilder updateItem = new StringBuilder();
			updateItem
			.append("	update	item	")
			.append("	set		i_name_k=?,i_name_e=?,description=?,price=?,ingredient_flag=?		")
			.append("	where	item_num=?	")
			;
			
			pstmt = conn.prepareStatement(updateItem.toString());
			//바인드 변수에 값 설정
			pstmt.setString(1, pVO.getiNameK());
			pstmt.setString(2, pVO.getiNameE());
			pstmt.setString(3, pVO.getDescription());
			pstmt.setInt(4, pVO.getPrice());
			pstmt.setString(5, pVO.getIngredientFlag());
			pstmt.setInt(6, pVO.getItemNum());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			//0: 다른 사람이 정보 수정하려고 시도, 1: 정보 수정
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
		
		return rowCnt;
	}//updateItem
	
	/**
	 * 상품의 옵션 정보를 갱신하는 일
	 * @param oVO
	 * @return
	 * @throws SQLException
	 */
	public int updateOption(DrinkOptionVO oVO) throws SQLException {
		int rowCnt = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			conn = dbCon.getConn();
			
			StringBuilder updateOption = new StringBuilder();
			updateOption
			.append("	update	drink_option	")
			.append("	set		size_s=?,size_m=?,size_l=?,shot=?,syrup=?,multi_cup=?		")
			.append("	where	item_num=?	")
			;
			
			pstmt = conn.prepareStatement(updateOption.toString());
			//바인드 변수에 값 설정
			pstmt.setString(1, oVO.getSizeS());
			pstmt.setString(2, oVO.getSizeM());
			pstmt.setString(3, oVO.getSizeL());
			pstmt.setInt(4, oVO.getShot());
			pstmt.setInt(5, oVO.getSyrup());
			pstmt.setString(6, oVO.getMultiCup());
			pstmt.setInt(7, oVO.getItemNum());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			//0: 다른 사람이 정보 수정하려고 시도, 1: 정보 수정
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
		
		return rowCnt;
	}//updateItem
	
	/**
	 * 상품의 성분 정보를 갱신하는 일
	 * @param iVO
	 * @return
	 * @throws SQLException
	 */
	public int updateIngredient(IngredientVO iVO) throws SQLException {
		int rowCnt = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			conn = dbCon.getConn();
			
			StringBuilder updateIngredient = new StringBuilder();
			updateIngredient
			.append("	update	ingredient	")
			.append("	set		caffeine=?,natrium=?,fatty_acid=?,calorie=?,sugar=?,protein=?		")
			.append("	where	item_num=?	")
			;
			
			pstmt = conn.prepareStatement(updateIngredient.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, iVO.getCaffeine());
			pstmt.setInt(2, iVO.getNatrium());
			pstmt.setInt(3, iVO.getFattyAcid());
			pstmt.setInt(4, iVO.getCalorie());
			pstmt.setInt(5, iVO.getSugar());
			pstmt.setInt(6, iVO.getProtein());
			pstmt.setInt(7, iVO.getItemNum());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			//0: 다른 사람이 정보 수정하려고 시도, 1: 정보 수정
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
		
		return rowCnt;
	}//updateItem
	
	/**
	 * 해당 상품을 삭제 처리하는 일(※ 실제로 삭제하지 않는다. ∵ 매출 처리 등)
	 * @param pVO
	 * @return
	 * @throws SQLException
	 */
	public int deleteItem(ProductVO pVO) throws SQLException {
		int rowCnt = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			conn = dbCon.getConn();
			
			StringBuilder deleteItem = new StringBuilder();
			deleteItem
			.append("	update	item	")
			.append("	set		item_flag='Y'	")
			.append("	where	item_num=?	")
			;
			
			pstmt = conn.prepareStatement(deleteItem.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, pVO.getItemNum());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			//0: 다른 사람이 정보 수정하려고 시도, 1: 정보 수정
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
		
		return rowCnt;
	}//deleteItem
	
	public int deleteOption(DrinkOptionVO oVO) throws SQLException {
		int rowCnt = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			conn = dbCon.getConn();
			
			StringBuilder deleteOption = new StringBuilder();
			deleteOption
			.append("	delete	from drink_option	")
			.append("	where	item_num=?	")
			;
			
			pstmt = conn.prepareStatement(deleteOption.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, oVO.getItemNum());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			//0: 다른 사람이 정보 수정하려고 시도, 1: 정보 수정
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
		
		return rowCnt;
	}//deleteItem
	
	public int deleteIngredient(IngredientVO iVO) throws SQLException {
		int rowCnt = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			conn = dbCon.getConn();
			
			StringBuilder deleteIngredient = new StringBuilder();
			deleteIngredient
			.append("	delete	from ingredient	")
			.append("	where	item_num=?	")
			;
			
			pstmt = conn.prepareStatement(deleteIngredient.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, iVO.getItemNum());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			//0: 다른 사람이 정보 수정하려고 시도, 1: 정보 수정
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}// end finally
		
		return rowCnt;
	}//deleteItem
	
}//class
