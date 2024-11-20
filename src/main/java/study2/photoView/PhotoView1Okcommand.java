package study2.photoView;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import study2.StudyInterface;

public class PhotoView1Okcommand implements StudyInterface {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String realPath = request.getServletContext().getRealPath("/images/phtoView");
      int maxSize = 1024 * 1024 * 10;
      String encoding = "UTF-8";
      
      MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
      
      String originalFilName = multipartRequest.getOriginalFileName("fName");
      String filesysttemName = multipartRequest.getFilesystemName("fName");
      
      String content = multipartRequest.getParameter("content") == null || multipartRequest.getParameter("content").equals("") ? "내용없음" : multipartRequest.getParameter("content");
      System.out.println("content : " + content)
      ;
      
     //BackEnd 파일체크 
      if(originalFilName != null && !originalFilName.equals("")) {
         request.setAttribute("message", "파일 전송 완료");
      }
      else {
         request.setAttribute("message", "파일전송실패");
      }
            
      request.setAttribute("url", "FileUpload1.st");

   }

}
