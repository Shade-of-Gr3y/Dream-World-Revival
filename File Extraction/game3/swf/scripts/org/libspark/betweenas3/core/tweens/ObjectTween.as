package org.libspark.betweenas3.core.tweens
{
   import org.libspark.betweenas3.core.easing.IEasing;
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.core.updaters.IUpdater;
   
   public class ObjectTween extends AbstractTween implements IIObjectTween
   {
      
      protected var _easing:IEasing;
      
      protected var _updater:IUpdater;
      
      public function ObjectTween(param1:ITicker)
      {
         super(param1,0);
      }
      
      public function get time() : Number
      {
         return _duration;
      }
      
      public function set time(param1:Number) : void
      {
         _duration = param1;
      }
      
      public function get easing() : IEasing
      {
         return this._easing;
      }
      
      public function set easing(param1:IEasing) : void
      {
         this._easing = param1;
      }
      
      public function get updater() : IUpdater
      {
         return this._updater;
      }
      
      public function set updater(param1:IUpdater) : void
      {
         this._updater = param1;
      }
      
      public function get target() : Object
      {
         return this._updater != null ? this._updater.target : null;
      }
      
      override protected function internalUpdate(param1:Number) : void
      {
         var _loc2_:Number = 0;
         if(param1 > 0)
         {
            if(param1 < _duration)
            {
               _loc2_ = this._easing.calculate(param1,0,1,_duration);
            }
            else
            {
               _loc2_ = 1;
            }
         }
         this._updater.update(_loc2_);
      }
      
      override protected function newInstance() : AbstractTween
      {
         return new ObjectTween(_ticker);
      }
      
      override protected function copyFrom(param1:AbstractTween) : void
      {
         super.copyFrom(param1);
         var _loc2_:ObjectTween = param1 as ObjectTween;
         this._easing = _loc2_._easing;
         this._updater = _loc2_._updater.clone();
      }
   }
}

