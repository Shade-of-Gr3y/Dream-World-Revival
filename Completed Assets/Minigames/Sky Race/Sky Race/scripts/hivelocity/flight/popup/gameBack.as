package hivelocity.flight.popup
{
   import as3.hivelocity.flight.events.flightEvent;
   import bfp.common.FontManager;
   import caurina.transitions.Tweener;
   import caurina.transitions.properties.ColorShortcuts;
   import caurina.transitions.properties.FilterShortcuts;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import hivelocity.flight.sound.soundController;
   
   public class gameBack extends MovieClip
   {
      
      static const BTN_DEFAULT:String = "_default";
      
      static const BTN_OVER:String = "_over";
      
      static const BTN_DOWN:String = "_down";
      
      static const BTN_OFF:String = "_off";
      
      static const BTN_UP:String = "_up";
       
      
      public var gameBackMask_mc:MovieClip;
      
      public var gameBackWin_mc:MovieClip;
      
      private var _initAlpha:Number;
      
      private var _btnArray:Array;
      
      private var _encountPokemon:String;
      
      private var _msgTop:String;
      
      private var _msg:String;
      
      private var _langCode:String = "";
      
      private var _soundController:soundController;
      
      public function gameBack()
      {
         super();
         ColorShortcuts.init();
         FilterShortcuts.init();
         this._initAlpha = this.alpha;
         this.__init();
      }
      
      public function set setEncountPokemon(param1:String) : void
      {
         this._encountPokemon = param1;
         switch(this._langCode)
         {
            case "ja":
               FontManager.lang_code = FontManager.LANG_CODE_JA;
               this._msgTop = "このゲームをしゅうりょうしますか？";
               this._msg = "しゅうりょうしたばあい、\n" + this._encountPokemon + "と\nなかよくなることはできません。";
               break;
            case "ko":
               FontManager.lang_code = FontManager.LANG_CODE_KO;
               this._msgTop = "이 게임을 종료하겠습니까?";
               this._msg = "종료하면\n" + this._encountPokemon + "와(과) 사이가 좋아질 수없습니다.";
               break;
            case "de":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._msgTop = "Möchtest du das Spiel beenden?";
               this._msg = "Beendest du das Spiel jetzt,\n" + "kannst du dich nicht mit\n" + this._encountPokemon + "anfreunden.";
               break;
            case "en":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._msgTop = "Want to quit this game?";
               this._msg = "If you quit, you can\'t befriend\n" + this._encountPokemon + ".";
               break;
            case "es":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._msgTop = "¿Quieres salir del juego?";
               this._msg = "Ten presente que si sales de este juego,\n" + "no podrás hacerte amigo de\n" + this._encountPokemon + ".";
               break;
            case "fr":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._msgTop = "Voulez-vous quitter ?";
               this._msg = "Si vous quittez maintenant,\n" + "vous perdrez l\'occasion d\'être apprécié par le\n" + this._encountPokemon + ".";
               break;
            case "it":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._msgTop = "Vuoi interrompere il minigioco?";
               this._msg = "Se interrompi ora, non potrai\n" + "fare amicizia con " + this._encountPokemon + ".";
               break;
            default:
               FontManager.lang_code = FontManager.LANG_CODE_JA;
               this._msgTop = "このゲームをしゅうりょうしますか？";
               this._msg = "しゅうりょうしたばあい、\n" + this._encountPokemon + "と\nなかよくなることはできません。";
         }
         FontManager.setAutoFontText(this["gameBackWin_mc"]["moji_mc"]["gameCloseMoji_top_mc"],this._msgTop,false);
         FontManager.setAutoFontText(this["gameBackWin_mc"]["moji_mc"]["gameCloseMoji_mc"],this._msg,false);
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
      
      public function winOpen() : void
      {
         this.winOpenAnime();
      }
      
      public function winClose() : void
      {
         this.winCloseAnime();
      }
      
      public function reset() : void
      {
         this._soundController.soundReset();
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      private function __init() : void
      {
         this._btnArray = [];
         with(this["gameBackMask_mc"])
         {
            
            alpha = 0;
            scaleX = 0;
            scaleY = 0;
            visible = false;
         }
         with(this["gameBackWin_mc"])
         {
            
            alpha = 0;
            visible = false;
         }
         this._btnArray.push(this["gameBackWin_mc"]["btnOk_mc"]);
         this._btnArray.push(this["gameBackWin_mc"]["btnCancel_mc"]);
         this.visible = false;
         this._soundController = new soundController();
      }
      
      private function setbtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].mouseChildren = false;
            param1[_loc2_].buttonMode = true;
            param1[_loc2_].addEventListener(MouseEvent.CLICK,this.handleButton,false,0,true);
            param1[_loc2_].addEventListener(MouseEvent.ROLL_OVER,this.handleButton,false,0,true);
            param1[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.handleButton,false,0,true);
            param1[_loc2_].addEventListener(MouseEvent.MOUSE_DOWN,this.handleButton,false,0,true);
            param1[_loc2_].addEventListener(MouseEvent.MOUSE_UP,this.handleButton,false,0,true);
            _loc2_++;
         }
      }
      
      private function deletebtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].buttonMode = false;
            param1[_loc2_].removeEventListener(MouseEvent.CLICK,this.handleButton);
            param1[_loc2_].removeEventListener(MouseEvent.ROLL_OVER,this.handleButton);
            param1[_loc2_].removeEventListener(MouseEvent.ROLL_OUT,this.handleButton);
            param1[_loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,this.handleButton);
            param1[_loc2_].removeEventListener(MouseEvent.MOUSE_UP,this.handleButton);
            _loc2_++;
         }
      }
      
      private function invalidatebtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].buttonMode = false;
            _loc2_++;
         }
      }
      
      private function validatebtn(param1:Array) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].buttonMode = true;
            _loc2_++;
         }
      }
      
      private function handleButton(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.buttonMode)
         {
            switch(param1.type)
            {
               case MouseEvent.ROLL_OVER:
                  this._soundController.playSound("btnOn");
                  _loc2_.gotoAndStop(BTN_OVER);
                  break;
               case MouseEvent.ROLL_OUT:
                  _loc2_.gotoAndStop(BTN_DEFAULT);
                  break;
               case MouseEvent.MOUSE_DOWN:
                  this._soundController.playSound("btnPush");
                  _loc2_.gotoAndStop(BTN_DOWN);
                  break;
               case MouseEvent.MOUSE_UP:
                  _loc2_.gotoAndStop(BTN_DEFAULT);
                  switch(_loc2_.name.split("_")[0])
                  {
                     case "btnOk":
                        this.deletebtn(this._btnArray);
                        dispatchEvent(new flightEvent(flightEvent.GAME_BACK_OK));
                        break;
                     case "btnCancel":
                        this.deletebtn(this._btnArray);
                        this.winClose();
                  }
            }
         }
         _loc2_ = null;
      }
      
      private function winOpenAnime(param1:Boolean = false) : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:Number = NaN;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc2_:Number = 0.25;
         var _loc3_:Number = 0.35;
         var _loc4_:String = "easeOutQuart";
         var _loc5_:Function = this.winOpenAnime;
         if(!param1)
         {
            _loc6_ = this;
            this._soundController.playSound("popupOpen");
            _loc6_.visible = true;
            _loc6_ = this["gameBackMask_mc"];
            _loc6_.visible = true;
            Tweener.addTween(_loc6_,{
               "alpha":this._initAlpha,
               "scaleX":1,
               "scaleY":1,
               "time":_loc2_,
               "transition":_loc4_
            });
            _loc6_ = this["gameBackWin_mc"];
            _loc6_.visible = true;
            _loc7_ = 0.9;
            _loc8_ = _loc6_.width;
            _loc9_ = _loc6_.height;
            _loc10_ = _loc6_.x;
            _loc11_ = _loc6_.y;
            _loc12_ = (_loc8_ - _loc8_ * _loc7_) / 2;
            _loc13_ = (_loc9_ - _loc9_ * _loc7_) / 2;
            _loc6_.alpha = 0;
            _loc6_.scaleX = _loc6_.scaleY = _loc7_;
            Tweener.addTween(_loc6_,{
               "delay":_loc3_,
               "time":_loc2_,
               "transition":"linear",
               "_color_redOffset":255,
               "_color_greenOffset":255,
               "_color_blueOffset":255,
               "_color_alphaMultiplier":0,
               "_Blur_blurX":16,
               "_Blur_blurY":16
            });
            Tweener.addTween(_loc6_,{
               "delay":_loc3_,
               "time":_loc2_,
               "transition":"linear",
               "_color_redOffset":0,
               "_color_greenOffset":0,
               "_color_blueOffset":0,
               "_color_alphaMultiplier":1,
               "_Blur_blurX":0,
               "_Blur_blurY":0
            });
            Tweener.addTween(_loc6_,{
               "delay":_loc3_,
               "time":_loc2_,
               "transition":"easeOutSine",
               "x":_loc10_,
               "y":_loc11_,
               "scaleX":1,
               "scaleY":1,
               "onComplete":_loc5_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this.setbtn(this._btnArray);
         }
      }
      
      private function winCloseAnime(param1:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc2_:Number = 0.1;
         var _loc3_:String = "easeOutQuart";
         var _loc4_:Function = this.winCloseAnime;
         if(!param1)
         {
            this._soundController.playSound("popupClose");
            _loc5_ = this["gameBackMask_mc"];
            Tweener.addTween(_loc5_,{
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "time":_loc2_,
               "transition":_loc3_
            });
            _loc5_ = this["gameBackWin_mc"];
            Tweener.removeTweens(_loc5_);
            Tweener.addTween(_loc5_,{
               "delay":0,
               "time":_loc2_,
               "transition":"linear",
               "alpha":0,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            _loc5_ = this;
            _loc5_.visible = false;
            _loc5_ = this["gameBackMask_mc"];
            _loc5_.visible = false;
            _loc5_ = this["gameBackWin_mc"];
            _loc5_.visible = false;
            dispatchEvent(new flightEvent(flightEvent.GAME_BACK_CANCEL));
         }
      }
   }
}
