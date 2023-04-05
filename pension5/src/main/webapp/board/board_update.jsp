<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@page import="pension.dao.BoardDao" %>
<%@page import="pension.dto.Board_Dto" %>
<%
       BoardDao bdao=new BoardDao();
       bdao.board_update(request);
       
       Board_Dto bdto=(Board_Dto)request.getAttribute("bdto");


%>

 <style>
    #section{
        width : 1000px;
        height : 500px;
        margin : auto;
        text-align:center;   
    }
   #section input[type=text]{
        width :300px;
        height :33px;
        border : 1px solid #D3C64A;
        outline : none;
        font-family: 'DeogonPrincess';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    
     #section input[type=submit]{
        width :306px;
        height :36px;
        border : 1px solid #D3C64A;
        outline : none;
        color:white;
        background:#D3C64A;
        font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
 </style>
 <script>
    window.onload=function()
    {
    	var imsi="<%=bdto.getDest()%>".split(",");
    	
    	for(i=0;i<imsi.length-1;i++)
    	{
    		document.uform.dest[imsi[i]].checked=true;
    	}	
    	
    }
 </script>

   <div id="section">
     
       <form name="uform" method="post" action="board_update_ok.jsp">
        <input type="hidden" name="id" value="<%=bdto.getId() %>">
         <table width="500" align="center">
         <tr>
           <tr>
            <td> 제   목 </td>
             <td><input type="text" name="title" id="title" value="<%=bdto.getTitle() %>"></td>
          </tr>
           <tr>
            <td> 이   름 </td> 
             <td><input type="text" name="name" id="name" value="<%=bdto.getName() %>"></td>
          </tr>
             <%
              if(session.getAttribute("userid")==null || !(session.getAttribute("userid").equals(bdto.getUserid())) )
              {	  
             %>
          <tr>
            <td> 비밀번호 </td>
            <td> <input type="password" name="pwd" id="pwd"></td>
           </tr>
           <%
              }
           %>
           <tr>
            <td> 내  용 </td>
             <td><input type="text" name="content" id="content" value="<%=bdto.getContent() %>"></td>
          </tr>
           <tr>
            <td> 선호 여행지 </td>
               <td>
               <input type="checkbox" name="dest" value="0"> 전주
              <input type="checkbox" name="dest" value="1"> 광주
              <input type="checkbox" name="dest" value="2"> 속초
              <input type="checkbox" name="dest" value="3"> 부산
              <input type="checkbox" name="dest" value="4"> 대구
              <input type="checkbox" name="dest" value="5"> 강릉
              <input type="checkbox" name="dest" value="6"> 제주
              <input type="checkbox" name="dest" value="7"> 포항
              </td>
           </tr>
         <tr>
        <td colspan="2" align="center"> 
        <input type="submit" value="정보수정" id="submit"></td>
         </tr>
       </form>
      </table> 
   </div>
 


 <%@include file="../bottom.jsp"%>