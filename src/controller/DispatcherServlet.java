package controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatcherServlet extends HttpServlet {
	private RequestMapping rm;

	public void init() throws ServletException {
		rm = new RequestMapping();
		rm.initMapping(); // request URI와 controller 간의 mapping 생성
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String contextPath = request.getContextPath();
		String servletPath = request.getServletPath();
		
		System.out.println("contextPath: " + contextPath);
		System.out.println("servletPath: " + servletPath);
		
		// RequestURI 중 servletPath에 대응되는 controller를 구함
		Controller controller = rm.findController(servletPath);
		try {
			// controller를 실행하여 request를 처리한 후, 이동할 uri를 반환 받음
			String uri = controller.execute(request, response);
			// 반환된 uri에 따라 forwarding 또는 redirection 여부를 결정하고 이동
			if (uri.startsWith("redirect:")) {
				String targetUri = contextPath + uri.substring("redirect:".length());
				response.sendRedirect(targetUri); // redirection 지시
			} else {
				RequestDispatcher rd = request.getRequestDispatcher(uri);
				rd.forward(request, response); // forwarding 수행
			}
		} catch (Exception e) {
			throw new ServletException(e.getMessage());
		}
	}
}