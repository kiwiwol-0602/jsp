package study2.ajax;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import study2.database.DbTestDAO;
import study2.database.DbTestVO;

@SuppressWarnings("serial")
@WebServlet("/AjaxIdCheck2_3")
public class AjaxIdCheck2_3 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		
		DbTestDAO dao = new DbTestDAO();
		
		DbTestVO vo = dao.getIdSearch(mid);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("mid", vo.getMid());
		map.put("name", vo.getName());
		map.put("age", vo.getAge()+"");
		map.put("gender", vo.getGender());
		map.put("address", vo.getAddress());
		
		System.out.println("map : " + map);
		
		//map형식의 자료를 JSON형식으로 변환처리한다.
		JSONObject jObj = new JSONObject(map);
		System.out.println("jObj : " + jObj);
		
		//jObj을 JSON객체의 문자열로 변환
		String str = jObj.toJSONString();
		
		response.getWriter().write(jObj+"");
	}
}
