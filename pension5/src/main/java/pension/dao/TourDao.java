package pension.dao;


import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pension.dto.GongjiDto;
import pension.dto.TourDto;

public class TourDao {
	
	
	Connection conn;
	public TourDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver"); 
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void tour_write_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{
		String path=request.getRealPath("/tour/img");
		int size=1024*1024*10;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		//���ε� ������ ������ �ȴٸ�
		/*
		 * String f1=multi.getFilesystemName("fname1");  //input type="file" name="fname1"
		 * String f2=multi.getFilesystemName("fname2");
		 * String f3=multi.getFilesystemName("fname3");
		 * String f4=multi.getFilesystemName("fname4");
		 */
		
	   Enumeration file=multi.getFileNames();  //input type="file"�� name�� ���� �� �����´�. why? ���� ����� �𸣱� ������
	   // ( "fname1" , "fname2" , "fname3" , "fname4" , "fname5" )
	   
	   String fname="";
	   while(file.hasMoreElements())
	   {
		   // multi.getFilesystemName("fname1") ~~~ fname2, fname3
		   fname=fname+multi.getFilesystemName(file.nextElement().toString())+",";  //input �±��� name		   
	   }
	   
	   //System.out.println(fname);  //1.jpg, 2.jpg, 3.jpg, 4.jpg (,)�� ����
	   fname=fname.replace("null,", "");
	   // ���̺� ������ ��
	   String title=multi.getParameter("title");
	   String content=multi.getParameter("content");
	   String userid=session.getAttribute("userid").toString();
	   
	   //���� ����
	   String sql="insert into tour(title, content, fname, userid, writeday) values(?,?,?,?,now())";
	   
	   //�ɺθ��ۻ���
	   PreparedStatement pstmt=conn.prepareStatement(sql);
	   pstmt.setString(1, title);
	   pstmt.setString(2, content);
	   pstmt.setString(3, fname);
	   pstmt.setString(4, userid);
	   
	   pstmt.executeUpdate();
	   
	   pstmt.close();
	   conn.close();
	   
	   response.sendRedirect("tour_list.jsp");
	  
	    
	}
	
	public void tour_list(HttpServletRequest request)throws Exception
	{
		// ������
		String sql="select t.id, t.title, m.name, t.readnum, t.writeday from member as m, tour as t";
		sql=sql+ " where m.userid=t.userid order by t.id desc";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		
		ResultSet rs=pstmt.executeQuery();
		
		// rs=> dto(ArrayList�� �̿�)
		
		ArrayList<TourDto> tlist=new ArrayList<TourDto>();
		
		while(rs.next())
		{
			TourDto tdto=new TourDto();
			tdto.setId(rs.getInt("id"));
			tdto.setTitle(rs.getString("title"));
			tdto.setName(rs.getString("name"));
			tdto.setReadnum(rs.getInt("readnum"));
			tdto.setWriteday(rs.getString("writeday"));
			
			tlist.add(tdto);
		}
		request.setAttribute("tlist", tlist);
	}
	
	public void tour_readnum(HttpServletRequest request, HttpServletResponse response)throws Exception
	{
		String id=request.getParameter("id");
		String sql="update tour set readnum=readnum+1 where id=?";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		response.sendRedirect("tour_content.jsp?id="+id);
	}
	
	public void tour_content(HttpServletRequest request)throws Exception
	{
		    String id=request.getParameter("id");
		    String sql="select*from tour where id=?";
		    PreparedStatement pstmt=conn.prepareStatement(sql);
		    pstmt.setString(1, id);
		
		    ResultSet rs=pstmt.executeQuery();
		    rs.next();
   
			TourDto tdto=new TourDto();
			tdto.setId(rs.getInt("id"));
			tdto.setTitle(rs.getString("title"));
			
			String userid=rs.getString("userid");  //"abcdefgh"
	        int len=userid.length()-4;             // 4
	        userid=userid.substring(0,4);          // "abcd"
	        for(int i=0;i<len;i++)
	        {
	        	userid=userid+"*";                 //"abcd******"
	        }
	        
			tdto.setUserid(userid);
			tdto.setReadnum(rs.getInt("readnum"));
			tdto.setWriteday(rs.getString("writeday"));
			tdto.setContent(rs.getString("content"));
			//tdto.setFname(rs.getString("fname"));
			
			//�׸������̸� ������
			String[] fname=rs.getString("fname").split(",");
			request.setAttribute("fname", fname);
			
			request.setAttribute("tdto", tdto);
			
			// ����� ���̵� request������ �ø���
			request.setAttribute("userid", rs.getString("userid"));
		}
	
