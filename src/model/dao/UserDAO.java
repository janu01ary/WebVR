// 사용자 정보 DB 관리
// USER 테이블에 사용자 정보를 추가, 수정, 삭제, 검색 수행 

package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserDAO {
	private JDBCUtil jdbcUtil = null;
	
	public UserDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}

	// USER 테이블에 새로운 User 생성
	public int create(User user) throws SQLException {
		String sql = "INSERT INTO user (email, password, nickname) VALUES (?, ?, ?)";		
		Object[] param = new Object[] {user.getEmail(), user.getPassword(), user.getNickname()};				
		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil 에 insert문과 매개 변수 설정
						
		try {				
			int result = jdbcUtil.executeUpdate();	// insert 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {		
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
		return 0;			
	}

	// USER 테이블의 사용자 정보 수정
	public int update(User user) throws SQLException {
		String sql = "UPDATE user "
					+ "SET email=?, password=?, nickname=? "
					+ "WHERE id=?";
		Object[] param = new Object[] {user.getEmail(), user.getPassword(), user.getNickname(), user.getUserID()};				
		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil에 update문과 매개 변수 설정
			
		try {				
			int result = jdbcUtil.executeUpdate();	// update 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		}
		finally {
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
		return 0;
	}

	//해당 ID를 가진 사용자를 USER 테이블에서 삭제
	public int remove(String userID) throws SQLException {
		String sql = "DELETE FROM user WHERE id=?";		
		jdbcUtil.setSqlAndParameters(sql, new Object[] {userID});	// JDBCUtil에 delete문과 매개 변수 설정

		try {				
			int result = jdbcUtil.executeUpdate();	// delete 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		}
		finally {
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
		return 0;
	}

	// 해당 ID의 사용자 정보를 DB에서 찾아 User 도메인 클래스에 저장 후 반환
	public User findUser(String userID) throws SQLException {
        String sql = "SELECT email, password, nickname "
        			+ "FROM user "
        			+ "WHERE id=? ";              
		jdbcUtil.setSqlAndParameters(sql, new Object[] {userID});	// JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			if (rs.next()) {						// 학생 정보 발견
				User user = new User(		// User 객체를 생성하여 학생 정보를 저장
					Integer.parseInt(userID),
					rs.getString("email"),
					rs.getString("password"),
					rs.getString("nickname"));
				return user;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}
	
	// 해당 ID의 사용자가 존재하는지 검사
	public boolean existingUser(String userID) throws SQLException {
		String sql = "SELECT count(*) FROM user WHERE id=?";      
		jdbcUtil.setSqlAndParameters(sql, new Object[] {userID});	// JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			if (rs.next()) {
				int count = rs.getInt(1);
				return (count == 1 ? true : false);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return false;
	}
	
	// 해당 ID의 사용자 정보를 DB에서 찾아 User 도메인 클래스에 저장 후 반환
	public User findUserByEmail(String email) throws SQLException {
		String sql = "select id, email, password, nickname "
			+ "from user "
			+ "where email=?";              
		jdbcUtil.setSqlAndParameters(sql, new Object[] {email});	// JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			if (rs.next()) {						// 학생 정보 발견
				User user = new User(		// User 객체를 생성하여 학생 정보를 저장
					rs.getInt("id"),
					email,
					rs.getString("password"),
					rs.getString("nickname"));
					System.out.println(user);
				return user;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}
	
	// 해당 ID의 사용자 정보를 DB에서 찾아 User 도메인 클래스에 저장 후 반환
	public User findUser(int userID) throws SQLException {
        String sql = "SELECT email, password, nickname "
        			+ "FROM user "
        			+ "WHERE id=?";              
		jdbcUtil.setSqlAndParameters(sql, new Object[] {userID});	// JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			if (rs.next()) {						// 학생 정보 발견
				User user = new User(		// User 객체를 생성하여 학생 정보를 저장
					userID,
					rs.getString("email"),
					rs.getString("password"),
					rs.getString("nickname"));
				return user;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}		

}
