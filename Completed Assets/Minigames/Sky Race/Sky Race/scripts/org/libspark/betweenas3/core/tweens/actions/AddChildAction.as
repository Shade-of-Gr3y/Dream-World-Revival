package org.libspark.betweenas3.core.tweens.actions
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import org.libspark.betweenas3.core.ticker.ITicker;
   import org.libspark.betweenas3.core.tweens.AbstractActionTween;
   
   public class AddChildAction extends AbstractActionTween
   {
       
      
      private var _target:DisplayObject;
      
      private var _parent:DisplayObjectContainer;
      
      public function AddChildAction(param1:ITicker, param2:DisplayObject, param3:DisplayObjectContainer)
      {
         super(param1);
         this._target = param2;
         this._parent = param3;
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function get parent() : DisplayObjectContainer
      {
         return this._parent;
      }
      
      override protected function action() : void
      {
         if(this._target != null && this._parent != null && this._target.parent != this._parent)
         {
            this._parent.addChild(this._target);
         }
      }
      
      override protected function rollback() : void
      {
         if(this._target != null && this._parent != null && this._target.parent == this._parent)
         {
            this._parent.removeChild(this._target);
         }
      }
   }
}
