package bfp.pgl.campaign.animator
{
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   
   public class TitleAnimator extends EventDispatcher
   {
      
      private var _defaultH:Number = 1;
      
      private var _target:MovieClip;
      
      private var _defaultW:Number = 1;
      
      private var _defaultX:Number = 0;
      
      private var _defaultY:Number = 0;
      
      public function TitleAnimator(param1:MovieClip)
      {
         super();
         this._target = param1;
         this._defaultX = param1.x;
         this._defaultY = param1.y;
         this._defaultW = param1.width;
         this._defaultH = param1.height;
         this.reset();
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this._target);
      }
      
      public function set defaultW(param1:Number) : *
      {
         this._defaultW = param1;
      }
      
      public function get defaultW() : Number
      {
         return this._defaultW;
      }
      
      public function get defaultH() : Number
      {
         return this._defaultH;
      }
      
      public function get display() : MovieClip
      {
         return this._target;
      }
      
      public function reset() : *
      {
         this._target.visible = false;
         this._target.alpha = 0;
      }
      
      public function set defaultH(param1:Number) : *
      {
         this._defaultH = param1;
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
      
      public function get defaultY() : Number
      {
         return this._defaultY;
      }
      
      public function set defaultX(param1:Number) : *
      {
         this._defaultX = param1;
      }
      
      public function get defaultX() : Number
      {
         return this._defaultX;
      }
      
      public function set defaultY(param1:Number) : *
      {
         this._defaultY = param1;
      }
   }
}

