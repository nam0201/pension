package util;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;


// 자주 사용하는 형태를 메소드를 통해 구현하고 필요시 호출
public class MyJob {
     
	   public static String comma(int num)
	   {
		   System.out.println("comma method");
		   DecimalFormat df=new DecimalFormat("#,###");
		   return df.format(num);
	   }
	   
	   public static long getUntil(String adate,String bdate)
	   {
		   String[] imsi1=adate.split("-");
		   String[] imsi2=bdate.split("-");
		   
		   int y1=Integer.parseInt(imsi1[0]);
		   int m1=Integer.parseInt(imsi1[1]);
		   int d1=Integer.parseInt(imsi1[2]);
		   
		   int y2=Integer.parseInt(imsi2[0]);
		   int m2=Integer.parseInt(imsi2[1]);
		   int d2=Integer.parseInt(imsi2[2]);
		   
		   LocalDate aday=LocalDate.of(y1, m1, d1);
		   LocalDate bday=LocalDate.of(y2, m2, d2);
		   //나중에 날짜가 뒤로 가면 -값이 나옴
		   long num=aday.until(bday,ChronoUnit.DAYS);
		   
		   return num;
	   }
	   
	   public static void main(String[] args) {
		   //2개의 날짜의 차이를 비교
		   LocalDate aday=LocalDate.of(2022, 12, 30);
		   LocalDate bday=LocalDate.of(2023, 1, 2);
		   
		   long num=aday.until(bday,ChronoUnit.DAYS);
		   
		   System.out.println(num);
		   
	   }
}
