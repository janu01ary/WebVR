/*
 *  마이페이지에서 회원정보 수정 후 form 받아와서 업데이트
 * 
 */

package controller.WebVR.user;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.WebVR.user.UserSessionUtils;
import model.User;
import model.dao.UserDAO;

public class UpdateMyPageController implements Controller {

	private UserDAO userDAO = new UserDAO();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그인 여부 확인
    	if (!UserSessionUtils.hasLogined(request.getSession())) {
            return "redirect:/WebVR/login/form";		// login form 요청으로 redirect
        }
    	
		HttpSession session = request.getSession();
		String userId = UserSessionUtils.getLoginUserId(session);
		User user = userDAO.findUser(userId);
		
		//GET request: form 요청
		if (request.getMethod().equals("GET")) {
			request.setAttribute("user", user);
			
			if (UserSessionUtils.isLoginUser(userId, session) ||
				UserSessionUtils.isLoginUser("admin", session)) {
				// 현재 로그인한 사용자가 수정 대상 사용자이거나 관리자인 경우 -> 수정 가능
								
				return "/WebVR/myPage.jsp";   // 검색한 사용자 정보를 update form으로 전송     
			}    
			
//			// else (수정 불가능한 경우) 사용자 보기 화면으로 오류 메세지를 전달
//			request.setAttribute("updateFailed", true);
//			request.setAttribute("exception", 
//				new IllegalStateException("타인의 정보는 수정할 수 없습니다."));            
//			return "/myPage/myPage.jsp";	// 사용자 보기 화면으로 이동 (forwarding)
		}
			
		User updateUser = new User(
				Integer.parseInt(userId),
				user.getEmail(),
				user.getPassword(),
				user.getNickname());
		try {
			userDAO.update(updateUser);
		} catch(Exception e) { 
			e.printStackTrace(); 
		} 

		request.setAttribute("user", updateUser);
		return "redirect:/WebVR/myPage.jsp";
	}

}