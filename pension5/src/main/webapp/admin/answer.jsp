<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.AdminDao"%>
<%
      AdminDao admd=new AdminDao();
      admd.answer(request, response);
      

%>