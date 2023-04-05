<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %> 
<style>
 #section {
   width:780px;
   height:500px;
   margin:auto;
  }
</style>
 <div id="section">
   <form method="post" action="admin_event_add_ok.jsp" enctype="multipart/form-data">
   <table width="700" align="center">
     <caption> <h3> 이벤트 추가하기 </h3></caption>
     <tr>
       <td> 이벤트 개요 </td>
       <td> <input type="text" name="title"></td>
     </tr>
     <tr>
       <td> 이벤트 그림 </td>
       <td> <input type="file" name="img"></td>
     </tr>
     <tr>
     <td></td>
       <td colspan="2"><input type="submit" value="이벤트등록"></td>
     </tr>      
   </table>
  </form> 
 
 
 </div>
</body>
</html>