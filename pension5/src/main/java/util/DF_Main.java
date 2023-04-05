package util;

import java.text.DecimalFormat;

public class DF_Main {
	
	public static void main(String[] args) {
		 //DecimalFormat
		//�����ڿ� �Ű������� ����� ���¸� ����
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
