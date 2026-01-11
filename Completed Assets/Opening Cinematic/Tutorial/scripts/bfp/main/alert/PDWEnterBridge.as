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
      
      public static function checkSharedObject() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = "pokemon" + PokemonBridge.member_id;
         var _loc3_:SharedObject = SharedObject.getLocal(_loc2_,"/");
         var _loc4_:Number;
         var _loc5_:Number = (_loc4_ = Number(_loc3_.data.start)) - PokemonBridge.last_started_at;
         try
         {
            Logger.log("-------------------------------");
            Logger.log(_loc3_.data.start.toString());
            Logger.log("-------------------------------");
            if(_loc4_ - PokemonBridge.last_started_at < 3600)
            {
               _loc1_ = true;
            }
         }
         catch(e:*)
         {
         }
         return _loc1_;
      }
      
      public static function entrySharedObject(param1:Number) : void
      {
         var _loc2_:String = "pokemon" + PokemonBridge.member_id;
         var _loc3_:SharedObject = SharedObject.getLocal(_loc2_,"/");
         _loc3_.data.start = PokemonBridge.last_started_at + 24 * 3600 - param1;
         _loc3_.flush();
         Logger.log("-------------------------------");
         Logger.log(_loc3_.data.start.toString());
         Logger.log("-------------------------------");
      }
      
      public static function removeSharedObject() : void
      {
         var _loc1_:String = "pokemon" + PokemonBridge.member_id;
         var _loc2_:SharedObject = SharedObject.getLocal(_loc1_,"/");
         _loc2_.data.start = NaN;
         _loc2_.flush();
         Logger.log("-------------------------------");
         Logger.log(_loc2_.data.start.toString());
         Logger.log("-------------------------------");
      }
      
      public static function PDWEntryCheck() : void
      {
         dispatchEvent(new Event(PDW_ENTRY_CHECK));
      }
      
      public static function PDWfinish() : void
      {
         dispatchEvent(new Event(PDW_FINISH));
      }
      
      public static function PDWDreamLand(param1:Boolean) : void
      {
         if(param1)
         {
            dispatchEvent(new Event(PDW_ENTER_DREAMLAND));
         }
         else
         {
            dispatchEvent(new Event(PDW_EXIT_DREAMLAND));
         }
      }
      
      public static function lifeCountDown(param1:Number) : void
      {
         dispatchEvent(new CustomEvent(LIFE_COUNTDOWN,param1));
      }
      
      public static function returntoPGL() : void
      {
         Logger.log(RETURN_TO_PGL);
         dispatchEvent(new Event(RETURN_TO_PGL));
      }
      
      public static function returntoPGL2() : void
      {
         Logger.log(RETURN_TO_PGL_2);
         dispatchEvent(new Event(RETURN_TO_PGL_2));
      }
      
      public static function PDWStartTimeStamp(param1:Number) : void
      {
         PokemonBridge.last_started_at = param1;
         dispatchEvent(new Event(GET_TIME_STAMP));
      }
      
      public static function enterAlert(param1:String) : void
      {
         _alertPage = param1;
         dispatchEvent(new Event(ENTER_ALERT));
      }
      
      public static function get alertPage() : String
      {
         return _alertPage;
      }
      
      public static function registerFont() : void
      {
         dispatchEvent(new Event(REGISTER_FONT));
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
