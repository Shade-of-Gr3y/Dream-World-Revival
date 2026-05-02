package org.libspark.betweenas3.tweens
{
   public interface ITweenGroup extends ITween
   {
       
      
      function contains(param1:ITween) : Boolean;
      
      function getTweenAt(param1:int) : ITween;
      
      function getTweenIndex(param1:ITween) : int;
   }
}
