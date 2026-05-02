package org.libspark.betweenas3.tickers
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.getTimer;
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.core.ticker.TickerListener;
   
   public class EnterFrameTicker implements ITicker
   {
      
      private static var _shape:Shape = new Shape();
       
      
      private var _first:TickerListener = null;
      
      private var _last:TickerListener = null;
      
      private var _numListeners:uint = 0;
      
      private var _tickerListenerPaddings:Array;
      
      private var _time:Number;
      
      public function EnterFrameTicker()
      {
         var _loc3_:TickerListener = null;
         super();
         this._tickerListenerPaddings = new Array(10);
         var _loc1_:TickerListener = null;
         var _loc2_:uint = 0;
         while(_loc2_ < 10)
         {
            _loc3_ = new TickerListener();
            if(_loc1_ != null)
            {
               _loc1_.nextListener = _loc3_;
               _loc3_.prevListener = _loc1_;
            }
            _loc1_ = _loc3_;
            this._tickerListenerPaddings[_loc2_] = _loc3_;
            _loc2_++;
         }
      }
      
      public function get time() : Number
      {
         return this._time;
      }
      
      public function addTickerListener(param1:TickerListener) : void
      {
         if(param1.nextListener != null || param1.prevListener != null)
         {
            return;
         }
         if(this._last != null)
         {
            if(this._last.nextListener != null)
            {
               this._last.nextListener.prevListener = param1;
               param1.nextListener = this._last.nextListener;
            }
            param1.prevListener = this._last;
            this._last.nextListener = param1;
         }
         this._last = param1;
         if(this._first == null)
         {
            this._first = param1;
         }
         this._numListeners++;
      }
      
      public function removeTickerListener(param1:TickerListener) : void
      {
         var _loc2_:TickerListener = this._first;
         while(_loc2_ != null)
         {
            if(_loc2_ == param1)
            {
               if(_loc2_.prevListener != null)
               {
                  _loc2_.prevListener.nextListener = _loc2_.nextListener;
                  _loc2_.nextListener = null;
               }
               else
               {
                  this._first = _loc2_.nextListener;
               }
               if(_loc2_.nextListener != null)
               {
                  _loc2_.nextListener.prevListener = _loc2_.prevListener;
                  _loc2_.prevListener = null;
               }
               else
               {
                  this._last = _loc2_.prevListener;
               }
               this._numListeners--;
            }
            _loc2_ = _loc2_.nextListener;
         }
      }
      
      public function start() : void
      {
         this._time = getTimer() / 1000;
         _shape.addEventListener(Event.ENTER_FRAME,this.update);
      }
      
      public function stop() : void
      {
         _shape.removeEventListener(Event.ENTER_FRAME,this.update);
      }
      
      function update(param1:Event) : void
      {
         var _loc2_:Number = this._time = getTimer() / 1000;
         var _loc3_:* = this._numListeners / 8 + 1 | 0;
         var _loc4_:uint = _loc3_ * 8 - this._numListeners;
         var _loc5_:TickerListener = this._tickerListenerPaddings[0] as TickerListener;
         var _loc6_:TickerListener = this._tickerListenerPaddings[_loc4_] as TickerListener;
         var _loc7_:TickerListener = null;
         if((_loc6_.nextListener = this._first) != null)
         {
            this._first.prevListener = _loc6_;
         }
         while(--_loc3_ >= 0)
         {
            if((_loc5_ = _loc5_.nextListener).tick(_loc2_))
            {
               if(_loc5_.prevListener != null)
               {
                  _loc5_.prevListener.nextListener = _loc5_.nextListener;
               }
               if(_loc5_.nextListener != null)
               {
                  _loc5_.nextListener.prevListener = _loc5_.prevListener;
               }
               if(_loc5_ == this._first)
               {
                  this._first = _loc5_.nextListener;
               }
               if(_loc5_ == this._last)
               {
                  this._last = _loc5_.prevListener;
               }
               _loc7_ = _loc5_.prevListener;
               _loc5_.nextListener = null;
               _loc5_.prevListener = null;
               _loc5_ = _loc7_;
               this._numListeners--;
            }
            if((_loc5_ = _loc5_.nextListener).tick(_loc2_))
            {
               if(_loc5_.prevListener != null)
               {
                  _loc5_.prevListener.nextListener = _loc5_.nextListener;
               }
               if(_loc5_.nextListener != null)
               {
                  _loc5_.nextListener.prevListener = _loc5_.prevListener;
               }
               if(_loc5_ == this._first)
               {
                  this._first = _loc5_.nextListener;
               }
               if(_loc5_ == this._last)
               {
                  this._last = _loc5_.prevListener;
               }
               _loc7_ = _loc5_.prevListener;
               _loc5_.nextListener = null;
               _loc5_.prevListener = null;
               _loc5_ = _loc7_;
               this._numListeners--;
            }
            if((_loc5_ = _loc5_.nextListener).tick(_loc2_))
            {
               if(_loc5_.prevListener != null)
               {
                  _loc5_.prevListener.nextListener = _loc5_.nextListener;
               }
               if(_loc5_.nextListener != null)
               {
                  _loc5_.nextListener.prevListener = _loc5_.prevListener;
               }
               if(_loc5_ == this._first)
               {
                  this._first = _loc5_.nextListener;
               }
               if(_loc5_ == this._last)
               {
                  this._last = _loc5_.prevListener;
               }
               _loc7_ = _loc5_.prevListener;
               _loc5_.nextListener = null;
               _loc5_.prevListener = null;
               _loc5_ = _loc7_;
               this._numListeners--;
            }
            if((_loc5_ = _loc5_.nextListener).tick(_loc2_))
            {
               if(_loc5_.prevListener != null)
               {
                  _loc5_.prevListener.nextListener = _loc5_.nextListener;
               }
               if(_loc5_.nextListener != null)
               {
                  _loc5_.nextListener.prevListener = _loc5_.prevListener;
               }
               if(_loc5_ == this._first)
               {
                  this._first = _loc5_.nextListener;
               }
               if(_loc5_ == this._last)
               {
                  this._last = _loc5_.prevListener;
               }
               _loc7_ = _loc5_.prevListener;
               _loc5_.nextListener = null;
               _loc5_.prevListener = null;
               _loc5_ = _loc7_;
               this._numListeners--;
            }
            if((_loc5_ = _loc5_.nextListener).tick(_loc2_))
            {
               if(_loc5_.prevListener != null)
               {
                  _loc5_.prevListener.nextListener = _loc5_.nextListener;
               }
               if(_loc5_.nextListener != null)
               {
                  _loc5_.nextListener.prevListener = _loc5_.prevListener;
               }
               if(_loc5_ == this._first)
               {
                  this._first = _loc5_.nextListener;
               }
               if(_loc5_ == this._last)
               {
                  this._last = _loc5_.prevListener;
               }
               _loc7_ = _loc5_.prevListener;
               _loc5_.nextListener = null;
               _loc5_.prevListener = null;
               _loc5_ = _loc7_;
               this._numListeners--;
            }
            if((_loc5_ = _loc5_.nextListener).tick(_loc2_))
            {
               if(_loc5_.prevListener != null)
               {
                  _loc5_.prevListener.nextListener = _loc5_.nextListener;
               }
               if(_loc5_.nextListener != null)
               {
                  _loc5_.nextListener.prevListener = _loc5_.prevListener;
               }
               if(_loc5_ == this._first)
               {
                  this._first = _loc5_.nextListener;
               }
               if(_loc5_ == this._last)
               {
                  this._last = _loc5_.prevListener;
               }
               _loc7_ = _loc5_.prevListener;
               _loc5_.nextListener = null;
               _loc5_.prevListener = null;
               _loc5_ = _loc7_;
               this._numListeners--;
            }
            if((_loc5_ = _loc5_.nextListener).tick(_loc2_))
            {
               if(_loc5_.prevListener != null)
               {
                  _loc5_.prevListener.nextListener = _loc5_.nextListener;
               }
               if(_loc5_.nextListener != null)
               {
                  _loc5_.nextListener.prevListener = _loc5_.prevListener;
               }
               if(_loc5_ == this._first)
               {
                  this._first = _loc5_.nextListener;
               }
               if(_loc5_ == this._last)
               {
                  this._last = _loc5_.prevListener;
               }
               _loc7_ = _loc5_.prevListener;
               _loc5_.nextListener = null;
               _loc5_.prevListener = null;
               _loc5_ = _loc7_;
               this._numListeners--;
            }
            if((_loc5_ = _loc5_.nextListener).tick(_loc2_))
            {
               if(_loc5_.prevListener != null)
               {
                  _loc5_.prevListener.nextListener = _loc5_.nextListener;
               }
               if(_loc5_.nextListener != null)
               {
                  _loc5_.nextListener.prevListener = _loc5_.prevListener;
               }
               if(_loc5_ == this._first)
               {
                  this._first = _loc5_.nextListener;
               }
               if(_loc5_ == this._last)
               {
                  this._last = _loc5_.prevListener;
               }
               _loc7_ = _loc5_.prevListener;
               _loc5_.nextListener = null;
               _loc5_.prevListener = null;
               _loc5_ = _loc7_;
               this._numListeners--;
            }
         }
         if((this._first = _loc6_.nextListener) != null)
         {
            this._first.prevListener = null;
         }
         else
         {
            this._last = null;
         }
         _loc6_.nextListener = this._tickerListenerPaddings[_loc4_ + 1] as TickerListener;
      }
   }
}
