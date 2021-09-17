package controller.WebVR;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.Exhibition;
import model.dao.ExhibitionDAO;

public class ListExhibitionController implements Controller {
	
	private ExhibitionDAO exhibitionDAO = new ExhibitionDAO();;

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<Exhibition> exhibitionList = exhibitionDAO.findExhibitionList();
		
		System.out.println("exhibitionList" + exhibitionList);

		request.setAttribute("exhibitionList", exhibitionList);
		return "/WebVR/home.jsp";
	}

}
