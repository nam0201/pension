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
        border : 1px solid #4B0700;
        background:#E5D85C;
        outline : none;
        font-family: 'DeogonPrincess';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    
    #section input[type=submit]{
        width :200px;
        height :36px;
        border : 1px solid #4B0700;
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
        border : 1px solid #4B0700;
        outline : none;
        color:black;
        background:#E5D85C;
        font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    #section input[type=button]{
    font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
    #section input[type=file]{
    font-weight:900;
        font-family: 'DeogonPrincess';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2205@1.0/DeogonPrincess.woff2') format('woff2');
    }
 
 </style>
<script>
  function add_form()
  {
	  var size=document.getElementsByClassName("up").length;
	  if(size<10)
	  {
	     var outer=document.getElementById("outer");
	     outer.innerHTML=outer.innerHTML+"<p class='up'> <input type='file' name='fname"+(size+1)+"'> </p> ";
	     if(size>4) // 크기가 4초과 (5부터)
	     {
	    	
	    	 var h=size*50;
	    	 document.getElementById("section").style.height=document.getElementById("section").style.height+h+"px";
	    	 
	    	 document.getElementById("section").style.height=500+(size*40)+"px";
	     }	 
	  }
  }
  function del_form()
  {
	  // class='up'의 크기를 알수 있다
	  //alert(document.getElementsByClassName("up").length);
	  var size=document.getElementsByClassName("up").length;
	  if(size!=1) // 하나만 남았을경우 삭제 중지
	    document.getElementsByClassName("up")[size-1].remove();
	  
	  document.getElementById("section").style.height=500+(size*40)+"px";
  }
 </script>
  <div id="section">
    <form method="post" action="tour_write_ok.jsp" enctype="multipart/form-data">
      <table width="600" align="center">
        <caption> <h3> 여행후기 작성 </h3></caption>
        <tr>
          <td> 제 목 </td>
          <td> <input type="text" name="title" id="title"> </td>        
        </tr>
        <tr>
          <td> 내 용 </td>
          <td> <textarea name="content" id="content"></textarea> </td>
        </tr>
        <tr>
          <td> 사 진 </td>
          <td id="outer">
           <input type="button" value="추가" onclick="add_form()"> <input type="button" value="삭제" onclick="del_form()">
           <p class="up"> <input type="file" name="fname1" > </p> 
           
          </td>
        </tr>
        <tr>
          <td colspan="2" align="center"> <input type="submit" value="후기 작성" id="submit"> </td>
        </tr>
      </table>
    </form>
    
  
  </div>
  
 <%@ include file="../bottom.jsp"%>