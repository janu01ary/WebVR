package controller.WebVR;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
import model.Artwork;
import model.Likes;
import model.User;
import model.dao.ArtworkDAO;
import model.dao.LikesDAO;
import model.dao.UserDAO;

public class ViewArtworkController implements Controller {

	private ArtworkDAO artworkDAO = new ArtworkDAO();
	private LikesDAO likesDAO = new LikesDAO();
	private UserDAO userDAO = new UserDAO();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int artworkId = Integer.parseInt(request.getParameter("artworkId"));
		Artwork artwork = artworkDAO.findArtwork(artworkId);
		request.setAttribute("artwork", artwork);
		
		// 로그인이 되어있는지 확인
		HttpSession session = request.getSession();
		if (!UserSessionUtils.hasLogined(session)) { // 로그인 안되어있는 있는 경우
			request.setAttribute("login", "false");
			request.setAttribute("like", "false");
        } else { // 로그인 되어있는 경우
        	request.setAttribute("login", "true");
        	
        	int userId = Integer.parseInt(UserSessionUtils.getLoginUserId(session));
			User user = userDAO.findUser(userId);
			Likes like = likesDAO.findLikesByUserId(userId, artworkId); // DB에서 user가 artwork에 좋아요를 누른 기록 확인
			
			if (like == null) { // 좋아요를 누른 기록이 없다면
				request.setAttribute("like", "false");
			}
			else { // 좋아요를 누른 기록이 있다면
				request.setAttribute("like", "true");
			}
        }
		
		artworkDAO.updateView(artwork); // 조회수 증가
		
		return "/WebVR/artwork.jsp";
	}

}
