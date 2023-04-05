<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %> 
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.EventDto" %>
<%@page import="java.util.ArrayList" %>
<%
    AdminDao adao=new AdminDao();
    adao.admin_event_list(request);
    ArrayList<EventDto> elist=(ArrayList<EventDto>)request.getAttribute("elist");
%>
<style>
 #section {
   width:780px;
   height:500px;
   margin:auto;
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
     border-bottom:1px solid #633A00;
   }
   #section table tr:first-child td {
     border-top:2px solid #633A00;
 
   }
   #section table tr:last-child td {
     border-bottom:2px solid #633A00;
   }
   #section a {
     color:#633A00;
   }
</style>
 <div id="section">
   <table width="600" align="center">
     <caption> <h3> 이벤트 현황 </h3></caption>
     <tr>
       <td> 이벤트 개요 </td>
       <td> 이벤트 사진 </td>
       <td> 등록일 </td>
       <td> 삭제 </td>
     </tr>
    <%
    for(int i=0;i<elist.size();i++)
    {
    %>
     <tr>
       <td> <%=elist.get(i).getTitle()%> </td>
       <td> <img src="../event/img/<%=elist.get(i).getImg()%>" width="50"> </td>
       <td> <%=elist.get(i).getWriteday() %> </td>
       <td> <a href="event_delete.jsp?id=<%=elist.get(i).getId()%>">click</a>
     </tr>
    <%
    }
    %>
    <tr>
      <td colspan="3" align="center"><a href="admin_event_add.jsp"> 이벤트 글쓰기 </a></td>
    </tr>  
   </table>
 
 </div>
</body>
</html>