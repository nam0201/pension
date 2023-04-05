<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- list.jsp -->
<%@page import="pension.dao.TourDao" %>
<%@page import="java.util.ArrayList" %>
<%@page import="pension.dto.TourDto" %>
<%@include file="admin_top.jsp"%>
<%
    TourDao tdao=new TourDao();
    tdao.tour_list(request);
    
    ArrayList<TourDto> tlist=(ArrayList<TourDto>)request.getAttribute("tlist");
%>
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
     }
     #section #write:hover
     {
     background : white;
     }
 </style>
 <div id="section">

   <table width="800" align="center">
      <caption><h3>여행 후기</h3></caption>
     <tr align="center">
       <td> 제목 </td>
       <td> 작성자 </td>
       <td> 조회수 </td>
       <td> 작성일 </td>
       <td> 삭제 </td>
     </tr>
     <%
      for(int i=0; i<tlist.size();i++)
      {	  
     %>
      <tr align="center">
        <td><a href="../tour/tour_readnum.jsp?id=<%=tlist.get(i).getId()%>"> <%=tlist.get(i).getTitle()%> </a> </td>
        <td> <%=tlist.get(i).getName()%> </td>  
        <td> <%=tlist.get(i).getReadnum()%> </td>  
        <td> <%=tlist.get(i).getWriteday()%> </td>
        <td> <a href="delete.jsp?table=tour&id=<%=tlist.get(i).getId()%>"> click </a> </td>    
      </tr>
     <%
      }
     %> 
     
  
   </table>

</div>


