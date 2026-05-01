package hivelocity.flight
{
   import as3.hivelocity.flight.events.*;
   import bfp.common.FontManager;
   import caurina.transitions.Tweener;
   import common.gameBridge;
   import flash.display.MovieClip;
   import hivelocity.flight.sound.soundController;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol519")]
   public class flightTitle extends MovieClip
   {
      
      public static const TITLW_START_MOVE:uint = 600;
      
      public var addhowto:MovieClip;
      
      public var addChara:MovieClip;
      
      public var title:MovieClip;
      
      public var btnGameStart_mc:topbtn_toGame;
      
      public var btnHowToPlay_mc:topbtn_toHelp;
      
      private var _howtoplay:howToPlay;
      
      private var _flightChara:flightChara;
      
      private var _titleCloseFlg:Boolean = false;
      
      private var _langCode:String = "";
      
      private var _soundController:soundController;
      
      public function flightTitle()
      {
         super();
         this.__init();
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
         this["title"].gotoAndStop("_" + this._langCode);
         this["btnHowToPlay_mc"].btn.gotoAndStop("_" + this._langCode);
         this["btnHowToPlay_mc"].btn.gotoAndStop("_" + this._langCode);
      }
      
      public function titleOpen() : void
      {
         this.charaFadeInMoveAnime();
         this.titleOpenAnime();
      }
      
      public function titleClose() : void
      {
         this.charaFadeOutMoveAnime();
         this.titleCloseAnime();
      }
      
      public function titleDown() : void
      {
         this.titleDownAnime();
      }
      
      public function gamePause() : void
      {
         this["btnGameStart_mc"].isLocked = false;
         this["btnHowToPlay_mc"].isLocked = false;
      }
      
      public function gameRestart() : void
      {
         if(!this._titleCloseFlg)
         {
            this["btnGameStart_mc"].isLocked = true;
            this["btnHowToPlay_mc"].isLocked = true;
         }
      }
      
      private function __init() : void
      {
         with(this["title"])
         {
            alpha = 0;
            scaleX = 0;
            scaleY = 0;
         }
         with(this["btnGameStart_mc"])
         {
            alpha = 0;
            scaleX = 0;
            scaleY = 0;
            isLocked = false;
            addEventListener(mainBtnEvent.BTN_GAME_START,gameStartHandler,false,0,true);
         }
         with(this["btnHowToPlay_mc"])
         {
            alpha = 0;
            scaleX = 0;
            scaleY = 0;
            isLocked = false;
            addEventListener(mainBtnEvent.BTN_HOWTOPLAY,showGameHowToHandler,false,0,true);
         }
         this._flightChara = new flightChara();
         this["addChara"].addChild(this._flightChara);
         this._soundController = new soundController();
      }
      
      private function titleOpenAnime(param1:Boolean = false) : void
      {
         var _loc2_:Number = 0.5;
         var _loc3_:Number = 0;
         var _loc4_:String = "easeOutBack";
         var _loc5_:Function = this.titleOpenAnime;
         var _loc6_:MovieClip = this["title"];
         if(!param1)
         {
            this["title"].gotoAndStop("_" + this._langCode);
            if(!gameBridge.pauseFlag)
            {
               this._soundController.playSound("openinig");
            }
            Tweener.addTween(_loc6_,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "delay":_loc3_,
               "time":_loc2_,
               "transition":_loc4_,
               "onComplete":_loc5_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.titleBtnOpenAnime();
         }
      }
      
      private function titleBtnOpenAnime(param1:Boolean = false) : void
      {
         var _loc6_:MovieClip = null;
         var _loc2_:Number = 0.5;
         var _loc3_:Number = 0;
         var _loc4_:String = "easeOutQuart";
         var _loc5_:Function = this.titleBtnOpenAnime;
         if(!param1)
         {
            _loc6_ = this["btnHowToPlay_mc"];
            _loc6_.btn.gotoAndStop("_" + this._langCode);
            Tweener.addTween(_loc6_,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "delay":_loc3_,
               "time":_loc2_,
               "transition":_loc4_
            });
            _loc3_ += 0.1;
            _loc6_ = this["btnGameStart_mc"];
            _loc6_.btn.gotoAndStop("_" + this._langCode);
            Tweener.addTween(_loc6_,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "delay":_loc3_,
               "time":_loc2_,
               "transition":_loc4_,
               "onComplete":_loc5_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this["btnGameStart_mc"].isLocked = true;
            this["btnHowToPlay_mc"].isLocked = true;
         }
      }
      
      private function charaFadeInMoveAnime(param1:Boolean = false) : void
      {
         var _loc2_:Number = 1.2;
         var _loc3_:Number = 0;
         var _loc4_:String = "easeOutQuart";
         var _loc5_:Function = this.charaFadeInMoveAnime;
         var _loc6_:MovieClip = this["addChara"];
         if(!param1)
         {
            Tweener.addTween(_loc6_,{
               "x":470,
               "delay":_loc3_,
               "time":_loc2_,
               "transition":_loc4_,
               "onComplete":_loc5_,
               "onCompleteParams":[true]
            });
         }
      }
      
      private function charaFadeOutMoveAnime(param1:Boolean = false) : void
      {
         var _loc2_:Number = 0.8;
         var _loc3_:Number = 0;
         var _loc4_:String = "easeOutQuart";
         var _loc5_:Function = this.charaFadeOutMoveAnime;
         var _loc6_:MovieClip = this["addChara"];
         if(!param1)
         {
            Tweener.addTween(_loc6_,{
               "x":-250,
               "delay":_loc3_,
               "time":_loc2_,
               "transition":_loc4_,
               "onComplete":_loc5_,
               "onCompleteParams":[true]
            });
         }
      }
      
      private function titleCloseAnime(param1:Boolean = false) : void
      {
         var _loc6_:MovieClip = null;
         var _loc2_:Number = 0.5;
         var _loc3_:Number = 0;
         var _loc4_:String = "easeOutQuart";
         var _loc5_:Function = this.titleCloseAnime;
         if(!param1)
         {
            _loc6_ = this["btnGameStart_mc"];
            _loc6_.gotoAndStop("_" + this._langCode);
            Tweener.addTween(_loc6_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "delay":_loc3_,
               "time":_loc2_,
               "transition":_loc4_
            });
            _loc6_ = this["btnHowToPlay_mc"];
            _loc6_.gotoAndStop("_" + this._langCode);
            Tweener.addTween(_loc6_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "delay":_loc3_,
               "time":_loc2_,
               "transition":_loc4_
            });
            _loc6_ = this["title"];
            Tweener.addTween(_loc6_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "delay":_loc3_,
               "time":_loc2_,
               "transition":_loc4_,
               "onComplete":_loc5_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            dispatchEvent(new flightEvent(flightEvent.GAME_TITLE_CLOSE));
         }
      }
      
      private function titleDownAnime(param1:Boolean = false) : void
      {
         var _loc2_:Number = 1.5;
         var _loc3_:Number = 0;
         var _loc4_:String = "easeOutQuart";
         var _loc5_:Function = this.titleDownAnime;
         var _loc6_:MovieClip = this;
         if(!param1)
         {
            Tweener.addTween(_loc6_,{
               "y":_loc6_.y + TITLW_START_MOVE,
               "delay":_loc3_,
               "time":_loc2_,
               "transition":_loc4_,
               "onComplete":_loc5_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            _loc6_.visible = false;
         }
      }
      
      private function __howToPlayOpen() : void
      {
         this._howtoplay = new howToPlay();
         this["addhowto"].addChild(this._howtoplay);
         this._howtoplay.helpOpen();
         this._howtoplay.addEventListener(flightEvent.HOWTO_WIN_CLOSE,this.__howToWinRemove,false,0,true);
      }
      
      private function __howToWinRemove(param1:flightEvent) : void
      {
         this["addhowto"].removeChild(this._howtoplay);
         this._howtoplay.removeEventListener(flightEvent.HOWTO_WIN_CLOSE,this.__howToWinRemove);
         this._howtoplay = null;
         this["btnGameStart_mc"].isLocked = true;
         this["btnHowToPlay_mc"].isLocked = true;
         this._soundController.soundReset();
      }
      
      private function gameStartHandler(param1:mainBtnEvent) : void
      {
         this._titleCloseFlg = true;
         this["btnGameStart_mc"].isLocked = false;
         this["btnHowToPlay_mc"].isLocked = false;
         this["btnGameStart_mc"].removeEventListener(mainBtnEvent.BTN_GAME_START,this.gameStartHandler);
         this["btnHowToPlay_mc"].removeEventListener(mainBtnEvent.BTN_HOWTOPLAY,this.showGameHowToHandler);
         this.titleClose();
         dispatchEvent(new flightEvent(flightEvent.GAME_START_CLICK));
      }
      
      private function showGameHowToHandler(param1:mainBtnEvent) : void
      {
         this["btnGameStart_mc"].isLocked = false;
         this["btnHowToPlay_mc"].isLocked = false;
         this.__howToPlayOpen();
      }
   }
}

