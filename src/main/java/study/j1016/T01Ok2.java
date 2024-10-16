package study.j1016;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/1016/T01Ok2")
public class T01Ok2 extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		// 넘어온 아이디와 비밀번호가 DB에 저장된 회원정보와 같은지를 비교.....
		
		String viewPage = "";
		RequestDispatcher dispatcher = null;
		if((mid.equals("admin") && pwd.equals("1234")) || (mid.equals("hkd1234") && pwd.equals("1234"))) {
			//response.sendRedirect(request.getContextPath()+"/study/1016/t02_Member.jsp?mid="+mid);
			//String viewPage = request.getContextPath()+"/study/1016/t02_Memver.jsp";
			viewPage ="/study/1016/t02_Member.jsp";
			request.setAttribute("mid", mid);//request가 저장도함(서블릿변수(뒤)를 request(앞)에 저장함)
			//RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage); //직렬화계체 중간에 멈추지 않고 계속해서 감(담아오는건 request에)
			//dispatcher = request.getRequestDispatcher(viewPage); //직렬화계체 중간에 멈추지 않고 계속해서 감(담아오는건 request에)
			//dispatcher.forward(request, response); //보내주는 역할
		}
		else {
			//response.sendRedirect(request.getContextPath()+"/study/1016/t02_Dispatcher.jsp?flag=no");
			//String viewPage = request.getContextPath()+"/study/1016/t02_Dispatcher.jsp";
			viewPage = "/study/1016/t02_Dispatcher.jsp";
			request.setAttribute("flag", "no");//request가 저장도함(서블릿변수:값(뒤)를 request 변수(앞)에 저장함)-뒤에가 데이터 앞에가 변수
			//RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage); //직렬화계체 중간에 멈추지 않고 계속해서 감(담아오는건 request에)
			//dispatcher = request.getRequestDispatcher(viewPage); //직렬화계체 중간에 멈추지 않고 계속해서 감(담아오는건 request에)
			//dispatcher.forward(request, response); //보내주는 역할
		}
		//request의 생명주기는 한번쓰면 끝남
		dispatcher = request.getRequestDispatcher(viewPage); //최종
		dispatcher.forward(request, response);
	}
}
