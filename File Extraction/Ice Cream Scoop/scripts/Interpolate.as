package
{
   public class Interpolate
   {
      
      public function Interpolate()
      {
         super();
      }
      
      public static function GetF(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:int) : Number
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param1 >= param6)
         {
            return param3;
         }
         if(param2 <= param6)
         {
            return param4;
         }
         _loc7_ = Number(param2 - param1);
         _loc8_ = param4 - param3;
         _loc9_ = Number(param6 - param1);
         _loc10_ = param3 + _loc8_ * _loc9_ / _loc7_;
         if(param5 != 0)
         {
            _loc10_ += param5 * (1024 - 1024 * _loc9_ / _loc7_) * _loc9_ / _loc7_ / 256;
         }
         return _loc10_;
      }
      
      public static function GetZ(param1:int, param2:int, param3:int) : int
      {
         return param2 * param3 / param1;
      }
      
      public static function Get(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(param1 >= param6)
         {
            return param3;
         }
         if(param2 <= param6)
         {
            return param4;
         }
         _loc7_ = param2 - param1;
         _loc8_ = param4 - param3;
         _loc9_ = param6 - param1;
         _loc10_ = param3 + _loc8_ * _loc9_ / _loc7_;
         if(param5 != 0)
         {
            _loc10_ += param5 * (1024 - 1024 * _loc9_ / _loc7_) * _loc9_ / _loc7_ / 256;
         }
         return _loc10_;
      }
   }
}

