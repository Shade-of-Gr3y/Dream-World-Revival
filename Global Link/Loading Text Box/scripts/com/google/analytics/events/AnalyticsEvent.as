package com.google.analytics.events
{
   import com.google.analytics.AnalyticsTracker;
   import flash.events.Event;
   
   public class AnalyticsEvent extends Event
   {
      
      public static const READY:String = "ready";
      
      public var tracker:AnalyticsTracker;
      
      public function AnalyticsEvent(param1:String, param2:AnalyticsTracker, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.tracker = param2;
      }
      
      override public function clone() : Event
      {
         return new AnalyticsEvent(type,tracker,bubbles,cancelable);
      }
   }
}

