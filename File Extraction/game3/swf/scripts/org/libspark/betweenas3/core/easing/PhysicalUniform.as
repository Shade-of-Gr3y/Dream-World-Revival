package org.libspark.betweenas3.core.easing
{
   public class PhysicalUniform implements IPhysicalEasing
   {
      
      private var _v:Number;
      
      private var _fps:Number;
      
      public function PhysicalUniform(param1:Number, param2:Number)
      {
         super();
         this._v = param1;
         this._fps = param2;
      }
      
      public function getDuration(param1:Number, param2:Number) : Number
      {
         return param2 / (param2 < 0 ? -this._v : this._v) * (1 / this._fps);
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number) : Number
      {
         return param2 + (param3 < 0 ? -this._v : this._v) * (param1 / (1 / this._fps));
      }
   }
}

