package jp.feb19.utils
{
   public class StringUtilities
   {
      
      public static const URL_REG_EXP:RegExp = /(https?:\/\/[0-9a-z-\/._?=&%\[\]~;]+)/ig;
       
      
      public function StringUtilities()
      {
         super();
      }
      
      public static function ignoreWhite(param1:String) : String
      {
         return StringUtilities.ignoreLetter(param1," ");
      }
      
      public static function ignoreLetter(param1:String, param2:String) : String
      {
         var _loc3_:Array = param1.split(param2);
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ += _loc3_[_loc5_];
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function getFileName(param1:String) : String
      {
         var _loc2_:String = param1;
         if(param1.lastIndexOf("\\") > -1)
         {
            _loc2_ = param1.substr(param1.lastIndexOf("\\") + 1);
         }
         else
         {
            _loc2_ = param1.substr(param1.lastIndexOf("/") + 1);
         }
         return _loc2_;
      }
      
      public static function replaceAll(param1:String, param2:String, param3:String) : String
      {
         return param1.replace(new RegExp(param2,"g"),param3);
      }
   }
}
