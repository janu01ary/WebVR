package controller.WebVR;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
import model.Comment;
import model.dao.CommentDAO;

public class CreateCommentController implements Controller {
	
	private CommentDAO commentDAO = new CommentDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부
		if (!UserSessionUtils.hasLogined(request.getSession())) { // 로그인 안되어있는 있는 경우
			return "redirect:/WebVR/login/form";	
		}

		String artworkId = request.getParameter("artworkId");
		
		HttpSession session = request.getSession();
		int userId = Integer.parseInt(UserSessionUtils.getLoginUserId(session));
		
		Comment comment = new Comment(
				0, 
				request.getParameter("content"), 
				new Date(), 
				userId, 
				Integer.parseInt(artworkId));
		System.out.println(commentDAO.create(comment));
		
		return "redirect:/WebVR/artwork/comment?artworkId=" + artworkId;
	}

}

