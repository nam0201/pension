<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   if(session.getAttribute("userid")==null)
   {
	   
     String y=request.getParameter("y");
     String m=request.getParameter("m");
     String d=request.getParameter("d");
     String id=request.getParameter("id");
     response.sendRedirect("../member/login.jsp?y="+y+"&m="+m+"&d="+d+"&id="+id);
   }  
   else
   {   
%>    
<%@include file="../top.jsp"%>
  <!-- reserve_next.jsp -->
  <%@page import="pension.dao.ReserveDao" %>
  <%@page import="pension.dto.RoomDto" %>
  <%@page import="java.text.DecimalFormat" %>
  <%@page import="util.MyJob" %>
  <%
       // 예약하고자 하는 방의 정보를 읽어온다..
      ReserveDao rdao=new ReserveDao();
      rdao.getRoom(request);
      RoomDto rdto=(RoomDto)request.getAttribute("rdto");
      
      //숙박 금액을 ,붙인 문자열로 변환
      DecimalFormat df=new DecimalFormat("#,###");
      String price=df.format(rdto.getPrice());  // ,를 붙인 1박 가격
  %>
 <style>
    #section{
        width : 1000px;
        height : 500px;
        margin : auto;   
    }
 </style>
  <script>
  
    function comma(num)
    {
    	return new Intl.NumberFormat().format(num);
    }
    /* 
    var tt=5461864;
    tt=new Intl.NumberFormat().format(tt);
    alert(tt); 
    */
    
    function hap()  //총결제금액을 구하는 함수
    {
    	//숙박 가격 : 객실의 1박 가격*숙박일수    	
    	var suk=parseInt(document.rform.suk.value);
    	var sprice=<%=rdto.getPrice()%>*suk;
    	document.getElementById("p1").innerText=comma(sprice);
    	//alert(sprice);
    	//초과인원 가격 : 1인당 추가금액*추가인원
    	var chuga=document.rform.inwon.value-<%=rdto.getMin()%>
    	var inwon=10000*chuga*suk;
    	document.getElementById("p2").innerText=comma(inwon);
    	//alert(inwon);
    	
    	//숯패키지 가격 : 패키지1개 가격 * 몇개 선택
    	var cprice=20000*document.rform.chacol.value;
    	document.getElementById("p3").innerText=comma(cprice);
    	//bbq패키지 가격 : 패키지1개 가격 * 몇개 선택
    	var bprice=45000*document.rform.bbq.value;
    	document.getElementById("p4").innerText=comma(bprice);
    	//총결제금액
    	var total=sprice+inwon+cprice+bprice;  //sprice에 ,가 들어있는데 더해서 문자로 됨.
    	document.rform.tprice.value=total;  //폼태그의 tprice에 값을 전달..
    	document.getElementById("ptot").innerText=comma(total);
    }
  </script>
 <div id="section">
  <!-- 입실일, 몇박, 인원, 숯패키지, 바비큐패키지 -->
  <form name="rform" method="post" action="reserve_ok.jsp">
   <input type="hidden" name="inday" value="<%=request.getAttribute("xday")%>">
   <input type="hidden" name="room_id" value="<%=rdto.getId()%>">
   <input type="hidden" name="tprice" value="<%=rdto.getPrice()%>">
   <table width="400" align="center">
     <caption> <h3> 예 약 하 기 </h3></caption>
       <tr>
          <td>객실명 </td>
          <td><%=rdto.getName()%> </td>
          <td> 가격(1박) </td>
          <td> <%=MyJob.comma(rdto.getPrice())%>원</td>
      </tr>  
       <tr>
         <td> 입실일 </td>
         <td><%=request.getAttribute("xday")%></td>
         <td> 숙박일수 </td>
         <td>
         <%
             //몇박이 가능한지를 체크
            int suk=rdao.getSuk(request);
         %>
           
         
             <select name="suk" onchange="hap()">  <!-- select는 보통 onchange사용 -->
               <%
                for(int i=1;i<=suk;i++)
                {	
               %>
               <option value="<%=i%>"><%=i%>박</option>
             <%
                }
             %>
             </select>
         </td>
       </tr>
      <tr>
        <td>기준인원 </td>
        <td> <%=rdto.getMin()%>/<%=rdto.getMax()%> </td>
        <td> 입실인원 </td>
        <td>
            <select name="inwon" onchange="hap()">
            <%
               for(int i=rdto.getMin();i<=rdto.getMax();i++)
               {	   
            %>
              <option value="<%=i%>"> <%=i%>명  </option>
            <%
               }
            %>  
            </select>
        </td>
      </tr>
      <tr>
        <td> 숯패키지 </td>
        <td>
           <select name="chacol" onchange="hap()">
             <option value="0"> 선택 </option>
             <option value="1"> 1 </option>
             <option value="2"> 2 </option>
             <option value="3"> 3 </option>
             <option value="4"> 4 </option>
             <option value="5"> 5 </option>
           </select>
        </td>
        <td> BBQ </td>
        <td>
          <select name="bbq" onchange="hap()">
             <option value="0"> 선택 </option>
             <option value="1"> 1 </option>
             <option value="2"> 2 </option>
             <option value="3"> 3 </option>
             <option value="4"> 4 </option>
             <option value="5"> 5 </option>
           </select>
        </td>
      </tr>
        <tr>
         <td>숙박가격</td>
         <td colspan="3" align="right"><span id="p1"><%=price%></span>원</td>
      </tr>
      <tr>
         <td>인원추가</td>
         <td colspan="3" align="right"><span id="p2">0</span>원</td>
      </tr>
        <tr>
         <td>숯패키지</td>
         <td colspan="3" align="right"><span id="p3">0</span>원</td>
      </tr>
        <tr>
         <td>BBQ</td>
         <td colspan="3" align="right"><span id="p4">0</span>원</td>
      </tr>
       <tr>
         <td>총 결제금액</td>
         <td colspan="3" align="right"><span id="ptot"><%=price%></span>원</td>
      </tr>
       
       <tr>
         <td colspan="4" align="center"><input type="submit" value="예약하기"></td>
       </tr>        
   </table>  
 </div>
 </form>


 <%@include file="../bottom.jsp"%>
 <%
 }
 %>