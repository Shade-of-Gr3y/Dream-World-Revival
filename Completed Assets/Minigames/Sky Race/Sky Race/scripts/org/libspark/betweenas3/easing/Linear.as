package org.libspark.betweenas3.easing
{
   import org.libspark.betweenas3.core.easing.EaseNone;
   import org.libspark.betweenas3.core.easing.IEasing;
   
   public class Linear
   {
      
      private static const _linear:IEasing = new EaseNone();
      
      public static const linear:IEasing = _linear;
      
      public static const easeNone:IEasing = _linear;
      
      public static const easeIn:IEasing = _linear;
      
      public static const easeOut:IEasing = _linear;
      
      public static const easeInOut:IEasing = _linear;
      
      public static const easeOutIn:IEasing = _linear;
       
      
      public function Linear()
      {
         super();
      }
   }
}
