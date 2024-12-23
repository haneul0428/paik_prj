package manager.paik.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.chipher.DataEncryption;
import kr.co.sist.dao.DbConnection;

/**
 * @author : user
 * @fileName : CustomerDAO
 * @since : 24. 10. 24.
 */
//싱글톤 패턴
public class CustomerDAO {
    private static CustomerDAO cDAO;

    private CustomerDAO() {}

    public static CustomerDAO getInstance() {
        if(cDAO == null) {
            cDAO = new CustomerDAO();
        }
        return cDAO;
    }

    //countCustomer : 모든 회원의 수를 센다.
    /**
     * 다이나믹 쿼리
     * @param searchVO
     * @return
     * @throws SQLException
     */
    public int countCustomer(SearchVO searchVO) throws SQLException {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();
        try {
            conn = dbCon.getConn();
            StringBuilder countQuery = new StringBuilder();
            countQuery.append("SELECT COUNT(*) AS cnt FROM Customer");

            if (searchVO.getKeyword() != null && !searchVO.getKeyword().equals("")) {
                countQuery.append(" WHERE INSTR(").append(searchVO.getField()).append(", ?) != 0");
            }

            pstmt = conn.prepareStatement(countQuery.toString());

            if (searchVO.getKeyword() != null && !searchVO.getKeyword().equals("")) {
                pstmt.setString(1, searchVO.getKeyword());
            }

            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("cnt");
            }
        } finally {
            dbCon.dbClose(rs, pstmt, conn);
        }
        return count;
    }

    //selectAllOrder : 모든회원의 정보를 출력한다.
    public List<CustomerVO> selectAllCustomer(SearchVO searchVO) throws Exception {
        List<CustomerVO> list = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();
        try {
            conn = dbCon.getConn();
            StringBuilder selectSql = new StringBuilder();
            selectSql.append("SELECT * FROM (")
                    .append("    SELECT A.*, ROWNUM AS RNUM FROM (")
                    .append("        SELECT CUS_ID, NAME, PHONE, EMAIL, INPUT_DATE, GRADE, CUS_FLAG FROM CUSTOMER");

            if (searchVO.getKeyword() != null && !searchVO.getKeyword().equals("")) {
                selectSql.append(" WHERE INSTR(").append(searchVO.getField()).append(", ?) != 0");
            }
            selectSql.append("        ORDER BY INPUT_DATE DESC")
                    .append("    ) A WHERE ROWNUM <= ?")
                    .append(") WHERE RNUM >= ?");

            pstmt = conn.prepareStatement(selectSql.toString());
            int bindIndex = 1;
            
            DataEncryption de = new DataEncryption("abcdef0123456789");
            
            // 검색어가 있을 경우 검색어 바인드
            if (searchVO.getKeyword() != null && !searchVO.getKeyword().equals("")) {
                // 필드가 "1"일 때만 암호화
                if ("name".equals(searchVO.getField())) {
                    String str = de.encrypt(searchVO.getKeyword());
                    pstmt.setString(bindIndex++, de.encrypt(searchVO.getKeyword())); // 암호화 적용
                } else {
                    pstmt.setString(bindIndex++, searchVO.getKeyword()); // 그대로 사용
                }
            }

            // 페이징 처리를 위한 바인드
            pstmt.setInt(bindIndex++, searchVO.getEndNum());
            pstmt.setInt(bindIndex, searchVO.getStartNum());

            rs = pstmt.executeQuery();
            CustomerVO customerVO = null;
            while (rs.next()) {
                customerVO = new CustomerVO();
                customerVO.setCusId(rs.getString("cus_id"));
                customerVO.setName(rs.getString("name"));
                customerVO.setPhone(rs.getString("phone"));
                customerVO.setEmail(rs.getString("email"));
                customerVO.setInputDate(rs.getDate("input_date"));
                customerVO.setGrade(Grade.gradeForDB(rs.getInt("grade")));
                customerVO.setCusFlag(rs.getString("cus_flag"));
                list.add(customerVO);
            }
        } finally {
            dbCon.dbClose(rs, pstmt, conn);
        }
        return list;
    }

    //selectOneCustomer : 회원 한명의 정보를 출력한다 -> 상세보기
    public CustomerVO selectOneCustomer(String cusId) throws SQLException {
        CustomerVO cVO = new CustomerVO();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try{
            //3. Connecion 얻기
            conn = dbCon.getConn();

            String selectOneSql = "SELECT name, email, input_date, grade, cus_flag, phone FROM customer WHERE CUS_ID = ?";

            //4. 쿼리문 생성 객체 얻기
            pstmt = conn.prepareStatement(selectOneSql);

            //5. 바인드 변수에 값 설정
            pstmt.setString(1, cusId);

            //6. 쿼리문 수행후 결과 얻기
            rs = pstmt.executeQuery();
            if(rs.next()) {
                cVO.setCusId(cusId);
                cVO.setName(rs.getString("name"));
                cVO.setEmail(rs.getString("email"));
                cVO.setInputDate(rs.getDate("input_date"));
                cVO.setGrade(Grade.gradeForDB(rs.getInt("grade")));
                cVO.setCusFlag(rs.getString("cus_flag"));
                cVO.setPhone(rs.getString("phone"));
            }
        }finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }
        return cVO;
    }

    //Update : 회원의 정보를 변경한다. cusId와 가입일은 불가.
    public int updateCustomer(CustomerVO customerVO) throws SQLException {
        int updateCnt=0;

        Connection conn = null;
        PreparedStatement pstmt = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try{
            //3. Connecion 얻기
            conn = dbCon.getConn();

            StringBuilder updateSql =new StringBuilder();
            updateSql
                    .append("   UPDATE CUSTOMER")
                    .append("   SET name = ?,")
                    .append("   phone = ?,")
                    .append("   email = ?,")
                    .append("   cus_flag = ?, ")
                    .append("   grade = ? ")
                    .append("   WHERE cus_id = ? ");

            //4. 쿼리문 생성 객체 얻기
            pstmt=conn.prepareStatement(updateSql.toString());

            //5. 바인드 변수에 값 설정
            pstmt.setString(1,customerVO.getName() );
            pstmt.setString(2, customerVO.getPhone() );
            pstmt.setString(3, customerVO.getEmail() );
            pstmt.setString(4, customerVO.getCusFlag() );
            pstmt.setInt(5,customerVO.getGrade().getValue());
            pstmt.setString(6, customerVO.getCusId() );

            //6. 쿼리문 수행후 결과 얻기
            // 0, 1이 반환된다.
            updateCnt=pstmt.executeUpdate();

        }finally {
            //7. 연결 끊기
            dbCon.dbClose(null, pstmt, conn);
        }
        return updateCnt;
    }

    //Delete? 삭제는 불가.
    /**
     *
     * @param customerVO
     * @return
     * @throws SQLException
     */
    public int deleteCustomer(CustomerVO customerVO) throws SQLException {
        int updateCnt = 0;

        Connection conn = null;
        PreparedStatement pstmt = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try {
            //3. Connecion 얻기
            conn = dbCon.getConn();


            // 'N' -> 'Y',  'Y' -> 'N'
            StringBuilder updateSql = new StringBuilder();
            updateSql.append("update CUSTOMER ")
                      .append("set cus_flag = CASE WHEN cus_flag = 'Y' THEN 'N' ELSE 'Y' END ")
                     .append("WHERE cus_id = ? ");

            // 4. 쿼리문 생성 객체 얻기
            pstmt = conn.prepareStatement(updateSql.toString());

            // 5. 바인드 변수에 값 설정
            pstmt.setString(1, customerVO.getCusId());

            //6. 쿼리문 수행후 결과 얻기
            // 0, 1이 반환된다.
            updateCnt = pstmt.executeUpdate();

        } finally {
            //7. 연결 끊기
            dbCon.dbClose(null, pstmt, conn);
        }
        return updateCnt;
    }

} // CustomerDAO 끝 
