package org.libspark.betweenas3.core.tweens.decorators
{
   import org.libspark.betweenas3.core.tweens.AbstractTween;
   import org.libspark.betweenas3.core.tweens.IITween;
   import org.libspark.betweenas3.core.tweens.TweenDecorator;
   
   public class SlicedTween extends TweenDecorator
   {
      
      private var _begin:Number;
      
      private var _end:Number;
      
      public function SlicedTween(param1:IITween, param2:Number, param3:Number)
      {
         super(param1,0);
         _duration = param3 - param2;
         this._begin = param2;
         this._end = param3;
      }
      
      public function get begin() : Number
      {
         return this._begin;
      }
      
      public function get end() : Number
      {
         return this._end;
      }
      
      override protected function internalUpdate(param1:Number) : void
      {
         if(param1 > 0)
         {
            if(param1 < _duration)
            {
               _baseTween.update(param1 + this._begin);
            }
            else
            {
               _baseTween.update(this._end);
            }
         }
         else
         {
            _baseTween.update(this._begin);
         }
      }
      
      override protected function newInstance() : AbstractTween
      {
         return new SlicedTween(_baseTween.clone() as IITween,this._begin,this._end);
      }
   }
}

