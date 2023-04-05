<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@page import="pension.dao.ReserveDao" %>
<%@page import="java.util.ArrayList" %>
<%@page import="pension.dto.ReserveDto" %>
<%@page import="java.text.DecimalFormat" %>
<%
    ReserveDao rdao=new ReserveDao();
    rdao.reserve_all(session, request);
    
    ArrayList<ReserveDto> rlist=(ArrayList<ReserveDto>)request.getAttribute("rlist");
%>
<!-- reserve all -->

 <style>
    #section{
        width : 1000px;
        height : 500px;
        margin : auto;   
    }
 </style>
 <div id="section">
    <table width="800" align="center" border="1px">
         <caption><h3>예약 현황</h3></caption>
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
         <%
          for(int i=0;i<rlist.size();i++)
          {	  
        	  DecimalFormat df=new DecimalFormat("#,###");
        	  String tprice=df.format(rlist.get(i).getTprice());
         %>
         <tr align="center">
            <td> <%=rlist.get(i).getJcode() %></td>
            <td> <%=rlist.get(i).getName() %> </td>
           <td> <%=rlist.get(i).getInday()%>  </td>
           <td> <%=rlist.get(i).getOutday( )%>  </td>
           <td> <%=rlist.get(i).getInwon()%>  </td>
           <td> <%=rlist.get(i).getChacol()%>  </td>
           <td> <%=rlist.get(i).getBbq()%>  </td>
           <td align="right"> <%=tprice%>  </td> 
         </tr>
         <%
          }
         %>  
      </table>
  

 </div>


 <%@include file="../bottom.jsp"%>