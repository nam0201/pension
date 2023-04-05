<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.TourDao"%>

<%
   TourDao tdao=new TourDao();
   tdao.tour_write_ok(request, response, session);

%>