package org.libspark.betweenas3.easing
{
   import org.libspark.betweenas3.core.easing.IEasing;
   import org.libspark.betweenas3.core.easing.QuadraticEaseIn;
   import org.libspark.betweenas3.core.easing.QuadraticEaseInOut;
   import org.libspark.betweenas3.core.easing.QuadraticEaseOut;
   import org.libspark.betweenas3.core.easing.QuadraticEaseOutIn;
   
   public class Quad
   {
      
      public static const easeIn:IEasing = new QuadraticEaseIn();
      
      public static const easeOut:IEasing = new QuadraticEaseOut();
      
      public static const easeInOut:IEasing = new QuadraticEaseInOut();
      
      public static const easeOutIn:IEasing = new QuadraticEaseOutIn();
       
      
      public function Quad()
      {
         super();
      }
   }
}
