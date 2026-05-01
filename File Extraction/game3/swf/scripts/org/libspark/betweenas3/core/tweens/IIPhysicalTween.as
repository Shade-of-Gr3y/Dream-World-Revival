package org.libspark.betweenas3.core.tweens
{
   import org.libspark.betweenas3.core.updaters.IPhysicalUpdater;
   import org.libspark.betweenas3.tweens.IObjectTween;
   
   public interface IIPhysicalTween extends IObjectTween, IITween
   {
      
      function get updater() : IPhysicalUpdater;
      
      function set updater(param1:IPhysicalUpdater) : void;
   }
}

