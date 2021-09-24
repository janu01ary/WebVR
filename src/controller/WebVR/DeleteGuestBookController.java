package controller.WebVR;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
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
			// 로그인 여부 확인
	    	if (!UserSessionUtils.hasLogined(request.getSession())) {
	            return "redirect:/WebVR/login/form";		// login form 요청으로 redirect
	        }
			HttpSession session = request.getSession();
		
			int gbID = Integer.parseInt(request.getParameter("gbID"));// 파라미터로 게스트북 아이디
			
		
			guestBookDAO.remove(gbID);//삭제 
		
		
		return "/WebVR/myPage.jsp";//마이페이지에서 해야할듯
	}

}