package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Artwork;
import model.Exhibition;

public class ArtworkDAO {
	private JDBCUtil jdbcUtil = null;
	
	public ArtworkDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}
	
	// Artwork 생성
	public int create(Artwork artwork, Exhibition exhibition) throws SQLException {
		String sql = "INSERT INTO artwork VALUES (?, ?, ?, ?, ?, ?, 0, 0)";		
		Object[] param = new Object[] { exhibition.getId(), 
						artwork.getTitle(),
						artwork.getArtworkAddress(),
						artwork.getDescription(),
						artwork.getArtistName(),
						artwork.getDate() };	
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
	
	// Artwork 수정
	public int update(Artwork artwork) throws SQLException {
		String sql = "UPDATE artwork "
					+ "SET title=?, artwork_address=?, description=?, artist_name=? date=? "
					+ "WHERE id=? ";
		Object[] param = new Object[] { artwork.getTitle(),
				artwork.getArtworkAddress(),
				artwork.getDescription(),
				artwork.getArtistName(),
				artwork.getDate() };				
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
	
	// Artwork 삭제
	public int remove(int id) throws SQLException {
		String sql = "DELETE FROM artwork WHERE id=?";		
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

	// 주어진 id에 해당하는 artwork를 데이터베이스에서 찾아 도메인 클래스에 저장하여 반환
	public Artwork findArtwork(int id) throws SQLException {
		String sql = "SELECT artworkId, exhibitionId, title, artworkAddress, description, artistName, date, viewCount, likesCount "
    			+ "FROM artwork "
    			+ "WHERE artworkId=? ";         
		jdbcUtil.setSqlAndParameters(sql, new Object[] {id});	// JDBCUtil에 query문과 매개 변수 설정
		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			Artwork artwork = null;
			if (rs.next()) {						//  정보 발견
				artwork = new Artwork(		// Artwork 객체를 생성하여 커뮤니티 정보를 저장
						rs.getInt("artworkId"),
						rs.getInt("exhibitionId"),
						rs.getString("title"),
						rs.getInt("artworkAddress"),
						rs.getString("description"),
						rs.getString("artistName"),
						rs.getDate("date"),
						rs.getInt("viewCount"),
						rs.getInt("likesCount"));
			}
			return artwork;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
		
	}
	
	// 전체 Artwork를 List에 저장 및 반환
	public List<Artwork> findArtworkList() throws SQLException {
		String sql = "SELECT artworkId, exhibitionId, title, artworkAddress, description, artistName, date, viewCount, likesCount "
				+ "FROM artwork "
				+ "ORDER BY artworkId DESC "; 
		
		jdbcUtil.setSqlAndParameters(sql, null);		// JDBCUtil에 query문 설정
					
		try {
			ResultSet rs = jdbcUtil.executeQuery();			// query 실행			
			List<Artwork> artworkList = new ArrayList<Artwork>();	
			while (rs.next()) {
				Artwork artwork = new Artwork(		
						rs.getInt("artworkId"),
						rs.getInt("exhibitionId"),
						rs.getString("title"),
						rs.getInt("artworkAddress"),
						rs.getString("description"),
						rs.getString("artistName"),
						rs.getDate("date"),
						rs.getInt("viewCount"),
						rs.getInt("likesCount"));
				artworkList.add(artwork);
			}		
			return artworkList;					
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}
	
	// Artwork의 view(조회수) 증가
	public int updateView(Artwork artwork) throws SQLException {
		String sql = "UPDATE artwork "
					+ "SET views_count=? "
					+ "WHERE id=? ";
		Object[] param = new Object[] {artwork.getViewCount() + 1, artwork.getArtworkId()};				
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
	
	// Artwork의 like(좋아요 수) 증가
	public int increaseLike(Artwork artwork) throws SQLException {
		String sql = "UPDATE artwork "
					+ "SET likes_count=? "
					+ "WHERE id=? ";
		Object[] param = new Object[] {artwork.getLikesCount() + 1, artwork.getArtworkId()};				
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
	
	// Artwork의 like(좋아요 수) 감소
	public int decreaseLike(Artwork artwork) throws SQLException {
		String sql = "UPDATE artwork "
					+ "SET likes_count=? "
					+ "WHERE id=? ";
		Object[] param = new Object[] {artwork.getLikesCount() - 1, artwork.getArtworkId()};				
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
}