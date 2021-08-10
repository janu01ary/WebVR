package controller;

import java.util.HashMap;
import java.util.Map;

import controller.WebVR.CommentArtworkController;
import controller.WebVR.CreateGuestBookController;
import controller.WebVR.GuestBookController;
import controller.WebVR.ListExhbController;
import controller.WebVR.ShareArtworkController;
import controller.WebVR.ViewArtworkController;
import controller.WebVR.ViewExhbController;
import controller.WebVR.user.DeleteUserController;
import controller.WebVR.user.LoginController;
import controller.WebVR.user.LogoutController;
import controller.WebVR.user.MyPageController;
import controller.WebVR.user.RegisterUserController;

public class RequestMapping {
	// 각 요청 uri에 대한 controller 객체를 저장할 HashMap 생성
	private Map<String, Controller> mappings = new HashMap<String, Controller>();

	public void initMapping() {
		// 각 uri에 대응되는 controller 객체를 생성 및 저장

		//home
        mappings.put("/", new ListExhbController());
		
		//login, register
        mappings.put("/WebVR/login/form", new ForwardController("/WebVR/loginForm.jsp"));
        mappings.put("/WebVR/login", new LoginController());
        mappings.put("/WebVR/logout", new LogoutController());
        mappings.put("/WebVR/register/form", new ForwardController("/WebVR/registerForm.jsp"));
        mappings.put("/WebVR/register", new RegisterUserController());
        
        //exhibition
        mappings.put("/WebVR/exhb", new ViewExhbController());
        
        //artwork
        mappings.put("/WebVR/exhb/artwork", new ViewArtworkController());
        mappings.put("/WebVR/artwork/comment", new CommentArtworkController());
        mappings.put("/WebVR/artwork/share", new ShareArtworkController());

        //myPage
        mappings.put("/WebVR/myPage", new MyPageController());
        mappings.put("/WebVR/myPage/delete", new DeleteUserController());
        
        //guestbook
        mappings.put("/WebVR/exhb/guestbook", new GuestBookController());
        
        //gridview
        mappings.put("/WebVR/exhb/List", new GuestBookController());
        mappings.put("/WebVR/exhb/List/artwork", new ViewArtworkController());
        
        
        
	}

	public Controller findController(String uri) {
		// 주어진 uri에 대응되는 controller 객체를 찾아 반환
		return mappings.get(uri);
	}
}
