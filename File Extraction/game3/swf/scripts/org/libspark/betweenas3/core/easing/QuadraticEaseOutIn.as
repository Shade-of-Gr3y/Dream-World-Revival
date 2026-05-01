package org.libspark.betweenas3.core.easing
{
   public class QuadraticEaseOutIn implements IEasing
   {
      
      public function QuadraticEaseOutIn()
      {
         super();
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            return -(param3 / 2) * (param1 = param1 * 2 / param4) * (param1 - 2) + param2;
         }
         return param3 / 2 * (param1 = (param1 * 2 - param4) / param4) * param1 + (param2 + param3 / 2);
      }
   }
}

