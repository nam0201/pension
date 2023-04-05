package util;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Vector;

public class Enu {

	public static void main(String[] args) {
		// Enumeration : 요소들을 담는 클래스  => 순서를 가지지 않음
		// Vector라는 elements() 메소드는 Vector에 있는 값을 Enumeration으로 전달
		Vector<String> vector=new Vector<String>();
		vector.add("배트맨");
		vector.add("슈퍼맨");
		vector.add("원더우먼");
		
		Enumeration enu=vector.elements();
		// hasMoreElements() : 요소가 존재하면 true, 없으면 false
		// nextElement() : 요소를 가져오기
		while(enu.hasMoreElements())
		{
		    System.out.println(enu.nextElement());	
		}
		
		// Iterator
		// ArrayList iterator() 메소드를 통해 값을 Iterator객체로 전달..
		ArrayList<String> list=new ArrayList<String>();
		list.add("aaa");
		list.add("bbb");
		list.add("ccc");
		list.add("ddd");
		
		// hasNext() : 다음 요소가 존재하냐? true, false
		// next() : 요소 가져오기
		Iterator ite=list.iterator();
		
		while(ite.hasNext())
		{
			System.out.println(ite.next());
		}

	}

}
