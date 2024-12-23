package manager.paik.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

public class OrderDAO {
	private static OrderDAO oDAO;
	
	//singleton
	private OrderDAO(){
		
	}
	
	public static OrderDAO getInstance() {
		if(oDAO == null) {
			oDAO = new OrderDAO();
		}
		
		return oDAO;
	}
	
	/**
	 * 미수령된 주문의 수를 조회하는 일을 하는 메소드
	 * @param sVO
	 * @return
	 * @throws SQLException
	 */
	public int selectTotalCountNotReceived(SearchVO sVO) throws SQLException{
		int totalCount = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		try {
			conn = dbCon.getConn();
			
			StringBuilder selectCount = new StringBuilder();
			selectCount
			.append("	select count(cart_item_num)cnt from cart_item	")
			.append("	where order_flag='Y' and receipt_flag='N'	")
			;
			pstmt = conn.prepareStatement(selectCount.toString());
			//바인드 변수 값 설정
			//쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}//end if
		} finally {
			dbCon.dbClose(rs, pstmt, conn);
		}// finally
		
		return totalCount;
	}//selectTotalCountNotReceived
	
	/**
	 * 수령한 주문의 수를 조회하는 일을 하는 메소드
	 * @param sVO
	 * @return
	 * @throws SQLException
	 */
	public int selectTotalCountReceived(SearchVO sVO) throws SQLException{
		int totalCount = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		try {
			conn = dbCon.getConn();
			
			StringBuilder selectCount = new StringBuilder();
			selectCount
			.append("	select count(cart_item_num)cnt from cart_item	")
			.append("	where	order_flag='Y' and receipt_flag='Y'	")
			;
			pstmt = conn.prepareStatement(selectCount.toString());
			//바인드 변수 값 설정
			//쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("cnt");
			}//end if
		} finally {
			dbCon.dbClose(rs, pstmt, conn);
		}// finally
		
