package org.libspark.betweenas3.core.easing
{
   public interface IPhysicalEasing
   {
      
      function getDuration(param1:Number, param2:Number) : Number;
      
      function calculate(param1:Number, param2:Number, param3:Number) : Number;
   }
}

