package study2.database;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/study2/database/DbDeleteOK")
public class DbDeleteOK extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null || request.getParameter("idx").equals("") ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		DbTestDAO dao = new DbTestDAO();
		
		int res = dao.setDbDeleteOK(idx);

		if(res != 0) {
    	request.setAttribute("message", "회원정보 삭제 완료");
    	request.setAttribute("url", "/study2/database/Dblist");
    }
    else {
    	request.setAttribute("message", "회원정보 삭제 실패");
    	request.setAttribute("url", "/study2/database/DbSearch?idx="+idx);
    }
		
		
		String viewPage="/include/message.jsp";
    RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
    dispatcher.forward(request, response);
	}
}
