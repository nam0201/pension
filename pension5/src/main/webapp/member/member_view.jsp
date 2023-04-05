<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>
<%@page import="pension.dto.MemberDto" %>    
<%
       //member테이블에서 해당회원의 정보를 가져와서 출력..
       MemberDao mdao=new MemberDao();
       mdao.member_view(session, request);
       
       MemberDto mdto=(MemberDto)request.getAttribute("mdto");
%>    
<%@include file="../top.jsp"%>

 <style>
    #section{
        width : 1000px;
        height : 500px;
        margin : auto;   
    }
 </style>
  <div id="section">
    <table width="300" align="center">
       <caption> <h3> 회원정보 </h3></caption>
          <tr> 
             <td> 아이디 </td>
            <td> <%=mdto.getUserid()%> </td>
          </tr>
          <tr>
             <td> 이름 </td>
             <td> <%=mdto.getName() %> </td>
          </tr> 
          <tr>
             <td> 전화번호 </td>
             <td> <%=mdto.getPhone() %> </td>
          </tr>
          <tr>
             <td> 이메일 </td>
             <td> <%=mdto.getEmail() %> </td>
          </tr> 
          <tr>
             <td colspan="2" align="center">
               <input type="button" onclick="location='member_update.jsp'" value="정보수정">
               <input type="button" onclick="location='member_out.jsp'" value="탈퇴신청">
              </td>   
    </table>

 </div>
<!-- 
     onclick="member_out()"
     
     <script>
       function member_out()
       {
         location="member_out.jsp";
       }
      </script>   
 
 -->

 <%@include file="../bottom.jsp"%>