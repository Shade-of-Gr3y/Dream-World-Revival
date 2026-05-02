package bfp.common
{
   import caurina.transitions.Tweener;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class FukidashiAnimator extends EventDispatcher
   {
      
      public static const POSITION_TYPE_TOP:String = "top";
      
      public static const POSITION_TYPE_BOTTOM:String = "bottom";
      
      public static const SHOW_FINISH:String = "showFinish";
      
      protected var _targetObject:DisplayObject;
      
      protected var _defaultX:Number = 0;
      
      protected var _defaultY:Number = 0;
      
      public function FukidashiAnimator(param1:DisplayObject, param2:Number = 0, param3:Number = 0)
      {
         super();
         this._targetObject = DisplayObject(param1);
         this._defaultX = param2;
         this._defaultY = param3;
         this.init();
      }
      
      protected function init() : *
      {
         this._targetObject.visible = false;
      }
      
      public function get defaultX() : Number
      {
         return this._defaultX;
      }
      
      public function set defaultX(param1:Number) : *
      {
         this._defaultX = param1;
      }
      
      public function get defaultY() : Number
      {
         return this._defaultY;
      }
      
      public function set defaultY(param1:Number) : *
      {
         this._defaultY = param1;
      }
      
      public function get targetObject() : DisplayObject
      {
         return this._targetObject;
      }
      
      public function set targetObject(param1:DisplayObject) : *
      {
         this._targetObject = param1;
      }
      
      public function show(param1:* = "top") : *
      {
         var _loc2_:* = undefined;
         switch(param1)
         {
            case POSITION_TYPE_TOP:
               _loc2_ = -16;
               break;
            case POSITION_TYPE_BOTTOM:
               _loc2_ = 16;
         }
         this._targetObject.visible = true;
         Tweener.removeTweens(this._targetObject,"y");
         this._targetObject.x = this._defaultX;
         this._targetObject.y = this._defaultY;
         Tweener.addTween(this._targetObject,{
            "delay":0,
            "time":0.1,
            "transition":"easeOutQuad",
            "y":this._defaultY + _loc2_
         });
         Tweener.addTween(this._targetObject,{
            "delay":0.1,
            "time":0.2,
            "transition":"easeInQuad",
            "y":this._defaultY,
            "onComplete":this.showFinish
         });
      }
      
      protected function showFinish() : *
      {
         dispatchEvent(new Event(FukidashiAnimator.SHOW_FINISH));
      }
      
      public function hide() : *
      {
         Tweener.removeTweens(this._targetObject,"y");
         this._targetObject.visible = false;
      }
   }
}

