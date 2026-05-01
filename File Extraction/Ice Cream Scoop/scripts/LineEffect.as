package
{
   import bfp.common.*;
   import common.*;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.text.TextField;
   import game.message.FontSetting;
   import game.message.MessageMgr;
   
   public class LineEffect extends MovieClip
   {
      
      private static const phaseNone:* = 0;
      
      private static const phaseIn:* = 1;
      
      private static const phaseMove:* = 2;
      
      private static const phaseOut:* = 3;
      
      private static const phaseRemove:* = 4;
      
      private var m_hunnyPos:Number;
      
      private var m_pos:Number;
      
      private var m_lineMc:MovieClip;
      
      private var m_anmMc:MovieClip;
      
      private var m_nPos:Number;
      
      private var m_se:Sound;
      
      private var m_lineNum:int;
      
      private var m_phase:int;
      
      private var m_hunnyMc:MovieClip;
      
      private var m_back:Number;
      
      private var m_bRemove:Boolean;
      
      private var m_count:int;
      
      public function LineEffect(param1:MovieClip, param2:MovieClip)
      {
         super();
         this.m_hunnyMc = param1;
         this.m_anmMc = param2;
         this.m_nPos = 0;
         this.m_lineMc = new LineMovie();
         x = 500;
         addChild(this.m_lineMc);
         var _loc3_:TextField = this.m_lineMc.clearlineMc.textMc;
         FontSetting.setIDText(_loc3_,MessageMgr.ID_CLEAR_LINE,false);
         addEventListener(Event.ENTER_FRAME,this._enterFrame);
      }
      
      public function clearLineEnable(param1:Boolean) : *
      {
         this.m_lineMc.clearlineMc.visible = param1;
      }
      
      public function release() : void
      {
         parent.removeChild(this);
         removeEventListener(Event.ENTER_FRAME,this._enterFrame);
      }
      
      private function _enterFrame(param1:Event) : void
      {
         switch(this.m_phase)
         {
            case phaseIn:
               this._moveIn();
               break;
            case phaseMove:
               this._move();
               break;
            case phaseOut:
               this._moveOut();
               break;
            case phaseRemove:
               this._remove();
               break;
            case phaseNone:
               if(this.m_bRemove)
               {
                  if(this.m_lineMc.currentLabel == "_pause")
                  {
                     this.m_lineMc.play();
                     this.m_phase = phaseRemove;
                  }
               }
         }
      }
      
      public function startMove(param1:Number, param2:int) : void
      {
         this.m_back = this.m_hunnyMc.y;
         this.m_pos = param1;
         this.m_lineNum = param2;
         this.m_phase = phaseIn;
         this.m_count = 0;
         this.m_nPos = 0;
         this.m_bRemove = false;
         y = this.m_pos;
         this.m_lineMc.gotoAndPlay(2);
         this.m_se = new SeHunny();
         this.m_se.play();
         var _loc3_:TextField = this.m_lineMc.figAnmMc.lineFigMc.textMc;
         FontSetting.setText(_loc3_,this.m_lineNum.toString() + MessageMgr.getInstance().getMessage(MessageMgr.ID_CM),false);
         this.m_anmMc.gotoAndStop(4);
      }
      
      public function remove() : void
      {
         this.m_se = null;
         this.m_bRemove = true;
         this.m_nPos = 0;
      }
      
      public function getPos() : Number
      {
         return this.m_nPos;
      }
      
      private function _remove() : void
      {
         this.m_bRemove = false;
      }
      
      private function _moveIn() : void
      {
         var _loc1_:Number = this.m_pos;
         ++this.m_count;
         this.m_hunnyMc.y = Interpolate.GetF(0,6,this.m_back,this.m_pos,0,this.m_count);
         this.m_nPos = this.m_hunnyMc.y - this.m_back;
         if(this.m_count == 6)
         {
            this.m_phase = phaseMove;
         }
      }
      
      public function getLineNum() : int
      {
         return this.m_lineNum;
      }
      
      private function _moveOut() : void
      {
         var _loc1_:Number = parent.y + this.m_pos;
         ++this.m_count;
         this.m_hunnyMc.y = Interpolate.GetF(0,6,this.m_pos,this.m_back,0,this.m_count);
         this.m_nPos = this.m_hunnyMc.y - this.m_back;
         if(this.m_count == 6)
         {
            this.m_phase = phaseNone;
         }
      }
      
      private function _move() : void
      {
         if(this.m_anmMc.mc.currentLabel == "_loop")
         {
            this.m_count = 0;
            this.m_phase = phaseOut;
         }
      }
   }
}

