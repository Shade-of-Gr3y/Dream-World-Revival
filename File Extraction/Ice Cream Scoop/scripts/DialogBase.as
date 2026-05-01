package
{
   import caurina.transitions.*;
   import caurina.transitions.properties.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class DialogBase extends MovieClip
   {
      
      public static const MOTION_ALERT:* = 0;
      
      public static const MOTION_WINDOW:* = 1;
      
      protected var m_bEnable:Boolean;
      
      protected var m_motion:int;
      
      protected var m_okBtn:easyButton;
      
      protected var m_dialogMc:MovieClip;
      
      protected var m_bExit:Boolean;
      
      protected var m_dialogBackMc:MovieClip;
      
      protected var m_bOpen:Boolean;
      
      public function DialogBase(param1:MovieClip, param2:MovieClip, param3:int = 1)
      {
         super();
         this.m_dialogMc = param1;
         this.m_dialogBackMc = param2;
         this.m_motion = param3;
         ColorShortcuts.init();
         FilterShortcuts.init();
         this.m_okBtn = new easyButton(param1.okMc,this._okFunc);
         this._openMotion();
         this.m_bExit = false;
         this.m_bEnable = true;
         this.m_bOpen = false;
      }
      
      public function release() : void
      {
         this.m_okBtn.release();
         this.m_dialogMc.visible = false;
      }
      
      public function isEnable() : Boolean
      {
         return this.m_bEnable;
      }
      
      protected function _closeMotion() : void
      {
         switch(this.m_motion)
         {
            case MOTION_ALERT:
               this._closeMotionAlert(this.m_dialogMc);
               break;
            case MOTION_WINDOW:
               this._closeMotionWindow(this.m_dialogMc);
         }
      }
      
      public function isOpen() : Boolean
      {
         return this.m_bOpen;
      }
      
      protected function _openMotionWindow(param1:*) : void
      {
         var mc:* = param1;
         mc.visible = true;
         Tweener.addTween(mc,{
            "time":0.3,
            "alpha":1,
            "transition":"linear"
         });
         this.m_dialogMc.y += 40;
         Tweener.addTween(mc,{
            "time":0.3,
            "y":this.m_dialogMc.y - 40,
            "transition":"easeOutQuint",
            "onComplete":function():*
            {
               m_bOpen = true;
            }
         });
         if(this.m_dialogBackMc != null)
         {
            this.m_dialogBackMc.scaleX = 0.5;
            this.m_dialogBackMc.scaleY = 0.5;
            this.m_dialogBackMc.alpha = 0;
            Tweener.addTween(this.m_dialogBackMc,{
               "delay":0,
               "time":0.25,
               "transition":"linear",
               "alpha":0.4
            });
            Tweener.addTween(this.m_dialogBackMc,{
               "delay":0,
               "time":0.25,
               "transition":"easeOutSine",
               "scaleX":1,
               "scaleY":1
            });
         }
      }
      
      protected function _openMotionAlert(param1:*) : void
      {
         var disW:*;
         var disH:*;
         var mc:* = param1;
         var _scale:Number = 0.9;
         var _defaultW:* = mc.width;
         var _defaultH:* = mc.height;
         var _defaultX:* = mc.x;
         var _defaultY:* = mc.y;
         mc.alpha = 0;
         mc.scaleX = mc.scaleY = _scale;
         disW = (_defaultW - _defaultW * _scale) / 2;
         disH = (_defaultH - _defaultH * _scale) / 2;
         mc.x = _defaultX + disW;
         mc.y = _defaultY + disH;
         mc.visible = true;
         Tweener.addTween(mc,{
            "delay":0,
            "time":0,
            "transition":"linear",
            "_color_redOffset":255,
            "_color_greenOffset":255,
            "_color_blueOffset":255,
            "_color_alphaMultiplier":0,
            "_Blur_blurX":16,
            "_Blur_blurY":16
         });
         Tweener.addTween(mc,{
            "delay":0,
            "time":0.25,
            "transition":"linear",
            "_color_redOffset":0,
            "_color_greenOffset":0,
            "_color_blueOffset":0,
            "_color_alphaMultiplier":1,
            "_Blur_blurX":0,
            "_Blur_blurY":0
         });
         Tweener.addTween(mc,{
            "delay":0,
            "time":0.25,
            "transition":"easeOutSine",
            "x":_defaultX,
            "y":_defaultY,
            "scaleX":1,
            "scaleY":1,
            "onComplete":function():*
            {
               m_bOpen = true;
            }
         });
         if(this.m_dialogBackMc != null)
         {
            this.m_dialogBackMc.scaleX = 0.5;
            this.m_dialogBackMc.scaleY = 0.5;
            this.m_dialogBackMc.alpha = 0;
            Tweener.addTween(this.m_dialogBackMc,{
               "delay":0,
               "time":0.25,
               "transition":"linear",
               "alpha":0.4
            });
            Tweener.addTween(this.m_dialogBackMc,{
               "delay":0,
               "time":0.25,
               "transition":"easeOutSine",
               "scaleX":1,
               "scaleY":1
            });
         }
      }
      
      protected function _okFunc(param1:MouseEvent) : void
      {
         this.m_bExit = true;
         this._exitDialog();
      }
      
      protected function _exitDialog() : void
      {
         this.m_okBtn.enable(false);
         this._closeMotion();
      }
      
      public function isExit() : Boolean
      {
         return this.m_bExit;
      }
      
      protected function _closeMotionAlert(param1:*) : void
      {
         var mc:* = param1;
         if(this.m_dialogBackMc != null)
         {
            Tweener.removeTweens(this.m_dialogBackMc);
            Tweener.addTween(this.m_dialogBackMc,{
               "delay":0,
               "time":0.2,
               "transition":"linear",
               "alpha":0
            });
            Tweener.addTween(this.m_dialogBackMc,{
               "delay":0,
               "time":0.2,
               "transition":"linear",
               "scaleX":0.5,
               "scaleY":0.51,
               "onComplete":function():*
               {
                  _close();
               }
            });
            Tweener.removeTweens(mc);
            Tweener.addTween(mc,{
               "delay":0,
               "time":0.1,
               "transition":"linear",
               "alpha":0
            });
         }
         else
         {
            Tweener.removeTweens(mc);
            Tweener.addTween(mc,{
               "delay":0,
               "time":0.1,
               "transition":"linear",
               "alpha":0,
               "onComplete":function():*
               {
                  _close();
               }
            });
         }
      }
      
      protected function _closeMotionWindow(param1:*) : void
      {
         var mc:* = param1;
         if(this.m_dialogBackMc != null)
         {
            Tweener.removeTweens(this.m_dialogBackMc);
            Tweener.addTween(this.m_dialogBackMc,{
               "delay":0,
               "time":0.3,
               "transition":"linear",
               "alpha":0
            });
            Tweener.addTween(this.m_dialogBackMc,{
               "delay":0,
               "time":0.25,
               "transition":"easeInQuint",
               "scaleX":0.5,
               "scaleY":0.51
            });
         }
         Tweener.addTween(mc,{
            "time":0.3,
            "alpha":0,
            "transition":"linear"
         });
         Tweener.addTween(mc,{
            "time":0.3,
            "y":this.m_dialogMc.y + 40,
            "transition":"easeInQuint",
            "onComplete":function():*
            {
               m_dialogMc.y -= 40;
               _close();
            }
         });
      }
      
      protected function _close() : void
      {
         this.m_dialogMc.visible = false;
         if(this.m_dialogBackMc != null)
         {
            this.m_dialogBackMc.visible = false;
         }
         this.m_bEnable = false;
      }
      
      protected function _openMotion() : void
      {
         this.m_dialogMc.gotoAndStop(2);
         this.m_dialogMc.visible = true;
         if(this.m_dialogBackMc != null)
         {
            this.m_dialogBackMc.visible = true;
         }
         switch(this.m_motion)
         {
            case MOTION_ALERT:
               this._openMotionAlert(this.m_dialogMc);
               break;
            case MOTION_WINDOW:
               this._openMotionWindow(this.m_dialogMc);
         }
      }
   }
}

