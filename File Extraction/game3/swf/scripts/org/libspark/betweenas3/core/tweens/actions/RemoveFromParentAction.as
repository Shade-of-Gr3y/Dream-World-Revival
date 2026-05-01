package org.libspark.betweenas3.core.tweens.actions
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.core.tweens.AbstractActionTween;
   
   public class RemoveFromParentAction extends AbstractActionTween
   {
      
      private var _target:DisplayObject;
      
      private var _parent:DisplayObjectContainer;
      
      public function RemoveFromParentAction(param1:ITicker, param2:DisplayObject)
      {
         super(param1);
         this._target = param2;
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      override protected function action() : void
      {
         if(this._target != null && this._target.parent != null)
         {
            this._parent = this._target.parent;
            this._parent.removeChild(this._target);
         }
      }
      
      override protected function rollback() : void
      {
         if(this._target != null && this._parent != null)
         {
            this._parent.addChild(this._target);
            this._parent = null;
         }
      }
   }
}

