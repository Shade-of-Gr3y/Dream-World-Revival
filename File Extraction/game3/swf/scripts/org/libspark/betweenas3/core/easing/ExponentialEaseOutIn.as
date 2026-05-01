package org.libspark.betweenas3.core.easing
{
   public class ExponentialEaseOutIn implements IEasing
   {
      
      public function ExponentialEaseOutIn()
      {
         super();
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            return param1 * 2 == param4 ? param2 + param3 / 2 : param3 / 2 * (1 - Math.pow(2,-10 * param1 * 2 / param4)) + param2;
         }
         return param1 * 2 - param4 == 0 ? param2 + param3 / 2 : param3 / 2 * Math.pow(2,10 * ((param1 * 2 - param4) / param4 - 1)) + param2 + param3 / 2;
      }
   }
}

