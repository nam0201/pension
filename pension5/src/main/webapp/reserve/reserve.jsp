<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>

 <style>
    #section{
        width : 1000px;
    
        margin : auto;   
    }
      .cblue {
     color:blue;
   }
   .cred {
     color:red;
   }
 </style>
    
  <div id="section">
  <%@page import="java.time.LocalDate" %>
  <%@page import="pension.dao.ReserveDao" %>
  <%@page import="java.util.ArrayList" %>
  <%@page import="pension.dto.RoomDto" %>
  <%
       ReserveDao rdao=new ReserveDao();
      // 달력을 만들때 필요한 값 => 해당월의 총일수, 1일의 요일,  몇주
      
      // 현재 시간을 기준으로 달력을 만든다면 => 이번달
      int year,month;
      if(request.getParameter("year")==null)
      {	  
          LocalDate today=LocalDate.now(); // 현재시간을 가지는 LocalDate객체를 생성
          year=today.getYear();
          month=today.getMonthValue();
      }
      else
      {  
         year=Integer.parseInt(request.getParameter("year"));
         month=Integer.parseInt(request.getParameter("month"));
      }
      // 특정날짜의 날짜객체를 만들수 있다..
      LocalDate xday=LocalDate.of(year,month,1); // 년,월,일을 매개변수로 전달하면 해당날짜의 객체가 생성
      
      // 총일수
      int chong=xday.lengthOfMonth();
      
      // 1일의 요일   :  getDayOfWeek().getValue() => 1~7까지의 값  월~일
      int yoil=xday.getDayOfWeek().getValue();
      if(yoil==7)
    	 yoil=0;
      
      // 몇주인가?  => (yoil+chong)/7     :   int / int  => int (소수점이 사라진다)
      int ju=(int)Math.ceil( (yoil+chong)/7.0 ) ;    		
      
  %>
   
    <table width="1000" height="500" align="center" border="1">
      <caption> <h3> 실시간 예약 </h3>
         <%
         if(month==1)
         {	 
         %>
         <a href="reserve.jsp?year=<%=year-1%>&month=12">ᐗ</a>
         <% 
         }
         else
         {
          %>
          <a href="reserve.jsp?year=<%=year%>&month=<%=month-1%>">ᐗ </a>	  
         <%
         }
         %>
         <h3 style="display:inline;"> <%=year%>년 <%=month%>월 </h3>
         <%
         if(month==12)
         {	 
         %>
         <a href="reserve.jsp?year=<%=year+1%>&month=1"> ᐓ  </a>
         <%
         }
         else
         {	 
         %>
          <a href="reserve.jsp?year=<%=year%>&month=<%=month+1%>"> ᐓ  </a>
          <%
         }
          %>
         
         
      </caption>
     <tr align="center" height="25">
      <td class="cblue"> 일 </td>
      <td style="color:green"> 월 </td>
      <td style="color:#3F0099"> 화 </td>
      <td > 수 </td>
      <td style="color:#BDBDBD"> 목 </td>
      <td style="color:#F361A6"> 금 </td>
      <td class="cred"> 토 </td>
     </tr>
     <%
     int day=1; // 달력에 출력될 날짜
     
     for(int i=1;i<=ju;i++)
     {
     %>
      <tr align="center">
        <%
        for(int j=0;j<7;j++)  //  0 1 2 3 4 5 6
        {
        %>
        
        <%
        if( ( (j<yoil) && i==1 ) || day>chong  )
        {
        %>
         <td> &nbsp; </td>   <!-- 1일의 요일 이전의 j값은 빈칸 -->
        <%
        }
        else
        {
     	   
     	  //객실정보 가져오기
     	  rdao.getRoomName(request);
     	  ArrayList<RoomDto> rlist=(ArrayList<RoomDto>)request.getAttribute("rlist");
     	  
    	     
        %>
         <td height="90" style="font-size:13px;" align="center"><span style="font-size:15px;font-weight:900;"> <%=day%></span><p>
          <!-- 객실명 -->
         <%
         LocalDate today=LocalDate.now();
         LocalDate prevday=LocalDate.of(year,month,day);
         
       if(!prevday.isBefore(today))  
       {
         for(int k=0;k<rlist.size();k++) //방이름 출력하는 for
         {
        	 //예약하는 객실의 id
        	 int id=rlist.get(k).getId();
         %>
         
         <%
           
          //년, 월, 일, room의 id
          boolean ck=rdao.isEmpty(year, month, day,id);
         
          if(ck)
          {	  
         %>
           <a href="reserve_next.jsp?y=<%=year%>&m=<%=month%>&d=<%=day%>&id=<%=id%>"> <%=rlist.get(k).getName()%></a><br>  
         <%
          }
          else
          {
        %>	    
         <span style="color:red"><%=rlist.get(k).getName()%>(예약완료)</span> <br>   
         <%
          }
         %>
         <%
         }  //td안에 방을 출력하는 for
       }   //이전 날짜일 경우 방 목록 출력안되는 if문
         %>
         </td>
        <%
           day++;
        }
        %> 
         
        <%
          
        }
        %>
      </tr>
     <%
     }
     %>
    
    </table>
    <%@include file="../bottom.jsp"%> 
  
  </div>
  