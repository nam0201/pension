<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String cname=request.getParameter("cname");

    Cookie cookie=new Cookie(cname,"");
    cookie.setMaxAge(0);
    response.addCookie(cookie);
    
    response.sendRedirect("cookie_view.jsp");

%>