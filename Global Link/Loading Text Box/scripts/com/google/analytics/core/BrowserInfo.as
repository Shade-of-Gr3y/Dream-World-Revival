package com.google.analytics.core
{
   import com.google.analytics.utils.Environment;
   import com.google.analytics.utils.Variables;
   import com.google.analytics.utils.Version;
   import com.google.analytics.v4.Configuration;
   
   public class BrowserInfo
   {
      
      private var _config:Configuration;
      
      private var _info:Environment;
      
      public function BrowserInfo(param1:Configuration, param2:Environment)
      {
         super();
         _config = param1;
         _info = param2;
      }
      
      public function get utmul() : String
      {
         return _info.language.toLowerCase();
      }
      
      public function get utmje() : String
      {
         return "0";
      }
      
      public function toURLString() : String
      {
         var _loc1_:Variables = null;
         _loc1_ = toVariables();
         return _loc1_.toString();
      }
      
      public function get utmsr() : String
      {
         return _info.screenWidth + "x" + _info.screenHeight;
      }
      
      public function get utmcs() : String
      {
         return _info.languageEncoding;
      }
      
      public function get utmfl() : String
      {
         var _loc1_:Version = null;
         if(_config.detectFlash)
         {
            _loc1_ = _info.flashVersion;
            return _loc1_.major + "." + _loc1_.minor + " r" + _loc1_.build;
         }
         return "-";
      }
      
      public function toVariables() : Variables
      {
         var _loc1_:Variables = null;
         _loc1_ = new Variables();
         _loc1_.URIencode = true;
         _loc1_.utmcs = utmcs;
         _loc1_.utmsr = utmsr;
         _loc1_.utmsc = utmsc;
         _loc1_.utmul = utmul;
         _loc1_.utmje = utmje;
         _loc1_.utmfl = utmfl;
         return _loc1_;
      }
      
      public function get utmsc() : String
      {
         return _info.screenColorDepth + "-bit";
      }
   }
}

