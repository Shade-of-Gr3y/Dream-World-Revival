package caurina.transitions
{
   public class AuxFunctions
   {
       
      
      public function AuxFunctions()
      {
         super();
      }
      
      public static function numberToR(param1:Number) : Number
      {
         return (param1 & 16711680) >> 16;
      }
      
      public static function numberToG(param1:Number) : Number
      {
         return (param1 & 65280) >> 8;
      }
      
      public static function numberToB(param1:Number) : Number
      {
         return param1 & 255;
      }
      
      public static function getObjectLength(param1:Object) : uint
      {
         var _loc3_:String = null;
         var _loc2_:uint = 0;
         for(_loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function concatObjects(... rest) : Object
      {
         var _loc3_:Object = null;
         var _loc5_:String = null;
         var _loc2_:Object = {};
         var _loc4_:int = 0;
         while(_loc4_ < rest.length)
         {
            _loc3_ = rest[_loc4_];
            for(_loc5_ in _loc3_)
            {
               if(_loc3_[_loc5_] == null)
               {
                  delete _loc2_[_loc5_];
               }
               else
               {
                  _loc2_[_loc5_] = _loc3_[_loc5_];
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}
