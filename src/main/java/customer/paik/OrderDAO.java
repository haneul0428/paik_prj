package customer.paik;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

public class OrderDAO {
    private static OrderDAO oDAO;

    private OrderDAO(){

    }

    // Singleton 패턴
    public static OrderDAO getInstance() {
        if (oDAO == null) {
            oDAO = new OrderDAO();
        }
        return oDAO;
    }

    /**
     * 세션에 저장된 cart_num 으로 order_flag 가 'Y'인 것들을 가져온다.
     * @return
     * @throws SQLException
     */
    public List<OrderVO> selectAllOrder(int cartNum) throws SQLException {
        List<OrderVO> list = new ArrayList<OrderVO>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try{
            //3. Connecion 얻기
            conn = dbCon.getConn();
            
            //4. 쿼리문 생성 객체 얻기
            StringBuilder selectAllOrder = new StringBuilder();
            selectAllOrder
            		.append(" SELECT c.cart_item_num, i.i_name_k, i.categories_num, c.input_date, i.price, i.ingredient_flag,")
                    .append(" (c.quantity * i.price) AS total, c.quantity, i.image, ")
                    .append("  d.drink_size, d.cup, d.syrup, d.shot, d.topping,d.base")
                    .append("  FROM CART_ITEM c ")
                    .append("  LEFT OUTER JOIN item i ON c.item_num = i.item_num ")
                    .append("  LEFT OUTER JOIN order_detail d ON c.cart_item_num = d.cart_item_num ")
                    .append("  where c.order_flag ='Y' and c.cart_num=?")
                    .append(" order by c.input_date desc");
            
            //5. 바인드 변수에 값 설정
            pstmt = conn.prepareStatement(selectAllOrder.toString());
            
            //이 바인드 변수에 cart_num이 넘어옴.
            pstmt.setInt(1, cartNum);
            rs = pstmt.executeQuery();
            
            OrderVO oVO = null;
            //6. 쿼리문 수행후 결과 얻기
            while (rs.next()) {
                oVO = new OrderVO();
                oVO.setCartItemNum(rs.getInt("cart_item_num"));
                oVO.setiNameK(rs.getString("i_name_k"));
                oVO.setInputDate(rs.getDate("input_date"));
                oVO.setPrice(rs.getInt("price"));
                oVO.setTotal(rs.getInt("total"));
                oVO.setQuantity(rs.getInt("quantity"));
                oVO.setImage(rs.getString("image"));
                oVO.setDrinkSize(rs.getString("drink_size"));
                oVO.setCup(rs.getString("cup"));
                oVO.setSyrup(rs.getInt("syrup"));
                oVO.setShot(rs.getInt("shot"));
                oVO.setTopping(rs.getString("topping"));
                oVO.setBase(rs.getString("base"));
                oVO.setIngredient_flag(rs.getString("ingredient_flag"));
                oVO.setCategories_num(rs.getString("categories_num"));
                
                list.add(oVO);
            }
        }finally {
        	//7. 연결 끊기
        	dbCon.dbClose(rs, pstmt, conn);
        }
        return list;
    }//selectAllOrder

}
