package customer.paik;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

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
     * insert vocVO
     * @param vocVO
     * @throws SQLException
     */
    public void insertVoc(VocVO vocVO) throws SQLException {

        Connection conn = null;
        PreparedStatement pstmt = null;

        //1. JNDI 사용객체 생성
        //2. DBCP에서 Datasource 얻기
        DbConnection dbCon = DbConnection.getInstance();
        try{
            //3. Connecion 얻기
            conn = dbCon.getConn();

            //4. 쿼리문 생성 객체 얻기
            //insert into voc values(VOC_SEQ.NEXTVAL,'test01','불만','이것좀 추가 해주세여.','아 제발요~~','매장외 방문',sysdate,'답변변변벼녑','Y',sysdate(x),sysdate(x));
            StringBuilder insertSql = new StringBuilder();
            insertSql
                    .append(" insert into voc ")
                    .append(" values(VOC_SEQ.NEXTVAL,?,?,?,?,?,?,?,?)");
            pstmt = conn.prepareStatement(insertSql.toString());

            //5. 바인드 변수에 값 설정
            pstmt.setString(1, vocVO.getCusId());
            pstmt.setString(2,vocVO.getInquiryType());
            pstmt.setString(3,vocVO.getTitle());
            pstmt.setString(4,vocVO.getContent());
            pstmt.setString(5, vocVO.getRoute());
            pstmt.setDate(6, vocVO.getVisit());
            pstmt.setString(7, vocVO.getAns());
            pstmt.setString(8, vocVO.getAnsAl());

            //6. 쿼리문 수행후 결과 얻기
            pstmt.executeUpdate();
        }finally {
            //7. 연결 끊기
            dbCon.dbClose(null, pstmt, conn);
        }

    }


    /**
     *
     * @return
     * @throws SQLException
     */
    public List<VocVO> selectAllVoc() throws SQLException {
        List<VocVO> vocList = new ArrayList<>();

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
            StringBuilder selectAllSql = new StringBuilder();
            selectAllSql.
                    append("select * from voc");

            //5. 바인드 변수에 값 설정
            //6. 쿼리문 수행후 결과 얻기
            pstmt = conn.prepareStatement(selectAllSql.toString());
            rs = pstmt.executeQuery();
            VocVO vocVO = null;
            while (rs.next()) {
                 vocVO= new VocVO();
                vocVO.setCusId(rs.getString(1));
                vocVO.setInquiryType(rs.getString(2));
                vocVO.setTitle(rs.getString(3));
                vocVO.setContent(rs.getString(4));
                vocVO.setRoute(rs.getString(5));
                vocVO.setVisit(rs.getDate(6));
                vocVO.setAns(rs.getString(7));
                vocVO.setAnsAl(rs.getString(8));
                vocList.add(vocVO);
            }

        }finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }

        return vocList;
    }

    /**
     *
     * @param vocNum
     * @return
     * @throws SQLException
     */
    public int deleteVoc(int vocNum) throws SQLException {
      int rowCnt =0;

      Connection conn = null;
      PreparedStatement pstmt = null;

      //1. JNDI 사용객체 생성
      //2. DBCP에서 Datasource 얻기
      DbConnection dbCon = DbConnection.getInstance();
      try{
          //3. Connecion 얻기
          conn = dbCon.getConn();

          //4. 쿼리문 생성 객체 얻기
          String deleteSql = "delete from voc where voc_num = ?";
          pstmt = conn.prepareStatement(deleteSql);

          //5. 바인드 변수에 값 설정
          pstmt.setInt(1, vocNum);

          //6. 쿼리문 수행후 결과 얻기
          rowCnt = pstmt.executeUpdate();

      }finally {
          //7. 연결 끊기
          dbCon.dbClose(null, pstmt, conn);
      }
      return rowCnt;
    }


    /**
     * @param
     * @param vocNum
     * @return
     * @throws SQLException
     */
    public VocVO selectOneVoc(int vocNum) throws SQLException {
        VocVO vocVO = new VocVO();

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
            String selectOneSql = "select * from voc where voc_num=?";
            pstmt= conn.prepareStatement(selectOneSql);

            //5. 바인드 변수에 값 설정
            pstmt.setInt(1, vocNum);

            //6. 쿼리문 수행후 결과 얻기
            rs = pstmt.executeQuery();
            if (rs.next()) {
                vocVO.setCusId(rs.getString("cus_id"));
                vocVO.setInquiryType(rs.getString("inquiry_t"));
                vocVO.setTitle(rs.getString("title"));
                vocVO.setContent(rs.getString("content"));
                vocVO.setRoute(rs.getString("route"));
                vocVO.setVisit(rs.getDate("visit"));
                vocVO.setAns(rs.getString("ans"));
                vocVO.setAnsAl(rs.getString("ans_al"));
                vocVO.setAnsDate(rs.getDate("ans_d"));
                vocVO.setInquiryDate(rs.getDate("inquiry_d"));
            }

        }finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }

        return vocVO;
    }


    /**
     *
     * @param vocVO
     * @return
     * @throws SQLException
     */
    public int updateVoc(VocVO vocVO) throws SQLException {
        int rowCnt =0;

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
            StringBuilder updateSql = new StringBuilder();
            updateSql
                    .append(" update voc ")
                    .append(" set       ")
                    .append(" where voc_num=?");

            //5. 바인드 변수에 값 설정
            //6. 쿼리문 수행후 결과 얻기

        }finally {
            //7. 연결 끊기
            dbCon.dbClose(rs, pstmt, conn);
        }



        return rowCnt;
    }
}
