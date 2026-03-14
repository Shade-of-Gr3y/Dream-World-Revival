package bfp.common
{
   public class crypt
   {
      
      private static var zero_char:* = "0".charCodeAt(0);
      
      private static var a_char:* = "a".charCodeAt(0);
      
      public function crypt()
      {
         super();
      }
      
      public static function encrypt(param1:uint, param2:uint) : String
      {
         param1 = uint(param1 << 8 | param2);
         var _loc3_:String = "";
         var _loc4_:String = String(param1 << 8 ^ 0xC3C3C3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ += String.fromCharCode(_loc4_.charCodeAt(_loc5_++) - zero_char + a_char);
         }
         return _loc3_;
      }
      
      public static function encrypt_kinomi(param1:uint) : String
      {
         var _loc2_:String = "";
         var _loc3_:String = String(param1 << 8 ^ 0xC3C3C3);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ += String.fromCharCode(_loc3_.charCodeAt(_loc4_++) - zero_char + a_char);
         }
         return _loc2_;
      }
      
      public static function decrypt(param1:String) : Object
      {
         var _loc2_:int = 0;
         var _loc3_:String = "";
         while(_loc2_ < param1.length)
         {
            _loc3_ += String.fromCharCode(param1.charCodeAt(_loc2_++) - a_char + zero_char);
         }
         var _loc4_:uint = uint((parseInt(_loc3_,10) ^ 0xC3C3C3) >> 8);
         return {
            "p_id":_loc4_ >> 8,
            "f_id":_loc4_ & 0x0F
         };
      }
   }
}

