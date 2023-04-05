<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@page import="pension.dao.ReserveDao" %>
<%@page import="pension.dto.RoomDto"%>
<%@page import="util.MyJob" %>
<%
     ReserveDao rdao=new ReserveDao();
     rdao.getRoom(request);
     RoomDto rdto=(RoomDto)request.getAttribute("rdto");
%>

 <style>
    #section{
        width : 1000px;
        height : 700px;
        margin : auto;   
    }
 </style>
 <script>
   function zoom_chg(my)  //my : 작은그림의 파일
   {
	   document.getElementById("zoom").src=my;
   }
 </script>
 <div id="section">
   <table width="700" align="center">
      <caption><h3> <%=rdto.getName()%> 객실보기</h3></caption>
      <tr>
        <td colspan="4" align="center">
        
        <%
        String imsi;
        if(rdto.getRimg().equals(""))
        	imsi=",";
        else
          imsi=rdto.getRimg();
        
        String[] img=imsi.split(",");
        
        if(img.length>0)
        {	
        %>
         <div><img  id="zoom" src="img/<%=img[0]%>" width="400" height="300"></div>  <!-- 큰그림 -->
         <%
        }  
           for(int i=0;i<img.length;i++)
           {
         %>
           <img src="img/<%=img[i]%>" width="50" height="40" onclick="zoom_chg(this.src)">
         <%
           }
         %>
         </td>  
       </tr>
       <tr>  
         <td> 객실명 </td>
         <td><%=rdto.getName()%></td>
         <td> 1박 가격 </td>
         <td> <%=MyJob.comma(rdto.getPrice())%>원 </td>
      </tr>
      <tr>
         <td> 기준인원 </td>
         <td> <%=rdto.getMin()%> </td>
         <td> 최대인원 </td>
         <td> <%=rdto.getMax()%> </td>
      </tr>
      <tr>
         <td> 객실 정보 </td>
         <td colspan="3">
            <%=rdto.getContent().replace("\r\n", "<br>") %>
          </td>
      </tr>            
   </table>

 </div>


 <%@include file="../bottom.jsp"%>