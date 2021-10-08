package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Artwork;
import model.Likes;
import model.User;

public class LikesDAO {
	private JDBCUtil jdbcUtil = null;
	
	public LikesDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}
	
	// Likes 생성
	public int create(User user, Artwork artwork) throws SQLException {
		String sql = "INSERT INTO likes(user_id, artwork_id) VALUES (?, ?)";	
		Object[] param = new Object[] { user.getUserID(), 
						artwork.getArtworkId() };
		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil 에 insert문과 매개 변수 설정
						
		try {
			int result = jdbcUtil.executeUpdate();	// insert 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); // resource 반환
		}

		return 0;			
	}
		
	// Likes 삭제
	public int remove(int id) throws SQLException {
		String sql = "DELETE FROM likes WHERE id=?";		
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
	
	// 주어진 userId, artworkId에 해당하는 artwork를 데이터베이스에서 찾아 도메인 클래스에 저장하여 반환
	public Likes findLikesByUserId(int userId, int artworkId) throws SQLException {
		String sql = "SELECT id, user_id, artwork_id "
    			+ "FROM likes "
    			+ "WHERE user_id=? and artwork_id=? ";         
		jdbcUtil.setSqlAndParameters(sql, new Object[] {userId, artworkId});	// JDBCUtil에 query문과 매개 변수 설정
		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			Likes like = null;
			if (rs.next()) {						//  정보 발견
				like = new Likes(		// like 객체를 생성하여 커뮤니티 정보를 저장
						rs.getInt("id"),
						rs.getInt("user_id"),
						rs.getInt("artwork_id"));
			}
			return like;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null; 
		
	}
	
	// 주어진 userId에 해당하는 likes List를 데이터베이스에서 찾아 도메인 클래스에 저장하여 반환
		public List<Likes> findLikesListByUserId(int userId) throws SQLException {
			String sql = "SELECT l.id, l.user_id, l.artwork_id, a.artwork_address, a.exhibition_id "
	    			+ "FROM likes l "
					+ "INNER JOIN artwork a "
	    			+ "ON l.artwork_id = a.id "
	    			+ "WHERE user_id=? ";  
			
			jdbcUtil.setSqlAndParameters(sql, new Object[] {userId});	// JDBCUtil에 query문과 매개 변수 설정
			try {
				ResultSet rs = jdbcUtil.executeQuery();			// query 실행			
				List<Likes> likesList = new ArrayList<Likes>();	
				while (rs.next()) {				
					Likes like = new Likes(		// like 객체를 생성하여 커뮤니티 정보를 저장
							rs.getInt("l.id"),
							rs.getInt("l.user_id"),
							rs.getInt("l.artwork_id"),
							rs.getString("a.artwork_address"),
							rs.getInt("a.exhibition_id")
							);
					likesList.add(like);
				}		
				return likesList;					
				
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				jdbcUtil.close();		// resource 반환
			}
			return null;
		}
	
	// 주어진 artworkId에 해당하는 likes List를 데이터베이스에서 찾아 도메인 클래스에 저장하여 반환
	public List<Likes> findLikesListByArtworkId(int artworkId) throws SQLException {
		String sql = "SELECT id, user_id, artwork_id "
    			+ "FROM likes "
    			+ "WHERE artwork_id=? ";  
		
		jdbcUtil.setSqlAndParameters(sql, new Object[] {artworkId});	// JDBCUtil에 query문과 매개 변수 설정
		try {
			ResultSet rs = jdbcUtil.executeQuery();			// query 실행			
			List<Likes> likesList = new ArrayList<Likes>();	
			while (rs.next()) {				
				Likes like = new Likes(		// like 객체를 생성하여 커뮤니티 정보를 저장
						rs.getInt("id"),
						rs.getInt("user_id"),
						rs.getInt("artwork_id"));
				likesList.add(like);
			}		
			return likesList;					
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}
}
