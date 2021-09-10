package controller.WebVR;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.Artwork;
import model.dao.ArtworkDAO;

public class ViewArtworkController implements Controller {

	private ArtworkDAO artworkDAO = new ArtworkDAO();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int artworkId = Integer.parseInt(request.getParameter("artworkId"));
		Artwork artwork = artworkDAO.findArtwork(artworkId);
		request.setAttribute("artwork", artwork);
		
		artworkDAO.updateView(artwork); // 조회수 증가
		
		return "/WebVR/artwork.jsp";
	}

}
