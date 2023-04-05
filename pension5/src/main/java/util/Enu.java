package util;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Vector;

public class Enu {

	public static void main(String[] args) {
		// Enumeration : ��ҵ��� ��� Ŭ����  => ������ ������ ����
		// Vector��� elements() �޼ҵ�� Vector�� �ִ� ���� Enumeration���� ����
		Vector<String> vector=new Vector<String>();
		vector.add("��Ʈ��");
		vector.add("���۸�");
		vector.add("�������");
		
		Enumeration enu=vector.elements();
		// hasMoreElements() : ��Ұ� �����ϸ� true, ������ false
		// nextElement() : ��Ҹ� ��������
		while(enu.hasMoreElements())
		{
		    System.out.println(enu.nextElement());	
		}
		
		// Iterator
		// ArrayList iterator() �޼ҵ带 ���� ���� Iterator��ü�� ����..
		ArrayList<String> list=new ArrayList<String>();
		list.add("aaa");
		list.add("bbb");
		list.add("ccc");
		list.add("ddd");
		
		// hasNext() : ���� ��Ұ� �����ϳ�? true, false
		// next() : ��� ��������
		Iterator ite=list.iterator();
		
		while(ite.hasNext())
		{
			System.out.println(ite.next());
		}

	}

}
