package util;

public class Test2 {
   
	public static void main(String[] args) {
	    
		  // 3�ڸ��� 0���� ä����� �� ��..
		  int num=3;
		  String imsi=num+"";
		  
		  //1�ڸ� => "00" ���̱�
		  //2�ڸ� => "0" ���̱�
		  //3�ڸ� => x
		  if(imsi.length()==1)
			  imsi="00"+imsi;
		  else if(imsi.length()==2)
			  imsi="0"+imsi;
		  
		  System.out.println(imsi);
   }
}
