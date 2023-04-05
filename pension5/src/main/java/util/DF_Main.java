package util;

import java.text.DecimalFormat;

public class DF_Main {
	
	public static void main(String[] args) {
		 //DecimalFormat
		//생성자에 매개변수로 출력할 형태를 지정
		double num=51357.6726;
		
		DecimalFormat df=new DecimalFormat("0");
		System.out.println(df.format(num));
		
		df=new DecimalFormat("0.0");
		System.out.println(df.format(num));
		
		df=new DecimalFormat("0.00");
		System.out.println(df.format(num));
		
		df=new DecimalFormat("000000000.000000000");
		System.out.println(df.format(num));
		
		df=new DecimalFormat("#");
		System.out.println(df.format(num));
		
		df=new DecimalFormat("#.#");
		System.out.println(df.format(num));
		
		df=new DecimalFormat("#,###");
		System.out.println(df.format(num));
	}

}
