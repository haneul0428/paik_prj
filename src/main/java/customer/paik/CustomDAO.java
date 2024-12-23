package customer.paik;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.chipher.DataDecryption;
import kr.co.sist.chipher.DataEncryption;
import kr.co.sist.dao.DbConnection;

public class CustomDAO {
	private static CustomDAO cDAO;

	private CustomDAO() {
	}//CustomDAO()

	public static CustomDAO getInstance() {
		if(cDAO == null) {
			cDAO = new CustomDAO();
		}//if
		return cDAO;
	}//getInstance()

	//로그인
	public boolean login(CustomVO cVO) throws SQLException{
		boolean loginFlag = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dbCon = DbConnection.getInstance();
		try {
			con = dbCon.getConn();
			
			String loginQuery = "select cus_id,name,cus_flag from customer where cus_id=? and cus_pass=?";
			pstmt = con.prepareStatement(loginQuery);
			
			pstmt.setString(1, cVO.getCusId());
			pstmt.setString(2, cVO.getCusPass());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cVO.setName(rs.getString("name"));
				cVO.setCusFlag(rs.getString("cus_flag"));
				loginFlag = true;
			}//if
			
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}//try~fi
		
		return loginFlag;
	}//login(CustomVO cVO)

	//id 중복확인
	public boolean duplicationId(String id) throws SQLException {
		boolean resultFlag = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 1. JNDI 사용객체 생성
		// 2. DBCP에서 DataSource 얻기
		DbConnection dbCon = DbConnection.getInstance();

		try {
			// 3. Connection 얻기
			con = dbCon.getConn();

			// 4. 쿼리문 생성객체 얻기
			String dupIdQuery = "select cus_id from customer where cus_id=?";
			pstmt = con.prepareStatement(dupIdQuery);

			// 5. 바인드 변수 값설정
			pstmt.setString(1, id);

			// 6. 쿼리문 수행 후 결과얻기
			rs = pstmt.executeQuery();

			resultFlag = rs.next(); // id 존재여부 --> id O: true, id X: false
			//System.out.println("ID 존재 여부: " + resultFlag);	//id 확인용
		} finally {
			// 7. 연결끊기
			dbCon.dbClose(rs, pstmt, con);
		} // try~ca~fi

		return resultFlag;
	}//duplicationId(String cusId)

	//회원가입
	public void signUp(CustomVO cVO) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			String signUpQuery = "insert into customer(cus_id,cus_pass,name,phone,email,cus_flag,grade) values(?,?,?,?,?,'N',0)";
			pstmt = con.prepareStatement(signUpQuery);
			
			pstmt.setString(1, cVO.getCusId());
			pstmt.setString(2, cVO.getCusPass());
			pstmt.setString(3, cVO.getName());
			pstmt.setString(4, cVO.getPhone());
			pstmt.setString(5, cVO.getEmail());
			
			pstmt.executeUpdate();
			
			//회원가입할 때 장바구니 생성
			String createCartQuery = "insert into cart(cart_num, cus_id) values(cart_seq.nextval, ?)";
			pstmt = con.prepareStatement(createCartQuery);
			pstmt.setString(1, cVO.getCusId());
			
			pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}//try~fi
		
	}//signUp(CustomVO cVO)

	//아이디찾기
	public String searchId(CustomVO cVO) throws SQLException {
		String foundId = null;
		String cusFlag = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dbCon = DbConnection.getInstance();
		try {
			con = dbCon.getConn();

			String searchIdQuery = "select cus_id,cus_flag from customer where name=? and phone=?";

			pstmt = con.prepareStatement(searchIdQuery);

			pstmt.setString(1, cVO.getName());
			pstmt.setString(2, cVO.getPhone());

			rs = pstmt.executeQuery();

			if(rs.next()) {
				foundId = rs.getString("cus_id");
				cusFlag = rs.getString("cus_flag");
			}

		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}//try~fi
		
		if(foundId == null) {
			return "일치하는 회원 정보가 존재하지 않습니다.";
		}//if
		
		if("Y".equals(cusFlag)) {
			return "이미 탈퇴된 계정입니다.";
		}//if

		return foundId;
	}//searchId(CustomVO cVO)

	//비밀번호찾기
	public String searchPass(CustomVO cVO) throws SQLException {
		String tempPass = setTempPass();
		String cusFlag = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dbCon = DbConnection.getInstance();
		try {
			con = dbCon.getConn();

			String searchPassQuery = "select cus_id,cus_flag from customer where cus_id=? and name=? and phone=?";

			pstmt = con.prepareStatement(searchPassQuery);

			pstmt.setString(1, cVO.getCusId());
			pstmt.setString(2, cVO.getName());
			pstmt.setString(3, cVO.getPhone());

			rs = pstmt.executeQuery();

			if(rs.next()) {
				cusFlag = rs.getString("cus_flag");
				
				if("Y".equals(cusFlag)) {
					return "이미 탈퇴된 계정입니다.";
				}//if
				
				String hashedPass = DataEncryption.messageDigest("SHA-1", tempPass);
				String updatePassQuery = "update customer set cus_pass=? where cus_id=?";

				pstmt = con.prepareStatement(updatePassQuery);

				pstmt.setString(1, hashedPass);
				pstmt.setString(2, cVO.getCusId());

				pstmt.executeUpdate();
			} else {
				return "일치하는 회원 정보가 존재하지 않습니다.";
			}//if
			
		} catch(NoSuchAlgorithmException nsa) {
			nsa.printStackTrace();
        } finally {
			dbCon.dbClose(rs, pstmt, con);
		}//try~fi
		
		return tempPass;
	}//searchPass(CustomVO cVO)

	//임시 비밀번호 생성 - 10자(숫자0~9 대문자A~Z 소문자a~z 로 구성)
	public String setTempPass() {
		StringBuilder tempPass = new StringBuilder();

		for(int i=0; i<10; i++) {
			int ranNum = (int)(Math.random()*62);
			char ranChar = ' ';

			if(ranNum < 10) {
				ranChar = (char)('0' + ranNum);	//숫자 0~9
			} else if (ranNum < 36) {
				ranChar = (char)('A' + (ranNum - 10));	//대문자 A~Z
			} else {
				ranChar = (char)('a' + (ranNum - 36));	//소문자 a~z
			}//el~if

			tempPass.append(ranChar);
		}//f

		return tempPass.toString();
	}//setTempPass()

	/**
	 * 회원의 아이디에 해당하는 정보를 가져오는 일을 하는 메소드
	 * @param cusId
	 * @return
	 * @throws SQLException
	 */
	public CustomVO selectCustomer(String cusId) throws SQLException {
		CustomVO cVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			StringBuilder selectCustomer = new StringBuilder();
			selectCustomer
			.append("	select cus_id, cus_pass, name, phone, email, grade	")
			.append("	from customer	")
			.append("	where cus_id=?	")
			;
			
			pstmt = con.prepareStatement(selectCustomer.toString());
			//바인드 변수에 값 설정
			pstmt.setString(1, cusId);
			
			//쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cVO = new CustomVO();
				cVO.setCusId(rs.getString("cus_id"));
				cVO.setName(rs.getString("name"));
				cVO.setPhone(rs.getString("phone"));
				cVO.setEmail(rs.getString("email"));
				cVO.setGrade(rs.getString("grade"));
				
				DataDecryption dd = new DataDecryption("abcdef0123456789");
				cVO.setName(dd.decrypt(cVO.getName()));
				cVO.setPhone(dd.decrypt(cVO.getPhone()));
				cVO.setEmail(dd.decrypt(cVO.getEmail()));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}//end finally
		
		return cVO;
	}//selectCustomer

	public int updateAccount(CustomVO cVO) throws SQLException {
		int rowCnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			StringBuilder updatePass = new StringBuilder();
			updatePass
			.append("	update	customer	")
			.append("	set		phone=?, email=?	")
			.append("	where	cus_id=?	")
			;
			
			pstmt = con.prepareStatement(updatePass.toString());
			
			//바인드 변수에 값 설정
			pstmt.setString(1, cVO.getPhone());
			pstmt.setString(2, cVO.getEmail());
			pstmt.setString(3, cVO.getCusId());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
		
		return rowCnt;
	}

	public int updatePass(CustomVO cVO) throws SQLException {
		int rowCnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			StringBuilder updatePass = new StringBuilder();
			updatePass
			.append("	update	customer	")
			.append("	set		cus_pass=?	")
			.append("	where	cus_id=?	")
			;
			
			pstmt = con.prepareStatement(updatePass.toString());
			
			//바인드 변수에 값 설정
			pstmt.setString(1, cVO.getNewPass());
			pstmt.setString(2, cVO.getCusId());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
		
		return rowCnt;
	}

	public int deleteAccount(CustomVO cVO) throws SQLException {
		int rowCnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		try {
			con = dbCon.getConn();
			
			StringBuilder deleteAccount = new StringBuilder();
			deleteAccount
			.append("	update 	customer	")
			.append("	set		cus_flag='Y'	")
			.append("	where	cus_id=? and cus_pass=?	")
			;
			
			pstmt = con.prepareStatement(deleteAccount.toString());
			
			//바인드 변수에 값 설정
			pstmt.setString(1, cVO.getCusId());
			pstmt.setString(2, cVO.getCusPass());
			
			//쿼리문 수행 후 결과 얻기
			rowCnt = pstmt.executeUpdate();
			
		} finally {
			dbCon.dbClose(null, pstmt, con);
		}
		
		return rowCnt;
	}//deleteAccount
	
	//비밀번호 비교
	public boolean compareToPass(String pass, String cusId) throws SQLException {
		boolean flag = false;
		
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
			pstmt= conn.prepareStatement("select * from customer where cus_pass=? and cus_id=?");
			
			//5. 바인드 변수에 값 설정
			pstmt.setString(1, pass);
			pstmt.setString(2, cusId);
			
			//6. 쿼리문 수행후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				flag = true;
			}
		}finally {
			//7. 연결 끊기
			dbCon.dbClose(rs, pstmt, conn);
		}
		return flag;
	}//compareToPass(String pass, String cusId)

}//c
