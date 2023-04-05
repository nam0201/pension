<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 쿠키를 확인하기
    Cookie[] cookie=request.getCookies();

    for(int i=0;i<cookie.length;i++)
    {
    	out.print(cookie[i].getName());
    	out.print(" : ");
    	out.print(cookie[i].getValue());
    	out.print("<p>");
    	
    	/* name이라는 쿠키변수의 값을 출력
    	if( cookie[i].getName().equals("name") )
    	{
    		out.print("이름은 "+cookie[i].getValue());
    		//값을 가져와서 실행하거나 처리
    	}
    	*/
    }
%>

   <a href="cookie_del.jsp?cname=name"> 이름 쿠키삭제하기</a> <p>
    <a href="cookie_del.jsp?cname=age"> 나이 쿠키삭제하기</a> <p>
     <a href="cookie_del.jsp?cname=pcode"> 상품코드 쿠키삭제하기</a>