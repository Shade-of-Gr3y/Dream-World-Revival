package bfp.common
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class LoadingBridge
   {
      
      private static var _percent:Number = 0;
      
      public static var posY:Number = 0;
      
      public static var languageLoadedPercent:Number = 0;
      
      public static var speed:Number = 0;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
      
      private static var _language:String;
      
      private static var _site:String = PokemonBridge.SITE_PGL;
       
      
      public function LoadingBridge()
      {
         super();
      }
      
      public static function set percent(param1:Number) : *
      {
         _percent = param1;
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
      
      public static function showLoading(param1:Number = 1) : *
      {
         dispatchEvent(new LoadingEvent(LoadingEvent.SHOW_LOADING,{"duration":param1}));
      }
      
      public static function hideLoading(param1:Number = 1) : *
      {
         dispatchEvent(new LoadingEvent(LoadingEvent.HIDE_LOADING,{"duration":param1}));
      }
      
      public static function finishFirstLoading() : *
      {
         dispatchEvent(new LoadingEvent(LoadingEvent.FINISH_FIRST_LOADING));
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
