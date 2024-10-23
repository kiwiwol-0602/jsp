package study2.mapping;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
//@WebServlet("/study2/mapping/list.do") //directory
@WebServlet("*.do") //extension(FrontController)
public class DoController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String msg = request.getParameter("msg")==null ? "" : request.getParameter("msg");
		
		request.setAttribute("msg", msg);
		
		DoInterface commond = null;
		
		String viewPage = "/WEB-INF/study2/mapping/";
		
		String uri = request.getRequestURI();
		
		System.out.println("uri : "+uri);
		
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		System.out.println("com : "+com);
		
		if(com.equals("list")) {
			commond = new DoListCommand();
			commond.execute(request, response);
			viewPage += "doList.jsp";
		}
		else if(com.equals("serch")) {
			commond = new DoSerchCommand();
			commond.execute(request, response);
			viewPage += "doSerch.jsp";
		}
		else if(com.equals("input")) {
			commond = new DoInputCommand();
			commond.execute(request, response);
			viewPage += "doInput.jsp";
		}
		else if(com.equals("inputOk")) {
			commond = new DoInputOkCommand();
			commond.execute(request, response);
			viewPage += "test2.jsp";
		}
		else if(com.equals("update")) {
			commond = new DoUpdateCommand();
			commond.execute(request, response);
			viewPage += "doUpdate.jsp";
		}
		else if(com.equals("updateOk")) {
			commond = new DoUpdateOkCommand();
			commond.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("delete")) {
			commond = new DoDeleteCommand();
			commond.execute(request, response);
			viewPage += "doDelete.jsp";
		}
		else if(com.equals("deleteOk")) {
			commond = new DoDeleteOkCommand();
			commond.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
