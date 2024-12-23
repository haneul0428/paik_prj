package customer.paik;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

public class CartItemDAO {
	private static CartItemDAO ciDAO;
	
	private CartItemDAO() {
	}//CartItemDAO()
	
	public static CartItemDAO getInstance() {
		if(ciDAO == null) {
			ciDAO = new CartItemDAO();
		}//if
		return ciDAO;
	}//getInstance()
	
	public int selectTotalCountOrder(CartItemVO ciVO) throws SQLException {
		int totalCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			StringBuilder selectTotalCount = new StringBuilder();
			selectTotalCount
			.append("	select count(cart_num)cnt	")
			.append("	from(select ci.cart_num cart_num, c.cus_id cus_id		")
			.append("	from cart_item ci, cart c	")
			.append("	where ci.cart_num = c.cart_num)	")
			.append("	where cus_id=?	")
			;
			
			pstmt = con.prepareStatement(selectTotalCount.toString());
			//바인드 변수 값 설정
			pstmt.setString(1, ciVO.getCusId());
			
			//쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt"); // cnt값 받기
			}//end if
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}//end finally
		
		return totalCount;
	}//selectTotalCountOrder(CartItemVO ciVO)
	
	//장바구니 리스트
	public List<CartItemVO> selectCartList(String userId) throws SQLException{
		List<CartItemVO> cartItems = new ArrayList<CartItemVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			//해당 아이디의 장바구니 목록을 불러오기
			StringBuilder selectCartList = new StringBuilder();
			selectCartList
			.append("	select image, item_name, price, cart_item_num, cart_num, order_flag, receipt_flag, quantity, category_num, item_num	")
			.append("	from(select image, i_name_k item_name, price, cart_item_num, ci.cart_num cart_num, order_flag, receipt_flag, quantity, categories_num category_num, i.item_num item_num	")
			.append("	from item i, cart_item ci, cart c	")
			.append("	where i.item_num=ci.item_num and ci.cart_num = c.cart_num and order_flag='N' and cus_id = ?)	")
			.append("	order by cart_item_num asc	")
			;
			
			pstmt = con.prepareStatement(selectCartList.toString());
			
			//바인드 변수 설정
			pstmt.setString(1, userId);
			
			//쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			CartItemVO ciVO = null;
			ItemVO iVO = null;
			
			while(rs.next()) {
				ciVO = new CartItemVO();
				ciVO.setImage(rs.getString("image"));
				ciVO.setItemName(rs.getString("item_name"));
				ciVO.setPrice(rs.getInt("price"));
				ciVO.setCartItemNum(rs.getInt("cart_item_num"));
				ciVO.setCartNum(rs.getInt("cart_num"));
				ciVO.setOrderFlag(rs.getString("order_flag"));
				ciVO.setReceiptFlag(rs.getString("receipt_flag"));
				ciVO.setQuantity(rs.getInt("quantity"));
				ciVO.setCategoriesNum(rs.getInt("category_num"));
				ciVO.setItemNum(rs.getInt("item_num"));
				ciVO.setiVO(iVO);	//cartitemVO와 itemVO를 합
				
				cartItems.add(ciVO);
			}
			
			
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		
		return cartItems;
	}//selectCartList(String userId)

	public int updateQuantity(CartItemVO ciVO) throws SQLException {
		int rowCnt = -1;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			StringBuilder updateQuantity = new StringBuilder();
			updateQuantity
			.append("	update 	cart_item	")
			.append("	set		quantity=?	")
			.append("	where	cart_item_num=?	")
			;
			
			pstmt = con.prepareStatement(updateQuantity.toString());
			
			//바인드 변수에 값 설정
			
			pstmt.setInt(1, ciVO.getQuantity());
			pstmt.setInt(2, ciVO.getCartItemNum());
			
			//쿼리문 수행 후 결과 얻기
			
			rowCnt = pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
		
		return rowCnt;
	}//updateQuantity(CartItemVO ciVO)

	/**
	 * 아이템 옵션을 최종 저장
	 * @param ciVO
	 * @throws SQLException
	 */
	public void insertOrderDetail(CartItemVO ciVO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dbCon = DbConnection.getInstance();

		try {
			con = dbCon.getConn();

			// 1. 먼저 update 문 실행
			StringBuilder updateOrderDetail = new StringBuilder();
			updateOrderDetail
					.append("UPDATE order_detail ")
					.append("SET drink_size = ?, cup = ?, syrup = ?, shot = ?, topping = ?, base = ? ")
					.append("WHERE cart_item_num = ?");

			pstmt = con.prepareStatement(updateOrderDetail.toString());

			// 바인드 변수에 값 설정
			pstmt.setString(1, ciVO.getSize());
			pstmt.setString(2, ciVO.getCup());
			pstmt.setInt(3, ciVO.getSyrup());
			pstmt.setInt(4, ciVO.getShot());
			pstmt.setString(5, ciVO.getAddChoco());
			pstmt.setString(6, ciVO.getAddStraw());
			pstmt.setInt(7, ciVO.getCartItemNum());

			// 업데이트 실행 후 영향받은 행의 수 확인
			int rowsAffected = pstmt.executeUpdate();
			pstmt.close();

			// 2. 만약 업데이트된 행이 없다면 insert 실행
			if (rowsAffected == 0) {
				StringBuilder insertOrderDetail = new StringBuilder();
				insertOrderDetail
						.append("INSERT INTO order_detail(order_detail_num, cart_item_num, drink_size, cup, syrup, shot, topping, base) ")
						.append("VALUES(order_detail_seq.nextval, ?, ?, ?, ?, ?, ?, ?)");

				pstmt = con.prepareStatement(insertOrderDetail.toString());

				// 바인드 변수에 값 설정
				pstmt.setInt(1, ciVO.getCartItemNum());
				pstmt.setString(2, ciVO.getSize());
				pstmt.setString(3, ciVO.getCup());
				pstmt.setInt(4, ciVO.getSyrup());
				pstmt.setInt(5, ciVO.getShot());
				pstmt.setString(6, ciVO.getAddChoco());
				pstmt.setString(7, ciVO.getAddStraw());

				// insert 쿼리 실행
				pstmt.executeUpdate();
			}
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}
	}// upsertOrderDetail(CartItemVO ciVO)

	public void updateOrderDetail(CartItemVO ciVO, int orderDetailNum) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dbCon = DbConnection.getInstance();

		try {
			con = dbCon.getConn();

			StringBuilder updateOrderDetail = new StringBuilder();
			updateOrderDetail
					.append("	update order_detail	")
					.append("	set drink_size=? , cup=? , syrup=? , shot=? , topping=? , base=?	")
					.append("	where order_detail_num=?	");

//			update order_detail
//			set drink_size=? , cup=? , syrup=? , shot=? , topping=? , base=?
//			where order_detail_num=?

			pstmt = con.prepareStatement(updateOrderDetail.toString());
			//바인드 변수에 값 설정
//			pstmt.setInt(1, ciVO.getCartItemNum());
			pstmt.setString(1, ciVO.getSize());
			pstmt.setString(2, ciVO.getCup());
			pstmt.setInt(3, ciVO.getSyrup());
			pstmt.setInt(4, ciVO.getShot());
			pstmt.setString(5, ciVO.getAddChoco());
			pstmt.setString(6, ciVO.getAddStraw());
			pstmt.setInt(7, orderDetailNum);

			//쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();


		} finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
	}//updateOrderDetail(CartItemVO ciVO)

	public int deleteCart(CartItemVO ciVO) throws SQLException {
		int rowCnt = -1;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			StringBuilder deleteCart = new StringBuilder();
			deleteCart
			.append("	delete	from cart_item	")
			.append("	where	cart_item_num=? and cart_num=?	");
			
			pstmt = con.prepareStatement(deleteCart.toString());
			
			//바인드 변수에 값 설정
			pstmt.setInt(1, ciVO.getCartItemNum());
			pstmt.setInt(2, ciVO.getCartNum());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
		
		return rowCnt;
	}//deleteCart(CartItemVO ciVO)
	
	public int orderCart(CartItemVO ciVO) throws SQLException {
		int rowCnt = -1;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			StringBuilder deleteItem = new StringBuilder();
			deleteItem
			.append("	update	cart_item	")
			.append("	set		order_flag='Y'	")
			.append("	where	cart_item_num=? and cart_num=?	")
			;
			
			pstmt = con.prepareStatement(deleteItem.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, ciVO.getCartItemNum());
			pstmt.setInt(2, ciVO.getCartNum());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}// end finally
		
		return rowCnt;
	}//orderCart(CartItemVO ciVO)
	
	public int TotalCostCart(CartItemVO cartItems) {
		int totalCost = 0;
		
		return totalCost;
	}//TotalCostCart(CartItemVO cartItems)
	
}//c
