package bfp.pgl.common
{
   import bfp.common.CustomEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class CampaignBridge
   {
      
      public static const CALL_HELP:String = "CALL_HELP";
      
      public static const CAMPAIGN_PLAY:String = "CAMPAIGN_PLAY";
      
      public static const CAMPAIGN_STOP:String = "CAMPAIGN_STOP";
      
      public static const CAMPAIGN_GET:String = "CAMPAIGN_GET";
      
      public static const CAMPAIGN_FINISH:String = "CAMPAIGN_FINISH";
      
      public static const WINDOW_CAMPAIGN_LIST:String = "WINDOW_CAMPAIGN_LIST";
      
      public static const WINDOW_CAMPAIGN_DETAIL:String = "WINDOW_CAMPAIGN_DETAIL";
      
      public static const WINDOW_CAMPAIGN_CLOSE:String = "WINDOW_CAMPAIGN_CLOSE";
      
      public static const WINDOW_CAMPAIGN_GAME:String = "WINDOW_CAMPAIGN_GAME";
      
      public static const WINDOW_CAMPAIGN_CLEAR:String = "WINDOW_CAMPAIGN_CLEAR";
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static const CAMPAIGN_LIST:String = "CAMPAIGN_LIST";
      
      public static const CAMPAIGN_DETAIL:String = "CAMPAIGN_DETAIL";
      
      public static const CAMPAIGN_GAME:String = "CAMPAIGN_GAME";
      
      public static const CAMPAIGN_CLEAR:String = "CAMPAIGN_CLEAR";
      
      public static const CAMPAIGN_CHANGE:String = "CAMPAIGN_CHANGE";
      
      private static var _page:String = "";
      
      public function CampaignBridge()
      {
         super();
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function get page() : String
      {
         return _page;
      }
      
      public static function willTrigger(param1:String) : Boolean
      {
         return _dispatcher.willTrigger(param1);
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function change(param1:String, param2:Object = null) : void
      {
         _page = param1;
         dispatchEvent(new CustomEvent(CAMPAIGN_CHANGE,param2));
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(param1);
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
   }
}

