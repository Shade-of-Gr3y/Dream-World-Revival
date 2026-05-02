package common
{
   import flash.events.Event;
   
   public class gameBridgeEvent extends Event
   {
      
      public static const START_GAME:String = "startGame";
      
      public static const CLOSE_GAME:String = "closeGame";
      
      public static const FINISH_GAME:String = "finishGame";
      
      public static const PAUSE_GAME:String = "pauseGame";
      
      public static const RESTART_GAME:String = "restartGame";
       
      
      public function gameBridgeEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function toString() : String
      {
         return "Type : " + type;
      }
      
      override public function clone() : Event
      {
         return new gameBridgeEvent(type,bubbles,cancelable);
      }
   }
}
