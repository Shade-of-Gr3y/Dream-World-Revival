package bfp.common
{
   import com.google.analytics.AnalyticsTracker;
   import com.google.analytics.GATracker;
   import com.google.analytics.debug.DebugConfiguration;
   import com.google.analytics.v4.Configuration;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class Analytics
   {
      
      public static const MODE_AS3:String = "AS3";
      
      public static const MODE_Bridge:String = "Bridge";
      
      private var eventName:String = "onSendTag";
      
      private var tracker:AnalyticsTracker;
      
      private var paramName:String = "tag";
      
      public function Analytics(param1:String = "onSendTag", param2:String = "tag")
      {
         super();
         this.eventName = param1;
         this.paramName = param2;
      }
      
      public function init(param1:DisplayObject, param2:String, param3:String = "AS3", param4:Boolean = false, param5:Configuration = null, param6:DebugConfiguration = null) : *
      {
         this.tracker = new GATracker(param1,param2,param3,param4,param5,param6);
         PokemonBridge.addEventListener(this.eventName,this.onSendTag);
      }
      
      public function removeEvent() : *
      {
         PokemonBridge.removeEventListener(this.eventName,this.onSendTag);
      }
      
      private function onSendTag(param1:CustomEvent) : *
      {
         var _loc2_:* = param1.data[this.paramName];
         this.tracking(_loc2_);
      }
      
      private function tracking(param1:String) : *
      {
         if(this.tracker != null)
         {
            this.tracker.trackPageview(param1);
         }
      }
   }
}

