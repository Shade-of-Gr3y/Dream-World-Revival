package bfp.main.alert
{
   import bfp.common.CustomEvent;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.SharedObject;
   
   public class PDWEnterBridge
   {
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static const PDW_ONE_HOUR_ALERT:String = "PDW_ONE_HOUR_ALERT";
      
      public static const PDW_ONE_HOUR_ALERT_SLEEP:String = "PDW_ONE_HOUR_ALERT_SLEEP";
      
      public static const PDW_PRESSURE_ALERT:String = "PDW_PRESSURE_ALERT";
      
      public static const PDW_PRESSURE_ALERT_SLEEP:String = "PDW_PRESSURE_ALERT_SLEEP";
      
      public static const PDW_EXIT_ALERT:String = "PDW_EXIT_ALERT";
      
      public static const PDW_EXIT_ALERT_SLEEP:String = "PDW_EXIT_ALERT_SLEEP";
      
      public static const PDW_ENTRY_CHECK:String = "PDW_ENTRY_CHECK";
      
      public static const PDW_FINISH:String = "PDW_FINISH";
      
      public static const PDW_ENTER_DREAMLAND:String = "PDW_ENTER_DREAMLAND";
      
      public static const PDW_EXIT_DREAMLAND:String = "PDW_EXIT_DREAMLAND";
      
      public static const LIFE_COUNTDOWN:String = "LIFE_COUNTDOWN";
      
      public static const RETURN_TO_PGL:String = "RETURN_TO_PGL";
      
      public static const RETURN_TO_PGL_2:String = "RETURN_TO_PGL_2";
      
      public static const GET_TIME_STAMP:String = "GET_TIME_STAMP";
      
      public static const HOUR_24_TIMER_ALERT:String = "HOUR_24_TIMER_ALERT";
      
      public static const HOUR_24_TIMER_ALERT_SLEEP:String = "HOUR_24_TIMER_ALERT_SLEEP";
      
      public static const BUSY_PDW_ALERT:String = "BUSY_PDW_ALERT";
      
      public static const BUSY_PDW_ALERT_SLEEP:String = "BUSY_PDW_ALERT_SLEEP";
      
      public static const FLOATING_NO_SYNCID:String = "FLOATING_NO_SYNCID";
      
      public static const FLOATING_NOT_SYNC:String = "FLOATING_NOT_SYNC";
      
      public static const FLOATING_SET_ID:String = "FLOATING_SET_ID";
      
      public static const ENABLE_ACCESS_TO_PDW:String = "ENABLE_ACCESS_TO_PDW";
      
      public static const FINISH_ACCESS_TO_PDW:String = "FINISH_ACCESS_TO_PDW";
      
      public static const PAUSE_ACCESS_TO_PDW:String = "PAUSE_ACCESS_TO_PDW";
      
      public static const PAUSE_ACCESS_TO_PDW_SLEEP:String = "PAUSE_ACCESS_TO_PDW_SLEEP";
      
      public static const DOWNLOAD_PDW_ALERT:String = "DOWNLOAD_PDW_ALERT";
      
      public static const SLEEPING_PDW_ALERT:String = "SLEEPING_PDW_ALERT";
      
      public static const ENTER_ALERT_CLOSE:String = "ENTER_ALERT_CLOSE";
      
      public static const REMOVED_SITE_PDW:String = "REMOVED_SITE_PDW";
      
      public static const DELAY_CAMPAIGN:String = "DELAY_CAMPAIGN";
      
      public static const DELAY_BOARD:String = "DELAY_BOARD";
      
      public static const DELAY_PLAYDATA:String = "DELAY_PLAYDATA";
      
      public static const ALERT_DONT_WAKEUP:String = "ALERT_DONT_WAKEUP";
      
      public static const ALERT_DONT_SLEEP:String = "ALERT_DONT_SLEEP";
      
      public static const DELAY_GAMEDATA:String = "DELAY_GAMEDATA";
      
      public static const ENTER_ALERT:String = "ENTER_ALERT";
      
      private static var _alertPage:String = "";
      
      public static const REGISTER_FONT:String = "REGISTER_FONT";
      
      public function PDWEnterBridge()
      {
         super();
      }
      
      public static function willTrigger(type:String) : Boolean
      {
         return _dispatcher.willTrigger(type);
      }
      
      public static function get alertPage() : String
      {
         return _alertPage;
      }
      
      public static function registerFont() : void
      {
         dispatchEvent(new Event(REGISTER_FONT));
      }
      
      public static function entrySharedObject(num:Number) : void
      {
         var soName:String = "pokemon" + PokemonBridge.member_id;
         var _so:SharedObject = SharedObject.getLocal(soName,"/");
         _so.data.start = PokemonBridge.last_started_at + 24 * 3600 - num;
         _so.flush();
         Logger.log("-------------------------------");
         Logger.log(_so.data.start.toString());
         Logger.log("-------------------------------");
      }
      
      public static function removeSharedObject() : void
      {
         var soName:String = "pokemon" + PokemonBridge.member_id;
         var _so:SharedObject = SharedObject.getLocal(soName,"/");
         _so.data.start = NaN;
         _so.flush();
         Logger.log("-------------------------------");
         Logger.log(_so.data.start.toString());
         Logger.log("-------------------------------");
      }
      
      public static function returntoPGL() : void
      {
         Logger.log(RETURN_TO_PGL);
         dispatchEvent(new Event(RETURN_TO_PGL));
      }
      
      public static function lifeCountDown(num:Number) : void
      {
         dispatchEvent(new CustomEvent(LIFE_COUNTDOWN,num));
      }
      
      public static function PDWfinish() : void
      {
         dispatchEvent(new Event(PDW_FINISH));
      }
      
      public static function checkSharedObject() : Boolean
      {
         var flag:Boolean = false;
         var soName:String = "pokemon" + PokemonBridge.member_id;
         var _so:SharedObject = SharedObject.getLocal(soName,"/");
         var time:Number = Number(_so.data.start);
         var answer:Number = time - PokemonBridge.last_started_at;
         try
         {
            Logger.log("-------------------------------");
            Logger.log(_so.data.start.toString());
            Logger.log("-------------------------------");
            if(time - PokemonBridge.last_started_at < 3600)
            {
               flag = true;
            }
         }
         catch(e:*)
         {
         }
         return flag;
      }
      
      public static function returntoPGL2() : void
      {
         Logger.log(RETURN_TO_PGL_2);
         dispatchEvent(new Event(RETURN_TO_PGL_2));
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         _dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public static function addEventListener(type:String, listener:Function, userCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false) : void
      {
         _dispatcher.addEventListener(type,listener,userCapture,priority,weakRef);
      }
      
      public static function enterAlert(page:String) : void
      {
         _alertPage = page;
         dispatchEvent(new Event(ENTER_ALERT));
      }
      
      public static function PDWDreamLand(flag:Boolean) : void
      {
         if(flag)
         {
            dispatchEvent(new Event(PDW_ENTER_DREAMLAND));
         }
         else
         {
            dispatchEvent(new Event(PDW_EXIT_DREAMLAND));
         }
      }
      
      public static function dispatchEvent(e:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(e);
      }
      
      public static function PDWStartTimeStamp(num:Number) : void
      {
         PokemonBridge.last_started_at = num;
         dispatchEvent(new Event(GET_TIME_STAMP));
      }
      
      public static function PDWEntryCheck() : void
      {
         dispatchEvent(new Event(PDW_ENTRY_CHECK));
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         return _dispatcher.hasEventListener(type);
      }
   }
}

