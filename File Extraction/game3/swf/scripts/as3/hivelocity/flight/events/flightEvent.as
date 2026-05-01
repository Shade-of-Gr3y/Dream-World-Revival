package as3.hivelocity.flight.events
{
   import flash.events.Event;
   
   public class flightEvent extends Event
   {
      
      public static const GAME_START:String = "game_start";
      
      public static const WAIT_FRAME:String = "wait_frame";
      
      public static const FLIGHT_GAUGE_READY:String = "flight_gauge_ready";
      
      public static const COUNT_FINISH:String = "count_finish";
      
      public static const CLOUD_CHANGE:String = "cloud_change";
      
      public static const ENERGY_CHANGE:String = "energy_change";
      
      public static const ENERGY_COMBO:String = "energy_combo";
      
      public static const CHARA_MOVE:String = "chara_move";
      
      public static const ENERGY_FULL:String = "energy_full";
      
      public static const BG_MOVE:String = "bg_move";
      
      public static const CHARA_GOAL_ACTION_FIN:String = "chara_goal_action_fin";
      
      public static const GAME_RETRY:String = "game_retry";
      
      public static const GAME_FINISH:String = "game_finish";
      
      public static const GAME_OPENING_BG:String = "game_opening_bg";
      
      public static const GAME_TIME_UP:String = "game_time_up";
      
      public static const GAME_START_CLICK:String = "game_start_click";
      
      public static const ADD_SCORE_REMOVE:String = "add_score_remove";
      
      public static const ADD_SPEED_REMOVE:String = "add_speed_remove";
      
      public static const ADD_CLOUD_REMOVE:String = "add_cloud_remove";
      
      public static const ADD_THUNDER_REMOVE:String = "add_thunder_remove";
      
      public static const PAUSE_CANCEL:String = "pause_cancel";
      
      public static const LOADING_READY:String = "loading_ready";
      
      public static const LOADING_COMPLETE:String = "loading_complete";
      
      public static const ENERGY_GET:String = "energy_get";
      
      public static const TIME_UP_ANIME_FIN:String = "time_up_anime_fin";
      
      public static const GOAL_ANIME_FIN:String = "goal_anime_fin";
      
      public static const SPEED_UP_ANIME_FIN:String = "speed_up_anime_fin";
      
      public static const HOWTO_WIN_CLOSE:String = "howto_win_close";
      
      public static const GAME_BACK_CANCEL:String = "game_back_cancel";
      
      public static const GAME_BACK_OK:String = "game_back_ok";
      
      public static const DISTANCE_LINE_REMOVE:String = "distance_line_remove";
      
      public static const GAME_TITLE_CLOSE:String = "game_title_close";
      
      public var addpoint:uint = 0;
      
      public var addspeed:Number = 0;
      
      public var addtype:Number = 0;
      
      public function flightEvent(param1:String, param2:uint = 0, param3:Number = 0, param4:uint = 1, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.addpoint = param2;
         this.addspeed = param3;
         this.addtype = param4;
      }
      
      override public function clone() : Event
      {
         return new flightEvent(type,this.addpoint,this.addspeed,this.addtype,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("flightEvent","type","addpoint","addspeed","addtype","bubbles","cancelable","eventPhase");
      }
   }
}

