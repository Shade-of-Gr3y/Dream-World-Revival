package bfp.tpc.pdw.dialog
{
   import caurina.transitions.Tweener;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class Alert extends Sprite implements IDialog
   {
       
      
      private var _bmp:Bitmap;
      
      public var type:String = "alert";
      
      public function Alert()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
      }
      
      public function init() : void
      {
         var bmd:BitmapData;
         var dy:int;
         var dialog:Alert = null;
         stage.addEventListener(Event.RESIZE,this.resizeHandler);
         this.resizeHandler();
         this.visible = false;
         bmd = new BitmapData(this.width,this.height,true,0);
         bmd.draw(this);
         this._bmp = new Bitmap(bmd,"never",false);
         this.parent.addChild(this._bmp);
         dialog = this;
         dy = int((528 - this._bmp.height) * 0.5);
         this._bmp.x = int((1003 - this._bmp.width) * 0.5);
         this._bmp.alpha = 0;
         this._bmp.y = int((528 - this._bmp.height) * 0.5) - 100;
         this._bmp.z = 50;
         this._bmp.rotationX = -60;
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
            "onComplete":function():void
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
               dialog.visible = true;
               dialog.x = int((1003 - dialog.width) * 0.5);
               dialog.y = int((528 - dialog.height) * 0.5);
               visit();
            }
         });
      }
      
      public function release() : void
      {
         stage.removeEventListener(Event.RESIZE,this.resizeHandler);
      }
      
      public function visit() : void
      {
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
            "onComplete":function():void
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
            }
         });
      }
      
      public function resizeHandler(param1:Event = null) : void
      {
         if(stage)
         {
            this.x = int((1003 - this.width) * 0.5);
            this.y = int((528 - this.height) * 0.5);
            if(this.root)
            {
               this.root.transform.perspectiveProjection.projectionCenter = new Point(int(1003 / 2),int(528 / 2));
            }
         }
      }
   }
}
