package controller.WebVR;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;

public class ShareArtworkController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 컨트롤러가 어떤 jsp 파일로 리턴되어야 하는지만 작성하면 됨
		return "/WebVR/artworkShare.jsp";
	}

}
