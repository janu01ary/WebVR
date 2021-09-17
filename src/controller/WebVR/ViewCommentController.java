package controller.WebVR;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.Artwork;
import model.Comment;
import model.User;
import model.dao.CommentDAO;
import model.dao.ArtworkDAO;
import model.dao.UserDAO;

public class ViewCommentController implements Controller {

	private CommentDAO commentDAO = new CommentDAO();
	private ArtworkDAO artworkDAO = new ArtworkDAO();
	private UserDAO userDAO = new UserDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int artworkId = Integer.parseInt(request.getParameter("artworkId"));
		Artwork artwork = artworkDAO.findArtwork(artworkId);
		
		List<Comment> commentList = commentDAO.findCommentListByArtworkId(artworkId);
		
		List<User> userList = new ArrayList<User>();
		if (commentList != null) {
			for (int i = 0; i < commentList.size(); i++) {
				userList.add(userDAO.findUser(commentList.get(i).getUserID()));
			}
		}

		request.setAttribute("userID", 5);
		request.setAttribute("artwork", artwork);
		request.setAttribute("commentList", commentList);
		request.setAttribute("userList", userList);
		
		return "/WebVR/comment.jsp";
	}

}
