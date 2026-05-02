package org.libspark.betweenas3.core.easing
{
   public class BackEaseInOut implements IEasing
   {
       
      
      public var s:Number;
      
      public function BackEaseInOut(param1:Number = 1.70158)
      {
         super();
         this.s = param1;
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * (param1 * param1 * ((this.s * 1.525 + 1) * param1 - this.s * 1.525)) + param2;
         }
         return param3 / 2 * ((param1 = param1 - 2) * param1 * ((this.s * 1.525 + 1) * param1 + this.s * 1.525) + 2) + param2;
      }
   }
}
