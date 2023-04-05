<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="pension.dao.MantoDao" %>
<%@page import="pension.dto.MantoDto" %>
<%@page import="java.util.ArrayList" %>
<%
    MantoDao mdao=new MantoDao();
    mdao.manto_list(session, request);
    ArrayList<MantoDto> mlist=(ArrayList<MantoDto>)request.getAttribute("mlist");
%> 
 <%@ include file="../top.jsp"%>
 <!-- list.jsp -->
 <style>
    @font-face 
      {
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
       }
     #section{
        width :1000px;
        height :500px;
        margin :auto;
        text-align:center;
        margin-top : 50px;
        
    }
     
       #section table {
     border-spacing:0px;
   }
   #section table tr:hover {
      background:#D3C64A;
   }
   #section table tr:first-child:hover {
      background:white;
   }
   #section table td {
     height:30px;
     font-size:13px;
   }
   #section table td {
     border-bottom:1px solid #D3C64A;
   }
   #section table tr:first-child td {
     border-top:2px solid #D3C64A;
     font-weight:900;
   }
   #section table tr:last-child td {
     border-bottom:2px solid #D3C64A;
   }
   #section a {
     color:#D3C64A;
   }
   
    #section #content {
     width:300px;
     height:60px;
     overflow:auto;
   }
   
 </style>
  

 
  <div id="section">
    <table width="700" align="center" border="1">
      <caption> <h3> 나의 질문 현황 </h3></caption>
      <tr align="center">
        <td> 질문유형 </td>
        <td> 질문내용 </td>
        <td> 처리상태 </td>
        <td> 등록일 </td>
        <td> 삭제 </td>
      </tr>
      
     <%
     for(int i=0;i<mlist.size();i++)
     {
    	 //질문유형
    	 String que;
    	 switch(mlist.get(i).getQue())
    	 {
    	    case 0 : que="회원관련" ; break;
    	    case 1 : que="예약관련" ; break;
    	    case 2 : que="객실관련" ; break;
    	    case 3 : que="결제관련" ; break;
    	    default: que="자료오류";
    	 }
    	 //처리상태
    	 String state;
    	 switch(mlist.get(i).getState())
    	 {
    	    case 0 : state="미답변"  ; break;
    	    case 1 : state="답변완료"  ; break;
    	    case 2 : state="삭제"  ; break;
    	    default: state="오류";
    	 }
     %>
      <tr>
        <td align="center"> <%=que%> </td>
        <td>
         <div id="content"> <%=mlist.get(i).getContent()%> </div>
        <%
         if(mlist.get(i).getState()==1)
         {
        %>
         <div id="content"> <%=mlist.get(i).getAnswer()%> </div>
        <%
         }
        %>
        </td>
        <td align="center"> <%=state%> </td>
        <td align="center"> <%=mlist.get(i).getWriteday()%> </td>
        <td align="center"> <a href="delete.jsp?id=<%=mlist.get(i).getId()%>"> click </a> </td>
      </tr>
     <%
     }
     %>
    </table>

  </div>
  
 <%@ include file="../bottom.jsp"%>