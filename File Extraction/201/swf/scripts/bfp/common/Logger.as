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
      
      public static function log(obj:Object) : void
      {
         text = obj as String;
         dispatchEvent(new Event(LOG));
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

