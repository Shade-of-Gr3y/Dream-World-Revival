package org.libspark.thread
{
   internal class ErrorHandler
   {
      
      public var autoTermination:Boolean;
      
      public var handler:Function;
      
      public var reset:Boolean;
      
      public function ErrorHandler(param1:Function, param2:Boolean, param3:Boolean)
      {
         super();
         this.handler = param1;
         this.reset = param2;
         this.autoTermination = param3;
      }
   }
}

