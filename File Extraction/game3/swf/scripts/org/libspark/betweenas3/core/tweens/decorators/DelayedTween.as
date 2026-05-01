package org.libspark.betweenas3.core.tweens.decorators
{
   import org.libspark.betweenas3.core.tweens.AbstractTween;
   import org.libspark.betweenas3.core.tweens.IITween;
   import org.libspark.betweenas3.core.tweens.TweenDecorator;
   
   public class DelayedTween extends TweenDecorator
   {
      
      private var _preDelay:Number;
      
      private var _postDelay:Number;
      
      public function DelayedTween(param1:IITween, param2:Number, param3:Number)
      {
         super(param1,0);
         _duration = param2 + param1.duration + param3;
         this._preDelay = param2;
         this._postDelay = param3;
      }
      
      public function get preDelay() : Number
      {
         return this._preDelay;
      }
      
      public function get postDelay() : Number
      {
         return this._postDelay;
      }
      
      override protected function internalUpdate(param1:Number) : void
      {
         _baseTween.update(param1 - this._preDelay);
      }
      
      override protected function newInstance() : AbstractTween
      {
         return new DelayedTween(_baseTween.clone() as IITween,this._preDelay,this._postDelay);
      }
   }
}

