package com.google.analytics.data
{
   import com.google.analytics.utils.Timespan;
   
   public class UTMB extends UTMCookie
   {
      
      public static var defaultTimespan:Number = Timespan.thirtyminutes;
      
      private var _lastTime:Number;
      
      private var _domainHash:Number;
      
      private var _trackCount:Number;
      
      private var _token:Number;
      
      public function UTMB(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN)
      {
         super("utmb","__utmb",["domainHash","trackCount","token","lastTime"],defaultTimespan * 1000);
         this.domainHash = param1;
         this.trackCount = param2;
         this.token = param3;
         this.lastTime = param4;
      }
      
      public function get token() : Number
      {
         return _token;
      }
      
      public function set trackCount(param1:Number) : void
      {
         _trackCount = param1;
         update();
      }
      
      public function set lastTime(param1:Number) : void
      {
         _lastTime = param1;
         update();
      }
      
      public function get lastTime() : Number
      {
         return _lastTime;
      }
      
      public function set domainHash(param1:Number) : void
      {
         _domainHash = param1;
         update();
      }
      
      public function get domainHash() : Number
      {
         return _domainHash;
      }
      
      public function set token(param1:Number) : void
      {
         _token = param1;
         update();
      }
      
      public function get trackCount() : Number
      {
         return _trackCount;
      }
   }
}

