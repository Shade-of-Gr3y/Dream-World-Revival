package org.libspark.betweenas3.core.ticker
{
   public class TickerListener
   {
      
      public var prevListener:TickerListener = null;
      
      public var nextListener:TickerListener = null;
      
      public function TickerListener()
      {
         super();
      }
      
      public function tick(param1:Number) : Boolean
      {
         return false;
      }
   }
}

