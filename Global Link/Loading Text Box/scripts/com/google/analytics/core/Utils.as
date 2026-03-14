package com.google.analytics.core
{
   public class Utils
   {
      
      public function Utils()
      {
         super();
      }
      
      public static function trim(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 == "")
         {
            return "";
         }
         _loc3_ = [" ","\n","\r","\t"];
         _loc4_ = param1;
         if(param2)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length && _loc4_.indexOf(_loc3_[_loc5_]) > -1)
            {
               _loc4_ = _loc4_.split(_loc3_[_loc5_]).join("");
               _loc5_++;
            }
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length && _loc3_.indexOf(_loc4_.charAt(_loc6_)) > -1)
            {
               _loc6_++;
            }
            _loc4_ = _loc4_.substr(_loc6_);
            _loc7_ = _loc4_.length - 1;
            while(_loc7_ >= 0 && _loc3_.indexOf(_loc4_.charAt(_loc7_)) > -1)
            {
               _loc7_--;
            }
            _loc4_ = _loc4_.substring(0,_loc7_ + 1);
         }
         return _loc4_;
      }
      
      public static function generateHash(param1:String) : int
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = 1;
         _loc3_ = 0;
         if(param1 != null && param1 != "")
         {
            _loc2_ = 0;
            _loc4_ = param1.length - 1;
            while(_loc4_ >= 0)
            {
               _loc5_ = int(param1.charCodeAt(_loc4_));
               _loc2_ = (_loc2_ << 6 & 0x0FFFFFFF) + _loc5_ + (_loc5_ << 14);
               _loc3_ = _loc2_ & 0x0FE00000;
               if(_loc3_ != 0)
               {
                  _loc2_ ^= _loc3_ >> 21;
               }
               _loc4_--;
            }
         }
         return _loc2_;
      }
      
      public static function generate32bitRandom() : int
      {
         return Math.round(Math.random() * 2147483647);
      }
      
      public static function validateAccount(param1:String) : Boolean
      {
         var _loc2_:RegExp = null;
         _loc2_ = /^UA-[0-9]*-[0-9]*$/;
         return _loc2_.test(param1);
      }
   }
}

