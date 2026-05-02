package org.libspark.betweenas3.core.easing
{
   public class PhysicalAccelerate implements IPhysicalEasing
   {
       
      
      private var _iv:Number;
      
      private var _a:Number;
      
      private var _fps:Number;
      
      public function PhysicalAccelerate(param1:Number, param2:Number, param3:Number)
      {
         super();
         this._iv = param1;
         this._a = param2;
         this._fps = param3;
      }
      
      public function getDuration(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param2 < 0?Number(-this._iv):Number(this._iv);
         var _loc4_:Number = param2 < 0?Number(-this._a):Number(this._a);
         return (-_loc3_ + Math.sqrt(_loc3_ * _loc3_ - 4 * (_loc4_ / 2) * -param2)) / (2 * (_loc4_ / 2)) * (1 / this._fps);
      }
      
      public function calculate(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc4_:Number = param3 < 0?Number(-1):Number(1);
         var _loc5_:Number = param1 / (1 / this._fps);
         return param2 + _loc4_ * this._iv * _loc5_ + _loc4_ * this._a * _loc5_ * _loc5_ / 2;
      }
   }
}
