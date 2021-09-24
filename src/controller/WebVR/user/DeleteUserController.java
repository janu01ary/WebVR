/*
 *  해당 회원 정보 DB에서 삭제
 * 
 */

package controller.WebVR.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
import model.User;
import model.dao.UserDAO;

public class DeleteUserController implements Controller {

	private UserDAO userDAO = new UserDAO();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그인 여부 확인
    	if (!UserSessionUtils.hasLogined(request.getSession())) {
            return "redirect:/WebVR/login/form";		// login form 요청으로 redirect
        }
    	
		HttpSession session = request.getSession();	
		int adminId = 1;
		int userId = Integer.parseInt(UserSessionUtils.getLoginUserId(session));
	
		if ((UserSessionUtils.isLoginUser(adminId, session) && 	// 로그인한 사용자가 관리자이고 	
			 userId != adminId)							// 삭제 대상이 일반 사용자인 경우, 
			   || 												// 또는 
			(!UserSessionUtils.isLoginUser(adminId, session) &&  // 로그인한 사용자가 관리자가 아니고 
			UserSessionUtils.isLoginUser(userId, session))) { // 로그인한 사용자가 삭제 대상인 경우 (자기 자신을 삭제)

			userDAO.remove(String.valueOf(userId));				// 사용자 정보 삭제
			
			if (UserSessionUtils.isLoginUser(adminId, session))	// 로그인한 사용자가 관리자 	
				return "redirect:/WebVR/home";		// 사용자 리스트로 이동
			else 									// 로그인한 사용자는 이미 삭제됨
				return "redirect:/WebVR/logout";		// logout 처리
		}
		
		
		User user = userDAO.findUser(userId);
		if(user.matchPassword(request.getParameter("confirm_pwd"))) {
			userDAO.remove(String.valueOf(userId));
			return "redirect:/WebVR/home";
		}
		
		/* 삭제가 불가능한 경우 
		User user = userDAO.findUser(userId);	// 사용자 정보 검색
		request.setAttribute("user", user);						
		request.setAttribute("deleteFailed", true);
		String msg = (UserSessionUtils.isLoginUser(adminId, session)) 
				   ? "시스템 관리자 정보는 삭제할 수 없습니다."		
				   : "타인의 정보는 삭제할 수 없습니다.";													
		request.setAttribute("exception", new IllegalStateException(msg));  */
		
		request.setAttribute("deleteFailed", "true");		
		return "redirect:/WebVR/myPage?userId=" + userId;
	}

}