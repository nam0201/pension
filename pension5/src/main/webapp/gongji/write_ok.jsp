<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.GongjiDao" %>    
<%
      //write_ok.jsp
      GongjiDao gdao=new GongjiDao();
      gdao.write_ok(request, response, session);

%>