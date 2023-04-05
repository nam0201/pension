<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<!-- reserve_view.jsp -->
   <style>
        #section{
          width : 1000px;
          height : 500px;
          margin : auto; 
          margin-top: 50;
          border : 1px solid #724C00;
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
   <%@page import="pension.dao.ReserveDao" %>
   <%@page import="pension.dto.ReserveDto" %>
   <%
       ReserveDao rdao=new ReserveDao();
       rdao.reserve_view(request);
       
       ReserveDto rdto=(ReserveDto)request.getAttribute("rdto");
   %>
    <div id="section">
      <table width="800" align="center" border="1px">
         <caption><h3>예약 내용이오</h3></caption>
        <tr align="center">
           <td> 주문코드 </td>
           <td> 객실명 </td>
           <td> 입실일 </td>
           <td> 퇴실일 </td>
           <td> 입실인원 </td>
           <td> 숯불패키지 </td>
           <td> bbq패키지 </td>
           <td> 총결제금액 </td>
         </tr>
         <tr align="center">
            <td> <%=rdto.getJcode() %></td>
            <td> <%=rdto.getName()%> </td>
           <td> <%=rdto.getInday()%>  </td>
           <td> <%=rdto.getOutday()%>  </td>
           <td> <%=rdto.getInwon()%>  </td>
           <td> <%=rdto.getChacol()%>  </td>
           <td> <%=rdto.getBbq()%>  </td>
           <td> <%=rdto.getTprice()%>  </td> 
         </tr>  
      </table>

    </div>


 <%@include file="../bottom.jsp"%>