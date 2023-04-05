<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="admin_top.jsp"%>
<%@page import="pension.dao.AdminDao"%>
<%@page import="pension.dto.ReserveDto" %>
<%@page import="java.util.ArrayList" %>
<%@page import="util.MyJob" %>
<%
       AdminDao adao=new AdminDao();
       adao.admin_reserve(request);
       ArrayList<ReserveDto> rlist=(ArrayList<ReserveDto>)request.getAttribute("rlist");
%>
 
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
  #rmsg{
    position:absolute;
    visibility:hidden;
    width:150px;
    height:60ox;
    background:white;
    border:1px solid black;
  }
</style>
<script>
function rview(my)
{
	 var userid=my.innerText;
	 var chk=new XMLHttpRequest();
	 var x=event.clientX;
	 var y=event.clientY;
	 chk.onload=function()
	 {
		 //alert(chk.responseText.trim());
		 document.getElementById("rmsg").style.left=x+"px";
		 document.getElementById("rmsg").style.top=y+"px";
		 document.getElementById("rmsg").style.visibility="visible";
		 document.getElementById("rmsg").innerHTML=chk.responseText.trim();
	 }
	 
	 chk.open("get","getInfo.jsp?userid="+userid);
	 chk.send();
}
function rhide(my)
{
	 document.getElementById("rmsg").style.visibility="hidden";
}
</script>
 <div id="section">
   <div id="rmsg"></div>
    <table width="700" align="center">
        <caption> <h3>예약 현황</h3></caption>
        <tr>
           <td>객실명</td>
           <td>예약자</td>
           <td>입실일 </td>
           <td>퇴실일</td>
           <td>숙박일</td>
           <td>숯불패키지</td>
           <td>바비큐 </td>
           <td>결제금액</td>
           <td>삭제 </td>
        </tr>
      <%@page import="java.text.DecimalFormat" %>
      <%
       for(int i=0;i<rlist.size();i++)
       {
    	   
      %>
        <tr>
           <td><%=rlist.get(i).getName()%> </td>
           <td onmouseover="rview(this)" onmouseout="rhide(this)"><%=rlist.get(i).getUserid()%></td>
           <td><%=rlist.get(i).getInday()%></td>
           <td><%=rlist.get(i).getOutday()%></td>
           <td><%=rlist.get(i).getSuk() %></td>
           <td><%=rlist.get(i).getChacol()%>개</td>
           <td><%=rlist.get(i).getBbq()%>개</td>
           <td><%=MyJob.comma(rlist.get(i).getTprice())%>원</td>
           <td><a href="reserve_delete.jsp?id=<%=rlist.get(i).getId()%>">click</a>
        </tr>
      
      <%
       }
      %>     
    </table>
 
 
 </div>