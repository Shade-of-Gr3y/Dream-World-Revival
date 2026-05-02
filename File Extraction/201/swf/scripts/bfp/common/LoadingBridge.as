package bfp.common
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class LoadingBridge
   {
      
      private static var _language:String;
      
      private static var _percent:Number = 0;
      
      public static var posY:Number = 0;
      
      public static var languageLoadedPercent:Number = 0;
      
      public static var speed:Number = 0;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      private static var _site:String = PokemonBridge.SITE_PGL;
      
      public function LoadingBridge()
      {
         super();
      }
      
      public static function set percent(value:Number) : *
      {
         _percent = value;
         if(_percent > 1)
         {
            _percent = 1;
         }
         else if(_percent < 0)
         {
            _percent = 0;
         }
         dispatchEvent(new LoadingEvent(LoadingEvent.SEND_PERCENT,{"percent":_percent}));
      }
      
      public static function get percent() : Number
      {
         return _percent;
      }
      
      public static function showLoading(duration:Number = 1) : *
      {
         dispatchEvent(new LoadingEvent(LoadingEvent.SHOW_LOADING,{"duration":duration}));
      }
      
      public static function hideLoading(duration:Number = 1) : *
      {
         dispatchEvent(new LoadingEvent(LoadingEvent.HIDE_LOADING,{"duration":duration}));
      }
      
      public static function finishFirstLoading() : *
      {
         dispatchEvent(new LoadingEvent(LoadingEvent.FINISH_FIRST_LOADING));
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

