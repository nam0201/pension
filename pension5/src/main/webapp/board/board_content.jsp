<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
     }
     #section #content {
       width:100%;
       height:100%;
       overflow:auto;
     }
 </style>
</head>
<body>
<%@page import="pension.dao.BoardDao"%>
<%@page import="pension.dto.Board_Dto" %>

<%
      BoardDao bdao=new BoardDao();
      bdao.board_content(request);
      
      Board_Dto bdto=(Board_Dto)request.getAttribute("bdto");
      
     
      
%>
  <div id="section">
     <table width="340" align="center" border="1">
       <caption><h3>상세내용</h3></caption>
          <tr>
            <td> 제   목 </td>
             <td><%=bdto.getTitle()%></td>
          </tr>
           <tr>
            <td> 이   름 </td> 
             <td><%=bdto.getName()%></td>
          </tr>
           <tr>
            <td> 내  용 </td>
             <td height="220"><%=bdto.getContent().replace("\r\n","<br>") %></td>
          </tr>
           <tr>
            <td> 선호 여행지 </td>
                <td><%=bdto.getDest()%></td>
           </tr> 
           <tr>
            <td> 조회수 </td>
                <td><%=bdto.getReadnum()%></td>
           </td> 
           <tr>
            <td> 작성일 </td>
                <td><%=bdto.getWriteday()%></td>
           </tr>
           <tr>
             <td colspan="10" align="center">
             <a href="board_list.jsp">목록</a>
             <a href="board_update.jsp?id=<%=bdto.getId() %>">수정</a>
            <%
              if(session.getAttribute("userid")==null || !(session.getAttribute("userid").equals(bdto.getUserid())) )
              {	  
             %>
                <a href="javascript:view()">삭제</a>
             <%
              }
              else
              {	  
             %>
             <a href="board_delete.jsp?id=<%=bdto.getId() %>">삭제</a>
            <%
              } 
            %>
            </td>
           </tr>  
   
             <tr style="display:none;" id="delform">
                <td colspan="2" align="center">
                   <form method="post" action="board_delete.jsp">
                     <input type="hidden" name="id" value="<%=bdto.getId()%>">
                     <input type="password" name="pwd" placeholder="비밀번호">
                     <input type="submit" value="삭제">
                  </form>
                 </td>
             </tr> 
  
      </table>
     <script>
  
     
     
     function view()
     {
    	 document.getElementById("delform").style.display="table-row";
     }
  
  </script>          
  
          
  
  </div>


 <%@include file="../bottom.jsp"%>
</body>
</html>