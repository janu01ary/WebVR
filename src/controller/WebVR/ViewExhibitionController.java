package controller.WebVR;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.Artwork;
import model.Exhibition;
import model.dao.ExhibitionDAO;

public class ViewExhibitionController implements Controller {
	
	private ExhibitionDAO exhibitionDAO = new ExhibitionDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int exhibitionId = Integer.parseInt(request.getParameter("exhibitionId"));
		Exhibition exhibition = exhibitionDAO.findExhibitionById(exhibitionId);
		List<Artwork> artworkList = exhibitionDAO.findArtworkListById(exhibitionId);

		request.setAttribute("exhibition", exhibition);
		request.setAttribute("artworkList", artworkList);
		
		return "/WebVR/exhibition.jsp";
	}

}
