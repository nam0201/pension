<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>
<%
      //member_input_ok.jsp

      MemberDao mdao=new MemberDao();
      mdao.member_input_ok(request, response);




%>