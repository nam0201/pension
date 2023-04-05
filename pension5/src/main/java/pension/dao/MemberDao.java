package pension.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import pension.dto.MemberDto;

public class MemberDao {
	//DB연결을 생성자를 통해서..
	
	Connection conn;
	
	public MemberDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver"); 
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void member_input_ok(HttpServletRequest request, HttpServletResponse response)throws Exception
	{
		//request값 읽기
		request.setCharacterEncoding("utf-8");
	    String userid=request.getParameter("userid");
	    String pwd=request.getParameter("pwd");
	    String phone=request.getParameter("phone");
	    String email=request.getParameter("email");
	    String name=request.getParameter("name");
		//쿼리작성
		String sql="insert into member(userid,pwd,phone,email,writeday,name)";
		sql=sql+" values(?,?,?,?,now(),?)";
		//심부름꾼 생성
	    PreparedStatement pstmt=conn.prepareStatement(sql);
	    pstmt.setString(1, userid);
	    pstmt.setString(2, pwd);
	    pstmt.setString(3, phone);
	    pstmt.setString(4, email);
	    pstmt.setString(5, name);
	   
		//쿼리실행
		pstmt.executeUpdate();
		//close
		pstmt.close();
		//이동(login)
		response.sendRedirect("login.jsp");
	}
	
	public void userid_check(HttpServletRequest request, JspWriter out) throws Exception
	{
		String userid=request.getParameter("userid");
		
		String sql="select * from member where userid=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		
		if(rs.next())  //true => 아이디가 존재
		{
			out.print("0");
		}
		else
		{
			out.print("1");
		}
		
	}
	
	public void login_ok(HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response)throws Exception
	{
		// request값 읽기
		request.setCharacterEncoding("utf-8");
	    String userid=request.getParameter("userid");
	    String pwd=request.getParameter("pwd");
	    String y=request.getParameter("y");
	    String m=request.getParameter("m");
	    String d=request.getParameter("d");
	    String id=request.getParameter("id");
	    
	    
	    String sql="select * from member where userid=?and pwd=? and state=0";
	    
	    PreparedStatement pstmt=conn.prepareStatement(sql);
	    pstmt.setString(1, userid);
	    pstmt.setString(2, pwd);
	    
	    ResultSet rs=pstmt.executeQuery();
	   
	    if(rs.next())
	    {
	    	//회원이 맞다면 => 회원으로 인증을 한다.. : 세션변수에 값을 저장
	    	session.setAttribute("userid", rs.getString("userid"));
	        session.setAttribute("name", rs.getString("name"));
	        
	        conn.close();
	        // 이동 : main이동
	        if(y.equals("null"))
			{
			   response.sendRedirect("../main/main.jsp");
			}
			else
			{	
			   response.sendRedirect("../reserve/reserve_next.jsp?y="+y+"&m="+m+"&d="+d+"&id="+id);
			}
		} 
	    else  //아이디, 비번이 잘못되었다..
	    {
	    	conn.close();
	    	response.sendRedirect("../member/login.jsp?chk=1");
	    }
	}
	
	public void logout(HttpSession session, HttpServletResponse response) throws Exception
	{
		 session.invalidate();  //하나씩 지우려면 session.remove
	     response.sendRedirect("../main/main.jsp");
	}
	
	public void member_view(HttpSession session, HttpServletRequest request)throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String userid=session.getAttribute("userid").toString();
		
		//쿼리작성
		String sql="select*from member where userid=?";
		//심부름꾼생성
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		//쿼리실행
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		//rs대신에 Dto를 이용하여 전달(request객체에 담아서)
		// 1. rs값을 Dto에 담기
		MemberDto mdto=new MemberDto();
		mdto.setUserid(rs.getString("userid"));   //매개변수로 받아서 이 클래스에 userid값을 넣어줌
		mdto.setName(rs.getString("name"));
		mdto.setPhone(rs.getString("phone"));
		mdto.setEmail(rs.getString("email"));
		mdto.setWriteday(rs.getString("writeday"));
		
		//2. request영역에 저장
		request.setAttribute("mdto", mdto);
	}
	
	public void member_update_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response)throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String phone=request.getParameter("phone");
		String email=request.getParameter("email");
		String userid=session.getAttribute("userid").toString();

		
		String sql="update member set phone=?, email=? where userid=?";
		//심부름꾼생성
		PreparedStatement pstmt=conn.prepareStatement(sql);
		
		pstmt.setString(1, phone);
		pstmt.setString(2, email);
		pstmt.setString(3, userid);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("member_view.jsp");
		
		
	}
	
	public void userid_search(HttpServletRequest request, JspWriter out)throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		
		
		String sql="select userid from member where name=? and email=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		
		
		ResultSet rs=pstmt.executeQuery();
		if(rs.next())
		{
			out.print(rs.getString("userid"));
		}
		else
		{
			out.print("");
		}
		
	}
	
	public void pwd_search(HttpServletRequest request, JspWriter out)throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String userid=request.getParameter("userid");
		
		String sql="select pwd from member where name=? and email=? and userid=?";
	    
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		pstmt.setString(3, userid);
		
		ResultSet rs=pstmt.executeQuery();
		if(rs.next())
		{
			out.print(rs.getString("pwd"));
			
		}
		else 
		{
		   out.print("2");	
		}
	}
	
	   public void member_out(HttpSession session, HttpServletResponse response)throws Exception
	    {
	    	String sql="update member set state=1 where userid=?";
	         
	    	 PreparedStatement pstmt=conn.prepareStatement(sql);
	    	 pstmt.setString(1, session.getAttribute("userid").toString());
	         
	    	 pstmt.executeUpdate();
	    	 
	    	 pstmt.close();
	    	 conn.close();
	    	 
	    	 //response.sendRedirect("logout.jsp");
	    	session.invalidate();
	    	
	    	response.sendRedirect("../main/main.jsp");
	    	
	    }
}

