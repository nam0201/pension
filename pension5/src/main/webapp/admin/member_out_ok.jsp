<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao" %>
<%
     AdminDao mdao=new AdminDao();
     mdao.member_out_ok(request, session, response);
%>