<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MemberDao" %>    
<%
    //login_ok.jsp
    MemberDao mado=new MemberDao();
    mado.login_ok(request, session, response);
%>