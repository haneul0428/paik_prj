package customer.paik;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;


public class ItemDAO {
	private static ItemDAO iDAO;
	
	private ItemDAO() {
	}
	
	public static ItemDAO getInstance() {
		if(iDAO == null) {
			iDAO = new ItemDAO();
		}//if
		return iDAO;
	}//getInstance()
	
	//카테고리 번호에 해당하는 상품(음료) 리스트 조회
	public List<ItemVO> selectMainItem(int categoriesNum) throws SQLException {
		List<ItemVO> itemList = new ArrayList<ItemVO>();
		
		ItemVO iVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			StringBuilder selectMainItemQuery = new StringBuilder();
			selectMainItemQuery.append("	select item_num,i_name_k,image,item_flag 	")
								.append("	from item	")
								.append("	where categories_num=?	");
			
			pstmt = con.prepareStatement(selectMainItemQuery.toString());
			pstmt.setInt(1, categoriesNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				iVO = new ItemVO();
				
				char itemFlag = rs.getString("item_flag").charAt(0);
				iVO.setItemFlag(itemFlag);
				
				if(itemFlag == 'N') {
					//아이템 존재유무
					iVO.setItemNum(rs.getInt("item_num"));
					iVO.setiNameKor(rs.getString("i_name_k"));
					iVO.setImage(rs.getString("image"));
					itemList.add(iVO);
				}//if
				
			}//w
			
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}//try~ca~fi
		
		return itemList;
	}//selectMainItem(int categorisNum)

	//아이템번호에 해당하는 상품 상세정보 조회
	public ItemVO selectDetailItem(int itemNum) throws SQLException {
		ItemVO iVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			StringBuilder selectDetailItemQuery = new StringBuilder();
			selectDetailItemQuery.append("	select i.i_name_k,i.i_name_e,i.description,i.price,i.image,	")
								.append("			i.item_flag,ing.caffeine,ing.natrium,ing.fatty_acid,	")
								.append("			ing.calorie,ing.sugar,ing.protein,i.ingredient_flag	")
								.append("	from item i	")
								.append("	left join ingredient ing on i.item_num = ing.item_num	")
								.append("	where i.item_num=?	");
			
			pstmt = con.prepareStatement(selectDetailItemQuery.toString());
			pstmt.setInt(1, itemNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				iVO = new ItemVO();
				iVO.setItemNum(itemNum);
				iVO.setiNameKor(rs.getString("i_name_k"));
				iVO.setiNameEng(rs.getString("i_name_e"));
				iVO.setDescription(rs.getString("description"));
				iVO.setPrice(rs.getInt("price"));
				iVO.setImage(rs.getString("image"));
				iVO.setItemFlag(rs.getString("item_flag").charAt(0));
				
				//영양성분 존재여부 확인
				char ingredientFlag = rs.getString("ingredient_flag").charAt(0);
				iVO.setIngredientFlag(ingredientFlag);
				
				if(ingredientFlag == 'N') {
					//영양성분
					iVO.setCaff(rs.getInt("caffeine"));
					iVO.setNat(rs.getInt("natrium"));
					iVO.setFatAcid(rs.getInt("fatty_acid"));
					iVO.setCal(rs.getInt("calorie"));
					iVO.setSugar(rs.getInt("sugar"));
					iVO.setPro(rs.getInt("protein"));
				}//if
			}//if
			
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}//try~ca~fi
		
		return iVO;
	}//selectDetailItem(int itemNum)

	//고객ID를 통해 장바구니번호를 찾음
	public int fetchCartNum(String cusId) throws SQLException{
		int CartNum = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			String CartNumQuery = "select cart_num from cart where cus_id=?";
			
			pstmt = con.prepareStatement(CartNumQuery);
			pstmt.setString(1, cusId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				CartNum = rs.getInt("cart_num");
			}//if
			
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}//try~fi
		
		return CartNum;
	}//fetchCartNum(int cusId)

	//장바구니에 상품(음료)을 추가
	public void insertCartItem(String cusId, int itemNum, int quantity) throws SQLException {
		int cartNum = fetchCartNum(cusId);	//장바구니 번호 가져오기
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			String insertCartItemQuery = "insert into cart_item(cart_item_num, cart_num, item_num, quantity, order_flag, receipt_flag) values(cart_item_seq.nextval,?,?,?,'N','N')";
			//System.out.println(insertCartItemQuery);
			
			pstmt = con.prepareStatement(insertCartItemQuery);
			pstmt.setInt(1, cartNum);
			pstmt.setInt(2, itemNum);
			pstmt.setInt(3, quantity);
			
			pstmt.executeUpdate();
			
//			int countAddCart = pstmt.executeUpdate();
//			if(countAddCart>0) {
//				System.out.println("장바구니에 아이템 추가 성공");
//			} else {
//				System.out.println("장바구니에 아이템 추가 실패");
//			}//if~el
			
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}//try~ca~fi
		
	}//insertCartItem(int itemNum, int quantity)
	
}//c
