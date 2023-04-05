package pension.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pension.dto.Board_Dto;
import pension.dto.GongjiDto;



public class BoardDao {

	 Connection conn;
	 public BoardDao()throws Exception 
     {
    	Class.forName("com.mysql.jdbc.Driver"); 
 		String db="jdbc:mysql://localhost:3306/pension";
 		conn=DriverManager.getConnection(db,"root","1234");
     }
	 
	  public void board_write_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception
	  {
		  request.setCharacterEncoding("utf-8");
		  String title=request.getParameter("title");
		  String name=request.getParameter("name");
		  String pwd=request.getParameter("pwd");
		  String content=request.getParameter("content");
		  String[] imsi=request.getParameterValues("dest");
		  String dest="";
		  for(int i=0; i<imsi.length;i++)
		  {
			  dest=dest+imsi[i]+",";
		  }
		  
		  //사용자의 아이디를 체크
		  String userid;
		  if(session.getAttribute("userid")==null)
		  {
			  userid="guest";
		  }
		  else
		  {
			  userid=session.getAttribute("userid").toString();
		  }
		  
		  String sql="insert into board(title,name,pwd,content,dest,writeday,userid)";
				 sql=sql+" values(?,?,?,?,?,now(),?)";
		  
		  PreparedStatement pstmt=conn.prepareStatement(sql);
		  pstmt.setString(1, title);
		  pstmt.setString(2, name);
		  pstmt.setString(3, pwd);
		  pstmt.setString(4, content);
		  pstmt.setString(5, dest);
		  pstmt.setString(6, userid);
		  
		  pstmt.executeUpdate();
		  pstmt.close();
		  conn.close();
		  response.sendRedirect("board_list.jsp");
	  }
	  
	  public void board_readnum(HttpServletRequest request, HttpServletResponse response)throws Exception
	  {
		  String id=request.getParameter("id");
		  String sql="update board set readnum=readnum+1 where id=?";
		  
		  PreparedStatement pstmt=conn.prepareStatement(sql);
		  
		  pstmt.setString(1, id);
		  
		  pstmt.executeUpdate();
		  
		  pstmt.close();
		  conn.close();
		  
		  response.sendRedirect("board_content.jsp?id="+id);
	  }
	  
	  public ResultSet board_list(HttpServletRequest request)throws Exception
	  {
		  int pager;
		  if(request.getParameter("pager")==null)
			  pager=1;
		  else
			  pager=Integer.parseInt(request.getParameter("pager"));
		  
		  int index=(pager-1)*10;
		  
		  String sql="select *from board order by id desc limit ?,10";
		  
		  PreparedStatement pstmt=conn.prepareStatement(sql);
		  pstmt.setInt(1, index);
		  
		  ResultSet rs=pstmt.executeQuery();
		  
		  return rs;
	  }
	  
	  public int getPstart(HttpServletRequest request)
	  {
		  int pager;
		  if(request.getParameter("pager")==null)
			  pager=1;
		  else
			 pager=Integer.parseInt(request.getParameter("pager"));
		  
		  int imsi=pager/10;
		  
		  if(pager%10 ==0)
			  imsi=imsi-1;
		  
		  int pstart=imsi*10+1;
		  
		  return pstart;
	  }
	  
	  public int getPage(HttpServletRequest request)
	  {
		  int pager;
		  if(request.getParameter("pager")==null)
			  pager=1;
		  else
			  pager=Integer.parseInt(request.getParameter("pager"));
		  return pager;
	  }
	  
	  public int getPend(int pstart, int chong)
	  {
		  int pend=pstart+9;
		  
		  if(chong < pend)
			  pend=chong;
		  return pend;
	  }
	  public int getChong() throws Exception
	  {
		 String sql="select ceil( count(*)/10 )as chong from board";
		 PreparedStatement pstmt=conn.prepareStatement(sql);
		 ResultSet rs=pstmt.executeQuery();
		 rs.next();
		 int chong=rs.getInt("chong");
		 return chong;
	  }
	  
