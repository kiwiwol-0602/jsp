package study2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import study2.ajax.AjaxIdCheck0Command;
import study2.ajax.AjaxIdCheck1Command;
import study2.ajax.AjaxPointCheckCommand;
import study2.calendar.CalendarCommand;
import study2.password.PassCheckOkCommand;
import study2.pdstest.FileDeleteCheckCommand;
import study2.pdstest.FileDeleteCommand;
import study2.pdstest.FileDownloadCommand;
import study2.pdstest.FileUpload1OkCommand;
import study2.pdstest.FileUpload2OkCommand;
import study2.pdstest.FileUpload3OkCommand;
import study2.pdstest.FileUpload4OkCommand;
import study2.pdstest.FileUpload5Ok;
import study2.pdstest.JavaFileDownloadCommand;
import study2.photoView.PhotoStorageListCommand;
import study2.photoView.PhotoView1Okcommand;
import study2.photoView.PhotoView2OkCommand;
import study2.photoView.PhotoViewDeleteCommand;
import study2.uuid.UuidFormOkCommand;

@SuppressWarnings("serial")
@WebServlet("*.st")
public class StudyController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StudyInterface command = null;
		String viewPage = "/WEB-INF/study2";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증처리.....(spring에서는 aop의 개념)
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(level > 4) {
			request.setAttribute("message", "로그인후 사용하세요");
			request.setAttribute("url", "/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(level == 1) {
			request.setAttribute("message", "정회원부터 사용하실수 있습니다.");
			request.setAttribute("url", "/MemberMain.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/PassCheckForm")) {
			viewPage += "/password/passCheck.jsp";
		}
		else if(com.equals("/PassCheckOk")) {
			command = new PassCheckOkCommand();
			command.execute(request, response);
			viewPage += "/password/passCheck.jsp";
		}
		else if(com.equals("/AjaxTest")) {
			viewPage += "/ajax/ajaxTest.jsp";
		}
		else if(com.equals("/AjaxIdCheck0")) {
			command = new AjaxIdCheck0Command();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/AjaxIdCheck1")) {
			command = new AjaxIdCheck1Command();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/AjaxPointCheck")) {
			command = new AjaxPointCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/AjaxTest2")) {
			viewPage += "/ajax/ajaxTest2.jsp";
		}
		else if(com.equals("/FileUpload")) {
			viewPage += "/pdstest/fileUpload.jsp";
		}
		else if(com.equals("/FileUpload1")) {
			viewPage += "/pdstest/fileUpload1.jsp";
		}
		else if(com.equals("/FileUpload2")) {
			viewPage += "/pdstest/fileUpload2.jsp";
		}
		else if(com.equals("/FileUpload3")) {
			viewPage += "/pdstest/fileUpload3.jsp";
		}
		else if(com.equals("/FileUpload4")) {
			viewPage += "/pdstest/fileUpload4.jsp";
		}
		else if(com.equals("/FileUpload5")) {
			viewPage += "/pdstest/fileUpload5.jsp";
		}
		else if(com.equals("/FileUpload6")) {
			viewPage += "/pdstest/fileUpload6.jsp";
		}
		else if(com.equals("/FileUpload1Ok")) {
			command = new FileUpload1OkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/FileUpload2Ok")) {
			command = new FileUpload2OkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/FileUpload3Ok")) {
			command = new FileUpload3OkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/FileUpload4Ok")) {
			command = new FileUpload4OkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
//		else if(com.equals("/FileUpload5Ok")) {
//			command = new FileUpload5OkCommand();
//			command.execute(request, response);
//			viewPage = "/include/message.jsp";
//		}
		else if(com.equals("/FileDownload")) {
			command = new FileDownloadCommand();
			command.execute(request, response);
			viewPage += "/pdstest/fileDownload.jsp";
		}
		else if(com.equals("/FileDelete")) {
			command = new FileDeleteCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/FileDeleteCheck")) {
			command = new FileDeleteCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/JavaFileDownload")) {
			command = new JavaFileDownloadCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/Calendar")) {
			command = new CalendarCommand();
			command.execute(request, response);
			viewPage += "/calendar/calendar.jsp";
		}
		else if(com.equals("/UuidForm")) {
			viewPage += "/uuid/uuidForm.jsp";
		}
		else if(com.equals("/UuidFormOk")) {
			command = new UuidFormOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/PhotoView")) {
			viewPage += "/photoView/photoView1.jsp";
		}
		else if(com.equals("/PhotoView1Ok")) {
			command = new PhotoView1Okcommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/PhotoView2")) {
			viewPage += "/photoView/photoView2.jsp";
		}
		else if(com.equals("/PhotoView2Ok")) {
			command = new PhotoView2OkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/PhotoStorageList")) {
			command = new PhotoStorageListCommand();
			command.execute(request, response);
			viewPage += "/photoView/photoStorageList.jsp";
		}
		else if(com.equals("/PhotoViewDelete")) {
			command = new PhotoViewDeleteCommand();
			command.execute(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
