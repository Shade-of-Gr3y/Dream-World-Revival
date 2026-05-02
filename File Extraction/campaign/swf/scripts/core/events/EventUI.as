package core.events
{
   import flash.events.EventDispatcher;
   
   public class EventUI extends EventDispatcher
   {
      
      public static const ROLLOVER:String = "ROLLOVER";
      
      public static const ROLLOUT:String = "ROLLOUT";
      
      public static const ACTIVE:String = "ACTIVE";
      
      public static const DEACTIVE:String = "DEACTIVE";
      
      public function EventUI()
      {
         super();
      }
   }
}

