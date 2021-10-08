package controller.WebVR;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
import model.GuestBook;
import model.GuestBookUser;
import model.dao.ExhibitionDAO;
import model.dao.GuestBookDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CreateGuestBookController implements Controller {
	private GuestBookDAO guestBookDAO = new GuestBookDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 
				if (!UserSessionUtils.hasLogined(request.getSession())) { // 로그인 안되어있는 있는 경우
					return "redirect:/WebVR/login/form";	
				} 
				
		HttpSession session = request.getSession(); 
		int exhbId = Integer.parseInt(request.getParameter("exhibitionId"));// 파라미터로 전시 아이디 가져오기
		// 로그인한 사용자 아이디 어떻게 가져옴..??
		int userID = Integer.parseInt(UserSessionUtils.getLoginUserId(session));// 파라미터로 유저 아이디 가져오기
		//Date date_now = new Date(System.currentTimeMillis());
		GuestBook gb = new GuestBook(0/* 자동으로 부여되는 아이디 */, userID, exhbId, request.getParameter("content"),
				new Date());

		try {
			guestBookDAO.create(gb);
			List<GuestBookUser> GBUList = guestBookDAO.getGuestBookList(exhbId);
			request.setAttribute("exhibitionId", exhbId);
			request.setAttribute("GBUList", GBUList);	
			return "/WebVR/guestbook.jsp";
		} catch (Exception e) {
			request.setAttribute("exhibitionId", exhbId);
			return "/WebVR/guestbook.jsp";//수정 필요
		}

	}

}