package pension.dao;

import java.io.File;
import java.net.http.HttpResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pension.dto.EventDto;
import pension.dto.MantoDto;
import pension.dto.MemberDto;
import pension.dto.ReserveDto;
import pension.dto.RoomDto;
import util.MyJob;

public class AdminDao {
	Connection conn;
    public AdminDao() throws Exception
    {
    	
	    Class.forName("com.mysql.jdbc.Driver"); 
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
    }
    
    // AdminDao
    public void admin_member(HttpServletRequest request,
    		HttpSession session,
    		HttpServletResponse response) throws Exception
    {
    	if(session.getAttribute("userid")==null || !(session.getAttribute("userid").equals("admin")) )
    	{
    		response.sendRedirect("../main/main.jsp");
    	}
    	else
    	{
    		String sql="select * from member order by name asc";
    		
    		PreparedStatement pstmt=conn.prepareStatement(sql);
    		ResultSet rs=pstmt.executeQuery();
    		
    		ArrayList<MemberDto> mlist=new ArrayList<MemberDto>();
    		
    		// rs => dto => ArrayList
    		while(rs.next()) 
    		{
    		    MemberDto mdto=new MemberDto();
    		    mdto.setId(rs.getInt("id"));
    		    mdto.setUserid(rs.getString("userid"));
    		    mdto.setName(rs.getString("name"));
    		    mdto.setPhone(rs.getString("phone"));
    		    mdto.setWriteday(rs.getString("writeday"));
    		    mdto.setState(rs.getInt("state"));
    		    mlist.add(mdto);
    		}
    		
    		request.setAttribute("mlist", mlist);
    	}
    }
    
    public void member_out_ok(HttpServletRequest request,
    		HttpSession session,
    		HttpServletResponse response) throws Exception
    {
    	if(session.getAttribute("userid")==null || !(session.getAttribute("userid").equals("admin")) )
    	{
    		response.sendRedirect("../main/main.jsp");
    	}
    	else
    	{
    		String id=request.getParameter("id");
			
    		String sql="update member set state=2 where id=?";
    		
    		PreparedStatement pstmt=conn.prepareStatement(sql);
    		pstmt.setString(1, id);
    		
    		pstmt.executeUpdate();
    		
    		pstmt.close();
    		conn.close();
    		
    		response.sendRedirect("admin_member.jsp");
    	}
    }
    
    public void admin_manto(HttpServletRequest request) throws Exception
    {
    	String sql="select * from manto order by id desc";    
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	
    	ResultSet rs=pstmt.executeQuery();
    	
    	ArrayList<MantoDto> mlist=new ArrayList<MantoDto>();
    	// rs => dto => ArrayList
    	while(rs.next())
    	{
    		MantoDto mdto=new MantoDto();
    		mdto.setId(rs.getInt("id"));
    		mdto.setQue(rs.getInt("que"));
    		mdto.setContent(rs.getString("content"));
    		mdto.setUserid(rs.getString("userid"));
    		mdto.setState(rs.getInt("state"));
    		mdto.setWriteday(rs.getString("writeday"));
    		
    		mlist.add(mdto);
    	}
    	
    	request.setAttribute("mlist", mlist);
    	
    }
    

    
    public void answer(HttpServletRequest request, HttpServletResponse response)throws Exception
    {
    	request.setCharacterEncoding("utf-8");
    	String id=request.getParameter("id");
    	String content=request.getParameter("content");
		//content내용은 answer필드에 저장해야됨.
		String sql="update manto set answer=?, state=1 where id=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, content);
		pstmt.setString(2, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("admin_manto.jsp");
    }
   
    
    public void answer_view(HttpServletRequest request,
    		JspWriter out) throws Exception
    {
    	String id=request.getParameter("id");
    	String sql="select answer from manto where id=?";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, id);
    	
    	ResultSet rs=pstmt.executeQuery();
    	rs.next();
    	out.print(rs.getString("answer").replace("\r\n","<br>"));
    }
    
