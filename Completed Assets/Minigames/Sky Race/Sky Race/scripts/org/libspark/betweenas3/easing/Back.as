package org.libspark.betweenas3.easing
{
   import org.libspark.betweenas3.core.easing.BackEaseIn;
   import org.libspark.betweenas3.core.easing.BackEaseInOut;
   import org.libspark.betweenas3.core.easing.BackEaseOut;
   import org.libspark.betweenas3.core.easing.BackEaseOutIn;
   import org.libspark.betweenas3.core.easing.IEasing;
   
   public class Back
   {
      
      public static const easeIn:IEasing = new BackEaseIn();
      
      public static const easeOut:IEasing = new BackEaseOut();
      
      public static const easeInOut:IEasing = new BackEaseInOut();
      
      public static const easeOutIn:IEasing = new BackEaseOutIn();
       
      
      public function Back()
      {
         super();
      }
      
      public static function easeInWith(param1:Number = 1.70158) : IEasing
      {
         return new BackEaseIn(param1);
      }
      
      public static function easeOutWith(param1:Number = 1.70158) : IEasing
      {
         return new BackEaseOut(param1);
      }
      
      public static function easeInOutWith(param1:Number = 1.70158) : IEasing
      {
         return new BackEaseInOut(param1);
      }
      
      public static function easeOutInWith(param1:Number = 1.70158) : IEasing
      {
         return new BackEaseOutIn(param1);
      }
   }
}
