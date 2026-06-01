package com.google.analytics.data
{
   public class UTMK extends UTMCookie
   {
      
      private var _hash:Number;
      
      public function UTMK(param1:Number = NaN)
      {
         super("utmk","__utmk",["hash"]);
         this.hash = param1;
      }
      
      public function get hash() : Number
      {
         return _hash;
      }
      
      public function set hash(param1:Number) : void
      {
         _hash = param1;
         update();
      }
   }
}

