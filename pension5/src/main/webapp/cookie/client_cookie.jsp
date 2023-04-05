<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
   // 쿠키 : 사용자의 컴퓨터에 정보를 저장하는 방법
   // 자바스크립트에서 쿠키 만들기
   document.cookie="name=슈퍼맨;max-age=60";
   document.cookie="age=33";
   function view()
   {
	   document.getElementById("ex").innerText=document.cookie;
   }
   function hide()
   {
	   var today=new Date();
	   today.setDate(today.getDate()-1);
	   document.cookie="name=;expires="+today.toGMTString();
   }
 </script>
</head>
<body> <!-- client_cookie.jsp -->
  <input type="button" onclick="view()" value="쿠키보기">
  <input type="button" onclick="hide()" value="쿠키삭제">
  <hr>
  <span id="ex"></span>
</body>
</html>