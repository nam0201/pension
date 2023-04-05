<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@page import="pension.dao.MemberDao" %>
<%@page import="pension.dto.MemberDto" %>
<%
     //member_update.jsp
     MemberDao mdao=new MemberDao();
     mdao.member_view(session, request);
     
     MemberDto mdto=(MemberDto)request.getAttribute("mdto");
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
 <div id="section">
   <div align="center"> <h3> 회원 정보 수정 </h3></div> <p>
   <form method="post" action="member_update_ok.jsp">
   <input type="text" name="phone" value="<%=mdto.getPhone()%>"> <p>
   <input type="text" name="email" value="<%=mdto.getEmail()%>"> <p>
   <input type="submit" value="정보수정">
   </form>
   

 </div>


 <%@include file="../bottom.jsp"%>