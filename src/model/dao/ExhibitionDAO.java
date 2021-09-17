package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import model.Artwork;
import model.Exhibition;

public class ExhibitionDAO {
	private JDBCUtil jdbcUtil = null;
	
	public ExhibitionDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}

	//exhibition 생성
	public int create(Exhibition exhibition) throws SQLException {
		String sql = "insert into exhibition (user_id, title, start_date, end_date, description, image_ddress) values (?, ?, ?, ?, ?, ?)"; 	
		Object[] param = new Object[] {
				exhibition.getUserId(), 
				exhibition.getTitle(), 
				new java.sql.Date(exhibition.getStart_date().getTime()), 
				new java.sql.Date(exhibition.getEnd_date().getTime()), 
				exhibition.getDescription(),
				exhibition.getImageAddress()};				
		jdbcUtil.setSqlAndParameters(sql, param);
		try {				
			int result = jdbcUtil.executeUpdate();
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {		
			jdbcUtil.commit();
			jdbcUtil.close();
		}		
		return 0;			
	}
	
	//exhibition id를 통해 exhibition 조회
	public Exhibition findExhibitionById(int exhibitionId) throws SQLException {
        String sql = "select user_id, title, description, image_address, start_date, end_date "
        			+ "from exhibition "
        			+ "where id=?";              
		jdbcUtil.setSqlAndParameters(sql, new Object[] {exhibitionId});

		try {
			ResultSet rs = jdbcUtil.executeQuery();	
			if (rs.next()) {				
				Exhibition exhibition = new Exhibition(		
					exhibitionId,
					rs.getInt("user_id"),
					rs.getString("title"),
					rs.getString("description"),
					rs.getString("image_address"),
					new java.util.Date(rs.getDate("start_date").getTime()),
					new java.util.Date(rs.getDate("end_date").getTime()));
				return exhibition;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();
		}
		return null;
	}
	
	//exhibition id를 통해 전시에 속한 artwork list 조회
	public List<Artwork> findArtworkListById(int exhibitionId) {
		String sql = "select id, title, description, artist_name, date, views_count, likes_count " 
      		   + "from artwork "
      		   + "where exhibition_id=? "
      		   + "order by id"; //시간 순서대로 id가 만들어지니까 그냥 id로 정렬
		jdbcUtil.setSqlAndParameters(sql, new Object[] {exhibitionId});	
					
		try {
			ResultSet rs = jdbcUtil.executeQuery();	
			List<Artwork> artworkList = new ArrayList<Artwork>();	
			while (rs.next()) {
				Artwork artwork = new Artwork(
					rs.getInt("id"),
					exhibitionId,
					rs.getString("title"), 
					rs.getString("artworkAddress"), 
					rs.getString("description"),
					rs.getString("artistName"),
					new java.util.Date(rs.getDate("date").getTime()),
					rs.getInt("views_count"),
					rs.getInt("likes_count"));
				artworkList.add(artwork); 
			}		
			return artworkList;					
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();	
		}
		return null;
	}
	
	// user id를 통해 해당 유저가 주최한 exhibition list 조회
	public List<Exhibition> findExhibitionListByUserId(int userId) {
		String sql = "select id, user_id, title, start_date, end_date, description " 
			+ "from exhibition "
			+ "where user_id=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] {userId});	

		try {
			ResultSet rs = jdbcUtil.executeQuery();	
			List<Exhibition> exhibitionList = new ArrayList<Exhibition>();	
			while (rs.next()) {
				Exhibition exhibition = new Exhibition(
					rs.getInt("id"),
					rs.getInt("user_id"),
					rs.getString("title"),
					rs.getString("description"),
					new java.util.Date(rs.getDate("start_date").getTime()),
					new java.util.Date(rs.getDate("end_date").getTime()));
				exhibitionList.add(exhibition);
			}		
			return exhibitionList;					

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();	
		}
		return null;
	}
	
	//현재 진행 중인 exhibition list 조회
	public List<Exhibition> findExhibitionList() {

		String sql = "select id, user_id, title, description, image_address, start_date, end_date " 
      		   + "from exhibition "
      		   + "where date(now()) >= date(start_date) AND date(now()) <= date(end_date) "
      		   + "order by id"; //시간 순서대로 id가 만들어지니까 그냥 id로 정렬
		jdbcUtil.setSqlAndParameters(sql, null);
					
		try {
			ResultSet rs = jdbcUtil.executeQuery();			
			List<Exhibition> exhibitionList = new ArrayList<Exhibition>();	
			while (rs.next()) {
				Exhibition exhibition = new Exhibition(	
					rs.getInt("id"),
					rs.getInt("user_id"),
					rs.getString("title"),
					rs.getString("description"),
					rs.getString("image_address"),
					new java.util.Date(rs.getDate("start_date").getTime()),
					new java.util.Date(rs.getDate("end_date").getTime()));
				exhibitionList.add(exhibition);	
			}		
			return exhibitionList;					
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();
		}
		return null;
	}
}