package study2.mapping;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/mapping/Test1Ok")
public class Test1Ok extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int su1 = (request.getParameter("su1")==null || request.getParameter("su1").equals(""))? 0 : Integer.parseInt(request.getParameter("su1"));
		int su2 = (request.getParameter("su2")==null || request.getParameter("su1").equals("")) ? 0 : Integer.parseInt(request.getParameter("su2"));
		String flag = request.getParameter("flag")==null ? "" : request.getParameter("flag");
		
		if(flag.equals("1")) {
			int hap = su1 + su2;
			int cha = su1 - su2;
			request.setAttribute("hap", hap);
			request.setAttribute("cha", cha);
		}
		else if(flag.equals("3")) {
			int gop = su1 * su2;
			int mok = 0;
			if(su2 !=0) mok = su1/su2;
			request.setAttribute("gop", gop);
			request.setAttribute("mok", mok);
		}
		else if(flag.equals("4")) {
			//LocalDate today = LocalDate.now();
			//Date today = new Date();
			//request.setAttribute("msg", today);
			LocalDateTime todaytime = LocalDateTime.now();
			String daytime = todaytime.toString().substring(0, 19).replace("T", " ");
			request.setAttribute("msg", daytime);
			request.setAttribute("daytime", daytime);
			request.setAttribute("day", daytime.substring(0, 10));
			request.setAttribute("time",daytime.substring(11, 19));
			
			
			
		}
		
		request.setAttribute("su1", su1);
		request.setAttribute("su2", su2);
		
		String viewPage = "/WEB-INF/study2/mapping/test1.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