	  public void board_content(HttpServletRequest request)throws Exception
	  {
		  request.setCharacterEncoding("utf-8");
		  
		  String id=request.getParameter("id");
		  
		  String sql="select*from board where id=?";
		  
		  PreparedStatement pstmt=conn.prepareStatement(sql);
		  pstmt.setString(1, id);
		  
		  ResultSet rs=pstmt.executeQuery();
		  rs.next();
	      
		  Board_Dto bdto=new Board_Dto();
		  bdto.setId(rs.getInt("id"));
	      bdto.setName(rs.getString("name"));
	      bdto.setReadnum(rs.getInt("readnum"));
	      bdto.setContent(rs.getString("content"));
	      bdto.setTitle(rs.getString("title"));
	      bdto.setWriteday(rs.getString("writeday"));
	      bdto.setUserid(rs.getString("userid"));
	      
	      String[] imsi=rs.getString("dest").split(",");
		  	 String dest="";
		  	 for(int i=0;i<imsi.length;i++)
		  	 {
		  	  switch(imsi[i])	    	
		  	   {
		  	      case "0" : dest=dest+"전주 " ; break;
		  	      case "1" : dest=dest+"광주 " ; break;
		  	      case "2" : dest=dest+"속초 " ; break;
		  	      case "3" : dest=dest+"부산 " ; break;
		  	      case "4" : dest=dest+"대구 " ; break;
		  	      case "5" : dest=dest+"강릉 " ; break;
		  	      case "6" : dest=dest+"제주 " ; break;
		  	      case "7" : dest=dest+"포항 " ; break;
		            default : dest=dest+"" ;
		  	   }
		  	}
		  	 bdto.setDest(dest);
	      request.setAttribute("bdto", bdto);
	      
	      rs.close();
	      pstmt.close();
	      conn.close();
  
	  }
	  public void board_update(HttpServletRequest request)throws Exception
	  {
		  String id=request.getParameter("id");
		  
		  String sql="select*from board where id=?";
		  
		  PreparedStatement pstmt=conn.prepareStatement(sql);
		  pstmt.setString(1, id);
		  
		  ResultSet rs=pstmt.executeQuery();
		  rs.next();
		  
		  Board_Dto bdto=new Board_Dto();
		  bdto.setId(rs.getInt("id"));
		  bdto.setTitle(rs.getString("title"));
		  bdto.setReadnum(rs.getInt("readnum"));
		  bdto.setName(rs.getString("name"));
		  bdto.setContent(rs.getString("content"));
		  bdto.setDest(rs.getString("dest"));
		  bdto.setWriteday(rs.getString("writeday"));
		  bdto.setUserid(rs.getString("userid"));
		  
		  request.setAttribute("bdto", bdto);
		  
		  rs.close();
		  pstmt.close();
		  conn.close();
	  }
	 
	  
	  public void board_update_ok(HttpServletRequest request, HttpServletResponse response)throws Exception
	  {
		  request.setCharacterEncoding("utf-8");
		  String id=request.getParameter("id");
		  String pwd=request.getParameter("pwd");
		  String title=request.getParameter("title");
		  String name=request.getParameter("name");
		  String content=request.getParameter("content");
		  String[] imsi=request.getParameterValues("dest");
		  String dest="";
		     for(int i=0;i<imsi.length;i++)
			 {
		    	dest=dest+imsi[i]+",";
		     }
		  if(pwd==null || isPwdCheck(id,pwd))
		  {	   
		  String sql="update board set title=?, name=?, content=?, dest=? where id=?";
	       
	      PreparedStatement pstmt=conn.prepareStatement(sql);
		  
		  pstmt.setString(1,title);
		  pstmt.setString(2, name);
		  pstmt.setString(3, content);
		  pstmt.setString(4, dest);
		  pstmt.setString(5, id);
		  
		  pstmt.executeUpdate();
		  pstmt.close();
		  conn.close();
		  
		  response.sendRedirect("board_content.jsp?id="+id);
		  }
		  else
		  {
			  conn.close();
			  response.sendRedirect("board_update.jsp?id="+id);
		  }
	  }
	  
	  public void board_delete(HttpServletRequest request, HttpServletResponse response)throws Exception
	  {
		  String id=request.getParameter("id");
	      String pwd=request.getParameter("pwd");
	  
	      if(pwd==null || isPwdCheck(id,pwd))
	      {
	    	  String sql="delete from board where id=?";
	    	  PreparedStatement pstmt=conn.prepareStatement(sql);
	    	  pstmt.setString(1,id);
	    	  
	    	  pstmt.executeUpdate();
	    	  pstmt.close();
	    	  conn.close();
	    	 
	    	  response.sendRedirect("board_list.jsp");
	      }
	      else
	      {
	    	  conn.close();
	    	  response.sendRedirect("board_content.jsp?id="+id);
	      }
	  }
	  
	  public boolean isPwdCheck(String id,String pwd) throws Exception
		{
			String sql="select pwd from board where id=?";
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,id);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			String xpwd=rs.getString("pwd");
			
			if(pwd.equals(xpwd))
				return true;
			else
				return false;
		}
	  
	  public void getFour(HttpServletRequest request)throws Exception
		{
			String sql="select * from board order by id desc limit 4";
			
			PreparedStatement pstmt=conn.prepareStatement(sql);
			ResultSet rs=pstmt.executeQuery();
			
			ArrayList<Board_Dto> blist=new ArrayList<Board_Dto>();
			
			while(rs.next())
			{
				Board_Dto bdto=new Board_Dto();
				bdto.setId(rs.getInt("id"));
				
				String title;
				if(rs.getString("title").length()>16)
				{
				    title=rs.getString("title").substring(0,16)+"...";	
				}
				else
					title=rs.getString("title");
				bdto.setTitle(title);
				bdto.setWriteday(rs.getString("writeday"));
				
				blist.add(bdto);
				
			}
			
			request.setAttribute("blist", blist);
			
		}
}
