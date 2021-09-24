package controller.WebVR;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
import model.dao.ArtworkDAO;
import model.dao.LikesDAO;
import model.dao.CommentDAO;
import model.Likes;
import model.Comment;
import model.Artwork;

public class DeleteMyPageArtworkController implements Controller {
	
	private ArtworkDAO artworkDAO = new ArtworkDAO();
	private LikesDAO likesDAO = new LikesDAO();
	private CommentDAO commentDAO = new CommentDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부
		if (!UserSessionUtils.hasLogined(request.getSession())) { // 로그인 안되어있는 있는 경우
			return "redirect:/WebVR/login/form";	
		}
		
		HttpSession session = request.getSession();
		String userId = UserSessionUtils.getLoginUserId(session);
		
		int artworkId = Integer.parseInt(request.getParameter("artworkId"));
		
		// join된 테이블의 값부터 삭제
		List<Likes> likesList = likesDAO.findLikesListByArtworkId(artworkId);
		Iterator<Likes> likesIter = likesList.iterator();
		for(int i = 0; likesIter.hasNext(); i++) {
			Likes likes = (Likes)likesIter.next();
			likesDAO.remove(likes.getLikeId());
		}
		
		List<Comment> commentList = commentDAO.findCommentListByArtworkId(artworkId);
		Iterator<Comment> commentIter = commentList.iterator();
		for(int i = 0; commentIter.hasNext(); i++) {
			Comment comment = (Comment)commentIter.next();
			commentDAO.delete(comment.getCmtID());
		}
		
		artworkDAO.remove(artworkId);
		
		return "redirect:/WebVR/myPage?userId=" + userId;
	}

}
