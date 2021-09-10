package controller.WebVR;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.dao.CommentDAO;

public class DeleteCommentController implements Controller {
	
	private CommentDAO commentDAO = new CommentDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String artworkId = request.getParameter("artworkId");
		
		int commentId = Integer.parseInt(request.getParameter("commentId"));
//		int result = commentDAO.deleteComment(commentId);
		commentDAO.delete(commentId);
		
		return "redirect:/WebVR/exhb/artwork?artworkId=" + artworkId;
	}

}
