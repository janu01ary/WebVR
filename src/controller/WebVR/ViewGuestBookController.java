package controller.WebVR;

import controller.Controller;
import model.GBU;
import model.GuestBook;
import model.User;
import model.dao.ExhibitionDAO;
import model.dao.GuestBookDAO;
import model.dao.UserDAO;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ViewGuestBookController implements Controller {

	private GuestBookDAO gbDAO = new GuestBookDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		int exhbID = Integer.parseInt(request.getParameter("ExhbId"));// 파라미터로 전시 아이디 가져오기

		List<GBU> GBUList = gbDAO.GBUList(exhbID);//전시 아이디로 방명록 리스트
		
		request.setAttribute("GBUList", GBUList);		// GBList보내기

		return "/webVR/Guestbook.jsp";
	}

}
