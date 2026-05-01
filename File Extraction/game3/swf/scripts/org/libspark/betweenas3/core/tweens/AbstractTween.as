package org.libspark.betweenas3.core.tweens
{
   import flash.events.Event;
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.core.ticker.TickerListener;
   import org.libspark.betweenas3.core.utils.ClonableEventDispatcher;
   import org.libspark.betweenas3.events.TweenEvent;
   import org.libspark.betweenas3.tweens.ITween;
   
   public class AbstractTween extends TickerListener implements IITween
   {
      
      protected var _ticker:ITicker;
      
      protected var _position:Number = 0;
      
      protected var _duration:Number = 0;
      
      protected var _startTime:Number;
      
      protected var _isPlaying:Boolean = false;
      
      protected var _stopOnComplete:Boolean = true;
      
      protected var _dispatcher:ClonableEventDispatcher;
      
      protected var _willTriggerFlags:uint = 0;
      
      protected var _classicHandlers:ClassicHandlers;
      
      public function AbstractTween(param1:ITicker, param2:Number)
      {
         super();
         this._ticker = param1;
         this._position = param2;
      }
      
      public function get ticker() : ITicker
      {
         return this._ticker;
      }
      
      public function get duration() : Number
      {
         return this._duration;
      }
      
      public function get position() : Number
      {
         return this._position;
      }
      
      public function get isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function get stopOnComplete() : Boolean
      {
         return this._stopOnComplete;
      }
      
      public function set stopOnComplete(param1:Boolean) : void
      {
         this._stopOnComplete = param1;
      }
      
      public function get onPlay() : Function
      {
         return this._classicHandlers != null ? this._classicHandlers.onPlay : null;
      }
      
      public function set onPlay(param1:Function) : void
      {
         this.getClassicHandlers().onPlay = param1;
      }
      
      public function get onPlayParams() : Array
      {
         return this._classicHandlers != null ? this._classicHandlers.onPlayParams : null;
      }
      
      public function set onPlayParams(param1:Array) : void
      {
         this.getClassicHandlers().onPlayParams = param1;
      }
      
      public function get onStop() : Function
      {
         return this._classicHandlers != null ? this._classicHandlers.onStop : null;
      }
      
      public function set onStop(param1:Function) : void
      {
         this.getClassicHandlers().onStop = param1;
      }
      
      public function get onStopParams() : Array
      {
         return this._classicHandlers != null ? this._classicHandlers.onStopParams : null;
      }
      
      public function set onStopParams(param1:Array) : void
      {
         this.getClassicHandlers().onStopParams = param1;
      }
      
      public function get onUpdate() : Function
      {
         return this._classicHandlers != null ? this._classicHandlers.onUpdate : null;
      }
      
      public function set onUpdate(param1:Function) : void
      {
         this.getClassicHandlers().onUpdate = param1;
      }
      
      public function get onUpdateParams() : Array
      {
         return this._classicHandlers != null ? this._classicHandlers.onUpdateParams : null;
      }
      
      public function set onUpdateParams(param1:Array) : void
      {
         this.getClassicHandlers().onUpdateParams = param1;
      }
      
      public function get onComplete() : Function
      {
         return this._classicHandlers != null ? this._classicHandlers.onComplete : null;
      }
      
      public function set onComplete(param1:Function) : void
      {
         this.getClassicHandlers().onComplete = param1;
      }
      
      public function get onCompleteParams() : Array
      {
         return this._classicHandlers != null ? this._classicHandlers.onCompleteParams : null;
      }
      
      public function set onCompleteParams(param1:Array) : void
      {
         this.getClassicHandlers().onCompleteParams = param1;
      }
      
      protected function getClassicHandlers() : ClassicHandlers
      {
         return this._classicHandlers || (this._classicHandlers = new ClassicHandlers());
      }
      
      public function play() : void
      {
         var _loc1_:Number = NaN;
         if(!this._isPlaying)
         {
            if(this._position >= this._duration)
            {
               this._position = 0;
            }
            _loc1_ = this._ticker.time;
            this._startTime = _loc1_ - this._position;
            this._isPlaying = true;
            this._ticker.addTickerListener(this);
            if((this._willTriggerFlags & 1) != 0)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.PLAY));
            }
            if(this._classicHandlers != null && this._classicHandlers.onPlay != null)
            {
               this._classicHandlers.onPlay.apply(null,this._classicHandlers.onPlayParams);
            }
            this.tick(_loc1_);
         }
      }
      
      public function firePlay() : void
      {
         if((this._willTriggerFlags & 1) != 0)
         {
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.PLAY));
         }
         if(this._classicHandlers != null && this._classicHandlers.onPlay != null)
         {
            this._classicHandlers.onPlay.apply(null,this._classicHandlers.onPlayParams);
         }
      }
      
      public function stop() : void
      {
         if(this._isPlaying)
         {
            this._isPlaying = false;
            if((this._willTriggerFlags & 2) != 0)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.STOP));
            }
            if(this._classicHandlers != null && this._classicHandlers.onStop != null)
            {
               this._classicHandlers.onStop.apply(null,this._classicHandlers.onStopParams);
            }
         }
      }
      
      public function fireStop() : void
      {
         if((this._willTriggerFlags & 2) != 0)
         {
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.STOP));
         }
         if(this._classicHandlers != null && this._classicHandlers.onStop != null)
         {
            this._classicHandlers.onStop.apply(null,this._classicHandlers.onStopParams);
         }
      }
      
      public function togglePause() : void
      {
         if(this._isPlaying)
         {
            this.stop();
         }
         else
         {
            this.play();
         }
      }
      
      public function gotoAndPlay(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > this._duration)
         {
            param1 = this._duration;
         }
         this._position = param1;
         this.play();
      }
      
      public function gotoAndStop(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > this._duration)
         {
            param1 = this._duration;
         }
         this._position = param1;
         this.internalUpdate(param1);
         if((this._willTriggerFlags & 4) != 0)
         {
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
         }
         if(this._classicHandlers != null && this._classicHandlers.onUpdate != null)
         {
            this._classicHandlers.onUpdate.apply(null,this._classicHandlers.onUpdateParams);
         }
         this.stop();
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         if(this._position < this._duration && this._duration <= param1 || 0 < this._position && param1 <= 0)
         {
            _loc2_ = true;
         }
         this._position = param1;
         this.internalUpdate(param1);
         if((this._willTriggerFlags & 4) != 0)
         {
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
         }
         if(this._classicHandlers != null && this._classicHandlers.onUpdate != null)
         {
            this._classicHandlers.onUpdate.apply(null,this._classicHandlers.onUpdateParams);
         }
         if(_loc2_)
         {
            if((this._willTriggerFlags & 8) != 0)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
            }
            if(this._classicHandlers != null && this._classicHandlers.onComplete != null)
            {
               this._classicHandlers.onComplete.apply(null,this._classicHandlers.onCompleteParams);
            }
         }
      }
      
      override public function tick(param1:Number) : Boolean
      {
         if(!this._isPlaying)
         {
            return true;
         }
         var _loc2_:Number = param1 - this._startTime;
         this._position = _loc2_;
         this.internalUpdate(_loc2_);
         if((this._willTriggerFlags & 4) != 0)
         {
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
         }
         if(this._classicHandlers != null && this._classicHandlers.onUpdate != null)
         {
            this._classicHandlers.onUpdate.apply(null,this._classicHandlers.onUpdateParams);
         }
         if(this._isPlaying)
         {
            if(_loc2_ >= this._duration)
            {
               this._position = this._duration;
               if(this._stopOnComplete)
               {
                  this._isPlaying = false;
                  if((this._willTriggerFlags & 8) != 0)
                  {
                     this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                  }
                  if(this._classicHandlers != null && this._classicHandlers.onComplete != null)
                  {
                     this._classicHandlers.onComplete.apply(null,this._classicHandlers.onCompleteParams);
                  }
                  return true;
               }
               if((this._willTriggerFlags & 8) != 0)
               {
                  this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
               }
               if(this._classicHandlers != null && this._classicHandlers.onComplete != null)
               {
                  this._classicHandlers.onComplete.apply(null,this._classicHandlers.onCompleteParams);
               }
               this._position = _loc2_ - this._duration;
               this._startTime = param1 - this._position;
               this.tick(param1);
            }
            return false;
         }
         return true;
      }
      
      protected function internalUpdate(param1:Number) : void
      {
      }
      
      public function clone() : ITween
      {
         var _loc1_:AbstractTween = this.newInstance();
         if(_loc1_ != null)
         {
            _loc1_.copyFrom(this);
         }
         return _loc1_;
      }
      
      protected function newInstance() : AbstractTween
      {
         return null;
      }
      
      protected function copyFrom(param1:AbstractTween) : void
      {
         this._ticker = param1._ticker;
         this._duration = param1._duration;
         this._stopOnComplete = param1._stopOnComplete;
         if(param1._classicHandlers != null)
         {
            this._classicHandlers = new ClassicHandlers();
            this._classicHandlers.copyFrom(param1._classicHandlers);
         }
         if(param1._dispatcher != null)
         {
            this._dispatcher = new ClonableEventDispatcher(this);
            this._dispatcher.copyFrom(param1._dispatcher);
         }
         this._willTriggerFlags = param1._willTriggerFlags;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(this._dispatcher == null)
         {
            this._dispatcher = new ClonableEventDispatcher(this);
         }
         this._dispatcher.addEventListener(param1,param2,param3,param4,param5);
         this.updateWillTriggerFlags();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         if(this._dispatcher != null)
         {
            return this._dispatcher.dispatchEvent(param1);
         }
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         if(this._dispatcher != null)
         {
            return this._dispatcher.hasEventListener(param1);
         }
         return false;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(this._dispatcher != null)
         {
            this._dispatcher.removeEventListener(param1,param2,param3);
            this.updateWillTriggerFlags();
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         if(this._dispatcher != null)
         {
            return this._dispatcher.willTrigger(param1);
         }
         return false;
      }
      
      protected function updateWillTriggerFlags() : void
      {
         if(this._dispatcher.willTrigger(TweenEvent.PLAY))
         {
            this._willTriggerFlags |= 1;
         }
         else
         {
            this._willTriggerFlags &= ~1;
         }
         if(this._dispatcher.willTrigger(TweenEvent.STOP))
         {
            this._willTriggerFlags |= 2;
         }
         else
         {
            this._willTriggerFlags &= ~2;
         }
         if(this._dispatcher.willTrigger(TweenEvent.UPDATE))
         {
            this._willTriggerFlags |= 4;
         }
         else
         {
            this._willTriggerFlags &= ~4;
         }
         if(this._dispatcher.willTrigger(TweenEvent.COMPLETE))
         {
            this._willTriggerFlags |= 8;
         }
         else
         {
            this._willTriggerFlags &= ~8;
         }
      }
   }
}

class ClassicHandlers
{
   
   public var onPlay:Function;
   
   public var onPlayParams:Array;
   
   public var onStop:Function;
   
   public var onStopParams:Array;
   
   public var onUpdate:Function;
   
   public var onUpdateParams:Array;
   
   public var onComplete:Function;
   
   public var onCompleteParams:Array;
   
   public function ClassicHandlers()
   {
      super();
   }
   
   public function copyFrom(param1:ClassicHandlers) : void
   {
      this.onPlay = param1.onPlay;
      this.onPlayParams = param1.onPlayParams;
      this.onStop = param1.onStop;
      this.onStopParams = param1.onStopParams;
      this.onUpdate = param1.onUpdate;
      this.onUpdateParams = param1.onUpdateParams;
      this.onComplete = param1.onComplete;
      this.onCompleteParams = param1.onCompleteParams;
   }
}
