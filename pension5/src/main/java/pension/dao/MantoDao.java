package pension.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pension.dto.MantoDto;

public class MantoDao {
	
	Connection conn;
	public MantoDao()throws Exception 
	{
		Class.forName("com.mysql.jdbc.Driver"); 
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void manto_write_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response)throws Exception
	{
		//request
		request.setCharacterEncoding("utf-8");
		String que=request.getParameter("que");
		String content=request.getParameter("content");
		
		String userid;
		if(session.getAttribute("userid")==null)
		   userid=request.getParameter("email");
		else
			userid=session.getAttribute("userid").toString();
		
		String sql="insert into manto(userid, que, content,writeday) values(?,?,?,now())";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, que);
		pstmt.setString(3, content);
		
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		response.sendRedirect("finish.jsp");
	}
	
	public void manto_list(HttpSession session, HttpServletRequest request)throws Exception
	{
		String userid=session.getAttribute("userid").toString();
		
		String sql="select * from manto where userid=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		
		ResultSet rs=pstmt.executeQuery();
		
		//rs => dto => ArrayList
		ArrayList<MantoDto> mlist=new ArrayList<MantoDto>();
		
		while(rs.next()) 
		{
		   	MantoDto mdto=new MantoDto();
		   	mdto.setId(rs.getInt("id"));
		   	mdto.setQue(rs.getInt("que"));
		   	mdto.setContent(rs.getString("content"));
		   	mdto.setState(rs.getInt("state"));
		   	mdto.setWriteday(rs.getString("writeday"));
		    mdto.setAnswer(rs.getString("answer"));
		    
		   	mlist.add(mdto);
		}
		
		request.setAttribute("mlist", mlist);
		
		
	}
	
	public void manto_delete(HttpServletRequest request, HttpServletResponse response)throws Exception
	{
		String id=request.getParameter("id");
		
		String sql="delete from manto where id=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("manto_list.jsp");
	}
	

}
