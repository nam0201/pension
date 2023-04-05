<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>

 <style>
    #main, #psearch, #usearch, #view2
    {
       width:300px;
       margin:auto;
       color:#FFDC73
       font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2'); 
       
    }
    #section{
        width : 1000px;
        height : 500px;
        margin : auto; 
        text-align:center;
        margin-top:50px;  
    }
    #section input[type=text]{
        width :300px;
        height :33px;
        border : 1px solid #FFDC73;
        outline : none;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    #section input[type=password]{
        width :300px;
        height :33px;
        border : 1px solid #FFDC73;
        outline : none; 
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');   
    
    }
    #section input[type=submit]{
        width :306px;
        height :36px;
        border : 1px solid #FFDC73;
        outline : none;
        color:#4B0700;
        background:#FFDC73;
        font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    
    #psearch, #usearch{
       display:none;
    }
    #view2
    {
       text-align:center;
    }
 </style>
   <script>
   function uview()  //아이디 찾기 폼을 보이게
   {
   	document.getElementById("usearch").style.display="block";
   	document.getElementById("psearch").style.display="none";
   }
   function pview()  //비밀번호 찾기 폼을 보이게
   {
   	document.getElementById("psearch").style.display="block";
   	document.getElementById("usearch").style.display="none";
   }
   
   function usend()  //아이디 찾기
   {
   	var name=document.uform.name.value;
   	var email=document.uform.email.value;
   	
   	var chk=new XMLHttpRequest();
   	
   	chk.onload=function()
   	{
   		//chk.responseText.trim();
   		var userid=chk.responseText.trim();
   		//아이디가 있다면 표시하기
   		if(userid == "")
   		{
   			document.getElementById("view2").innerText="이름 혹은 이메일을 다시 확인하시오";
   			document.getElementById("view2").style.color="red";
   			document.getElementById("view2").style.fontSize="12px"
   		}
   		else
   		{
   			document.getElementById("view2").innerText="당신의 아이디는 :"+userid+"이오";
   			document.getElementById("view2").style.color="blue";
   			document.getElementById("view2").style.fontSize="12px";
   			document.getElementById("usearch").style.display="none";
   		}	
   	}
   	chk.open("get","userid_search.jsp?name="+name+"&email="+email);
   	                               //?name=홍길동&email=hong@naver.com
   	chk.send();
   }
   function psend() //비밀번호 찾기
   {
   	var userid=document.pform.userid.value;
   	var name=document.pform.name.value;
   	var email=document.pform.email.value;
   	
   	var chk=new XMLHttpRequest();
   	
   	chk.onload=function()
   	{
   		var pwd=chk.responseText.trim()
   		
   		if(pwd == 2)
   		{
   			document.getElementById("view2").innerText="잘못 입력하셨소";
   			document.getElementById("view2").style.color="red";
   			document.getElementById("view2").style.fontSize="12px";
   		}
   		else
   		{
   			document.getElementById("view2").innerText="당신의 비밀번호는 :"+pwd+"이오";
   			document.getElementById("view2").style.color="blue";
   			document.getElementById("view2").style.fontSize="12px";
   			document.getElementById("psearch").style.display="none";
   			
   		}	
   	}
   	chk.open("get","pwd_search.jsp?userid="+userid+"&name="+name+"&email="+email);
   	chk.send();
   }
   function login_check(my)  //로그인시 아이디, 비번이 포함되었느냐를 확인..this-my
   {
   	//my.userid.value.trim().length
   	var userid=my.userid.value;
   	userid=userid.trim();
   	if(userid.length==0)
   	{
   		alert("아이디를 입력하시오");
   		return false;
   	}
   	else if(my.pwd.value.trim().length==0)  //my.pwd.value.trim()==""
   	{	
   		alert("비밀번호를 입력하시요");
   		return false;
   	}
   	else
   	{	
   	return true;
   	}
   }
   </script>
 <div id="section">
    
    <form method="post" action="login_ok.jsp" onsubmit="return login_check(this)">
      <input type="hidden" name="y" value="<%=request.getParameter("y")%>">
      <input type="hidden" name="m" value="<%=request.getParameter("m")%>">
      <input type="hidden" name="d" value="<%=request.getParameter("d")%>">
      <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
      <input type="text" name="userid" placeholder="아이디"> <p>
      <input type="password" name="pwd" placeholder="비밀번호"><p>
      <input type="submit" value="로그인">
      
      <%
      if(request.getParameter("chk")!=null)  
      {
       	  
      %>
      <br><span style="color:red;font-size:12px"> 탈퇴한 회원 혹은 로그인 정보가 일치 하지 않습니다. </span>
       <%
      }
       %>
           
    </form>
    <p align="center"> <span onclick="uview()">아이디 찾기 </span> | <span onclick="pview()"> 비밀번호 찾기 </span> | <a href="member_input.jsp">회원가입</a><p>
     
   
      <div id="view2"></div> 
   
   
   <div id="usearch">
     <form name="uform">
       <input type="text" name="name" placeholder="이름"><p>
       <input type="text" name="email" placeholder="이메일"><p>
       <input type="button"  value="아이디 찾기" onclick="usend()">
      </form>
    </div>
    
    <div id="psearch">
      <form name="pform">
        <input type="text" name="userid" placeholder="아이디"><p>
        <input type="text" name="name" placeholder="이름"><p>
        <input type="text" name="email" placeholder="이메일"><p>
        <input type="button" value=" 비밀번호 찾기" onclick="psend()">
      </form>
    </div>       
 </div>
 <%@include file="../bottom.jsp"%>
