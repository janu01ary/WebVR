package model.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Exhibition;

public class ExhibitionDAO {
	private JDBCUtil jdbcUtil = null;
	
	public ExhibitionDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}

	public int create() throws SQLException {
//		String sql = "INSERT INTO USER VALUES (?, ?, ?, ?)";		
//		Object[] param = new Object[] {5, "wlwdnd1118@gmail.com", "1234", "456789456789"};				
		String sql = "select * from test1;";
		Object[] param = new Object[] {};
		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil 에 insert문과 매개 변수 설정
		try {				
//			int result = jdbcUtil.executeUpdate();	// insert 문 실행
			ResultSet rs = jdbcUtil.executeQuery();
			while (rs.next()) {
				System.out.println("print rs : " + rs.getInt("test_c"));
			}
			return 1;
//			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {		
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
//
//		Date start_date = new Date(2021, 8, 15);
//		Date end_date = new Date(2021, 8, 16);
//		sql = "INSERT INTO EXHIBITION VALUES (?, ?, ?, ?, ?, ?)";		
//		param = new Object[] {5, 5, "title", "ㅎㅇ", start_date, end_date, "desc"};				
//		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil 에 insert문과 매개 변수 설정
//		try {				
//			int result = jdbcUtil.executeUpdate();	// insert 문 실행
//			return result;
//		} catch (Exception ex) {
//			jdbcUtil.rollback();
//			ex.printStackTrace();
//		} finally {		
//			jdbcUtil.commit();
//			jdbcUtil.close();	// resource 반환
//		}		
		return 0;			
	}

}
