package controller.WebVR;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.Artwork;
import model.Likes;
import model.User;
import model.dao.ArtworkDAO;
import model.dao.LikesDAO;
import model.dao.UserDAO;
import controller.WebVR.user.UserSessionUtils;

public class LikeArtworkController implements Controller {
	
	private ArtworkDAO artworkDAO = new ArtworkDAO();
	private LikesDAO likesDAO = new LikesDAO();
	private UserDAO userDAO = new UserDAO();
	
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int artworkId = Integer.parseInt(request.getParameter("artworkId"));
		Artwork artwork = artworkDAO.findArtwork(artworkId);
		artworkDAO.updateView(artwork); // 조회수 증가
		
// 현재 주석 부분은 로그인 세션 구현 후 테스트해야하는 부분
// 따라서 좋아요가 반영되지 X
/*		
		// 로그인이 되어있는지 확인
		HttpSession session = request.getSession();
		if (!UserSessionUtils.hasLogined(session)) { // 로그인 안되어있는 있는 경우
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script language='javascript'>");
			out.println("alert('로그인을 해주세요')");
			out.println("</script>");
			out.flush();
        }
		
		int userId = Integer.parseInt(UserSessionUtils.getLoginUserId(session));
		User user = userDAO.findUser(userId);
		Likes like = likesDAO.findLikesByUserId(userId); // DB에서 user가 artwork에 좋아요를 누른 기록 확인
		
		if (like == null) { // 좋아요를 누른 기록이 없다면
			artworkDAO.increaseLike(artwork); // artwork 좋아요 증가
			likesDAO.create(user, artwork); // likes에 user가 해당 artwork를 좋아한다는 데이터 삽입
		}
		else { // 좋아요를 누른 기록이 있다면
			artworkDAO.decreaseLike(artwork); // artwork 좋아요 감소
			likesDAO.remove(like.getLikeId()); // likes에 user가 해당 artwork를 좋아한다는 데이터 삭제
		}
*/		
		return "redirect:/WebVR/exhb/List/artwork?artworkId=" + artworkId;
	}
}
