package hivelocity.flight.status
{
   import as3.hivelocity.flight.events.flightEvent;
   import bfp.common.FontManager;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class flightTimer extends MovieClip
   {
      
      public static const BASE_FPS:uint = 30;
      
      public static const SECOND:uint = 1000;
       
      
      public var timealert_mc:MovieClip;
      
      public var gameTimerS:TextField;
      
      public var gameTimerM:TextField;
      
      private var _gameTime:int;
      
      private var _moveFlg:Boolean;
      
      private var _moveTimer:Timer;
      
      private var _fps:uint = 30;
      
      private var _timerStart:Number = 0;
      
      private var _timerPause:Number = 0;
      
      private var _alertFlg:Boolean = false;
      
      private var _langCode:String = "";
      
      public function flightTimer()
      {
         super();
         this.__init();
      }
      
      public function set setGameTime(param1:int) : *
      {
         this._gameTime = param1;
         this.setTimerTxt(this._gameTime);
      }
      
      public function set setFps(param1:uint) : void
      {
         this._fps = param1;
      }
      
      public function get getGameTimer() : int
      {
         return this._gameTime;
      }
      
      public function set setLangCode(param1:String) : void
      {
         this._langCode = param1;
         switch(this._langCode)
         {
            case "ja":
               FontManager.lang_code = FontManager.LANG_CODE_JA;
               break;
            case "ko":
               FontManager.lang_code = FontManager.LANG_CODE_KO;
               break;
            case "de":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            case "en":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            case "es":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            case "fr":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            case "it":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               break;
            default:
               FontManager.lang_code = FontManager.LANG_CODE_JA;
         }
         if(this._langCode != "ja")
         {
            this["gameTimerM"].x = this["gameTimerM"].x + 3;
            this["gameTimerS"].x = this["gameTimerS"].x - 3;
         }
      }
      
      public function reset() : void
      {
         this.timerStop();
         this.setTimerText("00","00");
         this._alertFlg = false;
         this.timealert_mc.gotoAndStop(1);
         this.__init();
      }
      
      public function timerStart() : void
      {
         if(this._moveFlg == false)
         {
            this._timerStart = getTimer();
         }
         this._moveFlg = true;
         if(!this._timerPause)
         {
            this._timerPause = 1000;
         }
         else if(this._timerPause < 0)
         {
            this._timerPause = 1;
         }
         this._moveTimer.delay = this._timerPause;
         this._moveTimer.start();
      }
      
      public function timerStop() : void
      {
         if(this._moveFlg)
         {
            if(this._timerStart == 0)
            {
               this._timerStart = getTimer();
            }
            if(this._timerPause == 0)
            {
               this._timerPause = SECOND - (getTimer() - this._timerStart);
            }
            else
            {
               this._timerPause = this._timerPause - (getTimer() - this._timerStart);
               if(this._timerPause < 0)
               {
                  this._timerPause = 0;
               }
            }
         }
         this._moveFlg = false;
         this._moveTimer.reset();
         this._moveTimer.stop();
      }
      
      public function alertReset() : void
      {
         this.timealert_mc.gotoAndStop(1);
      }
      
      private function __init() : void
      {
         this._timerPause = SECOND;
         this._moveTimer = new Timer(SECOND);
         this._moveTimer.addEventListener(TimerEvent.TIMER,this.__gameTimerHandler,false,0,true);
         this._moveTimer.reset();
      }
      
      private function setTimerTxt(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc5_:TextFormat = null;
         var _loc3_:String = "00";
         var _loc4_:String = "00";
         _loc2_ = param1;
         if(_loc2_ >= 60)
         {
            _loc4_ = String(Math.floor(_loc2_ / 60));
            _loc2_ = _loc2_ - int(_loc4_) * 60;
            if(_loc4_.length == 1)
            {
               _loc4_ = "0" + _loc4_;
            }
         }
         _loc3_ = String(_loc2_);
         if(_loc3_.length == 1)
         {
            _loc3_ = "0" + _loc3_;
         }
         this.setTimerText(_loc4_,_loc3_);
         if(param1 <= 30)
         {
            if(!this._alertFlg)
            {
               this._alertFlg = true;
               this.timealert_mc.gotoAndPlay("loop");
            }
            _loc5_ = new TextFormat();
            _loc5_.color = 15269888;
            this["gameTimerM"].setTextFormat(_loc5_);
            this["gameTimerS"].setTextFormat(_loc5_);
         }
      }
      
      private function setTimerText(param1:String, param2:String) : void
      {
         var spaceFormat:TextFormat = null;
         var $m:String = param1;
         var $s:String = param2;
         try
         {
            FontManager.setAutoFontText(this["gameTimerM"],$m,false);
            FontManager.setAutoFontText(this["gameTimerS"],$s,false);
            if(this._langCode != "ja")
            {
               spaceFormat = new TextFormat();
               spaceFormat.letterSpacing = 3;
               this["gameTimerM"].setTextFormat(spaceFormat);
               this["gameTimerS"].setTextFormat(spaceFormat);
            }
            return;
         }
         catch($e:Error)
         {
            return;
         }
      }
      
      private function __gameTimerHandler(param1:TimerEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._moveFlg)
         {
            this._timerStart = getTimer();
            this._timerPause = 0;
            this._gameTime--;
            if(this._gameTime < 0)
            {
               this._gameTime = 0;
               this._moveFlg = false;
               dispatchEvent(new flightEvent(flightEvent.GAME_TIME_UP));
            }
            this.setTimerTxt(this._gameTime);
            _loc2_ = this._fps;
            _loc2_ = BASE_FPS - this._fps;
            _loc3_ = SECOND * _loc2_ / BASE_FPS;
            _loc3_ = Math.ceil(_loc3_ / 100);
            _loc3_ = _loc3_ * 100;
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            _loc4_ = SECOND + _loc3_;
            this._moveTimer.reset();
            this._moveTimer.delay = _loc4_;
            this._moveTimer.start();
         }
      }
   }
}
