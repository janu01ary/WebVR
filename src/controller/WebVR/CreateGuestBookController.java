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
		// �α��� ���� 
				if (!UserSessionUtils.hasLogined(request.getSession())) { // �α��� �ȵǾ��ִ� �ִ� ���
					return "redirect:/WebVR/login/form";	
				} 
				
		HttpSession session = request.getSession(); 
		int exhbId = Integer.parseInt(request.getParameter("exhibitionId"));// �Ķ���ͷ� ���� ���̵� ��������
		// �α����� ����� ���̵� ��� ������..??
		int userID = Integer.parseInt(UserSessionUtils.getLoginUserId(session));// �Ķ���ͷ� ���� ���̵� ��������
		//Date date_now = new Date(System.currentTimeMillis());
		GuestBook gb = new GuestBook(0/* �ڵ����� �ο��Ǵ� ���̵� */, userID, exhbId, request.getParameter("content"),
				new Date());

		try {
			guestBookDAO.create(gb);
			List<GuestBookUser> GBUList = guestBookDAO.getGuestBookList(exhbId);
			request.setAttribute("exhibitionId", exhbId);
			request.setAttribute("GBUList", GBUList);	
			return "/WebVR/guestbook.jsp";
		} catch (Exception e) {
			request.setAttribute("exhibitionId", exhbId);
			return "/WebVR/guestbook.jsp";//���� �ʿ�
		}

	}

}