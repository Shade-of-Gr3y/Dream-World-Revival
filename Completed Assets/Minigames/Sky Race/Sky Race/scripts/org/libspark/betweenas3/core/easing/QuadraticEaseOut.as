package org.libspark.betweenas3.core.easing
{
   public class QuadraticEaseOut implements IEasing
   {
       
      
      public function QuadraticEaseOut()
      {
         super();
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return -param3 * (param1 = param1 / param4) * (param1 - 2) + param2;
      }
   }
}
