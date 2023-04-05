package util;

public class Test2 {
   
	public static void main(String[] args) {
	    
		  // 3자리를 0으로 채우고자 할 때..
		  int num=3;
		  String imsi=num+"";
		  
		  //1자리 => "00" 붙이기
		  //2자리 => "0" 붙이기
		  //3자리 => x
		  if(imsi.length()==1)
			  imsi="00"+imsi;
		  else if(imsi.length()==2)
			  imsi="0"+imsi;
		  
		  System.out.println(imsi);
   }
}
