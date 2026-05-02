package hivelocity.flight.popup
{
   import as3.hivelocity.flight.events.flightEvent;
   import bfp.common.FontManager;
   import caurina.transitions.Tweener;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import hivelocity.flight.sound.soundController;
   
   public class scoreBoard extends MovieClip
   {
      
      static const BONUS_BASE_TIME:int = 120;
      
      static const BTN_DEFAULT:String = "_default";
      
      static const BTN_OVER:String = "_over";
      
      static const BTN_DOWN:String = "_down";
      
      static const BTN_OFF:String = "_off";
      
      static const BTN_UP:String = "_up";
       
      
      public var btnFinish_mc:MovieClip;
      
      public var gameComboBonus:MovieClip;
      
      public var gameTotalScore_mc:MovieClip;
      
      public var gameScore:MovieClip;
      
      public var gameTimeBonus:MovieClip;
      
      public var flightTime_mc:MovieClip;
      
      private var _goalTime:int;
      
      private var _goalScore:int;
      
      private var _flightBonus:int;
      
      private var _gameTotalScore:int;
      
      private var _boardSetPosition:int;
      
      private var _comboNum:int;
      
      private var _flightComboBonus:int;
      
      private var _langCode:String = "";
      
      private var _soundController:soundController;
      
      public function scoreBoard()
      {
         super();
         this._boardSetPosition = this.y;
         this.__init();
      }
      
      public function set setGoalTime(param1:int) : void
      {
         this._goalTime = param1;
      }
      
      public function set setGoalScore(param1:int) : void
      {
         this._goalScore = param1;
         FontManager.setAutoFontText(this["gameScore"]["gameScore"],String(this._goalScore),true);
      }
      
      public function set setComboNum(param1:int) : void
      {
         this._comboNum = param1;
         this.flightComboBonusCalc();
      }
      
      public function get getTotalScore() : int
      {
         return this._gameTotalScore;
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
      }
      
      public function scoreBoardWinOpen() : void
      {
         this.flightTimeCalc();
         this.flightBonusCalc();
         this.totalScoreCalc();
         this.winOpen();
      }
      
      public function reset() : void
      {
         this.__init();
      }
      
      private function __init() : void
      {
         this.visible = false;
         this.alpha = 0;
         this.scaleX = this.scaleY = 0;
         this["flightTime_mc"].alpha = 0;
         this["gameScore"].alpha = 0;
         this["gameTimeBonus"].alpha = 0;
         this["gameComboBonus"].alpha = 0;
         this["gameTotalScore_mc"].alpha = 0;
         this["btnFinish_mc"].alpha = 0;
         this._soundController = new soundController();
      }
      
      private function flightTimeCalc() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = "00";
         var _loc3_:String = "00";
         _loc1_ = BONUS_BASE_TIME - this._goalTime;
         if(_loc1_ > 60)
         {
            _loc3_ = String(Math.floor(_loc1_ / 60));
            _loc1_ = _loc1_ - int(_loc3_) * 60;
            if(_loc3_.length == 1)
            {
               _loc3_ = "0" + _loc3_;
            }
         }
         _loc2_ = String(_loc1_);
         if(_loc2_.length == 1)
         {
            _loc2_ = "0" + _loc2_;
         }
         FontManager.setAutoFontText(this["flightTime_mc"]["scoreTimeM"],String(_loc3_),true);
         FontManager.setAutoFontText(this["flightTime_mc"]["scoreTimeS"],String(_loc2_),true);
      }
      
      private function flightBonusCalc() : void
      {
         this._flightBonus = 0;
         if(this._goalTime < BONUS_BASE_TIME)
         {
            this._flightBonus = this._goalTime * 200;
         }
         FontManager.setAutoFontText(this["gameTimeBonus"]["gameTimeBonus"],String(this._flightBonus),true);
      }
      
      private function flightComboBonusCalc() : void
      {
         this._flightComboBonus = 0;
         this._flightComboBonus = this._comboNum * 200;
         FontManager.setAutoFontText(this["gameComboBonus"]["gameComboBonus"],String(this._flightComboBonus),true);
      }
      
      private function totalScoreCalc() : void
      {
         this._gameTotalScore = this._flightBonus + this._goalScore + this._flightComboBonus;
         FontManager.setAutoFontText(this["gameTotalScore_mc"]["gameTotalScore"],String(this._gameTotalScore),true);
      }
      
      private function winOpen(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.3;
         var _loc3_:String = "easeOutBack";
         var _loc4_:Function = this.winOpen;
         if(!param1)
         {
            this._soundController.playSound("popupOpen");
            _loc5_ = this;
            _loc5_.visible = true;
            _loc5_.y = _loc5_.y + (_loc5_.height + 100);
            _loc5_.alpha = 0;
            this.scaleX = this.scaleY = 1;
            Tweener.addTween(_loc5_,{
               "time":_loc2_,
               "alpha":1,
               "transition":"linear"
            });
            Tweener.addTween(_loc5_,{
               "time":_loc2_,
               "y":this._boardSetPosition,
               "transition":"easeOutQuint",
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.scoreAnime();
         }
      }
      
      private function winClose(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.3;
         var _loc3_:String = "easeOutQuad";
         var _loc4_:Function = this.winClose;
         _loc5_ = this;
         if(!param1)
         {
            this._soundController.playSound("popupClose");
            Tweener.addTween(_loc5_,{
               "time":0.3,
               "alpha":0,
               "transition":"linear"
            });
            Tweener.addTween(_loc5_,{
               "time":0.3,
               "y":_loc5_.y + 40,
               "transition":"easeInQuint",
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this._soundController.soundReset();
            _loc5_.scaleX = _loc5_.scaleY = 0;
            _loc5_.visible = false;
            dispatchEvent(new flightEvent(flightEvent.GAME_RETRY));
         }
      }
      
      private function scoreAnime(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.3;
         var _loc3_:String = "easeOutBack";
         var _loc4_:Function = this.scoreAnime;
         var _loc6_:int = 50;
         if(!param1)
         {
            _loc5_ = this["flightTime_mc"];
            _loc5_.y = _loc5_.y + _loc6_;
            _loc5_.alpha = 0;
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "y":_loc5_.y - _loc6_,
               "time":_loc2_,
               "delay":0,
               "transition":_loc3_
            });
            _loc5_ = this["gameComboBonus"];
            _loc5_.y = _loc5_.y + _loc6_;
            _loc5_.alpha = 0;
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "y":_loc5_.y - _loc6_,
               "time":_loc2_,
               "delay":0,
               "transition":_loc3_
            });
            _loc5_ = this["gameScore"];
            _loc5_.y = _loc5_.y + _loc6_;
            _loc5_.alpha = 0;
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "y":_loc5_.y - _loc6_,
               "time":_loc2_,
               "delay":0.05,
               "transition":_loc3_
            });
            _loc5_ = this["gameTimeBonus"];
            _loc5_.y = _loc5_.y + _loc6_;
            _loc5_.alpha = 0;
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "y":_loc5_.y - _loc6_,
               "time":_loc2_,
               "delay":0.1,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.totalScoreAnime();
         }
      }
      
      private function totalScoreAnime(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.3;
         var _loc3_:String = "easeOutBack";
         var _loc4_:Function = this.totalScoreAnime;
         var _loc6_:int = 50;
         if(!param1)
         {
            this._soundController.playSound("result");
            _loc5_ = this["gameTotalScore_mc"];
            _loc5_.y = _loc5_.y + _loc6_;
            _loc5_.alpha = 0;
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "y":_loc5_.y - _loc6_,
               "time":_loc2_,
               "delay":0.2,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.btnFinishAnime();
         }
      }
      
      private function btnFinishAnime(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.3;
         var _loc3_:String = "easeOutBack";
         var _loc4_:Function = this.btnFinishAnime;
         var _loc6_:int = 50;
         _loc5_ = this["btnFinish_mc"];
         if(!param1)
         {
            _loc5_.y = _loc5_.y + _loc6_;
            _loc5_.alpha = 0;
            Tweener.addTween(_loc5_,{
               "alpha":1,
               "y":_loc5_.y - _loc6_,
               "time":_loc2_,
               "delay":0.1,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            _loc5_.mouseChildren = false;
            _loc5_.buttonMode = true;
            _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,this.__mouseDown,false,0,true);
            _loc5_.addEventListener(MouseEvent.ROLL_OVER,this.__mouseOver,false,0,true);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,this.__mouseDefault,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_UP,this.__gameFinish,false,0,true);
         }
      }
      
      private function __mouseDown(param1:MouseEvent = null) : void
      {
         this._soundController.playSound("btnPush");
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(BTN_DOWN);
      }
      
      private function __mouseOver(param1:MouseEvent = null) : void
      {
         this._soundController.playSound("btnOn");
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(BTN_OVER);
      }
      
      private function __mouseDefault(param1:MouseEvent = null) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(BTN_DEFAULT);
      }
      
      private function __gameFinish(param1:MouseEvent = null) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.gotoAndStop(BTN_DEFAULT);
         this["btnFinish_mc"].removeEventListener(MouseEvent.MOUSE_DOWN,this.__mouseDown);
         this["btnFinish_mc"].removeEventListener(MouseEvent.MOUSE_OVER,this.__mouseOver);
         this["btnFinish_mc"].removeEventListener(MouseEvent.MOUSE_UP,this.__gameFinish);
         dispatchEvent(new flightEvent(flightEvent.GAME_FINISH));
      }
   }
}
