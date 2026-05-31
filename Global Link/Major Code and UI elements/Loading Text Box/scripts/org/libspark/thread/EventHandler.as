package org.libspark.thread
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   internal class EventHandler
   {
      
      public var priority:int;
      
      public var dispatcher:IEventDispatcher;
      
      public var func:Function;
      
      public var useWeakReference:Boolean;
      
      public var listener:Function;
      
      public var type:String;
      
      public var useCapture:Boolean;
      
      public function EventHandler(param1:IEventDispatcher, param2:String, param3:Function, param4:Function, param5:Boolean, param6:int, param7:Boolean)
      {
         super();
         this.dispatcher = param1;
         this.type = param2;
         this.listener = param3;
         this.func = param4;
         this.useCapture = param5;
         this.priority = param6;
         this.useWeakReference = param7;
      }
      
      public function register() : void
      {
         this.dispatcher.addEventListener(this.type,this.handler,this.useCapture,this.priority,this.useWeakReference);
      }
      
      private function handler(param1:Event) : void
      {
         this.listener(param1,this);
      }
      
      public function unregister() : void
      {
         this.dispatcher.removeEventListener(this.type,this.handler,this.useCapture);
      }
   }
}

