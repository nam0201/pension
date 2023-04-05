package pension.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pension.dto.ReserveDto;
import pension.dto.RoomDto;

public class ReserveDao {
     
	 Connection conn;   
     public ReserveDao()throws Exception 
     {
    	Class.forName("com.mysql.jdbc.Driver"); 
 		String db="jdbc:mysql://localhost:3306/pension";
 		conn=DriverManager.getConnection(db,"root","1234");
     }
     
     //room테이블에 정보를 읽어오는 메소드
     public void getRoomName(HttpServletRequest request )throws Exception
     {
    	 String sql="select id,name from room order by price asc";
    	 
    	 PreparedStatement pstmt=conn.prepareStatement(sql);
    	 
    	 ResultSet rs=pstmt.executeQuery();
    	 
    	 ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
    	 
    	 //rs를 RoomDto에 ArrayList를 통해서 담기..
    	 while(rs.next())
    	 {
    		 //RoomDto에 객체생성후 값을 이동 => ArrayList에 add
    		 RoomDto rdto=new RoomDto();
    		 rdto.setId(rs.getInt("id"));
    		 rdto.setName(rs.getString("name"));
    		 
    		 rlist.add(rdto);
    		 
    	 }
    	 request.setAttribute("rlist", rlist);
     }
     
     //하나의 객실의 정보를 select
     public void getRoom(HttpServletRequest request) throws Exception
     {
    	 String id=request.getParameter("id");
    	 
    	 String sql="select * from room where id=?";
    	 
    	 PreparedStatement pstmt=conn.prepareStatement(sql);
    	 pstmt.setString(1, id);
    	 
    	 ResultSet rs=pstmt.executeQuery();
    	 rs.next();
    	 
    	 RoomDto rdto=new RoomDto();
    	 rdto.setId(rs.getInt("id"));
    	 rdto.setName(rs.getString("name"));
    	 rdto.setPrice(rs.getInt("price"));
    	 rdto.setMax(rs.getInt("max"));
    	 rdto.setMin(rs.getInt("min"));
    	 rdto.setRimg(rs.getString("rimg"));
    	 if(rs.getString("content")==null)
    		 rdto.setContent("");
    	 else
    	     rdto.setContent(rs.getString("content"));
    	 
    	 request.setAttribute("rdto", rdto);
    	 
    	  //
         String y=request.getParameter("y");
         String m=request.getParameter("m");
         String d=request.getParameter("d");
         
         String xday=y+"-"+m+"-"+d;
         
         
         request.setAttribute("xday", xday);
     }
     
     //입실일 이후 몇박이 가능한지를 체크하는 메소드
     public int getSuk(HttpServletRequest request) throws Exception
     {
    	 //입실일, room테이블의 id
    	 int y=Integer.parseInt(request.getParameter("y"));
    	 int m=Integer.parseInt(request.getParameter("m"));
    	 int d=Integer.parseInt(request.getParameter("d"));
    	 String id=request.getParameter("id");
    	 
    	 LocalDate xday=LocalDate.of(y,m,d); //입실일의 날짜 객체가 생성 : 2022-12-3
    	 
    	 int suk=1;
    	 for(int i=1;i<=6;i++)
    	 {
    		 // xday의 객체에 다음날의 정보를 넘기기
    		 xday=xday.plusDays(1);  //2022-12-4
    		 
    		 //입실일부터 하루씩 증가된 날짜를 쿼리문을 통해 예약가능한지 체크..
    		 String sql="select * from reserve where inday <= ? and outday > ? and room_id=?";
    		 
    		 PreparedStatement pstmt=conn.prepareStatement(sql);
    		 pstmt.setString(1, xday.toString());
    		 pstmt.setString(2, xday.toString());
    		 pstmt.setString(3, id);
    		 
    		 ResultSet rs=pstmt.executeQuery();
    		 
    		 if(rs.next())
    		 {
    			 break;
    		 }
    		 
    		  suk++;
    		 
    	 }
    	   return suk;
     }
     
