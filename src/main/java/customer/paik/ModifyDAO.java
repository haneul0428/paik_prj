package customer.paik;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.DbConnection;


public class ModifyDAO {
    private static ModifyDAO instance;

    private ModifyDAO() {}

    public static ModifyDAO getInstance() {
        if (instance == null) {
            instance = new ModifyDAO();
        }
        return instance;
    }

    public boolean validatePassword(String name, String password) throws SQLException {
        boolean isValid = false;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            StringBuilder query = new StringBuilder();
            query.append("SELECT COUNT(*) AS count FROM user_info WHERE name = ? AND password = ?");

            pstmt = con.prepareStatement(query.toString());
            pstmt.setString(1, name);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                isValid = rs.getInt("count") > 0;
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return isValid;
    }

    public int updateUserInfo(ModifyVO user) throws SQLException {
        int rowCount = 0;

        Connection con = null;
        PreparedStatement pstmt = null;

        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConn();
            StringBuilder updateQuery = new StringBuilder();
            updateQuery.append("UPDATE user_info SET ")
                       .append("password = ?, ")
                       .append("zipcode = ?, ")
                       .append("address = ?, ")
                       .append("address2 = ?, ")
                       .append("phone = ? ") // 전화번호 업데이트
                       .append("WHERE email = ?");

            pstmt = con.prepareStatement(updateQuery.toString());
            pstmt.setString(1, user.getPassword());
            pstmt.setString(2, user.getZipcode());
            pstmt.setString(3, user.getAddress());
            pstmt.setString(4, user.getAddress2());
            pstmt.setString(5, user.getPhone()); // 전화번호 추가
            pstmt.setString(6, user.getEmail());

            rowCount = pstmt.executeUpdate();
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }

        return rowCount;
    }
}
