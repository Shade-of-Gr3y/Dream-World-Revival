package org.libspark.betweenas3.easing
{
   import org.libspark.betweenas3.core.easing.ExponentialEaseIn;
   import org.libspark.betweenas3.core.easing.ExponentialEaseInOut;
   import org.libspark.betweenas3.core.easing.ExponentialEaseOut;
   import org.libspark.betweenas3.core.easing.ExponentialEaseOutIn;
   import org.libspark.betweenas3.core.easing.IEasing;
   
   public class Expo
   {
      
      public static const easeIn:IEasing = new ExponentialEaseIn();
      
      public static const easeOut:IEasing = new ExponentialEaseOut();
      
      public static const easeInOut:IEasing = new ExponentialEaseInOut();
      
      public static const easeOutIn:IEasing = new ExponentialEaseOutIn();
       
      
      public function Expo()
      {
         super();
      }
   }
}
