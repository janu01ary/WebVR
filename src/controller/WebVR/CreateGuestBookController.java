package controller.WebVR;

import controller.Controller;
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
		HttpSession session = request.getSession();
		int exhbId = Integer.parseInt(request.getParameter("ExhbId"));// 파라미터로 전시 아이디 가져오기
		// 로그인한 사용자 아이디 어떻게 가져옴..??
		int userID = Integer.parseInt(request.getParameter("UserId"));// 파라미터로 유저 아이디 가져오기
		Date date_now = new Date(System.currentTimeMillis());
		GuestBook gb = new GuestBook(0/* 자동으로 부여되는 아이디 */, userID, exhbId, request.getParameter("content"),
				date_now);

		try {
			guestBookDAO.create(gb);
			List<GuestBookUser> GBUList = guestBookDAO.getGuestBookList(exhbId);
			request.setAttribute("GBUList", GBUList);	
			return "/webVR/Guestbook.jsp";
		} catch (Exception e) {
			return "/webVR/Guestbook.jsp";//수정 필요
		}

	}

}