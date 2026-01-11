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
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static var _data:*;
      
      public static var _data_setting:*;
      
      private static var _loader:*;
      
      private static var _loader_setting:*;
      
      public static const COMPLETE_SETTING:String = "complete_setting";
       
      
      public function campaignData()
      {
         super();
      }
      
      public static function load(param1:String) : void
      {
         var path:String = param1;
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
      
      public static function load_setting(param1:String) : void
      {
         var path:String = param1;
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
      
      private static function completeHandler(param1:Event = null) : void
      {
         _loader.removeEventListener(Event.COMPLETE,completeHandler);
         _data = new XML(_loader.data);
         _loader = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private static function settingCompleteHandler(param1:Event = null) : void
      {
         _loader_setting.removeEventListener(Event.COMPLETE,settingCompleteHandler);
         _data_setting = new XML(_loader_setting.data);
         _loader_setting = null;
         dispatchEvent(new Event(COMPLETE_SETTING));
         trace("settingCompleteHandler -------------");
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(param1);
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function willTrigger(param1:String) : Boolean
      {
         return _dispatcher.willTrigger(param1);
      }
   }
}