    public void delete(HttpServletRequest request,HttpServletResponse response)throws Exception
    {
    	String id=request.getParameter("id");
    	String table=request.getParameter("table");
    	

    	if(table.equals("tour"))
    	{
        	//그림파일삭제  
        	TourDao tdao=new TourDao();
    	    tdao.getFname(id, request);
    	}
    	else
    	{	
    	String sql="delete from "+table+" where id=?";
    		
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, id);
    	
    	
    	pstmt.executeUpdate();
    	pstmt.close();
    	conn.close();
    	
    	//이동
    	switch(table)
    	{
    	    case "gongji" : response.sendRedirect("glist.jsp"); break;
    	    case "board"  : response.sendRedirect("blist.jsp"); break;
    	    case "tour"   :	response.sendRedirect("tlist.jsp"); break;
    	}
    	
    	
    
      }
    }
    
    public void admin_reserve(HttpServletRequest request)throws Exception
    {
    	String sql="select r1.* , r2.name from reserve as r1, room as r2 where r1.room_id=r2.id";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	ResultSet rs=pstmt.executeQuery();
    	
    	// rs=> dto=>ArrayList
    	ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
    	
    	while(rs.next())
    	{
    		ReserveDto rdto=new ReserveDto();
    		rdto.setId(rs.getInt("id"));
    		rdto.setInday(rs.getString("inday"));
    		rdto.setOutday(rs.getString("outday"));
    		rdto.setUserid(rs.getString("userid"));
    		rdto.setChacol(rs.getInt("chacol"));
    		rdto.setBbq(rs.getInt("bbq"));
    		rdto.setTprice(rs.getInt("tprice"));
    		rdto.setName(rs.getString("name"));
    	    // 입실일, 퇴실일 이용하여 숙박일수 구하기
    		long day=MyJob.getUntil(rs.getString("inday"), rs.getString("outday"));
    	    rdto.setSuk(day);
    	    
    		rlist.add(rdto);
    	}
    	request.setAttribute("rlist", rlist);
    }
    
    public void getInfo(HttpServletRequest request, JspWriter out)throws Exception
    {
    	String userid=request.getParameter("userid");
    	
    	String sql="select sum(tprice) as hap , count(*) as cnt from reserve where userid=?";
    	//where 대신에 group by userid => 회우너별
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, userid);
    	
    	ResultSet rs=pstmt.executeQuery();
    	rs.next();
    	
    	out.print(" 총 금액 : "+MyJob.comma(rs.getInt("hap"))+"원");
    	out.print("<p>");
    	out.print(" 예약횟수 : "+rs.getInt("cnt")+"회");
    	
    }
    
    public void admin_room(HttpServletRequest request)throws Exception
    {
    	String sql="select *from room order by min asc";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	ResultSet rs=pstmt.executeQuery();
    	
    	ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
    	while(rs.next())
    	{
    		RoomDto rdto=new RoomDto();
    		rdto.setName(rs.getString("name"));
    		rdto.setId(rs.getInt("id"));
    		rdto.setRimg(rs.getString("rimg"));
    		rdto.setPrice(rs.getInt("price"));
    		rdto.setMin(rs.getInt("min"));
    		rdto.setMax(rs.getInt("max"));
    		rdto.setContent(rs.getString("content"));
    		rdto.setWriteday(rs.getString("writeday"));
    		
    		rlist.add(rdto);
    	}
    	
    	request.setAttribute("rlist", rlist);
    	
    }
    
    //객실관련 메소드
    public void room_add_ok(HttpServletRequest request,
    		HttpServletResponse response) throws Exception
    {
    	String path=request.getRealPath("/room/img");
    	int size=1024*1024*10;
    	MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());

    	String name=multi.getParameter("name");
    	String rimg=multi.getFilesystemName("fname1");
    	rimg=rimg+","+multi.getFilesystemName("fname2");
    	rimg=rimg+","+multi.getFilesystemName("fname3")+",";   //  " 1.jpg , 2.jpg , 3.jpg , "
    	
    	//fname=fname.replace("null","");  // " null , 1.jpg , 2.jpg , "  => " , 1.jpg , 2.jpg "
    	rimg=rimg.replace("null,","");  //  " 1.jpg , 2.jpg , null, "   => 
    	
    	String price=multi.getParameter("price");
    	String min=multi.getParameter("min");
    	String max=multi.getParameter("max");
    	String content=multi.getParameter("content");
    	
    	String sql="insert into room(name,rimg,price,min,max,content,writeday) ";
    	sql=sql+" values(?,?,?,?,?,?,now())";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, name);
    	pstmt.setString(2, rimg);
    	pstmt.setString(3, price);
    	pstmt.setString(4, min);
    	pstmt.setString(5, max);
    	pstmt.setString(6, content);
    	pstmt.executeUpdate();
    	
    	pstmt.close();
    	conn.close();
    	
    	response.sendRedirect("admin_room.jsp");
    }
    
    public void room_update(HttpServletRequest request)throws Exception
    {
    	String id=request.getParameter("id");
    	
    	String sql="select * from room where id=?";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, id);
    	
    	ResultSet rs=pstmt.executeQuery();
    	rs.next();
    	
    	RoomDto rdto=new RoomDto();
		rdto.setName(rs.getString("name"));
		rdto.setId(rs.getInt("id"));
		rdto.setRimg(rs.getString("rimg"));
		rdto.setPrice(rs.getInt("price"));
		rdto.setMin(rs.getInt("min"));
		rdto.setMax(rs.getInt("max"));
		rdto.setContent(rs.getString("content"));
		rdto.setWriteday(rs.getString("writeday"));
		
		request.setAttribute("rdto", rdto);
    }
    
    public void room_update_ok(HttpServletRequest request, HttpServletResponse response)throws Exception
    {
    	String path=request.getRealPath("/room/img");
    	int size=1024*1024*10;
    	MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
    	
    	// 삭제할 그림을 삭제하기
    	String[] delimg=multi.getParameter("delimg").split(",");    //" 그림파일명, 그림파일명  , " 
    	for(int i=0; i<delimg.length;i++)
    	{
    		//delimg배열에 있는 값을 하나씩 꺼내서 삭제
    		File file=new File(path+"/"+delimg[i]);
    		if(file.exists())
    			file.delete();
    		
    	}
    	
    	// 새로 추가된 그림 + 존재할 그림
    	String eximg=multi.getParameter("eximg");   // 존재할 그림  "  그림파일명, 그림파일명, "
    	
    	Enumeration<String> enu=multi.getFileNames();
    	String chuga="";
    	while(enu.hasMoreElements())    //multi.getFilesystemName("type=file의 name")
    	{
    		chuga=chuga+multi.getFilesystemName(enu.nextElement().toString())+",";
    	}
    	chuga=chuga.replace("null,", "");
    	
    	String rimg=chuga+eximg;
    	String id=multi.getParameter("id");
    	String name=multi.getParameter("name");
    	String price=multi.getParameter("price");
    	String min=multi.getParameter("min");
    	String max=multi.getParameter("max");
    	String content=multi.getParameter("content");
    	
    	// 수정하는 동작
    	String sql="update room set name=?,rimg=?,price=?,min=?,max=?,content=? where id=?";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, name);
    	pstmt.setString(2, rimg);
    	pstmt.setString(3, price);
    	pstmt.setString(4, min);
    	pstmt.setString(5, max);
    	pstmt.setString(6, content);
    	pstmt.setString(7, id);
    	
    	pstmt.executeUpdate();
    	
    	pstmt.close();
    	conn.close();
    	
    	response.sendRedirect("admin_room.jsp");
    	
    }
    
    public void admin_event_add_ok(HttpServletRequest request, HttpServletResponse response)throws Exception
    {
    	String path=request.getRealPath("/event/img");
    	int size=1024*1024*10;
    	MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
    
    	String title=multi.getParameter("title");
    	String img=multi.getFilesystemName("img");
    	
    	String sql="insert into event(title,img,writeday) ";
    	sql=sql+" values(?,?,now())";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, title);
    	pstmt.setString(2, img);
    	
    	pstmt.executeUpdate();
    	
    	pstmt.close();
    	conn.close();
    	
    	response.sendRedirect("admin_event_list.jsp");
    }
    
    public void main_list(HttpServletRequest request)throws Exception
    {
    	//String sql="select *from event order by id desc limit 4";
    	String sql="select *from event order by id desc";
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	ResultSet rs=pstmt.executeQuery();
    	
    	ArrayList<EventDto> elist=new ArrayList<EventDto>();
    	while(rs.next())
    	{
    		EventDto edto=new EventDto();
    		edto.setId(rs.getInt("id"));
    		edto.setImg(rs.getString("img"));
    		
    		elist.add(edto);
    	}
    	request.setAttribute("elist",elist);
    }
    
    public void admin_event_list(HttpServletRequest request) throws Exception
    {
    	String sql="select * from event order by id desc";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	ResultSet rs=pstmt.executeQuery();
    	
    	ArrayList<EventDto> elist=new ArrayList<EventDto>();
    	while(rs.next()) 
    	{
    		EventDto edto=new EventDto();
    		edto.setId(rs.getInt("id"));
    		edto.setImg(rs.getString("img"));
    		edto.setTitle(rs.getString("title"));
    		edto.setWriteday(rs.getString("writeday"));
    		
    		elist.add(edto);
    	}
    	request.setAttribute("elist", elist);
    }
    
    public void event_delete(HttpServletRequest request, HttpServletResponse response)throws Exception
    {
    	String id=request.getParameter("id");
    	
    	String sql="delete from event where id=?";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, id);
    	
    	pstmt.executeUpdate();
    	
    	pstmt.close();
    	conn.close();
    	
    	response.sendRedirect("admin_event_list.jsp");
    }
    
    public void member_delete(HttpServletRequest request, HttpServletResponse response)throws Exception
    {
    	String id=request.getParameter("id");
    	
    	String sql="delete from member where id=?";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, id);
    	
    	pstmt.executeUpdate();
    	pstmt.close();
    	conn.close();
    	
    	response.sendRedirect("admin_member.jsp");
    }
    
    public void reserve_delete(HttpServletRequest request, HttpServletResponse response)throws Exception
    {
    	String id=request.getParameter("id");
    	
    	String sql="delete from reserve where id=?";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, id);
    	
    	pstmt.executeUpdate();
    	pstmt.close();
    	conn.close();
    	
    	response.sendRedirect("admin_reserve.jsp");
    	
    	
    }
 
 } 
    /*
    	if(session.getAttribute("userid")==null || !(session.getAttribute("userid").equals("admin")) )
    	{
    		response.sendRedirect("../main/main.jsp");
    	}
    	else
    	{
    		
    	}
    */


