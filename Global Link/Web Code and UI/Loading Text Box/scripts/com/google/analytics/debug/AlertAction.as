package com.google.analytics.debug
{
   public class AlertAction
   {
      
      public var container:Alert;
      
      private var _callback:*;
      
      public var name:String;
      
      public var activator:String;
      
      public function AlertAction(param1:String, param2:String, param3:*)
      {
         super();
         this.name = param1;
         this.activator = param2;
         _callback = param3;
      }
      
      public function execute() : void
      {
         if(_callback)
         {
            if(_callback is Function)
            {
               (_callback as Function)();
            }
            else if(_callback is String)
            {
               container[_callback]();
            }
         }
      }
   }
}

