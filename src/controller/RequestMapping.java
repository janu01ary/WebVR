package controller;

import java.util.HashMap;
import java.util.Map;

public class RequestMapping {
	// 각 요청 uri에 대한 controller 객체를 저장할 HashMap 생성
	private Map<String, Controller> mappings = new HashMap<String, Controller>();

	public void initMapping() {
		// 각 uri에 대응되는 controller 객체를 생성 및 저장
		
		// 작성 예시
		// mappings.put("/artist/login/form", new ForwardController("/artist/login_register.jsp"));
		// mappings.put("/artist/login", new LoginController());
	}

	public Controller findController(String uri) {
		// 주어진 uri에 대응되는 controller 객체를 찾아 반환
		return mappings.get(uri);
	}
}
