package org.libspark.betweenas3.core.easing
{
   public class ExponentialEaseInOut implements IEasing
   {
       
      
      public function ExponentialEaseInOut()
      {
         super();
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 == 0)
         {
            return param2;
         }
         if(param1 == param4)
         {
            return param2 + param3;
         }
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * Math.pow(2,10 * (param1 - 1)) + param2;
         }
         return param3 / 2 * (2 - Math.pow(2,-10 * --param1)) + param2;
      }
   }
}
