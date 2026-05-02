package org.libspark.betweenas3.core.tweens
{
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.core.updaters.IPhysicalUpdater;
   
   public class PhysicalTween extends AbstractTween implements IIPhysicalTween
   {
       
      
      protected var _updater:IPhysicalUpdater;
      
      public function PhysicalTween(param1:ITicker)
      {
         super(param1,0);
      }
      
      public function get updater() : IPhysicalUpdater
      {
         return this._updater;
      }
      
      public function set updater(param1:IPhysicalUpdater) : void
      {
         this._updater = param1;
         if(this._updater != null)
         {
            _duration = this._updater.duration;
         }
      }
      
      public function get target() : Object
      {
         return this._updater != null?this._updater.target:null;
      }
      
      override protected function internalUpdate(param1:Number) : void
      {
         this._updater.update(param1);
      }
      
      override protected function newInstance() : AbstractTween
      {
         return new PhysicalTween(_ticker);
      }
      
      override protected function copyFrom(param1:AbstractTween) : void
      {
         super.copyFrom(param1);
         var _loc2_:PhysicalTween = param1 as PhysicalTween;
         this._updater = _loc2_._updater.clone() as IPhysicalUpdater;
      }
   }
}
