<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongjiDao" %>
<%@page import="pension.dto.GongjiDto" %>
<%@page import="java.util.ArrayList" %>
<%

    GongjiDao gdao=new GongjiDao();
    gdao.list(request);
    
    ArrayList<GongjiDto> glist=(ArrayList<GongjiDto>)request.getAttribute("glist");
    
%> 
<%@include file="admin_top.jsp"%>
<!-- write.jsp -->
  <style>
      
      #section{
          width : 1000px;
          height : 500px;
          margin : auto; 
          margin-top: 50;
         
          background : white; 
          color : #633A00;
       }
       #section table{
         border-spacing : 0px;
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
       border-bottom:1px solid #633A00;
     }
     #section table tr:first-child td {
       border-top:2px solid #633A00;
       font-weight:900;
     }
   #section table tr:last-child td {
     border-bottom:2px solid #633A00;
   }
   #section a {
     color:#633A00;
  
  </style>
  
   <div id="section">
       <table width="700" align="center">
         <caption><h3> 공지사항 </h3></caption>
         <tr align="center">
            <td> 제목 </td>
            <td> 작성자 </td>
            <td> 조회수 </td>
            <td> 작성일 </td>
             <td>삭제 </td>           
          </tr>
          
         <%
         for(int i=0;i<glist.size();i++)
         {
        	 String imsi="";
        	 if(glist.get(i).getChk()==1)
        		 imsi="<b style='color:red;'>[공지]</b>";
         
         %>
         <tr align="center">
           <td><a href="../gongji/readnum.jsp?id=<%=glist.get(i).getId()%>"><%=imsi %> <%=glist.get(i).getTitle()%></a> </td>
           <td> 관리자 </td>
           <td> <%=glist.get(i).getReadnum() %></td>
           <td> <%=glist.get(i).getWriteday()%> </td>
           <td> <a href="delete.jsp?table=gongji&id=<%=glist.get(i).getId()%>">click</a> </td>
          </tr>
        <%
         }
        %>
        
        <%
           //관리자만 볼 수 있게
         if(session.getAttribute("userid")!=null)
         {	 
           if(session.getAttribute("userid").equals("admin"))
           {   
        %> 
        <tr>
          <td colspan="5" align="center">
            <a href="write.jsp">공지사항 글쓰기</a>
           </td>
        </tr>
        <%
         }
       }   
        %>

  
       </table>
    
    </div>
