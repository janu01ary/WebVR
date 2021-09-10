package controller.WebVR;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.Artwork;
import model.dao.ArtworkDAO;

public class ShareArtworkController implements Controller {
	
	private ArtworkDAO artworkDAO = new ArtworkDAO();

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int artworkId = Integer.parseInt(request.getParameter("artworkId"));
		Artwork artwork = artworkDAO.findArtwork(artworkId);
		request.setAttribute("artwork", artwork);		
		
		return "/WebVR/artworkShare.jsp";
	}

}
