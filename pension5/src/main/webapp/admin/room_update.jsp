<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="admin_top.jsp" %> 
<%@page import="pension.dao.AdminDao" %>
<%@page import="pension.dto.RoomDto" %>
<%
    AdminDao adao=new AdminDao();
    adao.room_update(request);
    RoomDto rdto=(RoomDto)request.getAttribute("rdto");
%>
<!-- room_update.jsp -->
<style>
 #section {
   width:780px;
   height:500px;
   margin:auto;
  }
  #section #gform{
   font-size:10px;
   
  }
</style>
<script>
   window.onload=function()
    {
	  document.rform.min.value=<%=rdto.getMin()%>;
	  document.rform.max.value=<%=rdto.getMax()%>;
	  
	  //문서를 읽을 때 그림의 갯수에 따라 type="file"의 갯수를 출력
	  var len=document.getElementsByClassName("chk").length;
	  //alert(len);   // 3-len => 보여질 type="file"의 갯수
	  
	  for(i=0;i<3-len;i++)   // len => 0 : 0,1,2     1:0,1,        2:0
	 {	  
	  document.getElementsByClassName("fname")[i].style.display="inline";
	 }
	  // fname => 0 1 2
    }
   
   function check()
   {
	   //삭제할 그림파일은 delimg변수, 존재할 그림파일은 eximg변수에 저장
	   var delimg="";
	   var eximg="";
	   
	   var chk=document.getElementsByClassName("chk");
	   var n=0;
	   for(i=0;i<chk.length;i++)   //체크박스가 있는 만큼 동작..
	   {
		   if(chk[i].checked)
		   {
			   delimg=delimg+chk[i].value+",";  //"그림파일1, 그림파일2 ,"
		   }
		   else
		   {
			   eximg=eximg+chk[i].value+",";   //"그림파일3, 그림파일4 ,"
		       n++;
		   }	   
	   }
	   
	   document.rform.delimg.value=delimg;
	   document.rform.eximg.value=eximg;
	   
	   //기존의 보이는 것을 전부숨김
	   for(i=0;i<3;i++)
	   {
		  document.getElementsByClassName("fname")[i].style.display="none";
	   }
	   // type="file"의 갯수를 변화 (삭제하고자 하는 그림이 발생하면)
	   // 3 - 체크된 체크박스갯수만큼 type="file"을 추가..
	   for(i=0;i<3-n;i++)
	  {
		   document.getElementsByClassName("fname")[i].style.display="inline";
	  }   
	   
   }
</script>
 <div id="section">
  <form name="rform" method="post" action="room_update_ok.jsp" enctype="multipart/form-data">
   <input type="hidden" name="delimg">
   <input type="hidden" name="eximg" value="<%=rdto.getRimg()%>">
   <input type="hidden" name="id" value="<%=rdto.getId()%>">
   <table width="480" align="center">
     <caption> <h3> 객실 수정 </h3></caption>
     <tr>
       <td> 객실명 </td>
       <td> <input type="text" name="name" value="<%=rdto.getName()%>"> </td>
     </tr>
     <tr>
       <td> 객실사진 </td>
       <td>
         <!-- 테이블에 있는 그림을 출력 -->
         <%
           if(rdto.getRimg() != null && !rdto.getRimg().trim().equals(""))   // null일 경우 사용금지
           {	   
             String[] img=rdto.getRimg().split(",");   //그림파일을 포함 "1.jpg, 2.jpg"
          
             for(int i=0;i<img.length;i++)
             {
         %>   	 
                 <img src="../room/img/<%=img[i]%>" width="50">
                 <input type="checkbox" class="chk" onclick="check()" value="<%=img[i]%>">
          <% 
             }
           }   
         %>
         
            
         <hr>
         <div id="gform" style="color:red">체크박스 선택시 해당 파일이 삭제됩니다.</div>
         <!-- 새로 추가하는 폼 --> 
         <input type="file" name="fname1" class="fname" style="display:none;"> <br>
         <input type="file" name="fname2" class="fname" style="display:none;"> <br>
         <input type="file" name="fname3" class="fname" style="display:none;"> <br>
       </td>
     </tr> 
     <tr>
       <td> 1박가격 </td>
       <td> <input type="text" name="price" value="<%=rdto.getPrice()%>"> </td>
     </tr>
     <tr>
       <td> 최소인원 </td>
       <td>
         <select name="min">
          <%
          for(int i=1;i<=20;i++)
          {
          %>
          <option value="<%=i%>"> <%=i%>명 </option>
          <%
          }
          %>
         </select>
       </td>
     </tr>
     <tr>
       <td> 최대인원 </td>
       <td>
       <select name="max">
          <%
          for(int i=1;i<=20;i++)
          {
          %>
          <option value="<%=i%>"> <%=i%>명 </option>
          <%
          }
          %>
         </select>
       </td>
     </tr>
     <tr>
       <td> 객실내용 </td>
       <td> <textarea name="content" id="content"><%=rdto.getContent()%></textarea> </td>
     </tr>
     <tr>
       <td colspan="2"> <input type="submit" value="객실수정">
     </tr>
   </table>
  </form>
 </div>
</body>
</html>