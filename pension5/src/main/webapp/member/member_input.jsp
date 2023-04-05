<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>

 <style>
 
    #section{
        width :1000px;
        height :500px;
        margin :auto;
        text-align:center;
        margin-top : 50px;
        
    }
    #section input[type=text]{
        width :300px;
        height :33px;
        border : 1px solid #D3C64A;
        outline : none;
        font-family: 'DeogonPrincess';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    #section input[type=password]{
        width :300px;
        height :33px;
        border : 1px solid #D3C64A;
        outline : none;    
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    #section input[type=submit]{
        width :306px;
        height :36px;
        border : 1px solid #D3C64A;
        outline : none;
        color:white;
        background:#D3C64A;
        font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
 </style>
 <!-- 
   1. 아이디 중복체크
   2. 비밀번호 동일한지 체크
   3. 가입하기 버튼 클릭시에 유효성 검사
      (아이디 : blur시에 아이디의 중복을 ajax를 통해 확인한다.. 
       
      
      비번, 이메일)
  -->
  <script>
     function userid_check(userid)
     { 
    	 if(userid.trim().length==0)
    	 {
    		 alert("아이디를 입력 해주시오");
    		 document.getElementById("umsg").innerText="";
    	 }
    	 else
    	 {
    	 var chk=new XMLHttpRequest();
    	 
    	 chk.onload=function()
    	 {
    		 //alert(chk.responseText.trim());
    		 if(chk.responseText.trim()=="0")
    		 {
    			 document.getElementById("umsg").innerText="사용 불가능한 아이디오";
    			 document.getElementById("umsg").style.color="red";
    		 }
    		 else
    		 {
    			 document.getElementById("umsg").innerText="사용 가능한 아이디오";
    			 document.getElementById("umsg").style.color="blue";
    		 }	 
    	 }
    	 chk.open("get", "userid_check.jsp?userid="+userid);  //사용하고자 하는 아이디 : 입력한 아이디
    	 chk.send();
    	 } //else의 끝 
     }
     function pwd_check()
     {
    	 if(document.pkc.pwd.value == document.pkc.pwd2.value)
    	 {
    		 document.getElementById("pmsg").innerText="비밀번호가 일치하오";
    		 document.getElementById("pmsg").style.color="blue";
    	 }
    	 else
    	 {
    		 document.getElementById("pmsg").innerText="비밀번호가 불일치하오";
    		 document.getElementById("pmsg").style.color="red";
    	 }	 
     }
  </script>
 <div id="section">
     <div align="center" style="color:#D3C64A"> <h3> 회원가입 </h3> </div>
     <form name="pkc" method="post" action="member_input_ok.jsp">
        <input type="text" name="userid" placeholder="아이디" onblur="userid_check(this.value)"> 
        <br><span id="umsg" style="font-size:12px;"></span>
        <p>
        <input type="password" name="pwd" placeholder="비밀번호" onkeyup="pwd_check()"> <p>
        <input type="password" name="pwd2" placeholder="비밀번호 확인" onkeyup="pwd_check()"> 
        <br><span id="pmsg" style="font-size:12px;"></span>
        <p>
        <input type="text" name="name" placeholder="이름"><p>
        <input type="text" name="phone" placeholder="전화번호"> <p>
        <input type="text" name="email" placeholder="이메일"> <p>
        <input type="submit" value="가입하기">
         
    </form>

 </div>


 <%@include file="../bottom.jsp"%>
<body>  <!-- member_input.jsp -->

</body>
</html>