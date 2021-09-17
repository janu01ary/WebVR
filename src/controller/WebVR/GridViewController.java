package controller.WebVR;

import controller.Controller;
import model.Artwork;
import model.dao.ArtworkDAO;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GridViewController implements Controller {
	
	private ArtworkDAO artworkDAO = new ArtworkDAO();
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 나중에 전체 ArtworkList가 아닌 해당하는 exhibition의 ArtworkList를 불러와야 함! 
		// ArtworkDAOd의 findArtworkListByExhibitionId 사용하여 수정 필요
		List<Artwork> artworkList = artworkDAO.findArtworkList();
		request.setAttribute("artworkList", artworkList);
		System.out.println(artworkList.size()); // 테스트용 출력문, 최종때 삭제 필요
		
		return "/WebVR/artworkList.jsp";
	}

}