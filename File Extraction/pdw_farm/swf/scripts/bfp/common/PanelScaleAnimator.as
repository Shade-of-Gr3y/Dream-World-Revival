package bfp.common
{
   import caurina.transitions.Tweener;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class PanelScaleAnimator extends EventDispatcher
   {
      
      public static const SHOW_FINISH:String = "showFinish";
      
      public static const HIDE_FINISH:String = "hideFinish";
      
      protected var _targetObject:DisplayObject;
      
      protected var _defaultX:Number = 0;
      
      protected var _defaultY:Number = 0;
      
      protected var _scale:Number = 0.9;
      
      protected var _defaultW:Number = 1;
      
      protected var _defaultH:Number = 1;
      
      public function PanelScaleAnimator(param1:DisplayObject, param2:Number = 0, param3:Number = 0)
      {
         super();
         this._targetObject = DisplayObject(param1);
         this._defaultW = param2;
         this._defaultH = param3;
         this.init();
      }
      
      protected function init() : *
      {
         this._targetObject.visible = false;
         this._defaultX = this._targetObject.x;
         this._defaultY = this._targetObject.y;
         this.reset();
      }
      
      public function reset() : *
      {
         Tweener.removeTweens(this._targetObject,"_color_redOffset","_color_greenOffset","_color_blueOffset","_color_alphaMultiplier","_Blur_blurX","_Blur_blurY","x","y","scaleX","scaleY","alpha","_autoAlpha");
         this._targetObject.visible = false;
         this._targetObject.alpha = 0;
         this._targetObject.scaleX = this._targetObject.scaleY = this._scale;
         var _loc1_:* = (this._defaultW - this._defaultW * this._scale) / 2;
         var _loc2_:* = (this._defaultH - this._defaultH * this._scale) / 2;
         this._targetObject.x = this._defaultX + _loc1_;
         this._targetObject.y = this._defaultY + _loc2_;
         Tweener.addTween(this._targetObject,{
            "delay":0,
            "time":0,
            "transition":"linear",
            "_color_redOffset":255,
            "_color_greenOffset":255,
            "_color_blueOffset":255,
            "_color_alphaMultiplier":0,
            "_Blur_blurX":16,
            "_Blur_blurY":16
         });
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
      
      public function get defaultW() : Number
      {
         return this._defaultW;
      }
      
      public function set defaultW(param1:Number) : *
      {
         this._defaultW = param1;
      }
      
      public function get defaultH() : Number
      {
         return this._defaultH;
      }
      
      public function set defaultH(param1:Number) : *
      {
         this._defaultH = param1;
      }
      
      public function get scale() : Number
      {
         return this._scale;
      }
      
      public function set scale(param1:Number) : *
      {
         this._scale = param1;
      }
      
      public function get targetObject() : DisplayObject
      {
         return this._targetObject;
      }
      
      public function set targetObject(param1:DisplayObject) : *
      {
         this._targetObject = param1;
      }
      
      public function show() : *
      {
         this._targetObject.visible = true;
         Tweener.addTween(this._targetObject,{
            "delay":0,
            "time":0.25,
            "transition":"linear",
            "_color_redOffset":0,
            "_color_greenOffset":0,
            "_color_blueOffset":0,
            "_color_alphaMultiplier":1,
            "_Blur_blurX":0,
            "_Blur_blurY":0
         });
         Tweener.addTween(this._targetObject,{
            "delay":0,
            "time":0.25,
            "transition":"easeOutSine",
            "x":this._defaultX,
            "y":this._defaultY,
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.showFinish
         });
      }
      
      protected function showFinish() : *
      {
         dispatchEvent(new Event(PanelScaleAnimator.SHOW_FINISH));
      }
      
      public function hide() : *
      {
         Tweener.removeTweens(this._targetObject,"_color_redOffset","_color_greenOffset","_color_blueOffset","_color_alphaMultiplier","_Blur_blurX","_Blur_blurY","x","y","scaleX","scaleY","alpha","_autoAlpha");
         Tweener.addTween(this._targetObject,{
            "delay":0,
            "time":0.1,
            "transition":"linear",
            "_autoAlpha":0,
            "onComplete":this.hideFinish
         });
      }
      
      protected function hideFinish() : *
      {
         dispatchEvent(new Event(PanelScaleAnimator.HIDE_FINISH));
      }
   }
}

