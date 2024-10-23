package study2.mapping;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DoDeleteOkCommand implements DoInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이곳은 DoDeleteOkCommand 입니다.");
    
		request.setAttribute("message", "회원 정보가 삭제되었습니다.");
  	request.setAttribute("url", "/study2/mapping/Test2");
	}

}
