<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
     //쿠키를 생성하기
     Cookie cookie=new Cookie("name", "슈퍼맨");
     cookie.setMaxAge(600);
  
     response.addCookie(cookie);
     
     cookie=new Cookie("age","22");
     cookie.setMaxAge(600);  //쿠키 지속시간
     response.addCookie(cookie);
     
     cookie=new Cookie("name", "홍길동");
     cookie.setMaxAge(600);
     response.addCookie(cookie);
     
     cookie=new Cookie("pcode","p0202003");
     cookie.setMaxAge(600);
     response.addCookie(cookie);

%>