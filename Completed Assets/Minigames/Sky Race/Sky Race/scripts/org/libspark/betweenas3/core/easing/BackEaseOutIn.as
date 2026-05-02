package org.libspark.betweenas3.core.easing
{
   public class BackEaseOutIn implements IEasing
   {
       
      
      public var s:Number;
      
      public function BackEaseOutIn(param1:Number = 1.70158)
      {
         super();
         this.s = param1;
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < param4 / 2)
         {
            return param3 / 2 * ((param1 = param1 * 2 / param4 - 1) * param1 * ((this.s + 1) * param1 + this.s) + 1) + param2;
         }
         return param3 / 2 * (param1 = (param1 * 2 - param4) / param4) * param1 * ((this.s + 1) * param1 - this.s) + (param2 + param3 / 2);
      }
   }
}
