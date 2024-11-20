package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.GetConn;

public class MemberDAO {
   private Connection conn = GetConn.getConn();
//   private Connection conn2 = GetConn.getConn();
//   private GetConn conn = GetConn.getInstance();
//   private GetConn conn2 = GetConn.getInstance();
//   
//   public MemberDAO() {
//      if(conn == conn2) System.out.println("conn과 conn2는 같은 객체 입니다.");
//      else System.out.println("conn과 conn2는 서로 다른 객체 입니다.");
//   }
   
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
   
   private String sql = "";
   MemberVO vo = null;
   
   public void pstmtClose() {
      if(pstmt != null) {
         try {
            pstmt.close();
         } catch (SQLException e) {}
      }
   }
   
   public void rsClose() {
  	 if(rs != null) {
  		 try {
  			 rs.close();
       } catch (SQLException e) {
       } finally { 
      	 pstmtClose(); 
       }
     }
   }

	public MemberVO getMemberIdCheck(String mid) {
		MemberVO vo = new MemberVO();
		try {
			sql = "select * from member where mid = ? and userDel != 'OK'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setContent(rs.getString("content"));
				vo.setPhoto(rs.getString("photo"));
				vo.setLevel(rs.getInt("level"));
				vo.setUserInfor(rs.getString("userInfor"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				//vo.setTempMid(rs.getString("TempMid"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 :"+e.getMessage()); 
		}
		 return vo;
	}
	public MemberVO getMemberNickNameCheck(String nickName) {
		MemberVO vo = new MemberVO();
		try {
			sql = "select * from member where nickName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setContent(rs.getString("content"));
				vo.setPhoto(rs.getString("photo"));
				vo.setLevel(rs.getInt("level"));
				vo.setUserInfor(rs.getString("userInfor"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));

			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 :"+e.getMessage()); 
		}
		return vo;
	}
		
	// 방문포인트 10씩 증가시켜주기
	public void setPonintPlus(MemberVO vo) {
		try {
				sql="update member set point=?, visitCnt=visitCnt+1, todayCnt=?, lastDate=now() where mid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, vo.getPoint());
				pstmt.setInt(2, vo.getTodayCnt());
				pstmt.setString(3, vo.getMid());
				pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 :"+e.getMessage()); 
    } finally { 
   	 pstmtClose(); 
    }
	}

	// 회원 가입 처리
	public int setMemberJoinOk(MemberVO vo) {
		int res = 0;
		try {
			sql = "insert into member values(default, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default, default, default, default, default, default, default);";
			pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, vo.getMid());
      pstmt.setString(2, vo.getPwd());
      pstmt.setString(3, vo.getNickName());
      pstmt.setString(4, vo.getName());
      pstmt.setString(5, vo.getGender());
      pstmt.setString(6, vo.getBirthday());
      pstmt.setString(7, vo.getTel());
      pstmt.setString(8, vo.getAddress());
      pstmt.setString(9, vo.getEmail());
      pstmt.setString(10, vo.getContent());
      pstmt.setString(11, vo.getPhoto());
      pstmt.setString(12, vo.getUserInfor());
      res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 :"+e.getMessage()); 
    } finally { 
   	 pstmtClose(); 
    }
		return res;
	}
	
	//전체 회원 리스트 처리
	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
		try {
			if(level == 999) { // 전체회원 모두보기 (페이징처리)
				sql = "select *, datediff(now(),lastDate) as elapsed_date from member order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else if(level == 888) { // 전체회원 모두 보기(단, 탈퇴신청회원(level=99)은 제외)
				sql = "select * from member where level!=99 order by nickName";
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select *, datediff(now(),lastDate) as elapsed_date from member where level=? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, level);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setContent(rs.getString("content"));
				vo.setPhoto(rs.getString("photo"));
				vo.setLevel(rs.getInt("level"));
				vo.setUserInfor(rs.getString("userInfor"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				if(level != 888) vo.setElapsed_date(rs.getInt("elapsed_date"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 :"+e.getMessage()); 
    } finally { 
   	 	rsClose(); 
    }
		return vos;
	}
	//회원 등업시켜주기
	public void setMemberLevelUpdate(int idx, int level) {
		try {
			sql = "update member set level = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, level);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		}	finally {
			pstmtClose();
		}
	}

	public int setMemberUpdateOk(MemberVO vo) {
		int res = 0;
		try {
			sql="update member set name=?, nickName=?, gender=?, birthday=?, tel=?, "
					+ "address=?, email=?, content=?, photo=?, userInfor=? where mid = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getGender());
			pstmt.setString(4, vo.getBirthday());
			pstmt.setString(5, vo.getTel());
			pstmt.setString(6, vo.getAddress());
			pstmt.setString(7, vo.getEmail());
			pstmt.setString(8, vo.getContent());
			pstmt.setString(9, vo.getPhoto());
			pstmt.setString(10, vo.getUserInfor());
			pstmt.setString(11, vo.getMid());
			res = pstmt.executeUpdate();
			
		}catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		}	finally {
			pstmtClose();
		}
		return res;
	}

	public int setMemberPwdCheckAjaxOk(String mid, String pwd) {
		int res = 0;
		try {
			sql = "update member set pwd = ? where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, mid);
			res=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		}	finally {
			pstmtClose();
		}
		return res;
	}

	public int setMemberDeleteCheckOk(String mid) {
		int res= 0;
		try {
			sql = "update member set userDel = 'OK', level = 99 where mid = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		}	finally {
			pstmtClose();
		}
		return res;
	}
	
	//회원 등급 변경 (관리자)
	public int setMemberLevelChange(int level, int idx) {
		int res = 0;
		try {
			sql = "update member set level = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, level);
			pstmt.setInt(2, idx);
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		}	finally {
			pstmtClose();
		}
		
		return res;
	}
	
	//회원의 총 인원수 구하기
	public int getTotRecCnt(int level) {
		int totRecCnt = 0;
		
		try {
			if(level == 999) {
				sql = "select count(idx) as totRecCnt from member";
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select count(idx) as totRecCnt from member where level = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, level);
			}
			rs = pstmt.executeQuery();
			
			rs.next();
			totRecCnt = rs.getInt("totRecCnt");
			
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		}	finally {
			rsClose();
		}
		return totRecCnt;
	}
		
	// 회원 상세정보 가져오기
		public MemberVO getMemberIdxCheck(int idx) {
			MemberVO vo = new MemberVO();
			try { 
				sql = "select * from member where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNickName(rs.getString("nickName"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setBirthday(rs.getString("birthday"));
					vo.setTel(rs.getString("tel"));
					vo.setAddress(rs.getString("address"));
					vo.setEmail(rs.getString("email"));
					vo.setContent(rs.getString("content"));
					vo.setPhoto(rs.getString("photo"));
					vo.setLevel(rs.getInt("level"));
					vo.setUserInfor(rs.getString("userInfor"));
					vo.setUserDel(rs.getString("userDel"));
					vo.setPoint(rs.getInt("point"));
					vo.setVisitCnt(rs.getInt("visitCnt"));
					vo.setTodayCnt(rs.getInt("todayCnt"));
					vo.setStartDate(rs.getString("startDate"));
					vo.setLastDate(rs.getString("lastDate"));
				}
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			}	finally {
				rsClose();
			}
			return vo;
	}
		
	// 아이디 검색 리스트
		public ArrayList<MemberVO> getMemberMidList(String mid) {
			ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
			try {
				sql = "select * from member where mid like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + mid + "%");
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					MemberVO vo = new MemberVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMid(rs.getString("mid"));
					vo.setPwd(rs.getString("pwd"));
					vo.setNickName(rs.getString("nickName"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setBirthday(rs.getString("birthday"));
					vo.setTel(rs.getString("tel"));
					vo.setAddress(rs.getString("address"));
					vo.setEmail(rs.getString("email"));
					vo.setContent(rs.getString("content"));
					vo.setPhoto(rs.getString("photo"));
					vo.setLevel(rs.getInt("level"));
					vo.setUserInfor(rs.getString("userInfor"));
					vo.setUserDel(rs.getString("userDel"));
					vo.setPoint(rs.getInt("point"));
					vo.setVisitCnt(rs.getInt("visitCnt"));
					vo.setTodayCnt(rs.getInt("todayCnt"));
					vo.setStartDate(rs.getString("startDate"));
					vo.setLastDate(rs.getString("lastDate"));
					
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			}	finally {
				rsClose();
			}
			return vos;
		}
	}

