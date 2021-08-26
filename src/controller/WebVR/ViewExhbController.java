package controller.WebVR;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.dao.ExhibitionDAO;

public class ViewExhbController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ExhibitionDAO exhibitionDAO = new ExhibitionDAO();
		System.out.println("create " + exhibitionDAO.create());
		
		return "/WebVR/artworkShare.jsp";
	}

} 
