<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongjiDao" %>
<%@page import="pension.dto.GongjiDto" %>
<%
    GongjiDao gdao=new GongjiDao();
    gdao.content(request);
    GongjiDto gdto=(GongjiDto)request.getAttribute("gdto");
%> 
<%@include file="../top.jsp"%>

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
     }
     #section #content {
       width:100%;
       height:100%;
       overflow:auto;
     }
 </style>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="section">
  
   <table width="700" align="center" border="1px">
   <caption><h3> 상세내용 </h3></caption>
     <tr>
        <td width="120" align="center"> 제목 </td>
        <td> <%=gdto.getTitle()%> </td>
     </tr>
     <tr>
        <td align="center"> 조회수 </td>
        <td> <%=gdto.getReadnum()%> </td>
     </tr> 
     <tr>
        <td align="center"> 작성일 </td>
        <td> <%=gdto.getWriteday()%> </td>
     </tr>
       <tr height="220">
        <td align="center"> 내용 </td>
        <td> <div id="content">  <%=gdto.getContent().replace("\r\n","<br>")%> </div></td> </td>
     </tr> 
     <tr>
      <td colspan="10" align="center"> 
      <a href="list.jsp"> 목록 </a>
      <%
        if(session.getAttribute("userid")!=null)
        {
        	if(session.getAttribute("userid").equals("admin"))
        	{
      %>
                <a href="update.jsp?id=<%=gdto.getId()%>"> 수정 </a>
                <a href="delete.jsp?id=<%=gdto.getId()%>"> 삭제 </a>
          <%
        	}
        }	
          %>
      </td>
     </tr>  
   </table>
   </div> 
  
 <%@include file="../bottom.jsp"%> 
</body>
</html>