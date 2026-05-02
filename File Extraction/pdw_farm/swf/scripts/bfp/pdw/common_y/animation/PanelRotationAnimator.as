package bfp.pdw.common_y.animation
{
   import caurina.transitions.Tweener;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class PanelRotationAnimator extends EventDispatcher
   {
      
      public static const SHOW_FINISH:String = "showFinish";
      
      public static const HIDE_FINISH:String = "hideFinish";
      
      protected var _targetObject:DisplayObject;
      
      protected var _defaultX:Number = 0;
      
      protected var _defaultY:Number = 0;
      
      protected var _scale:Number = 0.9;
      
      protected var _defaultW:Number = 1;
      
      protected var _defaultH:Number = 1;
      
      protected var _bpX:Number = 0;
      
      protected var _bpY:Number = 0;
      
      protected var _bmd:BitmapData;
      
      protected var _bm:Bitmap;
      
      protected var _display:Sprite;
      
      protected var _viewPort:Sprite;
      
      public function PanelRotationAnimator(param1:DisplayObject, param2:Number = 0, param3:Number = 0)
      {
         super();
         this._targetObject = DisplayObject(param1);
         this._defaultW = param2;
         this._defaultH = param3;
         this.init();
      }
      
      protected function init() : *
      {
         this._display = new Sprite();
         this._viewPort = new Sprite();
         this._targetObject.visible = false;
         this._defaultX = this._targetObject.x;
         this._defaultY = this._targetObject.y;
      }
      
      public function reset() : *
      {
         this.removePanel();
      }
      
      public function stop() : *
      {
         Tweener.removeTweens(this._display);
      }
      
      public function release() : *
      {
         this.removePanel();
         this._display = null;
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
      
      public function get display() : Sprite
      {
         return this._display;
      }
      
      public function set display(param1:Sprite) : *
      {
         this._display = param1;
      }
      
      public function get bpX() : Number
      {
         if(this._targetObject.root)
         {
            this._bpX = this._targetObject.root.transform.perspectiveProjection.projectionCenter.x;
            return this._bpX;
         }
         return this._bpX;
      }
      
      public function get bpY() : Number
      {
         if(this._targetObject.root)
         {
            this._bpY = this._targetObject.root.transform.perspectiveProjection.projectionCenter.y;
            return this._bpY;
         }
         return this._bpY;
      }
      
      public function get centerX() : Number
      {
         return Math.floor(this._defaultX + this._defaultW / 2);
      }
      
      public function get centerY() : Number
      {
         return Math.floor(this._defaultY + this._defaultH / 2);
      }
      
      public function show() : *
      {
         this.removePanel();
         this.createPanel();
         this.resetPanel();
         this.showAnime();
      }
      
      private function showAnime() : *
      {
         Tweener.removeTweens(this._display);
         Tweener.addTween(this._display,{
            "time":0.5,
            "alpha":1,
            "transition":"easeNone"
         });
         Tweener.addTween(this._display,{
            "time":0.5,
            "y":this._defaultY,
            "transition":"easeOutQuint"
         });
         Tweener.addTween(this._display,{
            "time":0.8,
            "z":0,
            "rotationX":0,
            "transition":"easeOutBack",
            "onComplete":this.showFinish
         });
      }
      
      protected function showFinish() : *
      {
         dispatchEvent(new Event(PanelRotationAnimator.SHOW_FINISH));
      }
      
      public function hide() : *
      {
         this._display.visible = true;
         Tweener.removeTweens(this._display);
         Tweener.addTween(this._display,{
            "time":0.2,
            "alpha":0,
            "transition":"easeNone"
         });
         Tweener.addTween(this._display,{
            "time":0.3,
            "rotationX":30,
            "transition":"easeNone"
         });
         Tweener.addTween(this._display,{
            "time":0.3,
            "z":50,
            "transition":"easeOutExpo",
            "onComplete":this.hideFinish
         });
      }
      
      protected function hideFinish() : *
      {
         dispatchEvent(new Event(PanelRotationAnimator.HIDE_FINISH));
      }
      
      private function createPanel() : *
      {
         if(this._bmd != null)
         {
            this._bmd.dispose();
            this._bmd = null;
         }
         this._bmd = new BitmapData(this.defaultW,this.defaultH,true,0);
         this._bmd.draw(this._targetObject,null,null,null,null,true);
         this._bm = new Bitmap(this._bmd,"auto",true);
         this._display.addChild(this._bm);
      }
      
      private function removePanel() : *
      {
         if(this._bmd != null)
         {
            this._bmd.dispose();
            this._bmd = null;
         }
         if(this._bm != null)
         {
            if(this._display.contains(this._bm))
            {
               this._display.removeChild(this._bm);
            }
         }
         this._bm = null;
      }
      
      private function resetPanel() : *
      {
         this._display.visible = true;
         this._display.alpha = 0;
         this._display.x = this._defaultX;
         this._display.y = this._defaultY - 100;
         this._display.z = 50;
         this._display.rotationX = -60;
      }
   }
}

