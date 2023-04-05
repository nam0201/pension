<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<!-- write.jsp -->
  <style>
     #section{
        width : 1000px;
        height : 500px;
        margin : auto;   
     }
     
     #section table {
       border-spacing:15px;
       margin-top : 30px;
         <!-- border-spacing 셀과 셀의 간격 -->
     }
      #section input[type=text]{
        width :300px;
        height :15px;
        border : 1px solid #D3C64A;
        outline : none;
        font-family: 'DeogonPrincess';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    #section input[type=password]{
        width :323px;
        height :15px;
        border : 1px solid #D3C64A;
        outline : none;    
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    #section input[type=submit]{
        width :200px;
        height :36px;
        border : 1px solid #D3C64A;
        outline : none;
        color:white;
        background:black;
        font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    #section textarea{
        width :306px;
        height :36px;
        border : 1px solid #D3C64A;
        outline : none;
        color:black;
        background:white;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
  </style>
   <div id="section">
       <table width="600" align="center">
          <caption><h3> 공지사항</h3></caption>
          <form method="post" action="write_ok.jsp">
              <tr>
                 <td align="center"> 제  목 </td>
                 <td align="center"><input type="text" name="title" id="title"></td>
              </tr>
              <tr>             
                <td align="center"> 내 용</td>
                <td align="center"><textarea cols="40" rows="5" name="content" id="content"></textarea></td>
              </tr>
              <tr>
                <td colspan="2" align="center">
                  <input type="checkbox" name="chk" value="1"> 체크하시면 항상 첫 페이지에 나오는 공지사항입니다.</td>
               </tr>   
              <tr>
                 <td colspan="2" align="center"><input type="submit" value="공지사항저장"></td>
              </tr>
                      
          </form>
        </table>

 </div>


 <%@include file="../bottom.jsp"%>