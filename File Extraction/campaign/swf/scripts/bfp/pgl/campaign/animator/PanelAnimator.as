package bfp.pgl.campaign.animator
{
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   
   public class PanelAnimator extends EventDispatcher
   {
      
      private var debugTime:Number = 0;
      
      private var _defaultH:Number = 1;
      
      private var _defaultW:Number = 1;
      
      private var _defaultX:Number = 0;
      
      private var _defaultY:Number = 0;
      
      private var _centerX:Number = 0;
      
      private var _centerY:Number = 0;
      
      private var _target:MovieClip;
      
      private const TARGET_SCALE:Number = 1.2;
      
      public function PanelAnimator(param1:MovieClip)
      {
         super();
         this._target = param1;
         this._defaultX = param1.x;
         this._defaultY = param1.y;
         this._defaultW = param1.width;
         this._defaultH = param1.height;
         this._centerX = Math.floor(this._defaultW / 2);
         this._centerY = Math.floor(this._defaultH / 2);
         this.reset();
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this._target);
      }
      
      public function get display() : *
      {
         return this._target;
      }
      
      public function set defaultH(param1:Number) : *
      {
         this._defaultH = param1;
         this._centerY = Math.floor(this._defaultH / 2);
      }
      
      public function reset() : *
      {
         this._target.visible = false;
         this._target.alpha = 0;
         this._target.scaleX = this._target.scaleY = this.TARGET_SCALE;
         this._target.x = this._centerX - this._target.width / 2;
         this._target.y = this._centerY - this._target.height / 2;
      }
      
      public function set defaultY(param1:Number) : *
      {
         this._defaultY = param1;
      }
      
      public function get defaultH() : Number
      {
         return this._defaultH;
      }
      
      private function playFinish() : *
      {
         var _loc1_:* = getTimer();
         var _loc2_:* = _loc1_ - this.debugTime;
         this.stop();
      }
      
      public function play() : *
      {
         this.debugTime = getTimer();
         var _loc1_:* = 80;
         this._target.visible = true;
         Tweener.addTween(this._target,{
            "delay":0,
            "time":0.6,
            "transition":"easeOutCubic",
            "x":this.defaultX,
            "y":this.defaultY,
            "scaleX":1,
            "scaleY":1
         });
         Tweener.addTween(this._target,{
            "delay":0,
            "time":0.5,
            "transition":"linear",
            "alpha":1
         });
         Tweener.addTween(this._target,{
            "delay":0.5,
            "time":0.03,
            "transition":"linear",
            "_color_redOffset":_loc1_,
            "_color_greenOffset":_loc1_,
            "_color_blueOffset":_loc1_
         });
         Tweener.addTween(this._target,{
            "delay":0.53,
            "time":0.03,
            "transition":"linear",
            "_color_redOffset":0,
            "_color_greenOffset":0,
            "_color_blueOffset":0
         });
         Tweener.addTween(this._target,{
            "delay":0.56,
            "time":0.03,
            "transition":"linear",
            "_color_redOffset":_loc1_,
            "_color_greenOffset":_loc1_,
            "_color_blueOffset":_loc1_
         });
         Tweener.addTween(this._target,{
            "delay":0.59,
            "time":0.03,
            "transition":"linear",
            "_color_redOffset":0,
            "_color_greenOffset":0,
            "_color_blueOffset":0,
            "onComplete":this.playFinish
         });
      }
      
      public function set defaultX(param1:Number) : *
      {
         this._defaultX = param1;
      }
      
      public function get defaultW() : Number
      {
         return this._defaultW;
      }
      
      public function get defaultX() : Number
      {
         return this._defaultX;
      }
      
      public function set defaultW(param1:Number) : *
      {
         this._defaultW = param1;
         this._centerX = Math.floor(this._defaultW / 2);
      }
      
      public function get defaultY() : Number
      {
         return this._defaultY;
      }
   }
}

