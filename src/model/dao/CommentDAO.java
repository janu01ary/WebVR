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

}
