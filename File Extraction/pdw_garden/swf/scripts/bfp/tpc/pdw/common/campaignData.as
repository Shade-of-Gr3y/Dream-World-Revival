package bfp.tpc.pdw.common
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   public class campaignData
   {
      
      public static var _data:*;
      
      public static var _data_setting:*;
      
      private static var _loader:*;
      
      private static var _loader_setting:*;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static const COMPLETE_SETTING:String = "complete_setting";
      
      public function campaignData()
      {
         super();
      }
      
      public static function load(path:String) : void
      {
         _loader = new URLLoader();
         var request:URLRequest = new URLRequest();
         request.url = path;
         request.method = URLRequestMethod.GET;
         _loader.addEventListener(Event.COMPLETE,completeHandler);
         try
         {
            _loader.load(request);
         }
         catch(e:*)
         {
            trace("NOT FOUND " + path);
         }
      }
      
      public static function load_setting(path:String) : void
      {
         _loader_setting = new URLLoader();
         var request:URLRequest = new URLRequest();
         request.url = path;
         request.method = URLRequestMethod.GET;
         _loader_setting.addEventListener(Event.COMPLETE,settingCompleteHandler);
         try
         {
            _loader_setting.load(request);
         }
         catch(e:*)
         {
            trace("NOT FOUND " + path);
         }
      }
      
      public static function get data() : *
      {
         return _data;
      }
      
      public static function get settingData() : *
      {
         return _data_setting;
      }
      
      private static function completeHandler(e:Event = null) : void
      {
         _loader.removeEventListener(Event.COMPLETE,completeHandler);
         _data = new XML(_loader.data);
         _loader = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private static function settingCompleteHandler(e:Event = null) : void
      {
         _loader_setting.removeEventListener(Event.COMPLETE,settingCompleteHandler);
         _data_setting = new XML(_loader_setting.data);
         _loader_setting = null;
         dispatchEvent(new Event(COMPLETE_SETTING));
         trace("settingCompleteHandler -------------");
      }
      
      public static function addEventListener(type:String, listener:Function, userCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false) : void
      {
         _dispatcher.addEventListener(type,listener,userCapture,priority,weakRef);
      }
      
      public static function dispatchEvent(e:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(e);
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         return _dispatcher.hasEventListener(type);
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         _dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public static function willTrigger(type:String) : Boolean
      {
         return _dispatcher.willTrigger(type);
      }
   }
}

