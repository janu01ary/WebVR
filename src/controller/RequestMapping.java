package controller;

import java.util.HashMap;
import java.util.Map;

import controller.WebVR.CreateCommentController;
import controller.WebVR.CreateGuestBookController;
import controller.WebVR.DeleteCommentController;
import controller.WebVR.DeleteGuestBookController;
import controller.WebVR.DeleteMyPageArtworkController;
import controller.WebVR.DeleteMyPageCommentController;
import controller.WebVR.GridViewController;
import controller.WebVR.LikeArtworkController;
import controller.WebVR.ListExhibitionController;
import controller.WebVR.ShareArtworkController;
import controller.WebVR.ViewArtworkController;
import controller.WebVR.ViewCommentController;
import controller.WebVR.ViewExhibitionController;
import controller.WebVR.ViewGuestBookController;
import controller.WebVR.user.DeleteUserController;
import controller.WebVR.user.LoginController;
import controller.WebVR.user.LogoutController;
import controller.WebVR.user.ViewMyPageController;
import controller.WebVR.user.UpdateMyPageController;
import controller.WebVR.user.RegisterUserController;

public class RequestMapping {
	// 각 요청 uri에 대한 controller 객체를 저장할 HashMap 생성
	private Map<String, Controller> mappings = new HashMap<String, Controller>();

	public void initMapping() {
		// 각 uri에 대응되는 controller 객체를 생성 및 저장

		//home
        mappings.put("/WebVR/home", new ListExhibitionController());
		
		//login, register
        mappings.put("/WebVR/login/form", new ForwardController("/WebVR/loginform.jsp"));
        mappings.put("/WebVR/login", new LoginController());
        mappings.put("/WebVR/logout", new LogoutController());
        mappings.put("/WebVR/register/form", new ForwardController("/WebVR/registerform.jsp"));
        mappings.put("/WebVR/register", new RegisterUserController());
        
        //exhibition
        mappings.put("/WebVR/exhb", new ViewExhibitionController());
        
        //artwork
        mappings.put("/WebVR/exhb/artwork", new ViewArtworkController());
        mappings.put("/WebVR/artwork/share", new ShareArtworkController());
        mappings.put("/WebVR/artwork/like", new LikeArtworkController());
        
        //comment
        mappings.put("/WebVR/artwork/comment", new ViewCommentController());
        mappings.put("/WebVR/artwork/comment/create", new CreateCommentController());
        mappings.put("/WebVR/artwork/comment/delete", new DeleteCommentController());

       //myPage
        mappings.put("/WebVR/myPage", new ViewMyPageController());
        mappings.put("/WebVR/myPage/update", new UpdateMyPageController());
        mappings.put("/WebVR/myPage/delete", new DeleteUserController());
        mappings.put("/WebVR/myPage/commentDelete", new DeleteMyPageCommentController());
        mappings.put("/WebVR/myPage/artworkDelete", new DeleteMyPageArtworkController());
        mappings.put("/WebVR/myPage/guestBookDelete", new DeleteGuestBookController());
        
        //guestbook
        mappings.put("/WebVR/exhb/guestbook", new ViewGuestBookController());
        mappings.put("/WebVR/exhb/guestbook/create", new CreateGuestBookController());
        mappings.put("/WebVR/exhb/guestbook/delete", new DeleteGuestBookController());
        
        //gridview
        mappings.put("/WebVR/exhb/List", new GridViewController());
        mappings.put("/WebVR/exhb/List/artwork", new ViewArtworkController());
        
	}

	public Controller findController(String uri) {
		// 주어진 uri에 대응되는 controller 객체를 찾아 반환
		return mappings.get(uri);
	}
}
