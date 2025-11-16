package bfp
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   
   public class PDWSharedObject
   {
      
      public static const FLUSHED:String = "flushed";
      
      public static const PENDING:String = "pending";
      
      public static const ERROR:String = "error";
      
      private static var _sharedObjectName:String;
      
      private static var _so:SharedObject;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function PDWSharedObject()
      {
         super();
      }
      
      public static function init(param1:String = "tpcpdwso") : void
      {
         _sharedObjectName = param1;
         _so = SharedObject.getLocal(_sharedObjectName);
         _so.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
      }
      
      public static function load() : Object
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc1_:Object = new Object();
         if(_so)
         {
            if(_so.size > 0)
            {
               for(_loc2_ in _so.data)
               {
                  _loc3_ = _so.data[_loc2_];
                  _loc1_[_loc2_] = _loc3_;
               }
            }
         }
         return _loc1_;
      }
      
      public static function save(param1:Object) : void
      {
         var i:* = undefined;
         var data:Object = param1;
         if(_so)
         {
            for(i in data)
            {
               _so.data[i] = data[i];
            }
            _so.data.saveDate = new Date();
            try
            {
               switch(_so.flush())
               {
                  case SharedObjectFlushStatus.FLUSHED:
                     _dispatcher.dispatchEvent(new Event(FLUSHED));
                     break;
                  case SharedObjectFlushStatus.PENDING:
                     _dispatcher.dispatchEvent(new Event(PENDING));
               }
            }
            catch(e:Error)
            {
               _dispatcher.dispatchEvent(new Event(ERROR));
            }
         }
      }
      
      private static function netStatusHandler(param1:NetStatusEvent) : void
      {
         dispatchEvent(param1);
         switch(param1.info.data)
         {
            case "SharedObject.Flush.Success":
            case "SharedObject.Flush.Failed":
         }
      }
      
      public static function clear() : void
      {
         if(_so)
         {
            _so.clear();
         }
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.removeEventListener(param1,param2,false);
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher.dispatchEvent(param1);
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
   }
}
