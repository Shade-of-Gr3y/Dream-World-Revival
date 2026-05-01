package
{
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import fl.transitions.easing.*;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ScreenScroll extends MovieClip
   {
      
      private var m_auto:MovieClip;
      
      private var m_bUpClick:Boolean;
      
      private var m_screenHeight:Number;
      
      private var m_screenAccel:Number;
      
      private var m_bEnable:Boolean;
      
      private var m_bDownOver:Boolean;
      
      private var m_ChangeFunc:Function;
      
      private var m_bDownClick:Boolean;
      
      private var m_tween:Tween;
      
      private var m_screen:MovieClip;
      
      private var m_arrow_up:MovieClip;
      
      private var m_arrow_down:MovieClip;
      
      private var m_screenPos:Number;
      
      private var m_bScroll:Boolean;
      
      private var m_bUpOver:Boolean;
      
      public function ScreenScroll(param1:MovieClip, param2:Function)
      {
         super();
         addEventListener(Event.ENTER_FRAME,this._enterFrame);
         this.m_screen = param1.scr;
         this.m_screenHeight = this.m_screen.y;
         this.m_screenPos = this.m_screen.y;
         this.m_ChangeFunc = param2;
         this.m_bEnable = false;
         this.m_bScroll = false;
         this.m_screenAccel = 0;
      }
      
      public function enable(param1:Boolean) : void
      {
      }
      
      public function release() : void
      {
         removeEventListener(Event.ENTER_FRAME,this._enterFrame);
      }
      
      private function _mouseClickOffUp(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this.m_bUpClick = false;
      }
      
      private function _scrollStop() : void
      {
         if(this.m_tween != null)
         {
            this.m_tween.stop();
            this.m_tween.removeEventListener(TweenEvent.MOTION_FINISH,this._endScroll);
            this.m_tween.removeEventListener(TweenEvent.MOTION_CHANGE,this.m_ChangeFunc);
            this.m_tween = null;
         }
      }
      
      private function _mouseClickOffDown(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this.m_bDownClick = false;
      }
      
      private function _endScroll(param1:TweenEvent) : void
      {
         this._scrollStop();
      }
      
      private function _mouseOutUp(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this.m_bUpOver = false;
      }
      
      public function isScroll() : Boolean
      {
         return this.m_tween != null;
      }
      
      private function _mouseClickAuto(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this.m_bScroll = false;
         this.m_auto.gotoAndStop(1);
         this.m_screenAccel = 0;
         this.Scroll(this.m_screenPos);
      }
      
      private function _enterFrame(param1:Event) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         if(this.m_bUpClick)
         {
            this.m_screenAccel = Math.min(20,this.m_screenAccel + 0.2);
         }
         else if(this.m_bDownClick)
         {
            this.m_screenAccel = Math.max(-20,this.m_screenAccel - 0.2);
         }
         else if(this.m_screenAccel != 0)
         {
            this.m_screenAccel -= this.m_screenAccel / 10;
            if(Math.abs(this.m_screenAccel) < 0.01)
            {
               this.m_screenAccel = 0;
            }
         }
         this.m_screen.y += this.m_screenAccel;
         this.m_ChangeFunc(null);
         if(this.m_screen.y >= this.m_screenPos)
         {
            this.m_screen.y = this.m_screenPos;
            this.m_bScroll = false;
            this.m_auto.gotoAndStop(1);
            this.m_screenAccel = 0;
            this.m_bUpClick = false;
         }
         else if(this.m_screen.y <= this.m_screenHeight)
         {
            this.m_screen.y = this.m_screenHeight;
            this.m_screenAccel = 0;
            this.m_bDownClick = false;
         }
      }
      
      private function _mouseOverUp(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         if(this.m_bUpOver == false)
         {
            this.m_bUpOver = true;
         }
         this._mouseOutDown(param1);
      }
      
      private function _mouseOutAuto(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         if(this.m_bScroll == true)
         {
            this.m_auto.gotoAndStop(3);
         }
         else
         {
            this.m_auto.gotoAndStop(1);
         }
      }
      
      private function _mouseClickUp(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this._scrollStop();
         this.m_bUpClick = true;
         this.m_bScroll = true;
         this.m_auto.gotoAndStop(3);
      }
      
      private function _mouseOutDown(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         if(this.m_bDownOver == true)
         {
            this.m_arrow_down.gotoAndStop(1);
         }
         this.m_bDownOver = false;
      }
      
      private function _mouseOverAuto(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         if(this.m_bScroll == true)
         {
            this.m_auto.gotoAndStop(4);
         }
         else
         {
            this.m_auto.gotoAndStop(2);
         }
      }
      
      private function _mouseOverDown(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         if(this.m_bDownOver == false)
         {
            this.m_arrow_down.gotoAndStop(2);
            this.m_bDownOver = true;
         }
         this._mouseOutUp(param1);
      }
      
      public function Scroll(param1:Number, param2:int = 48, param3:int = 0) : void
      {
         if(param1 > 0)
         {
            param1 = 0;
         }
         if(this.m_bScroll == false)
         {
            this._scrollStop();
            if(param1 != this.m_screen.y && param2 >= 1)
            {
               if(param3 == 0)
               {
                  this.m_tween = new Tween(this.m_screen,"y",Strong.easeOut,this.m_screen.y,param1,param2,false);
               }
               else
               {
                  this.m_tween = new Tween(this.m_screen,"y",None.easeOut,this.m_screen.y,param1,param2,false);
               }
               this.m_tween.addEventListener(TweenEvent.MOTION_FINISH,this._endScroll);
               this.m_tween.addEventListener(TweenEvent.MOTION_CHANGE,this.m_ChangeFunc);
            }
         }
         this.m_screenPos = param1;
      }
      
      private function _mouseClickDown(param1:MouseEvent) : void
      {
         if(this.m_bEnable == false)
         {
            return;
         }
         this._scrollStop();
         this.m_bDownClick = true;
         this.m_bScroll = true;
         this.m_auto.gotoAndStop(3);
      }
   }
}

