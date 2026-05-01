package org.libspark.betweenas3.core.ticker
{
   public interface ITicker
   {
      
      function get time() : Number;
      
      function addTickerListener(param1:TickerListener) : void;
      
      function removeTickerListener(param1:TickerListener) : void;
      
      function start() : void;
      
      function stop() : void;
   }
}

