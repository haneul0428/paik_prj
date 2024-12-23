package manager.paik.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.DbConnection;

/**
 * @author : user
 * @fileName : ManagerDAO
 * @since : 24. 10. 22.
 */
//싱글톤 패턴
public class ManagerDAO {

    private static ManagerDAO mDAO;

    private ManagerDAO() {
    }
    // 싱글톤 패턴
    public static ManagerDAO getInstance() {
        if (mDAO == null) {
            mDAO = new ManagerDAO();

        }
        return mDAO;
    }

    /*
    * myJstar
    * selectManager
    * managerVO를 전달받아 조희
    *
    */
    public boolean selectManager(ManagerVO mVO) throws SQLException {
        boolean loginFlag = false;
        
        DbConnection dbCon = DbConnection.getInstance();
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;

        try {
            conn = dbCon.getConn();
            String sql = "SELECT * FROM MANAGER WHERE manager_id=? and manager_pass=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mVO.getManagerId()); // 폼에서 전달된 매니저 ID 사용
            pstmt.setString(2, mVO.getManagerPass());

            // 아이디로 조회된 결과가 있으면
            rs = pstmt.executeQuery();
            if (rs.next()) {
                loginFlag = true;
            }
        } finally {
            dbCon.dbClose(rs, pstmt, conn);
        }
        return loginFlag;
    }

} // ManagerDAO 끝 

