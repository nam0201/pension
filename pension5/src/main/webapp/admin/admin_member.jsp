<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.MemberDto" %>
<%@page import="java.util.ArrayList" %>
<%
if(session.getAttribute("userid")==null || !(session.getAttribute("userid").equals("admin")) )
    {
    	response.sendRedirect("../main/main.jsp");
    }
    else
    {	
   AdminDao adao=new AdminDao();
   adao.admin_member(request, session, response);
   ArrayList<MemberDto> mlist=(ArrayList<MemberDto>)request.getAttribute("mlist");
%>    
<%@ include file="admin_top.jsp" %> 
<style>
 #section {
   width:780px;
   height:500px;
   margin:auto;
   text-align:center;
  }
  #section table {
     border-spacing:0px;
   }
   #section table tr:hover {
      background:#eeeeee;
   }
   #section table tr:first-child:hover {
      background:white;
   }
   #section table td {
     height:30px;
     font-size:13px;
   }
   #section table td {
     border-bottom:1px solid #4B0700;
   }
   #section table tr:first-child td {
     border-top:2px solid #4B0700;
     font-weight:900;
   }
   #section table tr:last-child td {
     border-bottom:2px solid #4B0700;
   }
   #section a {
     color:#4B0700;
   }
</style>
 <div id="section">
   <table width="700" align="center">
    
     <caption> <h3> 회원 목록 </h3></caption>
     <tr align="center">
       <td> 사용자 아이디 </td>
       <td> 이 름 </td>
       <td> 전화번호 </td>
       <td> 가입일 </td>
       <td> 회원상태 </td>
       <td> 회원영구삭제 </td>
       <td> 탈퇴승인 </td>
     </tr>
    <%
    for(int i=0;i<mlist.size();i++)
    {
    	String state;
    	switch(mlist.get(i).getState())
    	{
    	   case 0 : state="정상회원"; break;
    	   case 1 : state="탈퇴신청중"; break;
    	   case 2 : state="탈퇴회원"; break;
    	   default : state="오류";
    	}
    %> 
     <tr>
       <td> <%=mlist.get(i).getUserid()%> </td>
       <td> <%=mlist.get(i).getName()%> </td>
       <td> <%=mlist.get(i).getPhone()%> </td>
       <td> <%=mlist.get(i).getWriteday()%> </td>
       <td> <%=state%> </td>
       
       <td> <a href="member_delete.jsp?id=<%=mlist.get(i).getId()%>">click</a></td>
       <td>
         <%
         if(mlist.get(i).getState()==1)  //탈퇴신청한 회원만 (state필드의 값이 1인경우) 탈퇴를 누를 수 있도록 만듬 
         {	 
         %> 
           <a href="member_out_ok.jsp?id=<%=mlist.get(i).getId()%>"> 탈퇴 </a>  
            <!-- 클릭하면 member 테이블의 state필드를 2로 변경 -->
         <%
         }
         %>    
       </td>
      
     </tr>
    <%
    }
    %>
     
   </table>

 </div>
</body>
</html>
 <%
    }
 %>