package bfp.tpc.pdw.common
{
   import bfp.common.FontManager;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class EmotionWord extends MovieClip
   {
      
      public var bg_l:MovieClip;
      
      public var tuno:MovieClip;
      
      public var bg_r:MovieClip;
      
      public var bg_box:MovieClip;
      
      private var _isShow:Boolean;
      
      public var defX:Number;
      
      public var defY:Number;
      
      private var _cnt:int;
      
      public var tf:TextField;
      
      public function EmotionWord()
      {
         super();
         this._isShow = false;
         this.defX = 0;
         this.defY = 0;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      public function setText(labelId:String) : void
      {
         FontManager.setTextID(this.tf,labelId);
         this.tf.autoSize = TextFieldAutoSize.LEFT;
         this.bg_box.width = Math.floor(this.tf.width + 2);
         this.bg_r.x = this.bg_box.x + this.bg_box.width;
         this.bg_l.height = this.bg_box.height = this.bg_r.height = Math.floor(this.tf.height + 16);
         this.tuno.x = Math.floor(this.bg_box.x + this.bg_box.width / 2 - 3);
         this.tuno.y = Math.floor(this.bg_box.height - 1);
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
      }
      
      public function remove() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function visit() : void
      {
         if(this._isShow)
         {
            return;
         }
         Tweener.removeTweens(this);
         this._cnt = 0;
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
      }
   }
}

