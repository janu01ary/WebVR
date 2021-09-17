package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Comment;
import model.User;

public class CommentDAO {
private JDBCUtil jdbcUtil = null;
	
	public CommentDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}

	// comment 생성
	public int create(Comment comment) throws SQLException {
		String sql = "insert into comment (content, date, user_id, artwork_id) values (?, ?, ?, ?)"; //null로 두면 알아서 증가하는지? 아니면 id 컬럼을 제외하고 넣어야 하는 건지?	
		Object[] param = new Object[] {
				comment.getContent(), 
				new java.sql.Date(comment.getDate().getTime()), 
				comment.getUserID(), 
				comment.getArtwId()};				
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
	
	// comment 삭제
	public int delete(int commentId) throws SQLException {
		String sql = "delete from comment where id=?";		
		jdbcUtil.setSqlAndParameters(sql, new Object[] {commentId});	// JDBCUtil에 delete문과 매개 변수 설정

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
	
	// artwork id를 통해 해당 작품에 속한 최근 30개의 comment의 list 조회
	public List<Comment> findCommentListByArtworkId(int artworkId) {
		String sql = "select id, content, date, user_id " 
      		   + "from comment "
      		   + "where artwork_id=? "
      		   + "order by id desc " // 시간 순서대로 id가 만들어지니까 그냥 id로 내림차순 정렬
      		   + "limit 30"; // 최근 30개
		jdbcUtil.setSqlAndParameters(sql, new Object[] {artworkId});	
					
		try {
			ResultSet rs = jdbcUtil.executeQuery();		
			List<Comment> commentList = new ArrayList<Comment>();	
			while (rs.next()) {
				Comment comment = new Comment(
					rs.getInt("id"),
					rs.getString("content"),
					new java.util.Date(rs.getDate("date").getTime()),
					rs.getInt("user_id"),
					artworkId);
				commentList.add(comment);	
			}		
			return commentList;					
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();
		}
		return null;
	}
	
	// 사용자 id에 해당하는 comment List 가져옴
		public List<Comment> findCommentListByUserId(int userId) throws SQLException {//특정 사용자 방명록 리스트 반환
	        String sql = "SELECT c.id, user_id, artwork_id, a.title, content, c.date " 
	        		   + "FROM comment c "
	        		   + "INNER JOIN artwork a "
	        		   + "ON a.id = c.artwork_id "
	        		   + "WHERE user_id=? "
	        		   + "ORDER BY c.id DESC ";
	        
			jdbcUtil.setSqlAndParameters(sql, new Object[] {userId});		// JDBCUtil에 query문 설정
						
			try {
				ResultSet rs = jdbcUtil.executeQuery();		
				List<Comment> commentList = new ArrayList<Comment>();	// User들의 리스트 생성
				while (rs.next()) {
					Comment comment = new Comment(			// User 객체를 생성하여 현재 행의 정보를 저장
						rs.getInt("c.id"),
						rs.getString("content"),
						new java.util.Date(rs.getDate("c.date").getTime()),
						userId,
						rs.getInt("artwork_id"),
						rs.getString("a.title"));
					commentList.add(comment);				// List에 User 객체 저장
				}		
				return commentList;					
				
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				jdbcUtil.close();		// resource 반환
			}
			return null;
		}

}
