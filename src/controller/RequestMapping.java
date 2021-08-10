package controller;

import java.util.HashMap;
import java.util.Map;

import controller.WebVR.ListExhbController;
import controller.WebVR.ViewArtworkController;
import controller.WebVR.ViewExhbController;
import controller.WebVR.user.LoginController;
import controller.WebVR.user.LogoutController;
import controller.WebVR.user.RegisterUserController;

public class RequestMapping {
	// 각 요청 uri에 대한 controller 객체를 저장할 HashMap 생성
	private Map<String, Controller> mappings = new HashMap<String, Controller>();

	public void initMapping() {
		// 각 uri에 대응되는 controller 객체를 생성 및 저장

		//home
        mappings.put("/", new ListExhbController());
		
		//login, register
        mappings.put("/user/login/form", new ForwardController("/user/loginForm.jsp"));
        mappings.put("/user/login", new LoginController());
        mappings.put("/user/logout", new LogoutController());
        mappings.put("/user/register/form", new ForwardController("/user/registerForm.jsp"));
        mappings.put("/user/register", new RegisterUserController());
        
        //exhibition
        mappings.put("/WebVR/exhb", new ViewExhbController());
        
        //artwork
        mappings.put("/WebVR/exhb/artwork", new ViewArtworkController());
        
	}

	public Controller findController(String uri) {
		// 주어진 uri에 대응되는 controller 객체를 찾아 반환
		return mappings.get(uri);
	}
}
