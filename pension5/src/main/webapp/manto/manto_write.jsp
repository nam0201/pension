<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<!-- write.jsp 1:1질문 글쓰기 -->
 <style>

     #section{
        width :1000px;
        height :500px;
        margin :auto;
        text-align:center;
        margin-top : 50px;
        
    }
    
      @font-face 
      {
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
       }
     #section #que
    {
       border: 1px solid #D3C64A;
       width:100px;
       text-align: left;
       height:30px;
       right:10;
       font-size:12px;
       font-family: 'DeogonPrincess';
       src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
     #section input[type=text]{
        width :300px;
        height :15px;
        border : 1px solid #D3C64A;
        outline : none;
        font-family: 'DeogonPrincess';
       src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    
    #section input[type=submit]{
        width :200px;
        height :36px;
        border : 1px solid #D3C64A;
        outline : none;
        color:white;
        background:black;
        font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    #section textarea{
        width :306px;
        height :36px;
        border : 1px solid #D3C64A;
        outline : none;
        color:black;
        background:white;
        font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
   
 
 </style>
 <script>
    function len_check(my)
    {
    	document.getElementById("len").innerText=my.length;
    }
 </script>
 <div id="section">
   <form method="post" action="manto_write_ok.jsp">
      <table width="600" align="center">
        <caption> <h3> 1:1 질문하기 </h3></caption>
        <%
        if(session.getAttribute("userid")==null)
        {	
        %>
        <tr>
          <td> 이메일 </td>
          <td> <input type="text" name="email"></td>
        </tr>
        <%
        }
        %>
        <tr>
           <td> 질문 유형 </td>
           <td >
             <select id="que">
               <option value="0"> 회원관련 </option>
               <option value="1"> 예약관련 </option>
               <option value="2"> 객실관련 </option>
               <option value="3"> 결제관련 </option>
             </select>
           </td>
        </tr>
        <tr>
          <td> 질문 내용 <br> (<span id="len" style="color:red;"> </span>자) </td>
          <td> <textarea name="content" id="content" maxlength="99" onkeyup="len_check(this.value)"></textarea></td>
        </tr>
        <tr>
          <td colspan="2" align="center">
            <input type="submit" value="질문저장" id="submit">
            </td>
         </tr>          
      </table>
   
   </form>

 </div>


 <%@include file="../bottom.jsp"%>