/*
 *  myPage 불러오기 (User 정보/해당 User의 Likes, Visit List)
 * 
 */

package controller.WebVR.user;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
import model.User;
import model.Visit;
import model.Likes;
import model.Artwork;
import model.Comment;
import model.Exhibition;
import model.GuestBook;
import model.dao.UserDAO;
import model.dao.VisitDAO;
import model.dao.LikesDAO;
import model.dao.CommentDAO;
import model.dao.ExhibitionDAO;
import model.dao.GuestBookDAO;

public class ViewMyPageController implements Controller {

	private UserDAO userDAO = new UserDAO();
	private LikesDAO likesDAO = new LikesDAO();
	private VisitDAO visitDAO = new VisitDAO();
	private CommentDAO commentDAO = new CommentDAO();
	private GuestBookDAO guestBookDAO = new GuestBookDAO();
	private ExhibitionDAO exhibitionDAO = new ExhibitionDAO();

	@SuppressWarnings("null")
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 확인
    	if (!UserSessionUtils.hasLogined(request.getSession())) {
            return "redirect:/WebVR/login/form";		// login form 요청으로 redirect
        }
    	
		HttpSession session = request.getSession();
		String userId = request.getParameter("userId");

		if (UserSessionUtils.getLoginUserId(session).equals(userId)) {
			request.setAttribute("isSameUser", true);
		} else {
			request.setAttribute("isSameUser", false);
		}

    	User user = userDAO.findUser(userId);	// 사용자 정보 검색	
  
    	// 해당 사용자의 좋아요 리스트랑 방문한 전시 리스트 가져오기
    	List<Likes> likesList = likesDAO.findLikesListByUserId(Integer.parseInt(userId));
    	List<Visit> visitList = visitDAO.findVisitListByUserId(Integer.parseInt(userId));
    	List<Comment> commentList = commentDAO.findCommentListByUserId(Integer.parseInt(userId));
    	List<GuestBook> guestBookList = guestBookDAO.myGBList(Integer.parseInt(userId));
    	List<Exhibition> exhibitionList = exhibitionDAO.findExhibitionListByUserId(Integer.parseInt(userId));
    	HashMap<Integer, List<Artwork>> artworkMap = new HashMap<>();
    	
    	// user가 주최한 exhibition들의 Artwork들 가져옴
    	for(int i = 0; i < exhibitionList.size(); i++){
    		List<Artwork> artworkList = exhibitionDAO.findArtworkListById(exhibitionList.get(i).getId());
    		artworkMap.put(i, artworkList);
    	}
    	
    	
    	request.setAttribute("user", user);		// 사용자 정보 저장
    	
    	request.setAttribute("likesList", likesList);
    	request.setAttribute("visitList", visitList);
    	request.setAttribute("commentList", commentList);
    	request.setAttribute("guestBookList", guestBookList);
    	request.setAttribute("exhibitionList", exhibitionList);
    	request.setAttribute("artworkMap", artworkMap);
    	
		return "/WebVR/myPage.jsp";
	}

}
