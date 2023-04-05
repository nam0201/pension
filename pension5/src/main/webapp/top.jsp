<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <style>
   @font-face 
      {
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
       }
      body {
         font-family: 'DeogonPrincess';
         src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
         font-weight: normal;
         font-style: normal;
         margin : 0px;
         padding : 0px;
      }
      
      #outers{
         width:100%;
         height:28px;
         background: #FFE08C;
      }
      
      #first {
           width : 1000px;
           height :28px;
           background : #FFE08C;
           margin : auto; 
           font-family: 'DeogonPrincess';
           src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
           font-weight: normal;
           font-style: normal; 
      }
      #first #left {
          width : 950px;
          height : 28px;
          float : left;
          text-align : center;
          color:#4B0700;
          font-family: 'DeogonPrincess';
           src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
           font-weight: normal;
           font-style: normal;
          
      }
      #first #right {
         width : 40px;
         height : 28px;
         float : right;
         text-align : right;
         color:#4B0700;
      }
      #second {
           width : 1000px;
           height : 30px;
           background : #FAE0D4;
           margin : auto;
           margin-bottom : 0px;
           text-align : right;
           font-size : 13px;
   
      }
      #second #mmain {
         position : relative;
         display:inline-block;
      }
      #second #msub {
        position : absolute;
        left:-10px;
        top:6px;
    
        padding-left:0px;
        padding-right:0px;
        border:1px solid #4B0700;
        padding:8px;
        background:white;
        z-index:1;
         visibility:hidden;
       
      }
      #second #msub li{
        list-style-type:none;
        width:39px;
     
      }
      #third {
           width:1000px;
           height : 30px;           
           margin : auto;
           margin-top:0px;
           color:white;
           background : #C98500
      }
      #third > ul  {  /* 메뉴를 왼쪽으로 옮기기 위해 ul의 padding을 조절 */
          padding-left:10px;
      } 
      #third .main {  /* 주메뉴 */
           display : inline-block;
           list-style-type:none;
           width : 155px;
           position: relative;
      }
      #third .main .sub{  /*부메뉴의 ul태그*/
          position : absolute;
          padding-left : 0px;
          left:--5px;
          visibility:hidden;
          color : #796C00;
          z-index : 1;
      }
      #third .main .sub li {  /* 하위메뉴의 li태그 */
           list-style-type : none;
           width : 85px;
           height:25px;
           background:#FFFFD7;
           padding:4px;
      }
        #seventh {
          width:1000px;
          height:150px;
          margin:auto;
          font-size:13px;
          margin-top:15px;
          color:white;
          background:#544A00;
      }
      #seventh table {
         padding-top:30px;
      }
     a{
      text-decoration:none;
      color:black;
     }
   </style>
   <script>
    
     function first_hide() // 1층 숨기기
     {
	   document.getElementById("outers").style.display="none";
	   
	   // 쿠키변수를 생성 => ajax를 이용
	   var chk=new XMLHttpRequest();
	   chk.open("get","../mycookie.jsp");
	   chk.send();
     }
     
     function view_menu(n)  //5개의 class="sub" 요소 중에 하나를 보여준다..
     {
    	 document.getElementsByClassName("sub")[n].style.visibility="visible";
     }
     
     function hide_menu(n)
     {
    	 document.getElementsByClassName("sub")[n].style.visibility="hidden";
     }
     function my_view()
     {
    	 document.getElementById("msub").style.visibility="visible";
     }
     function my_hide()
     {
    	 document.getElementById("msub").style.visibility="hidden";
     }
   </script>
</head>
<body>
<%@page import="util.MyCookie" %>
 <%
  boolean ch=MyCookie.isCookie(request); 
 
 if(ch)   // (ch==0) // chk 쿠키변수가 없으면
 {
%> 
    <div id="outers">
      <div id="first">
      <div id="left"> 크리스마스 특별 이벤트 3박에 100,000원!!!</div>
      <div id="right"> <span onclick="first_hide()"> X </span> </div>
   </div>
 </div>
<%
 }
