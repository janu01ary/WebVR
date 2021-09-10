package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Comment;

public class CommentDAO {
private JDBCUtil jdbcUtil = null;
	
	public CommentDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}

	//comment 생성
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
	
	//artwork id를 통해 해당 작품에 속한 comment의 list 조회
	public List<Comment> findCommentListByArtworkId(int artworkId) {
		String sql = "select id, content, date, user_id " 
      		   + "from comment "
      		   + "where artwork_id=? "
      		   + "order by id"; //시간 순서대로 id가 만들어지니까 그냥 id로 정렬
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

}