	public void tour_delete(HttpServletRequest request, HttpServletResponse response)throws Exception
	{
		String id=request.getParameter("id");

		//������ ���ڵ��� fname�ʵ��� ���� �о�ͼ� �ش� ������ ����
		getFname(id, request);

		String sql="delete from tour where id=?";
				
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		response.sendRedirect("tour_list.jsp");
	}
	
	public void getFname(String id, HttpServletRequest request)throws Exception
	{
		String sql="select fname from tour where id=?";
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		String[] fname=rs.getString("fname").split(",");
		
		String path=request.getRealPath("/tour/img");
		
		for(int i=0; i<fname.length;i++)
		{
			File file=new File(path+"/"+fname[i]);  //������ :  ���/���ϸ�
			if(file.exists())
			  file.delete();
		}
	}
	
	public void tour_update(HttpServletRequest request)throws Exception
	
	{
          String id=request.getParameter("id");
          
          String sql="select * from tour where id=?";
          
          PreparedStatement pstmt=conn.prepareStatement(sql);
          pstmt.setString(1, id);
          
          ResultSet rs=pstmt.executeQuery();
          rs.next();
          
          TourDto tdto=new TourDto();
          tdto.setId(rs.getInt("id"));
          tdto.setTitle(rs.getString("title"));
          tdto.setContent(rs.getString("content"));
          
          request.setAttribute("tdto", tdto);
          
          // file���� ,�� ���е� ���� split���� ó���Ͽ� �迭�� ����..
          String[] fname=rs.getString("fname").split(",");
          request.setAttribute("fname", fname);
	
		
	}
	
	public void tour_update_ok(HttpServletRequest request, HttpServletResponse response)throws Exception
	{
		/*
		 * String delimg=request.getParameter("delimg"); String
		 * eximg=request.getParameter("eximg");
		 enctype�� request �ȵ�.
		 */
	
		/*
		 * String delimg=request.getParameter("delimg"); String
		 * eximg=request.getParameter("eximg");
		 * 
		 * System.out.println(delimg); System.out.println(eximg);
		 */
		
		// ���� ���ε� ��ü ����
    	String path=request.getRealPath("/tour/img");
    	int size=1024*1024*10;
    	MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
    	
    	//������ �׸�
    	String[] delimg=multi.getParameter("delimg").split(","); //"1.jpg, 2.jpg"
    	for(int i=0; i<delimg.length;i++)
    	{
    		File file=new File(path+"/"+delimg[i]);
    		if(file.exists())
    			file.delete();
    	}
    	
    	// ������ �׸� + �߰� �׸� => "���ϸ�, ���ϸ�, "
    	Enumeration enu=multi.getFileNames();  //"fname1 fname2 fname3 "input type="file"�� name�� �о�´�..
    	
    	// ����� ������ �̸��� ���ϱ� => multi.getFilessystemName("fname1")
    	String chuga="";
    	while(enu.hasMoreElements())
    	{
    		
    		chuga=chuga+multi.getFilesystemName(enu.nextElement().toString())+",";
    		
    	}
    	
    	chuga=chuga.replace("null,", "");  //�׸��� ������ ���ϸ� => null���� ���ϱ� null ���� ���ֱ� 
    			
    	System.out.println(chuga);
    	
    	String eximg=multi.getParameter("eximg");
    	
    	String fname=eximg+chuga;  //������ �׸� + �߰��� �׸� �̸���
    	
    	String id=multi.getParameter("id");
    	String title=multi.getParameter("title");
    	String content=multi.getParameter("content");
    	
    	String sql="update tour set title=?, content=?, fname=? where id=?";
    	
    	PreparedStatement pstmt=conn.prepareStatement(sql);
    	pstmt.setString(1, title);
    	pstmt.setString(2, content);
    	pstmt.setString(3, fname);
    	pstmt.setString(4, id);
    	
    	pstmt.executeUpdate();
    	
    	pstmt.close();
    	conn.close();
    	
    	response.sendRedirect("tour_content.jsp?id="+id);
	}
	
	public void getFour(HttpServletRequest request)throws Exception
	{
		String sql="select * from tour order by id desc limit 4";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<TourDto> tlist=new ArrayList<TourDto>();
		
		while(rs.next())
		{
			TourDto tdto=new TourDto();
			tdto.setId(rs.getInt("id"));
			String title;
			if(rs.getString("title").length()>16)
			{
			    title=rs.getString("title").substring(0,16)+"...";	
			}
			else
				title=rs.getString("title");
			tdto.setTitle(title);
			tdto.setWriteday(rs.getString("writeday"));
			
			tlist.add(tdto);
			
		}
		
		request.setAttribute("tlist", tlist);
		
	}

}
