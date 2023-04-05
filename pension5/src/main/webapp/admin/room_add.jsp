<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ include file="admin_top.jsp" %> 
<!-- room_add.jsp -->
<style>
 #section {
   width:780px;
   height:500px;
   margin:auto;
  }
</style>
 <div id="section">
  <form name="rform" method="post" action="room_add_ok.jsp" enctype="multipart/form-data">
   <table width="480" align="center">
     <caption> <h3> 객실 추가 </h3></caption>
     <tr>
       <td> 객실명 </td>
       <td> <input type="text" name="name"> </td>
     </tr>
     <tr>
       <td> 객실사진 </td>
       <td> 
         사진1 <input type="file" name="fname1"> <br>
         사진2 <input type="file" name="fname2"> <br>
         사진3 <input type="file" name="fname3"> <br>
       </td>
     </tr> 
     <tr>
       <td> 1박가격 </td>
       <td> <input type="text" name="price"> </td>
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
       <td> <textarea name="content" id="content"></textarea> </td>
     </tr>
     <tr>
       <td colspan="2"> <input type="submit" value="객실등록">
     </tr>
   </table>
  </form>
 </div>
</body>
</html>