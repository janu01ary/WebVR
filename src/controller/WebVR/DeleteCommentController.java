package controller.WebVR;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
import model.dao.CommentDAO;

public class DeleteCommentController implements Controller {
	
	private CommentDAO commentDAO = new CommentDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부
		if (!UserSessionUtils.hasLogined(request.getSession())) { // 로그인 안되어있는 있는 경우
			return "redirect:/WebVR/login/form";	
		}
		
		String artworkId = request.getParameter("artworkId");
		System.out.println("artworkId: " + artworkId);
		
		int commentId = Integer.parseInt(request.getParameter("commentId"));
//		int result = commentDAO.deleteComment(commentId);
		commentDAO.delete(commentId);
		
		return "redirect:/WebVR/artwork/comment?artworkId=" + artworkId;
	}

}
