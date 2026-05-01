package bfp.tpc.pdw.loading
{
   import caurina.transitions.Tweener;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class PDWAlert extends Sprite
   {
      
      private var _bmp:Bitmap;
      
      public function PDWAlert()
      {
         super();
         this.blendMode = BlendMode.LAYER;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
         var bmd:BitmapData;
         var dy:int;
         var alert:PDWAlert = null;
         stage.addEventListener(Event.RESIZE,this.resizeHandler);
         this.resizeHandler();
         this.visible = false;
         Tweener.removeTweens(this._bmp);
         if(this._bmp)
         {
            if(this._bmp.parent)
            {
               this._bmp.parent.removeChild(this._bmp);
            }
            this._bmp.bitmapData.dispose();
            this._bmp = null;
         }
         bmd = new BitmapData(this.width,this.height,true,0);
         bmd.draw(this);
         this._bmp = new Bitmap(bmd,PixelSnapping.NEVER,false);
         this.parent.addChild(this._bmp);
         alert = this;
         dy = int((557 - this._bmp.height) * 0.5);
         this._bmp.x = int((1003 - this._bmp.width) * 0.5);
         this._bmp.alpha = 0;
         this._bmp.y = int((557 - this._bmp.height) * 0.5) - 100;
         this._bmp.z = 50;
         this._bmp.rotationX = -90;
         Tweener.addTween(this._bmp,{
            "time":0.5,
            "alpha":1,
            "transition":"easeNone"
         });
         Tweener.addTween(this._bmp,{
            "time":0.5,
            "y":dy,
            "transition":"easeOutQuint"
         });
         Tweener.addTween(this._bmp,{
            "time":0.8,
            "z":0,
            "rotationX":0,
            "transition":"easeOutBack",
            "onComplete":function():*
            {
               if(_bmp)
               {
                  if(_bmp.parent)
                  {
                     _bmp.parent.removeChild(_bmp);
                  }
                  _bmp.bitmapData.dispose();
                  _bmp = null;
               }
               alert.visible = true;
               alert.x = int((1003 - alert.width) * 0.5);
               alert.y = int((557 - alert.height) * 0.5);
               visit();
            }
         });
      }
      
      public function away() : void
      {
         if(this._bmp)
         {
            if(this._bmp.parent)
            {
               this._bmp.parent.removeChild(this._bmp);
            }
            this._bmp.bitmapData.dispose();
            this._bmp = null;
         }
         Tweener.removeTweens(this);
         this.visible = true;
         Tweener.addTween(this,{
            "time":0.2,
            "alpha":0,
            "transition":"easeNone"
         });
         Tweener.addTween(this,{
            "time":0.3,
            "rotationX":30,
            "transition":"easeNone"
         });
         Tweener.addTween(this,{
            "time":0.3,
            "z":50,
            "transition":"easeOutExpo",
            "onComplete":function():*
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
            }
         });
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      public function resizeHandler(param1:Event = null) : void
      {
         if(stage)
         {
            this.x = int((1003 - this.width) * 0.5);
            this.y = int((557 - this.height) * 0.5);
            if(this.root)
            {
               this.root.transform.perspectiveProjection.projectionCenter = new Point(int(1003 / 2),int(557 / 2));
            }
         }
      }
      
      public function visit() : void
      {
      }
      
      public function release() : void
      {
         stage.removeEventListener(Event.RESIZE,this.resizeHandler);
      }
   }
}

