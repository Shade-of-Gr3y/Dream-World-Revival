package bfp.tpc.pdw.opening
{
   import bfp.common.FontManager;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.FilterShortcuts;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class WelcomeMessage extends Sprite
   {
      
      private var _bm:Bitmap;
      
      public function WelcomeMessage()
      {
         super();
         FilterShortcuts.init();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
      }
      
      private function removedFromStageHandler(param1:Event = null) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.release();
      }
      
      public function init() : void
      {
         var _loc1_:TextField = new TextField();
         var _loc2_:BitmapData = null;
         var _loc3_:Bitmap = null;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         FontManager.setTextID(_loc1_,"op_b_1");
         _loc1_.mouseEnabled = false;
         _loc1_.cacheAsBitmap = true;
         _loc2_ = new BitmapData(_loc1_.width + 40,120,true,0);
         _loc2_.draw(_loc1_);
         _loc3_ = new Bitmap(_loc2_,"auto",true);
         addChild(_loc3_);
         _loc3_.x = -1 * int(_loc1_.width / 2);
         _loc3_.y = -1 * _loc1_.height;
         x = int(1003 / 2);
         y = int(557 / 2);
         this._bm = _loc3_;
         alpha = 0;
         Tweener.addTween(this,{
            "delay":0,
            "time":1.2,
            "alpha":1,
            "transition":"easeOutQuad"
         });
         Tweener.addTween(this,{
            "delay":3.2,
            "time":1.2,
            "alpha":0,
            "transition":"easeInQuad"
         });
         Tweener.addTween(this,{
            "time":0,
            "_Blur_blurX":16,
            "_Blur_blurY":16,
            "_Blur_quality":2
         });
         Tweener.addTween(this,{
            "time":1.2,
            "_Blur_blurX":0,
            "_Blur_blurY":0,
            "transition":"easeNone"
         });
         Tweener.addTween(this,{
            "delay":3.2,
            "time":1.2,
            "_Blur_blurX":16,
            "_Blur_blurY":16,
            "transition":"easeNone"
         });
      }
      
      public function release() : void
      {
         removeChild(this._bm);
         this._bm.bitmapData.dispose();
         this._bm.bitmapData = null;
      }
   }
}

