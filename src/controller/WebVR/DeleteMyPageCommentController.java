package controller.WebVR;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
import model.dao.CommentDAO;

public class DeleteMyPageCommentController implements Controller {
	
	private CommentDAO commentDAO = new CommentDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부
		if (!UserSessionUtils.hasLogined(request.getSession())) { // 로그인 안되어있는 있는 경우
			return "redirect:/WebVR/login/form";	
		}
		
		HttpSession session = request.getSession();
		String userId = UserSessionUtils.getLoginUserId(session);
		
		int commentId = Integer.parseInt(request.getParameter("commentId"));
		commentDAO.delete(commentId);
		
		return "redirect:/WebVR/myPage?userId=" + userId;
	}

}
