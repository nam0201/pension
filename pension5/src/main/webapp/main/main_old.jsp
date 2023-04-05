<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="../top.jsp"%>   <!-- 아래위로 출력 -->
  <style>
      #fourth {
           width : 1000px;
           height : 280px;
           background : pink;
           margin : auto;
           border :1px solid #845E00; 
      }
      #fifth {
          width : 1000px;
          height : 120px;
          margin : auto;
      }
      #fifth td {
         border :1px solid #845E00;
      }
      #sixth {
          width : 1000px;
          height : 200px;
          
          margin : auto;
      }
      #sixth td {
         border :1px solid #845E00;
      }
    #tt {
     font-size:13px;
   }
   #tt   span{
      display:inline-block;
   }
   #tt #title {
      width:227px;
      text-align:left;
      padding-left:3px;
   }
   #tt #writeday {
      width:90px;
      text-align:right;
   }
   
  </style>
    <script>
    window.onload=function()  //현재 보여주는 그림의 배열 인덱스
    {
    	var mm=0;
    	var fmain=["11.jpg", "18.jpg", "19.jpg", "20.jpg", "16.jpg"]
    	
    	setInterval(function()   //setInterval(함수, 시간); ex) setInterval(func1, 1000); 
    	{                                                 //   setInterval(  function(){}, 1000);
    		mm++;                                         //   setInterval(  function())
    		if(mm==fmain.length)                                     //   {      
    	    	mm=0;                                     //   },1000);
    		document.getElementById("mainimg").src="../img/"+fmain[mm];    		
    	},3000);
    }
  </script>
    <div id="fourth">
      <img src="../img/1229.jpg" width="1000" height="280" id="mainimg">
       
    </div>
<%@page import="pension.dao.GongjiDao" %>
<%@page import="pension.dto.GongjiDto" %>
<%@page import="pension.dao.BoardDao" %>
<%@page import="pension.dto.Board_Dto" %>
<%@page import="pension.dao.TourDao" %>
<%@page import="pension.dto.TourDto" %>
<%@page import="java.util.ArrayList" %>
<%
     GongjiDao gdao=new GongjiDao();
     gdao.getFour(request);
     ArrayList<GongjiDto> glist=(ArrayList<GongjiDto>)request.getAttribute("glist");
     
     BoardDao bdao=new BoardDao();
     bdao.getFour(request);
     ArrayList<Board_Dto> blist=(ArrayList<Board_Dto>)request.getAttribute("blist");
     
     TourDao tdao=new TourDao();
     tdao.getFour(request);
     ArrayList<TourDto> tlist=(ArrayList<TourDto>)request.getAttribute("tlist");
    
%>
  
    <div id="fifth">
      <table width="1000" height="100">
         <tr>
           <td width="333" id="tt" align="center" style="padding-top:-3px;"><a href="../gongji/list.jsp"> 공지사항 </a><p>
            <%
            for(int i=0;i<glist.size();i++)
            {	
            %>
               <a href="../gongji/content.jsp?id=<%=glist.get(i).getId()%>">
               <span id="title"> <%=glist.get(i).getTitle()%></span>
               <span id="writeday"><%=glist.get(i).getWriteday()%></span> <br></a>
            <%
            }
            %>    
            </td>
           <td width="333" id="tt" align="center"><a href="../board/board_list.jsp"> 자유게시판 </a> <p>
             <%
             
            for(int i=0;i<blist.size();i++)
            {	
            %>
              <a href="../board/board_content.jsp?id=<%=blist.get(i).getId()%>">
               <span id="title"> <%=blist.get(i).getTitle()%></span> 
               <span id="writeday"><%=blist.get(i).getWriteday()%></span> <br></a>
            <%
            }
            %> 
           </td>
           <td width="333" id="tt" align="center"><a href="../tour/tour_list.jsp">여행후기</a> <p>
             <%
             for(int i=0;i<tlist.size();i++)
             {	
             %>
               <a href="../tour/tour_content.jsp?id=<%=tlist.get(i).getId()%>">
                <span id="title"> <%=tlist.get(i).getTitle()%></span>                 
                <span id="writeday"><%=tlist.get(i).getWriteday()%></span> <br></a>
             <%
            }
            %> 
           </td> 
          </tr>       
      </table>
    </div>
    <div id="sixth">
    <%@page import="pension.dao.AdminDao" %>
    <%@page import="pension.dto.EventDto" %>
    <%@page import="java.util.ArrayList" %>
    <%
        AdminDao adao=new AdminDao();
        adao.main_list(request);
        ArrayList<EventDto> elist=(ArrayList<EventDto>)request.getAttribute("elist");
    %>
       <table width ="1000" height="200">
         <tr align="center">
         <%
         for(int i=0; i<elist.size();i++)
         {	 
         %>
           <td width="248"> <img src="../event/img/<%=elist.get(i).getImg()%>"> </td>
          <%
         }
          %>
        </tr>  
       </table>
    </div>
  <%@include file="../bottom.jsp"%>   