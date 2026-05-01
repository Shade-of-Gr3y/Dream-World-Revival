package org.libspark.betweenas3.core.tweens.decorators
{
   import org.libspark.betweenas3.core.tweens.AbstractTween;
   import org.libspark.betweenas3.core.tweens.IITween;
   import org.libspark.betweenas3.core.tweens.TweenDecorator;
   
   public class ScaledTween extends TweenDecorator
   {
      
      private var _scale:Number;
      
      public function ScaledTween(param1:IITween, param2:Number)
      {
         super(param1,0);
         _duration = param1.duration * param2;
         this._scale = param2;
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
      
      override protected function internalUpdate(param1:Number) : void
      {
         _baseTween.update(param1 / this.scale);
      }
      
      override protected function newInstance() : AbstractTween
      {
         return new ScaledTween(_baseTween.clone() as IITween,this._scale);
      }
   }
}

