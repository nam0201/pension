package util;

public class Test {

	public static void main(String[] args) {
		/*
		room_id : 1~6
        "0"+room_id  => 01, 02

        room_id :  1~14
          
        "0"+room_id =>  
        */
		//Integer room_id=3;
		//String imsi=room_id.toString();
		
		int room_id=3;
		
		String imsi=room_id+"";  //���ڷ� ����
		
		if(imsi.length()==1)     //���̸� üũ
			imsi="0"+imsi;
		
		System.out.println(imsi);

	}

}
