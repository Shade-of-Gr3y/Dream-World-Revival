package org.libspark.betweenas3.core.easing
{
   public class QuadraticEaseInOut implements IEasing
   {
      
      public function QuadraticEaseInOut()
      {
         super();
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         param1 = param1 / (param4 / 2);
         if(param1 < 1)
         {
            return param3 / 2 * param1 * param1 + param2;
         }
         return -param3 / 2 * (--param1 * (param1 - 2) - 1) + param2;
      }
   }
}

