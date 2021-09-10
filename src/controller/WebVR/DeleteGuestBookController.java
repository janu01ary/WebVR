package controller.WebVR;

import controller.Controller;
import model.dao.GuestBookDAO;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class DeleteGuestBookController implements Controller {
	
	private GuestBookDAO guestBookDAO = new GuestBookDAO();
	
		@Override
		public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			HttpSession session = request.getSession();
		
			int gbID = Integer.parseInt(request.getParameter("gbID"));// 파라미터로 게스트북 아이디
			
		
			guestBookDAO.remove(gbID);//삭제 
		
		
		return "/webVR/Guestbook.jsp";//마이페이지에서 해야할듯
	}

}