		return totalCount;
	}//selectTotalCountReceived
	/**
	 * 미수령한 주문의 목록을 조회하는 일을 하는 메소드
	 * @param sVO
	 * @return
	 * @throws SQLException
	 */
	public List<OrderVO> selectNotReceivedList(SearchVO sVO)throws SQLException {
		List<OrderVO> list = new ArrayList<OrderVO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			//connection 열기
			conn = dbCon.getConn();
			
			//쿼리문 생성 객체 얻기
			StringBuilder selectNotReceivedList = new StringBuilder();
			selectNotReceivedList
			.append("	select cart_item_num, cart_num, cart_item_number, i_name_k, name, input_date, quantity, receipt_flag	")
			.append("	from(select LPAD(ci.cart_item_num,3,'0')cart_item_num, ci.cart_item_num cart_item_number, i.i_name_k, cus.name, ci.input_date, ci.quantity, ci.receipt_flag,	")
			.append("	row_number() over(order by ci.input_date asc) rnum, c.cart_num cart_num, ci.item_num item_num	")
			.append("	from cart_item ci, cart c, customer cus, item i	")
			.append("	where ci.item_num = i.item_num and cus.cus_id = c.cus_id and c.cart_num = ci.cart_num and receipt_flag='N')	")
			.append("	where rnum between ? and ?	")
			;
			/*
			 * .append("	select cart_item_num, i_name_k, name, input_date, quantity, receipt_flag	"
			 * )
			 * .append("	from(select LPAD(ci.cart_item_num,3,'0')cart_item_num, i.i_name_k, cus.name, ci.input_date, ci.quantity, ci.receipt_flag,	"
			 * ) .append("	row_number() over(order by ci.input_date asc) rnum	")
			 * .append("	from cart_item ci, cart c, customer cus, item i	")
			 * .append("	where ci.item_num = i.item_num and cus.cus_id = c.cus_id and c.cart_num = ci.cart_num and order_flag='Y' and receipt_flag='N')	"
			 * ) .append("	where rnum between ? and ?	") ;
			 */			
			pstmt = conn.prepareStatement(selectNotReceivedList.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, sVO.getStartNum());
			pstmt.setInt(2, sVO.getEndNum());
			
			rs = pstmt.executeQuery();
			
			OrderVO oVO = null;
			
			while(rs.next()) {
				oVO = new OrderVO();
				oVO.setCartItemNum(rs.getString("cart_item_num"));
				oVO.setCartNum(rs.getInt("cart_num"));
				oVO.setCartItemNumber(rs.getInt("cart_item_number"));
				oVO.setiNameK(rs.getString("i_name_k"));
				oVO.setName(rs.getString("name"));
				oVO.setInputDate(rs.getDate("input_date"));
				oVO.setQuantity(rs.getInt("quantity"));
				oVO.setReceiptFlag(rs.getString("receipt_flag"));
				
				list.add(oVO);
			}// end while
			
		} finally {
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
		
		return list;
	}//selectNotReceivedList
	
	/**
	* 수령한 주문의 목록을 조회하는 일을 하는 메소드
	* @param sVO
	* @return
	* @throws SQLException
	*/
	public List<OrderVO> selectReceivedList(SearchVO sVO)throws SQLException {
		List<OrderVO> list = new ArrayList<OrderVO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			//connection 열기
			conn = dbCon.getConn();
			
			//쿼리문 생성 객체 얻기
			StringBuilder selectNotReceivedList = new StringBuilder();
			selectNotReceivedList
			.append("	select cart_item_num, cart_num, cart_item_number, i_name_k, name, input_date, quantity, receipt_flag	")
			.append("	from(select LPAD(ci.cart_item_num,3,'0')cart_item_num, ci.cart_item_num cart_item_number, i.i_name_k, cus.name, ci.input_date, ci.quantity, ci.receipt_flag,	")
			.append("	row_number() over(order by ci.input_date asc) rnum, c.cart_num cart_num, ci.item_num item_num	")
			.append("	from cart_item ci, cart c, customer cus, item i	")
			.append("	where ci.item_num = i.item_num and cus.cus_id = c.cus_id and c.cart_num = ci.cart_num and receipt_flag='Y')	")
			.append("	where rnum between ? and ?	")
			/*
			 * .append("	select cart_item_num, i_name_k, name, input_date, quantity, receipt_flag	"
			 * )
			 * .append("	from(select LPAD(ci.cart_item_num,3,'0')cart_item_num, i.i_name_k, cus.name, ci.input_date, ci.quantity, ci.receipt_flag,	"
			 * ) .append("	row_number() over(order by ci.input_date asc) rnum	")
			 * .append("	from cart_item ci, cart c, customer cus, item i	")
			 * .append("	where ci.item_num = i.item_num and cus.cus_id = c.cus_id and c.cart_num = ci.cart_num and order_flag='Y' and receipt_flag='Y')	"
			 * ) .append("	where rnum between ? and ?	")
			 */			;
			
			pstmt = conn.prepareStatement(selectNotReceivedList.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, sVO.getStartNum());
			pstmt.setInt(2, sVO.getEndNum());
			
			rs = pstmt.executeQuery();
			
			OrderVO oVO = null;
			
			while(rs.next()) {
				oVO = new OrderVO();
				oVO.setCartItemNum(rs.getString("cart_item_num"));
				oVO.setCartNum(rs.getInt("cart_num"));
				oVO.setCartItemNumber(rs.getInt("cart_item_number"));
				oVO.setiNameK(rs.getString("i_name_k"));
				oVO.setName(rs.getString("name"));
				oVO.setInputDate(rs.getDate("input_date"));
				oVO.setQuantity(rs.getInt("quantity"));
				oVO.setReceiptFlag(rs.getString("receipt_flag"));
				
				list.add(oVO);
			}// end while
			
		} finally {
			dbCon.dbClose(rs, pstmt, conn);
		}// end finally
		
		return list;
	}
	
	public int changeReceived(OrderVO oVO) throws SQLException {
		int rowCnt = -1;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			conn = dbCon.getConn();
			
			StringBuilder changeReceived = new StringBuilder();
			changeReceived
			.append("	update	cart_item	")
			.append("	set		receipt_flag='Y'	")
			.append("	where	cart_item_num=? and cart_num=?	")
			;
			
			pstmt = conn.prepareStatement(changeReceived.toString());
			
			//바인드 변수에 값 설정
			
			pstmt.setInt(1, oVO.getCartItemNumber());
			pstmt.setInt(2, oVO.getCartNum());
			
			//쿼리문 수행 후 결과 얻기
			
			rowCnt = pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}//end finally
		
		return rowCnt;
	}//changeReceived
	
	public int changeNotReceived(OrderVO oVO) throws SQLException {
		int rowCnt = -1;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			conn = dbCon.getConn();
			
			StringBuilder changeReceived = new StringBuilder();
			changeReceived
			.append("	update	cart_item	")
			.append("	set		receipt_flag='N'	")
			.append("	where	cart_item_num=? and cart_num=?	")
			;
			
			pstmt = conn.prepareStatement(changeReceived.toString());
			
			//바인드 변수에 값 설정
			
			pstmt.setInt(1, oVO.getCartItemNumber());
			pstmt.setInt(2, oVO.getCartNum());
			
			//쿼리문 수행 후 결과 얻기
			
			rowCnt = pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, conn);
		}//end finally
		
		return rowCnt;
	}//changeReceived
	
}//OrderDAO
