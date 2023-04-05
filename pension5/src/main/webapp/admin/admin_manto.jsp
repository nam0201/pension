<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %>
<!-- admin_manto.jsp -->
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.MantoDto" %>
<%@page import="java.util.ArrayList" %>
<%
   AdminDao adao=new AdminDao();
   adao.admin_manto(request);
   ArrayList<MantoDto> mlist=(ArrayList<MantoDto>)request.getAttribute("mlist");
%>


<style>
 <style>
 #section {
   width:780px;
   height:500px;
   margin:auto;
  }
      #section table {
     border-spacing:0px;
   }
   #section table tr:hover {
      background:#eeeeee;
   }
   #section table tr:first-child:hover {
      background:white;
   }
   #section table td {
     height:30px;
     font-size:13px;
   }
   #section table td {
     border-bottom:1px solid #4B0700;
   }
   #section table tr:first-child td {
     border-top:2px solid #4B0700;
     font-weight:900;
   }
   #section table tr:last-child td {
     border-bottom:2px solid #4B0700;
   }
   #section a {
     color:#4B0700;
   }
   #section #incon { /* td태그 : id=content를 포함하는 */
     width:300px;
     height:60px;
   }
   #section #content {
     width:100%;
     height:100%;
     overflow:auto;
   }
</style>
</style>
  <div id="section">
   <table width="800" align="center">
     <caption> <h3> 1:1질문 현황</h3></caption>
     <tr align="center">
       <td> 질문유형 </td>
       <td> 질문자 </td>
       <td> 질문내용 </td>
       <td> 상태 </td>
       <td> 작성일 </td>
     </tr>
    <%
    for(int i=0;i<mlist.size();i++)
    {
    	// 질문유형
   	 String que;
   	 switch(mlist.get(i).getQue())
   	 {
   	    case 0: que="회원관련" ; break;
   	    case 1: que="예약관련" ; break; 
   	    case 2: que="객실관련" ; break; 
   	    case 3: que="결제관련" ; break; 
   	    default: que="자료오류";
   	 }
   	 // 처리상태
   	 String state;
   	 switch(mlist.get(i).getState())
   	 {
   	    case 0: state="미답변"; break;
   	    case 1: state="답변완료"; break;
   	    case 2: state="삭제"; break;
   	    default: state="자료오류";
   	 }
    %> 
     <tr align="center">
       <td> <%=que%> </td>
       <td> <%=mlist.get(i).getUserid()%> </td>
       <td align="left" id="incon"> <div id="content"> <%=mlist.get(i).getContent()%> </div></td>
      <%
       if(mlist.get(i).getState()==0)
       {
      %>        
       <td> <a href="#" onclick="answer_view(<%=mlist.get(i).getId()%>)"> <%=state%> </a></td>
      <%
       }
       else
       {
      %>
       <td onmouseover="ans_view(<%=mlist.get(i).getId()%>)" onmouseout="ans_hide()"> <%=state%> </td>
      <%
       }
      %>
       <td> <%=mlist.get(i).getWriteday()%> </td>
     </tr>
    <%
    }
    %>
   </table>
   <div id="answer_view">
     <div id="ans_con"></div>
   </div>
  <script>
   function ans_view(id) // 답변내용 보기
   {
	   var chk=new XMLHttpRequest();
	   var x=event.clientX;
	   var y=event.clientY;
	   chk.onload=function()
	   {
		   //alert(chk.responseText.trim());
		   document.getElementById("answer_view").style.visibility="visible";
		   document.getElementById("ans_con").innerHTML=chk.responseText.trim();
		   
		   document.getElementById("answer_view").style.left=x+"px";
		   document.getElementById("answer_view").style.top=y+"px";
	   }
	   chk.open("get","answer_view.jsp?id="+id);
	   chk.send();
   }
   function ans_hide() // 답변내용 숨기기
   {
	   document.getElementById("answer_view").style.visibility="hidden";
   }
   function answer_view(id) // 매개변수는 manto테이블의 id
   {
	   // 답변폼이 보이게 하고  id값을 폼태그에 전달
	   document.getElementById("answer").style.visibility="visible";
	   document.ansform.id.value=id;
	   
	   // 마우스의 위치
	   var x=event.clientX;
	   var y=event.clientY;
	   document.getElementById("answer").style.left=(x-350)+"px";
	   document.getElementById("answer").style.top=(y+40)+"px";
   }
   
  </script>
  <style>
   #answer_view {
      position:absolute;
      visibility:hidden;
      background:white;
   }
   #ans_con {
     width:250px;
     height:60px;
     border:1px solid #4B0700;
     overflow:auto;
     font-size:13px;
   }
   #answer  {
      position:absolute;
      visibility:hidden;
      background:white;
   }
   #answer #ans_content {
      width:250px;
      height:40px;
      border:1px solid #4B0700;
      resize:none;
   }
   #answer input[type=submit] {
      width:256px;
      height:30px;
      background:#4B0700;
      color:white;
   }
  </style>
   <div id="answer">
     <form name="ansform" method="post" action="answer.jsp">
       <input type="hidden" name="id">
       <textarea name="content" id="ans_content"></textarea> <br>
       <input type="submit" value="답변달기">
     </form>
   </div>
 </div>
</body>
</html>