     public void reserve_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response)throws Exception
     {
    	 //request값
    	 String inday=request.getParameter("inday");
    	 String room_id=request.getParameter("room_id");
    	 String tprice=request.getParameter("tprice");
    	 String userid=session.getAttribute("userid").toString();
    	 String chacol=request.getParameter("chacol");
    	 String bbq=request.getParameter("bbq");
    	 String inwon=request.getParameter("inwon");
    	 
    	 //퇴실일(outday)
    	 int suk=Integer.parseInt(request.getParameter("suk"));
    	 // inday : "2022-12-21"
    	 String[] imsi=inday.split("-");
    	 int y=Integer.parseInt(imsi[0]);
    	 int m=Integer.parseInt(imsi[1]);
    	 int d=Integer.parseInt(imsi[2]);
    	 
    	 LocalDate xday=LocalDate.of(y, m, d); // 입실일 날짜객체
    	 LocalDate outday=xday.plusDays(suk);  // 숙박만큼의 outday전달..
    	 
    	 //LocalDate객체는 toString() => outday.toString() => 년-월-일 (getyear,getmonth xxx) 
    	 //주문번호
    	 //예약순서를 제외한 주문번호
    	 String jcode="j"+y+m+"0"+room_id;   //j202212
    	 
    	 //같은년 월에 같은 객실에 예약번호중 가장 높은 2자리 수를 가져오기..
    	 
    	 String sql="select max( right(jcode,2) ) as num from reserve where jcode like ?";  //별칭주기num
    	 
    	 
    	 PreparedStatement pstmt=conn.prepareStatement(sql);
    	 pstmt.setString(1, jcode+"%");   //jcode like 'j20221201%'
    	 
    	 ResultSet rs=pstmt.executeQuery();
    	 rs.next();
    	 int num=rs.getInt("num");
    	 num++;
    	 //num이 1자일 경우 => "0"을 앞에 붙여준다
    	 //숫자는 자릿수를 알 수없다.
    	 String num2=num+"";
    	 if(num2.length()==1)
    		 num2="0"+num2;
    	 
    	 jcode=jcode+num2;  //주문코드 완성
    	 
    	 //System.out.println(jumun);
    	 //쿼리작성
    	 sql="insert into reserve(inday,outday,room_id,userid,jcode,chacol,bbq,inwon,writeday,tprice)";
    	 sql=sql+" values(?,?,?,?,?,?,?,?,now(),?)";
    	 //심부름꾼 생성 *선언이 위에 있으면 그냥 쓰면됨
    	 pstmt=conn.prepareStatement(sql);
    	 pstmt.setString(1, inday);
    	 pstmt.setString(2, outday.toString());
    	 pstmt.setString(3, room_id);
    	 pstmt.setString(4, userid);
    	 pstmt.setString(5, jcode);
    	 pstmt.setString(6, chacol);
    	 pstmt.setString(7, bbq);
    	 pstmt.setString(8, inwon);
    	 pstmt.setString(9, tprice);
    	 
    	 //쿼리 실행
    	 pstmt.executeUpdate();
    	 
    	 //close
    	 rs.close();
    	 pstmt.close();
    	 conn.close();
    	 //이동 : 예약완료 보기
    	 response.sendRedirect("reserve_view.jsp?jcode="+jcode);
     }
   
     public void reserve_view(HttpServletRequest request)throws Exception
     {
    	 String jcode=request.getParameter("jcode");
    	 
    	 String sql="select r2.jcode, r1.name, r2.inday, r2.outday, "
    	 		+ "r2.inwon, r2.chacol, r2.bbq, r2.tprice "
    	 		+ "from room as r1 inner join reserve as r2"
    	 		+ " on r1.id=r2.room_id and jcode=?";
    	 
    	 PreparedStatement pstmt=conn.prepareStatement(sql);
    	 pstmt.setString(1, jcode);
    	 
    	 ResultSet rs=pstmt.executeQuery();
    	 rs.next();
    	 
    	 //rs를 Dto에 담아 reqeust영역에 저장
    	 ReserveDto rdto=new ReserveDto();
    	 rdto.setJcode(rs.getString("jcode"));
    	 rdto.setName(rs.getString("name"));
    	 rdto.setInday(rs.getString("inday"));
    	 rdto.setOutday(rs.getString("outday"));
    	 rdto.setInwon(rs.getInt("inwon"));
    	 rdto.setChacol(rs.getInt("chacol"));
    	 rdto.setBbq(rs.getInt("bbq"));
    	 rdto.setTprice(rs.getInt("tprice"));
    	 
    	 request.setAttribute("rdto", rdto);
    	 
     }
     
     public void reserve_all(HttpSession session, HttpServletRequest request)throws Exception
     {
    	 String userid=session.getAttribute("userid").toString();
    	 
    	 String sql="select r2.jcode, r1.name, r2.inday, r2.outday, "
     	 		+ "r2.inwon, r2.chacol, r2.bbq, r2.tprice "
     	 		+ "from room as r1 inner join reserve as r2"
     	 		+ " on r1.id=r2.room_id and userid=? order by inday desc";
    	 
    	 PreparedStatement pstmt=conn.prepareStatement(sql);
    	 pstmt.setString(1, userid);
    	 
    	 ResultSet rs=pstmt.executeQuery();
    	 
    	 ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
    	 
    	 while(rs.next())
    	 {
    		 ReserveDto rdto=new ReserveDto();
        	 rdto.setJcode(rs.getString("jcode"));
        	 rdto.setName(rs.getString("name"));
        	 rdto.setInday(rs.getString("inday"));
        	 rdto.setOutday(rs.getString("outday"));
        	 rdto.setInwon(rs.getInt("inwon"));
        	 rdto.setChacol(rs.getInt("chacol"));
        	 rdto.setBbq(rs.getInt("bbq"));
        	 rdto.setTprice(rs.getInt("tprice"));
        	 
        	 rlist.add(rdto);
    	 }
    	 request.setAttribute("rlist", rlist);
     }
     
     public boolean isEmpty(int y, int m, int d, int id) throws Exception
     {
    	 String ymd=y+"-"+m+"-"+d;
    	 
    	 String sql="select * from reserve where inday <= ? and outday > ? and room_id=?";
    	 
    	 PreparedStatement pstmt=conn.prepareStatement(sql);
    	 pstmt.setString(1, ymd);
    	 pstmt.setString(2, ymd);
    	 pstmt.setInt(3, id);
    	 
    	 ResultSet rs=pstmt.executeQuery();
    	 
    	 if(rs.next())
    	 {   //예약불가
    		 return false;
    	 }
    	 else
    	 {  //예약가능
    		 return true;
    	 }
     }
     
     
}
