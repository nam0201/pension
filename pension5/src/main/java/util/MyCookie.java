package util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyCookie {
      public static void setCookie(HttpServletResponse response)
      {
    	    Cookie cookie=new Cookie("chk","11");
    	    cookie.setMaxAge(600);
    	    response.addCookie(cookie);
      }
      
      public static boolean isCookie(HttpServletRequest request)
      {
    	  Cookie[] cookie=request.getCookies();
    	  
    	  boolean ch=true;
    	   if(cookie!=null)
    	   {
    	   for(int i=0;i<cookie.length;i++)
    	   {
    		 if(cookie[i].getName().equals("chk"))
    		 {
    			 // ch=1;
    			 ch=false;
    		  }
    	     }
    	  }
    	   return ch;
      }
}
