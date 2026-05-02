package bfp.pgl.campaign.animator
{
   import caurina.transitions.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class BtAnimator extends EventDispatcher
   {
      
      private var _defaultH:Number = 1;
      
      private var _defaultW:Number = 1;
      
      private var _defaultX:Number = 0;
      
      private var _defaultY:Number = 0;
      
      private var _bg:MovieClip;
      
      private var _target:MovieClip;
      
      private var _offset:Number = 40;
      
      public function BtAnimator(param1:MovieClip)
      {
         super();
         this._target = param1;
         this._bg = param1.bg;
         this._defaultX = param1.x;
         this._defaultY = param1.y;
         this._defaultW = param1.width;
         this._defaultH = param1.height;
         this.reset();
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this._target);
         Tweener.removeTweens(this._bg);
      }
      
      public function get display() : MovieClip
      {
         return this._target;
      }
      
      public function out() : *
      {
         MouseAnimator.out(this._bg);
      }
      
      public function reset() : *
      {
         this._target.visible = false;
         this._target.alpha = 0;
         MouseAnimator.reset(this._bg);
      }
      
      public function get offset() : Number
      {
         return this._offset;
      }
      
      public function over() : *
      {
         MouseAnimator.over(this._bg,this.offset);
      }
      
      public function appear() : *
      {
         Tweener.removeTweens(this._target);
         this._target.visible = true;
         this._target.alpha = 1;
      }
      
      public function set defaultH(param1:Number) : *
      {
         this._defaultH = param1;
      }
      
      public function banish() : *
      {
         Tweener.removeTweens(this._target);
         this._target.visible = false;
         this._target.alpha = 0;
      }
      
      public function set offset(param1:Number) : *
      {
         this._offset = param1;
      }
      
      public function get defaultH() : Number
      {
         return this._defaultH;
      }
      
      public function set defaultX(param1:Number) : *
      {
         this._defaultX = param1;
      }
      
      public function play(param1:* = 0) : *
      {
         Tweener.addTween(this._target,{
            "delay":param1,
            "time":0.2,
            "transition":"linear",
            "_autoAlpha":1
         });
      }
      
      public function get defaultW() : Number
      {
         return this._defaultW;
      }
      
      public function get defaultX() : Number
      {
         return this._defaultX;
      }
      
      public function get defaultY() : Number
      {
         return this._defaultY;
      }
      
      public function set defaultW(param1:Number) : *
      {
         this._defaultW = param1;
      }
      
      public function set defaultY(param1:Number) : *
      {
         this._defaultY = param1;
      }
   }
}

