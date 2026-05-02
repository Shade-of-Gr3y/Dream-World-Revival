package org.libspark.betweenas3.core.tweens
{
   import org.libspark.betweenas3.core.easing.IEasing;
   import org.libspark.betweenas3.core.updaters.IUpdater;
   import org.libspark.betweenas3.tweens.IObjectTween;
   
   public interface IIObjectTween extends IObjectTween, IITween
   {
       
      
      function get time() : Number;
      
      function set time(param1:Number) : void;
      
      function get easing() : IEasing;
      
      function set easing(param1:IEasing) : void;
      
      function get updater() : IUpdater;
      
      function set updater(param1:IUpdater) : void;
   }
}
