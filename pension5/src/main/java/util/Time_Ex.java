package util;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Date;

public class Time_Ex {
    public static void main(String[] args) {
		//Date객체 날짜비교
    	
    	/*
    	Date today=new Date();  // 2022-12-22
    	Date xday=new Date(122,11,25);  //2022-12-25
    	//System.out.println(today.getYear());
    	
    	if(today.getTime() > xday.getTime())
    	{
    		System.out.println("today");
    	}
    	else
    	{
    		System.out.println("xday");
    	}
    	*/
    	//LocalDate를 통해 처리하기
    	LocalDate today=LocalDate.now();
    	LocalDate xday=LocalDate.of(2022, 12, 22);
    	
    	//날짜와 날짜간의 비교하여 정수를 리턴 : 이전날짜는 -, 이후는+ / 날짜가 얼마나 차이나냐?
    	System.out.println( today.until(xday, ChronoUnit.DAYS) );
    	
    	//오늘보다 적은 날짜(20까지는 true, 21부터는 false)
    	//System.out.println(xday.isBefore(today));
    	//첫번째방법
    	if(xday.isBefore(today))
    	{
    		
    	}
    	else
    	{
    		System.out.println("123456");
    	}
    	//두번째 방법
    	if(!xday.isBefore(today))
    	{
    		System.out.println("123456");
    	}
    	//세번째 방법
    	if( today.isEqual(xday)  ||  today.isAfter(xday))  //오늘과 같거나 뒤의 날짜인 경우
    	{
    		System.out.println("123456");
    	}
    	
    
    	System.out.println(xday.isAfter(today));
    	
    	if(xday.isBefore(today))
    	{
    		//System.out.println("NO");
    	}
    	
    	if(!today.isAfter(xday))
    	{
    		//System.out.println("chul");
    	}
    	
    	
    	
    	
    	/*
    	System.out.println( today.isAfter(xday)   );
    	System.out.println( today.isBefore(xday)  );
    	System.out.println( today.isEqual(xday)   );
	    */
    	
	}
}
