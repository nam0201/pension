<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">\
<title>Insert title here</title>
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
</head>
<body>
<%@page import="pension.dao.BoardDao"%>
<%@page import="java.sql.ResultSet" %>
<%
      BoardDao bdao=new BoardDao();
      ResultSet rs=bdao.board_list(request);
      
      int pstart=bdao.getPstart(request);
      int chong=bdao.getChong();
      int pend=bdao.getPend(pstart, chong);
      int pager=bdao.getPage(request);
      
%>
<div id="section">
   <table width="800" align="center" border="1px">
	   <tr>
	     <caption><h3> 자유게시판 </h3></caption>
	     <td align="center"> 제 목 </td>
	     <td align="center"> 이 름 </td>
	     <td align="center"> 선호 여행지</td>
	     <td align="center"> 작성일 </td>
	     <td align="center"> 조회수 </td>
	   </tr>
  <%
     while (rs.next())
     {
    	 String[] imsi=rs.getString("dest").split(",");
	    	String dest="";
	    	for(int i=0;i<imsi.length;i++)
	    	{
	    	  switch(imsi[i])	    	
	    	   {
	    	      case "0" : dest=dest+"전주 " ; break;
	    	      case "1" : dest=dest+"광주 " ; break;
	    	      case "2" : dest=dest+"속초 " ; break;
	    	      case "3" : dest=dest+"부산 " ; break;
	    	      case "4" : dest=dest+"대구 " ; break;
	    	      case "5" : dest=dest+"강릉 " ; break;
	    	      case "6" : dest=dest+"제주 " ; break;
	    	      case "7" : dest=dest+"포항 " ; break;
	              default : dest=dest+"" ;
	    	   }
	    	} 
  
  %>	   
   <tr align="center">
     <td><a href="board_readnum.jsp?id=<%=rs.getInt("id") %>"><%=rs.getString("title") %></a></td>     
     <td><%=rs.getString("name") %></td>
     <td><%=dest%></td>
     <td><%=rs.getString("writeday") %></td>
     <td><%=rs.getInt("readnum") %></td>
    </tr>
  <%
  }
  %>
     <tr>
        <td colspan="10" align="center">
        <!-- 이전 10페이지 목록 가기 -->
        <%
         if(pstart != 1)
         {	 
        %>
         <a href="board_list.jsp?pager=<%=pstart-1%>"> ◁ </a>
         <%
         }
         else
         {	 
         %>
         ◁
         <%
         }
         %>
         <!-- 1페이지 이전으로 가기 -->
         <%
         if(pager != 1)
         { 
         %>
          <a href="board_list.jsp?pager=<%=pager-1%>"> ◀ </a>
         <%
         }
         else
         {	 
         %>
         ◀
         <%
         }
         %>
         
         <%
         
         for(int i=pstart;i<=pend;i++)
         {
        	 String str="";
        	 if(pager ==i )
        		 str="style='color:red;'";
         %>
            <a href="board_list.jsp?pager=<%=i%>"<%=str%>><%=i%></a>
         <% 		 
         }
         %>
         
         <!-- 1페이지씩 다음페이지로 가기 -->
         <%
         if(pager != chong)
         {	 
         %>
         <a href="board_list.jsp?pager=<%=pager+1%>"> ▶ </a>
         <%
         }
         else
         {	  
         %>
          ▶
          <%
          }
          %>
          <!-- 10페이지 다음 목록으로 가기 -->
          <%
          if(pend != chong)
          {  
          %>
           <a href="board_list.jsp?pager=<%=pend+1%>">▷</a>
           <%
          }
          else
          {	  
           %>
           ▷
           <%
           }
           %>
           </td>
         </tr>           
  <tr> 
    <td colspan="10" align="center"> <a href="board_write.jsp"> 글쓰기</a></td>
   </tr>
 </table>     
  </div>


 <%@include file="../bottom.jsp"%>    
</body>
</html>