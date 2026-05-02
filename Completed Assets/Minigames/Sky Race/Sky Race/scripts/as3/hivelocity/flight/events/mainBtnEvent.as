package as3.hivelocity.flight.events
{
   import flash.events.Event;
   
   public class mainBtnEvent extends Event
   {
      
      public static const BTN_GAME_BACK:String = "btn_game_back";
      
      public static const BTN_HOWTOPLAY:String = "btn_howtoplay";
      
      public static const BTN_GAME_START:String = "btn_game_start";
      
      public static const BTN_GAME_PAUSE:String = "btn_game_pause";
       
      
      public function mainBtnEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new mainBtnEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("mainBtnEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
