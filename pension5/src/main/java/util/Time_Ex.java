package util;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Date;

public class Time_Ex {
    public static void main(String[] args) {
		//Date��ü ��¥��
    	
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
    	//LocalDate�� ���� ó���ϱ�
    	LocalDate today=LocalDate.now();
    	LocalDate xday=LocalDate.of(2022, 12, 22);
    	
    	//��¥�� ��¥���� ���Ͽ� ������ ���� : ������¥�� -, ���Ĵ�+ / ��¥�� �󸶳� ���̳���?
    	System.out.println( today.until(xday, ChronoUnit.DAYS) );
    	
    	//���ú��� ���� ��¥(20������ true, 21���ʹ� false)
    	//System.out.println(xday.isBefore(today));
    	//ù��°���
    	if(xday.isBefore(today))
    	{
    		
    	}
    	else
    	{
    		System.out.println("123456");
    	}
    	//�ι�° ���
    	if(!xday.isBefore(today))
    	{
    		System.out.println("123456");
    	}
    	//����° ���
    	if( today.isEqual(xday)  ||  today.isAfter(xday))  //���ð� ���ų� ���� ��¥�� ���
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
