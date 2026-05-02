package bfp.pgl.campaign.animator
{
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ContainerAnimator extends EventDispatcher
   {
      
      public static const PLAY_TYPE_CLOSE:String = "closeAnime";
      
      public static const PLAY_FINISH:String = "onPlayFinish";
      
      private const CLOSE_SCALE:Number = 0.98;
      
      private var _defaultH:Number = 1;
      
      private const SH:Number = 500;
      
      private var _defaultX:Number = 0;
      
      private var _defaultW:Number = 1;
      
      private var _defaultY:Number = 0;
      
      private var _centerX:Number = 0;
      
      private var _centerY:Number = 0;
      
      private const SW:Number = 1003;
      
      private var _target:MovieClip;
      
      private const TARGET_SCALE:Number = 1.2;
      
      public function ContainerAnimator(param1:MovieClip)
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
         this._target.alpha = 1;
         this._target.scaleX = this._target.scaleY = 1;
         this._target.x = this.defaultX;
         this._target.y = this.defaultY;
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
         this.stop();
         this.reset();
         dispatchEvent(new Event(ContainerAnimator.PLAY_FINISH));
      }
      
      public function play(param1:String) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         switch(param1)
         {
            case PLAY_TYPE_CLOSE:
               _loc2_ = this.defaultW * this.CLOSE_SCALE;
               _loc3_ = this.defaultH * this.CLOSE_SCALE;
               _loc4_ = (this.defaultW - _loc2_) / 2;
               _loc5_ = (this.defaultH - _loc3_) / 2;
               _loc6_ = this.defaultX + _loc4_;
               _loc7_ = this.defaultY + _loc5_;
               Tweener.addTween(this._target,{
                  "delay":0,
                  "time":0.2,
                  "transition":"easeInQuad",
                  "x":_loc6_,
                  "y":_loc7_,
                  "scaleX":this.CLOSE_SCALE,
                  "scaleY":this.CLOSE_SCALE
               });
               Tweener.addTween(this._target,{
                  "delay":0,
                  "time":0.2,
                  "transition":"linear",
                  "alpha":0,
                  "onComplete":this.playFinish
               });
         }
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

