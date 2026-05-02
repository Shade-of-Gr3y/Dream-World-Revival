package bfp.tpc.pdw.common
{
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class Emotion extends MovieClip
   {
      
      private var _isShow:Boolean;
      
      public var defX:Number;
      
      public var defY:Number;
      
      private var _cnt:int;
      
      public function Emotion()
      {
         super();
         this._isShow = false;
         this.defX = 0;
         this.defY = 0;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(event:Event) : void
      {
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.release();
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function init() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.visible = true;
         this.visit();
      }
      
      public function release() : void
      {
         this.visible = false;
         Tweener.removeTweens(this);
         this._isShow = false;
         removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function remove() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function enterFrameHandler(event:Event) : void
      {
         ++this._cnt;
         if(this._cnt > 8)
         {
            this._cnt = 0;
            if(this.currentFrame == 1)
            {
               this.gotoAndStop(2);
            }
            else
            {
               this.gotoAndStop(1);
            }
         }
      }
      
      public function visit() : void
      {
         if(this._isShow)
         {
            return;
         }
         Tweener.removeTweens(this);
         removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._cnt = 0;
         this.gotoAndStop(1);
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._isShow = true;
         this.x = this.defX;
         this.y = this.defY;
         Tweener.addTween(this,{
            "time":0.1,
            "y":this.defY - 16,
            "transition":"easeOutQuad"
         });
         Tweener.addTween(this,{
            "delay":0.1,
            "time":0.2,
            "y":this.defY,
            "transition":"easeInQuad"
         });
         Tweener.addTween(this,{
            "time":1.1,
            "onComplete":function():void
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
               else
               {
                  release();
               }
            }
         });
      }
   }
}

