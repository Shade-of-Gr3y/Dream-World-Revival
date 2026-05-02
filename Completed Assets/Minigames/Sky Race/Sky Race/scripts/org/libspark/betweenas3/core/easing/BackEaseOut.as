package org.libspark.betweenas3.core.easing
{
   public class BackEaseOut implements IEasing
   {
       
      
      public var s:Number;
      
      public function BackEaseOut(param1:Number = 1.70158)
      {
         super();
         this.s = param1;
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * ((param1 = param1 / param4 - 1) * param1 * ((this.s + 1) * param1 + this.s) + 1) + param2;
      }
   }
}
