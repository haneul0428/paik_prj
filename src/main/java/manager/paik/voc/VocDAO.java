package manager.paik.voc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

/**
 * @author : user
 * @fileName : vocDAO
 * @since : 24. 11. 7.
 */
public class VocDAO {

    private static VocDAO vDAO;

    private VocDAO() {
    }

    public static VocDAO getInstance() {
        if (vDAO == null) {
            vDAO = new VocDAO();
        }
        return vDAO;
    }


    /**
     *
     * @return
     * @throws SQLException
     */
    public List<VocVO> selectAllVoc(boolean type) throws SQLException {
        List<VocVO> list = new ArrayList<VocVO>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            conn = dbCon.getConn();

            StringBuilder selectSql = new StringBuilder();
            selectSql
                    .append("  select VOC_NUM, CUS_ID, INQUIRY_T, TITLE, CONTENT, ROUTE, VISIT, ANS_AL, INQUIRY_D ")
                    .append("  from voc  ");

            // type에 따라 where 조건 다르게 설정

            if (!type) {  // 응답
                selectSql.append(" where ANS IS NOT NULL");
            } else{  // 미응답
                selectSql.append(" where ANS IS NULL");
            }
            // type이 다른 값이면 where 조건 없이 전체 조회

            pstmt = conn.prepareStatement(selectSql.toString());
            rs = pstmt.executeQuery();

            VocVO vVO = null;
            while (rs.next()) {
                vVO = new VocVO();
                vVO.setVocNum(rs.getInt("voc_num"));
                vVO.setCusId(rs.getString("cus_id"));
                vVO.setInquiryType(rs.getString("inquiry_t")); // 컬럼명이 INQUIRY_T로 보여서 수정
                vVO.setTitle(rs.getString("title"));
                vVO.setContent(rs.getString("content"));
                vVO.setRoute(rs.getString("route"));
                vVO.setVisit(rs.getDate("visit"));
                vVO.setAnsAl(rs.getString("ans_al"));
                vVO.setInquiryDate(rs.getDate("inquiry_d"));
                list.add(vVO);
            }
        } finally {
            dbCon.dbClose(rs, pstmt, conn);
        }

        return list;
    }
} // vocDAO 끝 
