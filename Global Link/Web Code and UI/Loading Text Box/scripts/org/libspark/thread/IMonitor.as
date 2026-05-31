package org.libspark.thread
{
   public interface IMonitor
   {
      
      function notifyAll() : void;
      
      function notify() : void;
      
      function wait(param1:uint = 0) : void;
      
      function leave(param1:Thread) : void;
   }
}

