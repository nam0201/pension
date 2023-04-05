<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<%@page import="pension.dao.TourDao" %>
<%@page import="pension.dto.TourDto" %>
<%@include file="../top.jsp"%> 
<%
     TourDao tdao=new TourDao();
     tdao.tour_content(request);
     
     TourDto tdto=(TourDto)request.getAttribute("tdto");
     
     String[] fname=(String[])request.getAttribute("fname");
     String userid=request.getAttribute("userid").toString();
%>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #section{
          width : 1000px;
          height : 600px;
          margin : auto; 
          margin-top: 50;
          border : 1px solid #724C00;
          background : white; 
          color : #633A00;
          position : relative;
       }
       #section table{
         border-spacing : 0px;
         align:center;
         height: 300px; 
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
       border-bottom:1px solid #633A00;
     }
     #section table tr:first-child td {
       border-top:2px solid #633A00;
       
       font-weight:900;
     }
   #section table tr:last-child td {
     border-bottom:2px solid #633A00;
   }
     #section a {
     color:#633A00;
     }    
     #section #content {
       width:100%;
       height:100%;
       overflow:auto;
       word-break:break-all; /*스페이스 없을경우 한줄로 나오는 것을 줄을 바꾸게 하기 */
     }
     /*
     word-break : normal; 생략과 동일 => 영역내에서 over 되는 한글은 줄이 바뀜, 영어는 안바뀜
     word-break: break-all; => 전부 줄이 바뀜
     word-break : keep-all; => 전부 줄이 안바뀜
     */
   #section #img_layer {
     position:absolute;
     left : 200px;
     width : 600px;
     height: 400px;
     visibility : hidden;
     border : 1px solid #633A00;
     background:white;
   }
 </style>
 <script>
   function views(my)
   {
	   document.getElementById("img_layer").style.visibility="visible";
	   document.getElementById("img").src=my;
   }
   function hides()
   {
	   document.getElementById("img_layer").style.visibility="hidden";
   }
   
 </script>
</head>
<body>
  <div id="section">
  <!-- 큰그림을 보여줄 레이어 -->
   <div id="img_layer"><img src="" width="100%" height="100%" id="img" onclick="hides()"></div>
    <table width="600" align="center">
      <caption><h3>여행후기 내용</h3></caption>
        <tr>
          <td width="120" align="center"> 제목 </td>
          <td><%=tdto.getTitle()%></td>
        </tr>
        <tr>
          <td align="center"> 작성자 </td>
          <td><%=tdto.getUserid() %></td>
        </tr>
         <tr>
          <td height="500" align="center"> 내용 </td>
          <td><div id="content"><%=tdto.getContent().replace("\r\n","<br>") %></div></td>
        </tr>
        <tr height="110">
          <td align="center"> 사 진 </td> 
          <td>
          <%
            for(int i=0; i<fname.length;i++)
            {	 
          %>
          <img src="img/<%=fname[i]%>" width="100" height="100" onclick="views(this.src)">  
         <%
            }
         %>
         </td>
       </tr>
        <tr>
          <td align="center"> 조회수 </td>
          <td><%=tdto.getReadnum() %></td>
        </tr>
        <tr>
          <td align="center"> 작성일 </td>
          <td><%=tdto.getWriteday() %></td>
        </tr>
        <tr>
          <td colspan="10" align="center">
          <a href="tour_list.jsp">목록</a>
          <%
            //수정 삭제 링크는 본인의 글일 경우 나타내기                     객체명.equals(객체명)
            if(session.getAttribute("userid")!=null && session.getAttribute("userid").equals(userid))
            {                        
          %>
          <a href="tour_update.jsp?id=<%=tdto.getId()%>">수정</a>   
           <a href="tour_delete.jsp?id=<%=tdto.getId()%>">삭제</a> 
            <%
            }
            %>
            
            
            </td>
         </tr>
       </table>  
       
  </div>
 
 <%@include file="../bottom.jsp"%> 
</body>
</html>