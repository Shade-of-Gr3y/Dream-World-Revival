package org.libspark.betweenas3.core.tweens
{
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.tweens.ITween;
   
   public interface IITween extends ITween
   {
       
      
      function get ticker() : ITicker;
      
      function firePlay() : void;
      
      function fireStop() : void;
      
      function update(param1:Number) : void;
   }
}
