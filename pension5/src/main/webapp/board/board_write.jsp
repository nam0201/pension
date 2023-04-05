<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>

  <style>
      #section{
        width :1000px;
        height :500px;
        margin :auto;
        text-align:center;
        margin-top : 50px;
        
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
        font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
  </style>
  <div id="section">
     <form name="pk" method="post" action="board_write_ok.jsp">
        <table width="1000" align="center">
          <tr>
            <td> 제   목 
             <input type="text" name="title"></td>
          </tr>
           <tr>
            <td> 이   름 
             <input type="text" name="name"></td>
          </tr>
           <tr>
            <td> 비밀번호
             <input type="password" name="pwd"></td>
          </tr>
           <tr>
            <td> 내  용 
            <textarea background="white" cols="40" rows="4" name="content"></textarea></td>
          </tr>
           <tr>
            <td> 선호 여행지
            
              <input type="checkbox" name="dest" value="0"> 전주
              <input type="checkbox" name="dest" value="1"> 광주
              <input type="checkbox" name="dest" value="2"> 속초
              <input type="checkbox" name="dest" value="3"> 부산
              <input type="checkbox" name="dest" value="4"> 대구
              <input type="checkbox" name="dest" value="5"> 강릉
              <input type="checkbox" name="dest" value="6"> 제주
              <input type="checkbox" name="dest" value="7"> 포항
            </td>
          </tr>
          <tr>
          <td></td>
          </tr>
           <tr>
             <td> <input type="submit" value="입력"> </td>
            </tr>  
        </table>
     
     </form>
  </div>



<%@include file="../bottom.jsp"%>