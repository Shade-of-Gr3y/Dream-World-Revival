package org.libspark.betweenas3.core.easing
{
   public class ExponentialEaseOut implements IEasing
   {
       
      
      public function ExponentialEaseOut()
      {
         super();
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 == param4?Number(param2 + param3):Number(param3 * (1 - Math.pow(2,-10 * param1 / param4)) + param2);
      }
   }
}
