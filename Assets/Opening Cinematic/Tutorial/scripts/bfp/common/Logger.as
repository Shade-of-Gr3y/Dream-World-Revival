package bfp.common
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Logger
   {
      
      public static const LOG:String = "LOG";
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      public static var text:String = "";
       
      
      public function Logger()
      {
         super();
      }
      
      public static function log(param1:Object) : void
      {
         text = param1 as String;
         dispatchEvent(new Event(LOG));
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
