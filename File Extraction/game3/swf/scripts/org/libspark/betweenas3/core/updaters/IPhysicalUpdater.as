package org.libspark.betweenas3.core.updaters
{
   import org.libspark.betweenas3.core.easing.IPhysicalEasing;
   
   public interface IPhysicalUpdater extends IUpdater
   {
      
      function get easing() : IPhysicalEasing;
      
      function set easing(param1:IPhysicalEasing) : void;
      
      function get duration() : Number;
   }
}

