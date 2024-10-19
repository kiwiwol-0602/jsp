package study.exam;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/exam/t02_loginOk")
public class t02_loginOk extends HttpServlet{
    @Override
   protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      response.setContentType("text/html; charset=utf-8");
      String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
      String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
      
      String idList[] = {"hkd1234S", "kms1234C", "lkj1234J", "adminI", "atom1234I", "btom1234J", "ctom1234C"};
      String viewPage = "";
      
      for(int i = 0; i < idList.length; i++){
         if(idList[i].equals(mid) && pwd.equals("1234")){
            if(mid.substring(mid.length()-1).equals("I")){
               viewPage = "/study/exam/t02_login/t02_resI.jsp";
            }
            else if(mid.substring(mid.length()-1).equals("J")){
               viewPage = "/study/exam/t02_login/t02_resJ.jsp";
            }
            else if(mid.substring(mid.length()-1).equals("S")){
               viewPage = "/study/exam/t02_login/t02_resS.jsp";
            }
            else if(mid.substring(mid.length()-1).equals("C")){
               viewPage = "/study/exam/t02_login/t02_resC.jsp";
            }
            break;
         }
         else {
            viewPage = "/study/exam/t02_login/t02_login.jsp";
         }
      }
      
      request.setAttribute("mid", mid);
      request.setAttribute("pwd", pwd);
      RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
      dispatcher.forward(request, response);
   }
}
