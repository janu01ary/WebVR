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
import model.dao.UserDAO;

public class ViewCommentController implements Controller {

	private CommentDAO commentDAO = new CommentDAO();
	private UserDAO userDAO = new UserDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int artworkId = Integer.parseInt(request.getParameter("artworkId"));
		List<Comment> commentList = commentDAO.findCommentListByArtworkId(artworkId);
		
		List<User> userList = null;
		for (int i = 0; i < commentList.size(); i++) {
			userList.add(userDAO.findUser(commentList.get(i).getUserID()));
		}

		request.setAttribute("commentList", commentList);
		request.setAttribute("userList", userList);
		
		return "/WebVR/artworkComment.jsp";
	}

}
