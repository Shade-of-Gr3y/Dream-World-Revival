package jp.feb19.utils
{
   public class NumberUtilities
   {
       
      
      public function NumberUtilities()
      {
         super();
      }
      
      public static function toArray(param1:int, param2:int = 0) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Array = new Array();
         while(param1 >= 1)
         {
            _loc4_ = param1 % 10;
            _loc3_.push(_loc4_);
            param1 /= 10;
         }
         if(_loc3_.length < param2)
         {
            _loc5_ = int(_loc3_.length);
            while(_loc5_ < param2)
            {
               _loc3_.push(0);
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public static function format(param1:Number, param2:Number = NaN, param3:String = "", param4:String = "") : String
      {
         var _loc7_:Array = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc5_:String;
         var _loc6_:Number = (_loc5_ = param1.toString()).length;
         if(param3 != "")
         {
            _loc7_ = _loc5_.split("");
            _loc8_ = 3;
            _loc9_ = _loc7_.length;
            while(--_loc9_ > 0)
            {
               if(--_loc8_ == 0)
               {
                  _loc8_ = 3;
                  _loc7_.splice(_loc9_,0,param3);
               }
            }
            _loc5_ = _loc7_.join("");
         }
         if(!isNaN(param2))
         {
            if(_loc6_ < param2)
            {
               param2 -= _loc6_;
               _loc10_ = param4 == "" ? "0" : param4;
               while(param2--)
               {
                  _loc5_ = _loc10_ + _loc5_;
               }
            }
         }
         return _loc5_;
      }
      
      public static function unformat(param1:String) : Number
      {
         var _loc2_:String = StringUtilities.ignoreLetter(StringUtilities.ignoreWhite(param1),",");
         return Number(_loc2_);
      }
      
      public static function ordinal(param1:uint) : String
      {
         var _loc2_:* = param1.toString();
         if(param1 > 10 && Boolean(_loc2_.substr(-2,1)))
         {
            _loc2_ += "th";
         }
         else if(_loc2_.substr(-1,1) == "1")
         {
            _loc2_ += "st";
         }
         else if(_loc2_.substr(-1,1) == "2")
         {
            _loc2_ += "nd";
         }
         else if(_loc2_.substr(-1,1) == "3")
         {
            _loc2_ += "rd";
         }
         else
         {
            _loc2_ += "th";
         }
         return _loc2_;
      }
      
      public static function unordinal(param1:String) : uint
      {
         return uint(param1.substr(0,param1.length - 2));
      }
   }
}
