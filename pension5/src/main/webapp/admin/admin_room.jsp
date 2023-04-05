<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="admin_top.jsp" %> 
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.RoomDto" %>
<%@page import="java.util.ArrayList" %>
<%@page import="util.MyJob" %>
<%
    AdminDao adao=new AdminDao();
    adao.admin_room(request);
    ArrayList<RoomDto> rlist=(ArrayList<RoomDto>)request.getAttribute("rlist");
%>
<!-- admin_room.jsp -->
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
<script>
  function view_add(n)
  {
	  //alert(document.getElementsByClassName("add")[n].style.display);
	  if(document.getElementsByClassName("add")[n].style.display=="none")
	      document.getElementsByClassName("add")[n].style.display="table-row";
	  else
		  document.getElementsByClassName("add")[n].style.display="none";  
	  
	  /* 전제 한번에 숨기기
	  var len=document.getElementsByClassName("add").length;
	  for(i=0;i<len; i++)
		  document.getElementsByClassName("add")[i].style.display="none";
	  */
  }
</script>
 <div id="section">
  <table width="780" align="center">
    <caption><h3> 객실 현황 </h3></caption>
    <tr align="center">
      <td> 객실명 </td>
      <td width="90"> 1박금액 </td>
      <td> 최소인원 </td>
      <td> 최대인원 </td>
      <td> 등록일 </td>
      <td> 수정 </td>
    </tr>
   <%
   for(int i=0;i<rlist.size();i++)
   {
   %> 
    <tr align="center"  onclick="view_add(<%=i%>)">
      <td> <%=rlist.get(i).getName()%> </td>
      <td align="right"> <%=MyJob.comma(rlist.get(i).getPrice())%>원 </td>
      <td> <%=rlist.get(i).getMin()%>명 </td>
      <td> <%=rlist.get(i).getMax()%>명 </td>
      <td> <%=rlist.get(i).getWriteday()%> </td>
      <td> <a href="room_update.jsp?id=<%=rlist.get(i).getId()%>"> click </a> </td>
    </tr>
    <tr style="display:none;" class="add">
      <td colspan="3">
      <%
          
          //String img=rlist.get(i).getImg();
          //img.split(",");
        if( rlist.get(i).getRimg() !=null && !rlist.get(i).getRimg().trim().equals("") ) // 비어있지 않을때
        {
          String[] img=rlist.get(i).getRimg().split(",");
          
          for(int j=0;j<img.length;j++)
          {
      %>
            <img src="../room/img/<%=img[j]%>" width="120" height="100">
      <%
          }
        }
      %>
      </td>
      <td colspan="3" width="380"> <%=rlist.get(i).getContent().replace("\r\n","<br>")%> </td> 
    </tr>  
   <%
   }
   %>
    <tr align="center">
      <td colspan="6"> <a href="room_add.jsp"> 객실 추가 </a></td>
    </tr>
  </table>
 
 </div>
</body>
</html>



