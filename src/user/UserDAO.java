package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;





public class UserDAO {

	DataSource dataSource;
	public UserDAO() {
		try {
			Context initCtx = new InitialContext();
			Context envContext = (Context) initCtx.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/myoracle");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public int login(String userID, String userPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USERCHAR WHERE USERID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("userpassword").equals(userPassword)) {
					return 1;//로그인 성공
				}
				return 2;// 비밀번호가 틀림
			}else {
				return 0; //해당 사용자가 존재하지 않음
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return  -1;
	}
	
	 public int registerCheck(String userID) {

		    String sql = "SELECT * FROM USERCHAR WHERE USERID=?";		       
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    
		    try {
		      conn = dataSource.getConnection();
		      pstmt = conn.prepareStatement(sql);
		      pstmt.setString(1, userID);
		      rs = pstmt.executeQuery();
		      if(rs.next() || userID.equals("")) {
		    	  return 0; //이미 존재하는 회원
		      }else {
		    	  return 1; //가입 가능한 회원 아이디
		      }
		    } catch (Exception e) {
		      e.printStackTrace();
		    } finally {
		    	try {
					if(rs != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
		    }
		    return -1; // 데이터베이스 오류
		  }
	 
	 public int register(String userID, String userPassword, String userName,String userAge, String userGender, String userEmail, String userProfile) {
		    String sql = "insert into userchar values(?, ?, ?, ?, ?, ?, ?)";		       
		    Connection conn = null;
		    PreparedStatement pstmt = null;

		    try {
			  conn = dataSource.getConnection();
		      pstmt = conn.prepareStatement(sql);
		      pstmt.setString(1, userID);
		      pstmt.setString(2, userPassword);
		      pstmt.setString(3, userName);
		      pstmt.setInt(4, Integer.parseInt(userAge));
		      pstmt.setString(5, userGender);
		      pstmt.setString(6, userEmail);
		      pstmt.setString(7, userProfile);
		      return pstmt.executeUpdate();
		      
		    } catch (Exception e) {
		      e.printStackTrace();
		    } finally {
		    	try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
		    }
		    return -1; // 데이터베이스 오류
		  }
	 public UserDTO getUser(String userID) {
		 	UserDTO user = new UserDTO();
		 	Connection conn = null;
		 	PreparedStatement pstmt = null;
		 	ResultSet rs = null;
		    String SQL = "SELECT * FROM USERCHAR WHERE userID = ? ";		       

		    try {
			  conn = dataSource.getConnection();
		      pstmt = conn.prepareStatement(SQL);
		      pstmt.setString(1, userID);
		      rs= pstmt.executeQuery();
		      if(rs.next()) {
		    	  user.setUserid(userID);
		    	  user.setUserpassword(rs.getString("userPassword"));
		    	  user.setUsername(rs.getString("userName"));
		    	  user.setUserage(rs.getInt("userAge"));
		    	  user.setUsergender(rs.getString("userGender"));
		    	  user.setUseremail(rs.getString("userEmail"));
		    	  user.setUserprofile(rs.getString("userprofile"));
		      }
		    } catch (Exception e) {
		      e.printStackTrace();
		    } finally {
		    	try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
		    }
		    return user; // 데이터베이스 오류
		  }
	 public int update(String userID, String userPassword, String userName,String userAge, String userGender, String userEmail) {
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    String sql = "UPDATE USERCHAR SET userPassword=?, userName=?, userAge=?, userGender=?, userEmail=? WHERE userID=?";		       

		    try {
			  conn = dataSource.getConnection();
		      pstmt = conn.prepareStatement(sql);
		      pstmt.setString(1, userPassword);
		      pstmt.setString(2, userName);
		      pstmt.setInt(3, Integer.parseInt(userAge));
		      pstmt.setString(4, userGender);
		      pstmt.setString(5, userEmail);
		      pstmt.setString(6, userID);
		      return pstmt.executeUpdate();
		      
		    } catch (Exception e) {
		      e.printStackTrace();
		    } finally {
		    	try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
		    }
		    return -1; // 데이터베이스 오류
		  }
}
