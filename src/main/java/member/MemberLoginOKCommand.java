package member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.SecurityUtil;
import guest.GuestDAO;

public class MemberLoginOKCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String idSave = request.getParameter("idSave")==null? "off" : "on";
		
		// (숙제)아이디를 쿠키로 저장처리
		// 로그인 OK시에, idSave에 체크를 하였다면, 아이디를 쿠키에 저장처리한다. idSave에 체크해제되어 있다면 쿠키에서 제거한다.
		Cookie cookieMid = new Cookie("cMid",mid);
		cookieMid.setPath("/");
		if(idSave.equals("on")) {
			cookieMid.setMaxAge(60*60);
		}
		else {
			cookieMid.setMaxAge(0);
		}
		response.addCookie(cookieMid);
		
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo =  dao.getMemberIdCheck(mid);
		
		if(vo.getMid() == null) {
      request.setAttribute("message", "회원정보가 없습니다.\\n확인하고 다시 로그인하세요.");
      request.setAttribute("url", "MemberLogin.mem");
      return;
   }
		
		// 저장된 비밀번호에서 salt키를 분리시켜서 다시 암호화 후 비교 처리한다.
		String salt = vo.getPwd().substring(0,3);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		//System.out.println("pwd(암호화) : " +pwd);
		//System.out.println("pwd(DB) : " + vo.getPwd().substring(3));
		
		if(!vo.getPwd().substring(3).equals(pwd)) {
			request.setAttribute("message", "회원정보가 없습니다.\\n확인하고 다시 로그인 하세요.");
			request.setAttribute("url", "MemberLogin.mem");
			return;
		}
		
		//=======================로그인 처리된 회원을 처리=====================//
				
		// 동일한 아이디가 검색되었다면 비밀번호가 맞는지 확인 후
		// 입력받은 비밀번호를 암호화 시켜서 DB에 암호화 되어 저정되어 있는 비밀번호와 비교한다.
		
		//if(!vo.getPwd().equals(pwd)) {
		//	request.setAttribute("message", "비밀번호가 틀립니다.\\n확인하고 다시 로그인 하세요.");
		//	request.setAttribute("url", "MemberLogin.mem");
		//	return;			
		//}
		
		// 정상적인 로그인이 되었을 때 처리할 내용을 기술한다.
		// 세션에 저장할 항목 : mid, nickName
		HttpSession session = request.getSession();
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("sLastDate", vo.getLastDate()); //최근방문일을 세션에저장
		
		//회원등급별 등급명칭을 strLevel변수에 저장한다. (자동등업에서도 사용하기에 메소드 처리)
		String strLevel = strLevelProcess(vo.getLevel());
		session.setAttribute("sStrLevel", strLevel);
		
		// (숙제)todayCnt를 이용하여 방문포인트를 5회 미만일 경우에 10point씩 증가처리한다.
		// 방문포인트 10증가, 방문카운트(visitCnt,todayCnt) 1증가, 마지막날짜(최종방문일자:lastDate) 수정
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strToday = sdf.format(today);
		
		if(!strToday.equals(vo.getLastDate().substring(0, 10))) {
			vo.setTodayCnt(1);
			vo.setPoint(vo.getPoint()+10);
		}
		else {
			// 오늘 처음 방문한 경우 수행처리 (오늘 방문 카운트+1, 포인트 증가? 오늘 방문횟수가 5회까지만 포인트+10)
			vo.setTodayCnt(vo.getTodayCnt()+1);
			if(vo.getTodayCnt()<=5) {
				vo.setPoint(vo.getPoint()+10);
			}
		}
		//최근 방문일을 세션에 담아둔다.
		
		
		dao.setPonintPlus(vo);
		
		
		// 방문횟수(총/오늘) 누적, 마지막 방문일자 처리, 준 회원을 자동으로 등업처리 할 경우 수행 내용 등등..
		// 처리 완료된 자료들은 작업 수행이 진행되는 동안 꼭 필요한 정보만을 Session에 저장한다.

	// 준회원인경우 정회원으로 자동등업처리(조건:총방문회수 10회이상, 방명록글수 2개이상)
		int levelSw = 0;
		if(vo.getLevel() == 1) {
			GuestDAO gDao = new GuestDAO();
			vo = dao.getMemberIdCheck(mid);
			if(vo.getVisitCnt() >= 10 && gDao.getGuestCnt(mid, vo.getName(), vo.getNickName()) >= 2) {
				dao.setMemberLevelUpdate(vo.getIdx(), 2);
				session.setAttribute("sLevel", 2);
				session.setAttribute("strLevel", strLevelProcess(2));
				levelSw = 1;
			}
		}
		if(levelSw != 0) request.setAttribute("message", mid + "님 축하합니다.\\n정회원이 되셨습니다.");
		else request.setAttribute("message", mid + "님 로그인 되었습니다.");
	
		request.setAttribute("url", "MemberMain.mem");
	}
	private String strLevelProcess(int level) {
		String strLevel = "";
		if(level == 0) {
			strLevel = "관리자";
		}
		else if(level == 1) {
			strLevel = "준회원";
		}
		else if(level == 2) {
			strLevel = "정회원";
		}
		else if(level == 3) {
			strLevel = "우수회원";
		}
		return strLevel;
	}
}
