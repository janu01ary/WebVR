package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Artwork;
import model.Visit;
import model.User;

public class VisitDAO {
	private JDBCUtil jdbcUtil = null;
	
	public VisitDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}
	
	// Visit 생성
	public int create(User user, Artwork artwork) throws SQLException {
		String sql = "INSERT INTO visit VALUES (?, ?)";		
		Object[] param = new Object[] { user.getUserID(), 
						artwork.getArtworkId() };	
		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil 에 insert문과 매개 변수 설정
						
		String key[] = { "id" };
		try {
			jdbcUtil.executeUpdate(key); // insert 문 실행
			ResultSet rs = jdbcUtil.getGeneratedKeys();

			if (rs.next()) {
				int generatedKey = rs.getInt(1);
				return generatedKey;
			}
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); // resource 반환
		}

		return 0;			
	}
		
	// Visit 삭제
	public int remove(int id) throws SQLException {
		String sql = "DELETE FROM visit WHERE id=?";		
		jdbcUtil.setSqlAndParameters(sql, new Object[] {id});	// JDBCUtil에 delete문과 매개 변수 설정

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
	
	// 주어진 userId에 해당하는 visit List를 데이터베이스에서 찾아 도메인 클래스에 저장하여 반환
	public List<Visit> findVisitListByUserId(int userId) throws SQLException {
		String sql = "SELECT v.id, v.user_id, exhibition_id, e.title, e.description, e.image_address "
    			+ "FROM visit v "
				+ "INNER JOIN exhibition e "
    			+ "ON v.exhibition_id = e.id "
    			+ "WHERE v.user_id=? ";  
		
		jdbcUtil.setSqlAndParameters(sql, new Object[] {userId});	// JDBCUtil에 query문과 매개 변수 설정
		try {
			ResultSet rs = jdbcUtil.executeQuery();			// query 실행			
			List<Visit> visitList = new ArrayList<Visit>();	
			while (rs.next()) {				
				Visit visit = new Visit(		// like 객체를 생성하여 커뮤니티 정보를 저장
						rs.getInt("v.id"),
						rs.getInt("v.user_id"),
						rs.getInt("exhibition_id"),
						rs.getString("e.title"),
						rs.getString("e.description"),
						rs.getString("e.image_address")
						);
				visitList.add(visit);
			}		
			return visitList;					
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}
	
	// 주어진 exhibitionId에 해당하는 visit List를 데이터베이스에서 찾아 도메인 클래스에 저장하여 반환
	public List<Visit> findVisitListByArtworkId(int artworkId) throws SQLException {
		String sql = "SELECT id, user_id, exhibition_id "
    			+ "FROM visit "
    			+ "WHERE exhibition_id=? ";  
		
		jdbcUtil.setSqlAndParameters(sql, new Object[] {artworkId});	// JDBCUtil에 query문과 매개 변수 설정
		try {
			ResultSet rs = jdbcUtil.executeQuery();			// query 실행			
			List<Visit> visitList = new ArrayList<Visit>();	
			while (rs.next()) {				
				Visit visit = new Visit(		// like 객체를 생성하여 커뮤니티 정보를 저장
						rs.getInt("id"),
						rs.getInt("user_id"),
						rs.getInt("exhibition_id"));
				visitList.add(visit);
			}		
			return visitList;					
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}

}
