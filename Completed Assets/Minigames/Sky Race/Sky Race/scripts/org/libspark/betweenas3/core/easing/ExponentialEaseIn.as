package org.libspark.betweenas3.core.easing
{
   public class ExponentialEaseIn implements IEasing
   {
       
      
      public function ExponentialEaseIn()
      {
         super();
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 == 0?Number(param2):Number(param3 * Math.pow(2,10 * (param1 / param4 - 1)) + param2);
      }
   }
}
