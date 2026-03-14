package com.google.analytics.core
{
   import flash.net.URLRequest;
   import flash.utils.getTimer;
   
   public class RequestObject
   {
      
      public var start:int;
      
      public var request:URLRequest;
      
      public var end:int;
      
      public function RequestObject(param1:URLRequest)
      {
         super();
         start = getTimer();
         this.request = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:Array = null;
         _loc1_ = [];
         _loc1_.push("duration: " + duration + "ms");
         _loc1_.push("url: " + request.url);
         return "{ " + _loc1_.join(", ") + " }";
      }
      
      public function get duration() : int
      {
         if(!hasCompleted())
         {
            return 0;
         }
         return end - start;
      }
      
      public function hasCompleted() : Boolean
      {
         return end > 0;
      }
      
      public function complete() : void
      {
         end = getTimer();
      }
   }
}

