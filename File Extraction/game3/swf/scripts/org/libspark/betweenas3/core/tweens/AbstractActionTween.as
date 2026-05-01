package org.libspark.betweenas3.core.tweens
{
   import org.libspark.betweenas3.core.ticker.ITicker;
   
   public class AbstractActionTween extends AbstractTween implements IIActionTween
   {
      
      private var _lastTime:Number;
      
      public function AbstractActionTween(param1:ITicker)
      {
         super(param1,0);
         _duration = 0.01;
         this._lastTime = -1;
      }
      
      override protected function internalUpdate(param1:Number) : void
      {
         if(this._lastTime < 0.01 && param1 >= 0.01)
         {
            this.action();
         }
         else if(this._lastTime > 0 && param1 <= 0)
         {
            this.rollback();
         }
         this._lastTime = param1;
      }
      
      protected function action() : void
      {
      }
      
      protected function rollback() : void
      {
      }
   }
}

