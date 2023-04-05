<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>
<%@page import="pension.dao.TourDao" %>
<%@page import="pension.dto.TourDto" %>
<%
    TourDao tdao=new TourDao();
    tdao.tour_update(request);
    TourDto tdto=(TourDto)request.getAttribute("tdto");
    String[] fname=(String[])request.getAttribute("fname");
%>
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
  // 삭제할 그림파일의 opacity를 낮춘다
  function sel(n,my)
  {
	 //alert(n,my);
	 if(my)
	 {	 
	    // 인덱스값이 같은 체크박스의 체크가 되었다면 => 0.2
	    document.getElementsByClassName("img")[n].style.opacity=0.2;
	 } 
	 else
	 {	 
	    // 체크가 해제되었다면 => 1
	    document.getElementsByClassName("img")[n].style.opacity=1;
	 }
  }
  
  function check()
  {
	  // 삭제할 그림, 남겨둘 그림목록을 전달할수 있게 동작
	  var chk=document.getElementsByClassName("chk"); // 체크박스
	  var img=document.getElementsByClassName("img"); // 그림파일
	  
	  var delimg="";  // 삭제할 파일의 이름을 ,로 구분
	  var eximg="";   // 남겨질 파일의 이름을 ,로 구분
	  //chk[0].checked true => img[0] 은 삭제
	  //               false => img[1] 은 남겨진다
	  
	  //alert(chk[0].value);
	  
	  for(i=0;i<chk.length;i++)
	  {
	     if(chk[i].checked)
	     {	  
	        // 삭제된다 => checkbox가 체크된것
	        delimg=delimg+chk[i].value+",";
	     }
	     else
 	     {	  
	        // 남겨진다 => checkbox가 체크가 안된것
	        eximg=eximg+chk[i].value+",";
 	     }
	  }
	  
	  //alert(delimg);
	  //alert(eximg);
	  
	  document.upform.delimg.value=delimg;
	  document.upform.eximg.value=eximg;
	 
  }
 </script>
  <div id="section">
    <form name="upform" method="post" action="tour_update_ok.jsp"  onsubmit="return check()" enctype="multipart/form-data">
      <input type="hidden" name="delimg">  <!-- 삭제할 이미지의 명단을 담을 태그 -->
      <input type="hidden" name="eximg">   <!-- 남겨질 이미지의 명단을 담을 태그 -->
      <input type="hidden" name="id" value="<%=tdto.getId()%>">
      <table width="600" align="center">
        <caption> <h3> 여행후기 작성 </h3></caption>
        <tr>
          <td> 제 목 </td>
          <td> <input type="text" name="title" id="title" value="<%=tdto.getTitle()%>"> </td>        
        </tr>
        <tr>
          <td> 내 용 </td>
          <td> <textarea name="content" id="content"> <%=tdto.getContent()%></textarea> </td>
        </tr>
        <tr height="100">  <!-- 테이블에 올린 사진들을 출력 -->          
          <td> 사 진 </td>
          <td>
          <%
          for(int i=0; i<fname.length;i++)
          {	  
          %>
           <img src="img/<%=fname[i]%>" width="50" height="50" class="img">  <!-- 여러개는 class로 -->
           <input type="checkbox" onclick="sel(<%=i%>, this.checked)" class="chk" value="<%=fname[i]%>">
          <%
          }
          %>
           <br><span style="color:red;font-size:13px;"> 삭제할 그림을 체크하세요</span>
          </td>
          </tr>
          <tr>
           <td> 추가사진 </td>
          <td id="outer">
           <input type="button" value="추가" onclick="add_form()"> <input type="button" value="삭제" onclick="del_form()">
           <p class="up"> <input type="file" name="fname1"> </p> 
           
          </td>
        </tr>
        <tr>
          <td colspan="2" align="center"> <input type="submit" value="후기 수정" id="submit"> </td>
        </tr>
      </table>
    </form>
    
  
  </div>
  
 <%@ include file="../bottom.jsp"%>