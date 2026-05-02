package bfp.tpc.pdw.opening
{
   import bfp.*;
   import bfp.common.*;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.setTimeout;
   
   public class Opening extends MovieClip
   {
      
      public var rating:MovieClip;
      
      public var terms:MovieClip;
      
      private var _btn:AssetSkipBtn;
      
      public function Opening()
      {
         super();
         stop();
         tabEnabled = false;
         tabChildren = false;
         addFrameScript(1,function():void
         {
            stop();
            ColorShortcuts.init();
            Tweener.addTween(getChildByName("rating"),{
               "delay":4,
               "time":1.5,
               "_brightness":2.56,
               "transition":"easeOutQuad",
               "onComplete":function():void
               {
                  nextFrame();
               }
            });
         });
         addFrameScript(2,function():void
         {
            var terms:MovieClip = null;
            stop();
            ColorShortcuts.init();
            terms = MovieClip(getChildByName("terms"));
            terms.gotoAndStop(FontManager.lang_code == FontManager.LANG_CODE_JA ? 1 : 2);
            terms.button.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
            {
               var event:MouseEvent = param1;
               terms.button.mouseEnabled = false;
               PDWBridge.sfxClick();
               Tweener.addTween(terms,{
                  "time":1,
                  "_brightness":2.56,
                  "transition":"easeOutQuad",
                  "onComplete":function():void
                  {
                     nextFrame();
                  }
               });
            });
            terms.button.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):void
            {
               PDWBridge.sfxMouseOver();
            });
         });
         addFrameScript(3,function():void
         {
            addEventListener(Event.ENTER_FRAME,enterFrameHandler);
            _btn = new AssetSkipBtn();
            _btn.x = 844;
            _btn.y = 463;
            _btn.addEventListener(MouseEvent.CLICK,clickHandler);
            addChild(_btn);
            try
            {
               FontManager.setTextID(_btn.tf,"op_b_2");
            }
            catch(e:*)
            {
            }
         });
         addFrameScript(7,function():void
         {
            addChild(new WelcomeMessage());
         });
         addFrameScript(totalFrames - 1,function():void
         {
            stop();
            PDWBridge.changeScene(PDWBridge.SCENE_HOME);
         });
         if(stage)
         {
            setTimeout(this.addedToStageHandler,100);
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         }
      }
      
      private function addedToStageHandler(param1:Event = null) : void
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
         switch(FontManager.lang_code)
         {
            case FontManager.LANG_CODE_KO:
               gotoAndPlay(2);
               break;
            case FontManager.LANG_CODE_JA:
               gotoAndPlay(3);
               break;
            default:
               gotoAndPlay(4);
         }
      }
      
      public function release() : void
      {
         if(this._btn)
         {
            removeChild(this._btn);
            this._btn.removeEventListener(MouseEvent.CLICK,this.clickHandler);
            this._btn = null;
         }
         removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         PDWBridge.sfxClick();
         gotoAndPlay(totalFrames - 1);
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         if(Boolean(this._btn) && contains(this._btn))
         {
            setChildIndex(this._btn,numChildren - 1);
         }
      }
   }
}

import bfp.PDWBridge;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class AssetSkipBtn extends Sprite
{
   
   public var tf:TextField;
   
   public function AssetSkipBtn()
   {
      super();
      this.redraw();
      this.tf = new TextField();
      this.tf.mouseEnabled = false;
      addChild(this.tf);
      this.tf.selectable = false;
      this.tf.y = 1;
      this.tf.width = 140;
      this.tf.height = 24;
      var _loc1_:TextFormat = new TextFormat();
      _loc1_.align = TextFormatAlign.CENTER;
      _loc1_.color = 16777215;
      _loc1_.size = 12;
      this.tf.defaultTextFormat = _loc1_;
      this.tf.setTextFormat(_loc1_);
      buttonMode = true;
      addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
      addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
   }
   
   public function mouseOverHandler(param1:MouseEvent) : void
   {
      PDWBridge.sfxMouseOver();
      this.redraw(PDWBridge.ROLLOVER_COLOR);
   }
   
   public function mouseOutHandler(param1:MouseEvent) : void
   {
      this.redraw();
   }
   
   private function redraw(param1:int = 7094570) : void
   {
      graphics.clear();
      graphics.beginFill(param1);
      graphics.drawRoundRect(0,0,140,24,5);
   }
}
