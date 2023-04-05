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
          width : 1100px;
          height : 200px;
          margin-top:8px;
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
    var index = 0;   //이미지에 접근하는 인덱스
    window.onload = function(){
    slideShow();
           }

    function slideShow() {
    var i;
    var x = document.getElementsByClassName("slide1");  //slide1에 대한 dom 참조
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
     }
    index++;
    if (index > x.length) {
       index = 1;  //인덱스가 초과되면 1로 변경
     }   
    x[index-1].style.display = "block";  //해당 인덱스는 block으로
   setTimeout(slideShow, 4000);   //함수를 4초마다 호출

    }
  </script>
    <div id="fourth">
      <img class="slide1" src="../img/1229.jpg" width="1000" height="280">
      <img class="slide1" src="../img/11.jpg" width="1000" height="280">
      <img class="slide1" src="../img/18.jpg" width="1000" height="280">
      <img class="slide1" src="../img/19.jpg" width="1000" height="280">
      <img class="slide1" src="../img/20.jpg" width="1000" height="280">
      <img class="slide1" src="../img/16.jpg" width="1000" height="280"> 
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
    <script>
     //그림을 배열로 처리
     <%
        //elist에 들어있는 edto에서 img변수의 값을 아래의 배열에 넣는다.
        String str="";
        for(int i=0;i<elist.size();i++)
        {
        	str=str+"'"+elist.get(i).getImg()+"'";
        	if(i!=(elist.size()-1))
        	str=str+",";
        }
     %>
     
      var simg=[<%=str%>];                            //["e1.png","e2.png","e3.png","e4.png"];    
      var v=0;  // 보이는 이미지 중 가장 앞 인덱스
      function left_move()   // v의 값이 -1
      {
    	  v--;
 		 if(v==-1)
 	        v=simg.length-1;   //마지막 인덱스를 뜻한다.
 		 var chk=v;
 		 
 		 for(i=0;i<4;i++)  //4개의 그림을 넣기위한 form
 		 {
 			 if(chk==-1)
 				 chk=simg.length-1;
 			 
 			 document.getElementsByClassName("img")[i].src="../event/img/"+simg[chk];
 			 chk--;
 		 }	
      }
      
      function right_move()  //v의 값이 +1
      {
    	  v++;
    	  if(v==simg.length)
    		  v=0;   //첫번째 인덱스
    	  
    	  var chk=v;
    	  // v가 0일때 오른쪽 클릭 => v=1; 배열의 1번부터  4개를 가져온다..
    	  for(i=0;i<4;i++)   
    	 {
    		  if(chk==simg.length)
    			  chk=0;
    		  
    		  document.getElementsByClassName("img")[i].src="../event/img/"+simg[chk];
    		  chk++;
    	 }	  
    	  /*
    	  for(i=0;i<4;i++)  // i=0  1  2  3   배열 :  1  2  3  4
    	 {
    		  if((chk+i)==simg.length)
    		      chk=0-i;
    		  
    		  document.getElementsByClassName("img")[i].src="../event/img/"+simg[chk+i];
    	 }
    	 */ 
      }
    </script>
       <table width ="1100" height="200" align="center">
         <tr align="center">
           <td width="50" style="border:none;" onclick="left_move()"> ◀ </td>
         <%
         for(int i=0;i<4;i++)
         {	 
         %>
           <td width="248"> <img class="img" width="241" height="200" src="../event/img/<%=elist.get(i).getImg()%>"> </td>
          <%
         }
          %>
          <td width="50" style="border:none;" onclick="right_move()"> ▶ </td>
        
        </tr>  
       </table>
    </div>
  <%@include file="../bottom.jsp"%>   