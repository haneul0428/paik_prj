package manager.paik.dashboard;

import kr.co.sist.dao.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author : myJstar
 * @fileName : DashboardDAO
 * @since : 24. 10. 29.
 */

//싱글턴 패턴
public class DashboardDAO {
    
    private static DashboardDAO dDAO;
    
    private DashboardDAO() {
        
    }
    public static DashboardDAO getInstance() {
        if (dDAO == null) {
            dDAO = new DashboardDAO();
        }
        return dDAO;
    }

    /**
     * 최근 7일간의 음료 판매건수 조회
     * @return int[] drinkSales
     * @throws SQLException
     */
    public int[] selectDrinkSales() throws SQLException {
        int[] drinkSales = new int[7];

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try {
            //3. Connection 얻기
            conn = dbCon.getConn();

            // 쿼리문
            String selectDrinkSales =
                    "SELECT nvl(SUM(QUANTITY),0) AS amount " +
                            "FROM cart_item " +
                            "JOIN item ON cart_item.item_num = item.item_num "+
                            "WHERE order_flag = 'Y' AND TRUNC(cart_item.input_date) = TRUNC(sysdate - ?) " +
                            " AND item.categories_NUM BETWEEN 0 AND 1 ";

            //4. 쿼리문 생성 객체 얻기
            pstmt = conn.prepareStatement(selectDrinkSales);

            // 1부터 7까지 반복
            for (int i = 1; i <= 7; i++) {
                pstmt.setInt(1, i); // 바인드 변수 설정
                rs = pstmt.executeQuery(); // 쿼리 실행

                // 결과 얻기
                if (rs.next()) {
                    int amount = rs.getInt("amount"); // 판매 건수
                    drinkSales[i - 1] = amount;
                }
            }
        } finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }
        return drinkSales; // 최종 결과 반환
    }

    /**
     * 최근 7일간의 디저트+아이스크림 판매건수 조회
     * @return int[] dessertSales
     * @throws SQLException
     */
    public int[] selectDessertSales() throws SQLException {
        int[] dessertSales = new int[7];

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try {
            //3. Connection 얻기
            conn = dbCon.getConn();

            // 쿼리문
            String selectDessertSales =
                    "SELECT nvl(SUM(QUANTITY),0) AS amount " +
                            "FROM cart_item join item on cart_item.item_num = item.item_num  " +
                            "WHERE order_flag = 'Y' AND TRUNC(cart_item.input_date) = TRUNC(sysdate - ?)  " +
                            "AND categories_NUM BETWEEN 2 AND 3";

            //4. 쿼리문 생성 객체 얻기
            pstmt = conn.prepareStatement(selectDessertSales);

            // 1부터 7까지 반복
            for (int i = 1; i <= 7; i++) {
                pstmt.setInt(1, i); // 바인드 변수 설정
                rs = pstmt.executeQuery(); // 쿼리 실행

                // 결과 얻기
                if (rs.next()) {
                    int amount = rs.getInt("amount"); // 판매 건수
                    dessertSales[i - 1] = amount;
                }
            }
        } finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }
        return dessertSales; // 최종 결과 반환
    }


    /**
     * 지난 7일간 가입한 회원수
     * @return int[] selectJoinCustomer
     * @throws SQLException
     */
    public int[] selectJoinCustomer() throws SQLException {
        int[] selectJoinCustomer = new int[7];

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try {
            //3. Connection 얻기
            conn = dbCon.getConn();

            // 쿼리문
            String selectSql =
                    "SELECT count(cus_id) AS join " +
                            "FROM customer " +
                            "WHERE cus_flag = 'N' AND TRUNC(input_date) = TRUNC(sysdate - ?)";


            //4. 쿼리문 생성 객체 얻기
            pstmt = conn.prepareStatement(selectSql);

            // 1부터 7까지 반복
            for (int i = 1; i <= 7; i++) {
                pstmt.setInt(1, i); // 바인드 변수 설정
                rs = pstmt.executeQuery(); // 쿼리 실행

                // 결과 얻기
                if (rs.next()) {
                    int join = rs.getInt("join"); // 회원가입 건수
                    selectJoinCustomer[i - 1] = join;
                }
            }
        } finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }
        return selectJoinCustomer; // 최종 결과 반환
    }

    /**
     * 지난 7일간 가입한 회원수
     * @return int[] selectJoinCustomer
     * @throws SQLException
     */
    public int[] selectWithdrawCustomer() throws SQLException {
        int[] selectWithdrawCustomer = new int[7];

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try {
            //3. Connection 얻기
            conn = dbCon.getConn();

            // 쿼리문
            String selectSql =
                    "SELECT count(cus_id) AS withdraw " +
                            "FROM customer " +
                            "WHERE cus_flag = 'Y' AND TRUNC(input_date) = TRUNC(sysdate - ?)";

            //4. 쿼리문 생성 객체 얻기
            pstmt = conn.prepareStatement(selectSql);

            // 1부터 7까지 반복
            for (int i = 1; i <= 7; i++) {
                pstmt.setInt(1, i); // 바인드 변수 설정
                rs = pstmt.executeQuery(); // 쿼리 실행

                // 결과 얻기
                if (rs.next()) {
                    int withdraw = rs.getInt("withdraw"); // 탈퇴회원 수
                    selectWithdrawCustomer[i - 1] = withdraw;
                }
            }
        } finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }
        return selectWithdrawCustomer; // 최종 결과 반환
    }


    /**
     * 지난 7일간 올라온 voc
     * @return int[] selectVoc
     * @throws SQLException
     */
    public int[] selectVoc() throws SQLException {
        int[] selectVoc = new int[7];

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try {
            //3. Connection 얻기
            conn = dbCon.getConn();

            // 쿼리문
            String selectSql =
                    "select count(voc_num) as voc " +
                            " from voc " +
                            "WHERE TRUNC(inquiry_d) = TRUNC(sysdate - ?)";

            //4. 쿼리문 생성 객체 얻기
            pstmt = conn.prepareStatement(selectSql);

            // 1부터 7까지 반복
            for (int i = 1; i <= 7; i++) {
                pstmt.setInt(1, i); // 바인드 변수 설정
                rs = pstmt.executeQuery(); // 쿼리 실행

                // 결과 얻기
                if (rs.next()) {
                    int voc = rs.getInt("voc"); // voc 건수
                    selectVoc[i - 1] = voc;
                }
            }
        } finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }
        return selectVoc; // 최종 결과 반환
    }



    /**
     * 지난 7일간의 총 매출
     * @return int[] sales
     * @throws SQLException
     */
    public int[] selectSales() throws SQLException {
        int[] sales = new int[7];

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try {
            //3. Connection 얻기
            conn = dbCon.getConn();

            // 쿼리문
            String selectSql =
                    "SELECT nvl(SUM(i.price * c.quantity),0) as total " +
                            "FROM cart_item c " +
                            "JOIN item i ON c.item_num = i.item_num "+
                    "WHERE TRUNC(c.input_date) = TRUNC(sysdate-?)";

            //4. 쿼리문 생성 객체 얻기
            pstmt = conn.prepareStatement(selectSql);

            // 1부터 7까지 반복
            for (int i = 1; i <= 7; i++) {
                pstmt.setInt(1, i); // 바인드 변수 설정
                rs = pstmt.executeQuery(); // 쿼리 실행

                // 결과 얻기
                if (rs.next()) {
                    int total = rs.getInt("total"); // 판매량
                    sales[i - 1] = total;
                }
            }
        } finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }
        return sales; // 최종 결과 반환
    }
} // DashboardDAO 끝 
