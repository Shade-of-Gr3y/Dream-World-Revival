package org.libspark.betweenas3.core.tweens.actions
{
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.core.tweens.AbstractActionTween;
   
   public class FunctionAction extends AbstractActionTween
   {
      
      private var _func:Function;
      
      private var _params:Array;
      
      private var _rollbackFunc:Function;
      
      private var _rollbackParams:Array;
      
      public function FunctionAction(param1:ITicker, param2:Function, param3:Array = null, param4:Boolean = false, param5:Function = null, param6:Array = null)
      {
         super(param1);
         this._func = param2;
         this._params = param3;
         if(param4)
         {
            if(param5 != null)
            {
               this._rollbackFunc = param5;
               this._rollbackParams = param6;
            }
            else
            {
               this._rollbackFunc = param2;
               this._rollbackParams = param3;
            }
         }
      }
      
      override protected function action() : void
      {
         if(this._func != null)
         {
            this._func.apply(null,this._params);
         }
      }
      
      override protected function rollback() : void
      {
         if(this._rollbackFunc != null)
         {
            this._rollbackFunc.apply(null,this._rollbackParams);
         }
      }
   }
}

