package org.libspark.betweenas3.easing
{
   import org.libspark.betweenas3.core.easing.IPhysicalEasing;
   import org.libspark.betweenas3.core.easing.PhysicalAccelerate;
   import org.libspark.betweenas3.core.easing.PhysicalExponential;
   import org.libspark.betweenas3.core.easing.PhysicalUniform;
   
   public class Physical
   {
      
      private static var _defaultFrameRate:Number = 30;
      
      public function Physical()
      {
         super();
      }
      
      public static function get defaultFrameRate() : Number
      {
         return _defaultFrameRate;
      }
      
      public static function set defaultFrameRate(param1:Number) : void
      {
         _defaultFrameRate = param1;
      }
      
      public static function uniform(param1:Number = 10, param2:Number = NaN) : IPhysicalEasing
      {
         return new PhysicalUniform(param1,isNaN(param2) ? _defaultFrameRate : param2);
      }
      
      public static function accelerate(param1:Number = 1, param2:Number = 0, param3:Number = NaN) : IPhysicalEasing
      {
         return new PhysicalAccelerate(param2,param1,isNaN(param3) ? _defaultFrameRate : param3);
      }
      
      public static function exponential(param1:Number = 0.2, param2:Number = 0.0001, param3:Number = NaN) : IPhysicalEasing
      {
         return new PhysicalExponential(param1,param2,isNaN(param3) ? _defaultFrameRate : param3);
      }
   }
}