%> 
    <div id="second">
       <%
       if(session.getAttribute("userid")==null) //로그인 하지 않은 상태
       {
       %>	   
       <a href="../member/login.jsp">로그인</a> | <a href="../member/member_input.jsp">회원가입</a> | <a href="../manto/manto_write.jsp">1:1질문</a>
       <%
       }
       else if(session.getAttribute("userid").equals("admin"))  //admin인 경우
       {
       %>
           <%=session.getAttribute("name")%> 님 | <a href="../member/logout.jsp">로그아웃</a> 
            |  <a href="../admin/admin_main.jsp">관리페이지 </a>
       <% 	    
       }
       else  //나머지 회원인경우
       {   
       %>
       <%=session.getAttribute("name")%>님 환영하오!!  |   <a href="../member/logout.jsp">로그아웃</a> 
        |  <a href="../manto/manto_write.jsp">1:1질문</a>  | <span id="mmain" onmouseover="my_view()" onmouseout="my_hide()"> 마이페이지
          <ul id="msub">
             <li> <a href="../member/member_view.jsp">회원정보</a> </li>
             <li> <a href="../reserve/reserve_all.jsp">예약현황 </a></li>
             <li> <a href="../manto/manto_list.jsp">나의질문</a> </li>
           </ul> 
            </span>  
       <%
       }
       %> 
    </div>   
    <div id="third">
      <ul>
        <li class="main"><a href="../main/main.jsp"> <img src="../img/2.png" width="25" height="25" style="padding-top:2px;"> </a></li>
        <li class="main" onmouseover="view_menu(0)" onmouseout="hide_menu(0)"> 펜션소개 
           <ul class="sub">
              <li> 소개인사 </li>
              <li> 오시는 길 </li>
           </ul>
        </li>
        <li class="main" onmouseover="view_menu(1)" onmouseout="hide_menu(1)"> 객실현황 
           <ul class="sub">
           <%@page import="pension.dao.ReserveDao"%>
           <%@page import="java.util.ArrayList" %>
           <%@page import="pension.dto.RoomDto" %>
           <%
               //room 테이블에서 객실명을 가져와서 li태그에 이름을 출력 
               ReserveDao rdao2=new ReserveDao();
               rdao2.getRoomName(request);
               ArrayList<RoomDto> rlist2=(ArrayList<RoomDto>)request.getAttribute("rlist");
              
               for(int i=0;i<rlist2.size();i++)
               {
           %>
              <li> <a href="../room/room_view.jsp?id=<%=rlist2.get(i).getId()%>"> <%=rlist2.get(i).getName()%> </a> </li>
            
            <%
               }
            %>  
              
          </li>    
           </ul>
        <li class="main" onmouseover="view_menu(2)" onmouseout="hide_menu(2)"> 주변관광지 
           <ul class="sub">
             <li> 해운대 </li>
             <li> 킨텍스 </li>
             <li> 호수공원 </li>
             <li> 서오능 </li>
           </ul>
        </li>
        <li class="main" onmouseover="view_menu(3)" onmouseout="hide_menu(3)"> 예약하기 
           <ul class="sub">
             <li> 예약 안내 </li>
             <li><a href="../reserve/reserve.jsp"> 실시간예약 </a></li>
             <li>예약현황 </li>
           </ul>
        </li>
        <li class="main" onmouseover="view_menu(4)" onmouseout="hide_menu(4)"> 커뮤니티 
             <ul class="sub">
               <li> <a href="../gongji/list.jsp">공지사항</a> </li>
               <li> <a href="../board/board_list.jsp">자유게시판 </a></li>
               <li> <a href="../tour/tour_list.jsp">여행후기</a> </li>
             </ul>
        </li>
      </ul>
    </div>