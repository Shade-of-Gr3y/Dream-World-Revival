package
{
   import bfp.common.*;
   import common.*;
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import fl.transitions.easing.*;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.getTimer;
   import game.message.FontSetting;
   import game.message.FontSettingMgr;
   import game.message.MessageMgr;
   
   public class Main extends MovieClip
   {
      
      public static const TIMER:* = 90;
      
      public static const SCROLL_MARGIN:* = 260;
      
      public static const POICE_MIN:* = 25;
      
      public static const CircumFerenceMin:* = POICE_MIN * 2 * Math.PI;
      
      public static const phasePreLoad:* = 0;
      
      public static const phasePreInit:* = 1;
      
      public static const phaseLoad:* = 2;
      
      public static const phaseFadeIn:* = 3;
      
      public static const phaseSeed:* = 4;
      
      public static const phaseInit:* = 5;
      
      public static const phaseTitle:* = 6;
      
      public static const phaseHelp:* = 7;
      
      public static const phaseLikeSize:* = 8;
      
      public static const phaseCount:* = 9;
      
      public static const phaseStart:* = 10;
      
      public static const phaseRun:* = 11;
      
      public static const phaseTimeUp:* = 12;
      
      public static const phaseScrollDown:* = 13;
      
      public static const phaseScrollUp:* = 14;
      
      public static const phaseResultIn:* = 15;
      
      public static const phaseResult:* = 16;
      
      public static const phaseExit:* = 17;
      
      public static const phaseExitDialog:* = 18;
      
      public static const phaseHelpDialog:* = 19;
      
      public static const phaseError:* = 20;
      
      public static const phasePause:* = 21;
      
      public static const phasePauseIn:* = 22;
      
      public static const phasePauseOut:* = 23;
      
      public static const EFFECT_HEART:* = 0;
      
      public static const EFFECT_POOR:* = 1;
      
      private static const LIKE_RANGE:* = 5;
      
      private static const LINE_RANGE:* = 20;
      
      private static const LIKE_POS_X:* = 800;
      
      private static const LIKE_POS_Y:* = 480;
      
      private static const HUNNY_POS_Y:* = 130;
      
      private static const BARREL_POS_Y:* = 200;
      
      private static const STATUS_POS_Y:* = 268;
      
      private static const POICENUM_POS_Y:* = 450;
      
      private static const GUIDE_DROP_POS_Y:* = 160;
      
      private static const GUIDE_SEL_POS_Y:* = 200;
      
      internal var m_poiceNumMc:MovieClip;
      
      private var m_seedMgr:seedMgr;
      
      private var m_bLoad:Boolean;
      
      private var m_tween:Tween;
      
      public var guideCheckMc:MovieClip;
      
      private var m_sePoiceGetChannel:SoundChannel;
      
      public var scr:MovieClip;
      
      private var m_mainBGMTrans:SoundTransform;
      
      public var pauseMc:MovieClip;
      
      private var m_aDropPoice:Array;
      
      private var m_result:Result;
      
      private var m_bInit:Boolean;
      
      public var dialogBackMc:MovieClip;
      
      public var _treasureMc:MovieClip;
      
      private var m_dropNum:int;
      
      public var helpBtnMc:MovieClip;
      
      public var exitMesMc:MovieClip;
      
      private var m_aPoice:Array;
      
      public var mouseClearMc:MovieClip;
      
      private var m_poiceAdd:Number;
      
      private var md_count:int = 0;
      
      private var m_mainBGM:Sound;
      
      private var m_screen:MovieClip;
      
      private var m_recHeight:Number;
      
      private var m_bCursor:Boolean = false;
      
      public var loadImageMc:AssetPDWLoading;
      
      private var m_exitBtn:easyButton;
      
      public var resultMc:MovieClip;
      
      public var exitBtnMc:MovieClip;
      
      private var m_mainBGMFade:Boolean;
      
      private var m_likeNum:int;
      
      private var m_errorDialog:DialogBase;
      
      private var m_aLineMc:Array;
      
      private var m_seResult:Sound;
      
      private var bMouseDown:Boolean = false;
      
      private var m_guideCount:int;
      
      public var helpMc:MovieClip;
      
      internal var m_statusMc:MovieClip;
      
      private var m_useBarrel:Barrel;
      
      private var m_phaseLine:int;
      
      private var m_count:int;
      
      private var m_plate:Plate;
      
      private var m_seTimeUp:SeTimeUp;
      
      private var m_poiceDataMgr:PoiceDataMgr;
      
      private var m_scroll:ScreenScroll;
      
      private var m_twLikeSize:Tween;
      
      private var m_titleDialog:DialogBase;
      
      private var m_timer:CircleTimer;
      
      private var m_screenPos:Number;
      
      private var m_helpDialog:DialogBase;
      
      private var m_countDown:LoadSwfMovieClip;
      
      public var wallMc:MovieClip;
      
      private var m_sePoiceGet:Sound;
      
      public var loadMc:MovieClip;
      
      private var m_exitDialog:ExitDialog;
      
      private var m_aButton:Array = new Array();
      
      private var m_phase:int;
      
      private var bMouseDrag:Boolean = false;
      
      internal var m_pauseBmp:Bitmap;
      
      private var m_screenHeight:Number;
      
      private var m_prevPos:Number = 0;
      
      private var m_bGameInit:Boolean;
      
      public var exitMc:MovieClip;
      
      private var m_cursor:MovieClip;
      
      private var m_guideMode:int;
      
      private var m_hunnyMc:MovieClip;
      
      private var m_bStandalone:Boolean;
      
      private var m_likePoice:Poice;
      
      private var m_FontSettingMgr:FontSettingMgr;
      
      private var m_helpBtn:easyButton;
      
      private var m_aBarrel:Array;
      
      public var startMc:MovieClip;
      
      public var ErrorMc:MovieClip;
      
      private var m_PokeLikeSize:Number;
      
      private var m_phaseBack:Array;
      
      private var md_start:int = 0;
      
      private var m_phaseNext:int;
      
      private var m_recPos:Number;
      
      private var m_hunnyPos:Number = 130;
      
      private var m_mainBGMChannel:SoundChannel;
      
      internal var m_pauseCount:int;
      
      private var m_cursorPos:Vec2;
      
      private var m_heightMeter:HeightMeter;
      
      protected var m_debugDisplay:Boolean = false;
      
      private var m_bGiudeEnd:Boolean;
      
      private var m_poice:Poice;
      
      private var m_load_wait:int;
      
      private var m_aPoiceNum:Array = new Array();
      
      internal var m_pauseCheck:int;
      
      private var m_mainBGMVolume:Number;
      
      private var m_MituHunny:PokeLoad;
      
      public function Main()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5,5,this.frame6,6,this.frame7,7,this.frame8,8,this.frame9,9,this.frame10);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         addEventListener(Event.ENTER_FRAME,this._enterFrame);
         comDefine.nLanguage = gameBridge.langCode;
         this.m_bStandalone = false;
         if(stage != null)
         {
            this.m_bStandalone = true;
            comDefine.nLanguage = "es";
            FontManager.standalone("../font.swf");
         }
         this.m_timer = null;
         this.pauseMc.blackMc.alpha = 0;
         this.m_FontSettingMgr = new FontSettingMgr();
         MessageMgr.getInstance().initialize();
         if(stage == null)
         {
            this.m_FontSettingMgr.change(this.loadImageMc.loadMesMc,MessageMgr.ID_LOADING,true);
         }
         this.m_phase = phasePreLoad;
      }
      
      private function _initLikePoiceNum(param1:MovieClip, param2:int) : *
      {
         var _loc3_:Array = this.m_poiceDataMgr.getPoiceData(this.m_seedMgr.getSeedNo());
         var _loc4_:LoadSwfMovieClip = _loc3_[param2].LoadTexture();
         param1.colorMC.texMc.addChild(_loc4_);
         _loc4_.setLoadCallBack(this._likeLoadEnd);
         this.m_FontSettingMgr.change(param1.numMc,MessageMgr.ID_NUM0,false);
      }
      
      private function _timeOut() : void
      {
         var _loc1_:Barrel = null;
         if(this.m_poice != null)
         {
            this.m_poice.click();
            this.m_poice.resetSolid();
            this.m_screen.MoveScreen.removeChild(this.m_poice);
            this.m_poice = null;
         }
         this.bMouseDrag = false;
         this.bMouseDown = false;
         if(this.m_useBarrel != null)
         {
            this.m_useBarrel.moveOut();
         }
         this.m_useBarrel = null;
         if(this.m_sePoiceGetChannel != null)
         {
            this.m_sePoiceGetChannel.stop();
            this.m_sePoiceGetChannel = null;
         }
         for each(_loc1_ in this.m_aBarrel)
         {
            _loc1_.enable(false);
         }
         this.m_scroll.enable(false);
         this.m_count = 300;
         this.m_phase = phaseTimeUp;
         gotoAndStop("timeUp");
         this.exitMesMc.visible = true;
         this.exitMesMc.fin_MC.gotoAndPlay(1);
         MessageMgr.visibleMessageMc(this.exitMesMc.fin_MC);
         this.m_seTimeUp.play();
         this.m_exitBtn.enable(false);
         this.m_helpBtn.enable(false);
      }
      
      private function _loading() : void
      {
         if(loaderInfo.url == null)
         {
            return;
         }
         if(this.m_bLoad == false)
         {
            this._initLoad();
         }
         var _loc1_:* = loaderInfo.bytesLoaded;
         var _loc2_:* = loaderInfo.bytesTotal;
         ++this.m_load_wait;
         var _loc3_:* = Math.min(100,int(_loc1_ / _loc2_ * 100) / 2 + this.m_poiceDataMgr.nowLoading());
         this.loadImageMc.percentage = _loc3_;
         if(this.m_poiceDataMgr.isLoad() == false)
         {
            return;
         }
         if(_loc1_ >= _loc2_ && _loc2_ > 4 && this.m_load_wait >= 30)
         {
            comDefine.DebugPrint("poiceDataMgr loadingOK");
            if(this.m_bInit == false)
            {
               this._initialize();
            }
            gotoAndStop("fade_in");
            this.m_hunnyMc = this.scr.hunnyMc;
            this.m_hunnyMc.grpMc.addChild(this.m_MituHunny.getMovieClip());
            this.m_count = 100;
            this.loadImageMc.away();
            this.m_phase = phaseFadeIn;
            this.scr.guideSelectMc.visible = false;
            this.scr.guideMoveMc.visible = false;
            this.scr.guideDropMc.visible = false;
            if(gameBridge.pauseFlag == true)
            {
               this.pauseGameHandler(null);
            }
            gameBridge.addEventListener(gameBridgeEvent.PAUSE_GAME,this.pauseGameHandler);
            gameBridge.addEventListener(gameBridgeEvent.RESTART_GAME,this.restartGameHandler);
         }
      }
      
      private function _count() : void
      {
         if(this.m_countDown.m_lpMovieClip.count.currentFrame == this.m_countDown.m_lpMovieClip.count.totalFrames)
         {
            this.m_mainBGMTrans = new SoundTransform(this.m_mainBGMVolume,0);
            this.m_mainBGMChannel = this.m_mainBGM.play(0,int.MAX_VALUE,this.m_mainBGMTrans);
            this.mouseClearMc.visible = true;
            removeChild(this.m_countDown);
            gotoAndPlay("start");
            this.m_phase = phaseStart;
         }
      }
      
      private function _exitDialogFunc(param1:MouseEvent) : void
      {
         if(this.m_exitDialog != null || this.m_errorDialog != null)
         {
            return;
         }
         this.m_exitDialog = new ExitDialog(this.exitMc,this.dialogBackMc);
         this._pushPhase(phaseExitDialog);
         this._timerPause(false);
         this.m_mainBGMFade = true;
         this.m_helpBtn.enable(false);
         this.m_exitBtn.enable(false);
      }
      
      private function _releaseButton() : void
      {
         var _loc1_:easyButton = null;
         for each(_loc1_ in this.m_aButton)
         {
            _loc1_.release();
         }
         this.m_aButton.splice(0);
      }
      
      private function _help() : void
      {
         this._openTitleDialog(phaseTitle);
      }
      
      private function _onGuideMouse(param1:MouseEvent) : void
      {
         this._onScreenMouse(param1);
         if(this.m_guideMode == 0)
         {
            this.m_screen.guideDropMc.visible = true;
            this.m_screen.guideMoveMc.visible = false;
            this.m_bGiudeEnd = true;
         }
      }
      
      private function _exitout() : void
      {
         gameBridge.result = gameResult.ABORT;
         gameBridge.closeGame();
      }
      
      private function _onScreenMouse(param1:MouseEvent) : void
      {
         this._cusorEnable(true);
      }
      
      private function _changePoiceSize(param1:int) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.m_poice != null)
         {
            param1 *= this.m_useBarrel.mag;
            _loc2_ = param1 + this.m_poiceAdd;
            _loc3_ = Math.min(100,_loc2_ / (Math.PI * 2));
            this.m_poice.Addition(_loc3_);
            this.m_poiceAdd = Math.min(CircumFerenceMin,this.m_poiceAdd + CircumFerenceMin / 24);
         }
      }
      
      private function _countStart() : void
      {
         var _loc1_:Barrel = null;
         this.m_seedMgr.used();
         this._cusorEnable(true);
         for each(_loc1_ in this.m_aBarrel)
         {
            _loc1_.enable(true);
         }
         this.m_scroll.enable(true);
         this.m_useBarrel = null;
         this.m_dropNum = 0;
         this._printPoiceNum();
         this.m_recHeight = LINE_RANGE;
         this.m_heightMeter.resetHeight();
         this.m_heightMeter.print(this.m_statusMc.heightMc);
         gotoAndStop("count");
         addChildAt(this.m_countDown,getChildIndex(this.startMc) - 1);
         this.m_countDown.m_lpMovieClip.count.gotoAndPlay("countStart");
         this.wallMc.visible = false;
         this.m_phase = phaseCount;
      }
      
      private function _clickReset(param1:MouseEvent) : void
      {
         var _loc2_:Poice = null;
         for each(_loc2_ in this.m_aPoice)
         {
            if(_loc2_ != this.m_plate)
            {
               this.m_screen.PoiceScreen.removeChild(_loc2_);
            }
         }
         this.m_aPoice.splice(0);
         this.m_aPoice.push(this.m_plate);
         this.m_scroll.Scroll(this.m_screenHeight);
         this._printPoiceNum();
         this._countStart();
      }
      
      private function _mouseClear(param1:MouseEvent) : void
      {
         this.mouseClearMc.visible = false;
      }
      
      internal function frame10() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame5() : *
      {
         stop();
      }
      
      internal function frame6() : *
      {
         stop();
      }
      
      internal function frame7() : *
      {
         stop();
      }
      
      internal function frame8() : *
      {
         stop();
      }
      
      private function _helpDialogFunc(param1:MouseEvent) : void
      {
         this._openHelpDialog(this.m_phase);
      }
      
      private function _deleteCheck() : void
      {
         var _loc3_:Poice = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = 1;
         while(_loc2_ < this.m_aPoice.length)
         {
            _loc3_ = this.m_aPoice[_loc2_] as Poice;
            if(_loc3_.y > comDefine.ScreenHeight - this.m_screenHeight)
            {
               this._playEffect(EFFECT_POOR);
               this.m_screen.PoiceScreen.removeChild(_loc3_);
               this.m_aPoice.splice(_loc2_,1);
               _loc2_--;
               _loc1_ = true;
               ++this.m_dropNum;
            }
            else if(this.m_plate.isDrop(_loc3_) == true)
            {
               if(Math.abs(this.m_plate.x - _loc3_.x) > this.m_plate.size)
               {
                  this.m_screen.PoiceScreen.removeChild(_loc3_);
                  this.m_aPoice.splice(_loc2_,1);
                  _loc2_--;
                  this.m_screen.DropScreen.addChild(_loc3_);
                  this.m_aDropPoice.push(_loc3_);
                  _loc1_ = true;
               }
            }
            _loc2_++;
         }
         if(_loc1_ == true)
         {
            this._printPoiceNum();
         }
      }
      
      internal function frame9() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame4() : *
      {
         stop();
      }
      
      private function _pauseIn() : void
      {
         ++this.m_pauseCount;
         this.pauseMc.blackMc.alpha = 0.02 * this.m_pauseCount;
         if(this.m_pauseCount == 20)
         {
            this.m_phase = phasePause;
         }
      }
      
      private function _clickHandler(param1:MouseEvent) : void
      {
         if(this.bMouseDrag == true)
         {
            this._dropPoice();
         }
      }
      
      private function _mouseMove(param1:MouseEvent) : void
      {
         this.m_cursorPos.x = param1.stageX;
         this.m_cursorPos.y = param1.stageY;
         this._setCursorPos();
         this.m_bCursor = false;
      }
      
      private function _preInitialize() : void
      {
         this.scr.addEventListener(MouseEvent.MOUSE_OVER,this._onScreenMouse);
         this.scr.addEventListener(MouseEvent.MOUSE_OUT,this._offScreenMouse);
         this.mouseClearMc.addEventListener(MouseEvent.MOUSE_OVER,this._mouseClear);
         this.mouseClearMc.visible = false;
         this.guideCheckMc.addEventListener(MouseEvent.MOUSE_OVER,this._onGuideMouse);
         this.guideCheckMc.addEventListener(MouseEvent.MOUSE_OUT,this._offGuideMouse);
         this.guideCheckMc.visible = false;
         comDefine.rootMc = this;
         this.m_pauseCheck = 0;
         this.pauseMc.visible = false;
         this.dialogBackMc.visible = false;
         this.m_bLoad = false;
         this.m_bGameInit = false;
         this.m_bInit = false;
         this.m_load_wait = 0;
         this.m_phaseBack = new Array();
         this.m_phase = phaseLoad;
      }
      
      private function _mouseCursor(param1:MouseEvent) : void
      {
         this.m_bCursor = true;
      }
      
      private function _scrollDown() : void
      {
         if(this.m_scroll.isScroll() == false)
         {
            if(this.m_screenPos != this.m_screenHeight)
            {
               this.m_scroll.Scroll(this.m_screenPos,(this.m_screenPos - this.m_screenHeight) / 5,1);
               this.m_phase = phaseScrollUp;
            }
            else
            {
               this._startResult();
            }
         }
      }
      
      private function _loadPokemonImage() : void
      {
         this.m_MituHunny = new PokeLoad(comDefine.g_Dir + "mituhani.swf");
      }
      
      private function _dropMove() : void
      {
         var _loc2_:Poice = null;
         var _loc3_:int = 0;
         var _loc1_:Boolean = false;
         for each(_loc2_ in this.m_aDropPoice)
         {
            _loc2_.resetAccel();
            _loc2_.commitAccel();
         }
         _loc3_ = 0;
         while(_loc3_ < this.m_aDropPoice.length)
         {
            _loc2_ = this.m_aDropPoice[_loc3_] as Poice;
            if(_loc2_.y > comDefine.ScreenHeight - this.m_screenHeight)
            {
               this._playEffect(EFFECT_POOR);
               this.m_screen.DropScreen.removeChild(_loc2_);
               this.m_aDropPoice.splice(_loc3_,1);
               ++this.m_dropNum;
               _loc3_--;
               _loc1_ = true;
            }
            _loc3_++;
         }
         if(_loc1_ == true)
         {
            this._printPoiceNum();
         }
      }
      
      private function _startLikeSize() : void
      {
         gotoAndStop("help");
         this.m_phase = phaseLikeSize;
      }
      
      private function _likeLoadEnd(param1:LoadSwfMovieClip) : void
      {
         param1.m_lpMovieClip.scaleX = 0.3;
         param1.m_lpMovieClip.scaleY = 0.3;
      }
      
      private function _cusorEnable(param1:Boolean) : void
      {
         if(this.m_phase >= phaseCount && this.m_phase < phaseTimeUp)
         {
            if(param1)
            {
               comDefine.mouseEnable(false);
            }
            else
            {
               comDefine.mouseEnable(true);
            }
            if(this.m_cursor)
            {
               this.m_cursor.visible = param1;
            }
         }
         else
         {
            comDefine.mouseEnable(true);
            if(this.m_cursor)
            {
               this.m_cursor.visible = false;
            }
         }
      }
      
      private function _offScreenMouse(param1:MouseEvent) : void
      {
         this._cusorEnable(false);
      }
      
      private function _setCursorPos() : void
      {
         this.m_cursor.x = this.m_cursorPos.x;
         this.m_cursor.y = this.m_cursorPos.y - this.m_screen.y;
         if(this.m_poice != null)
         {
            this.m_poice.x = this.m_cursor.x;
            this.m_poice.y = this.m_cursor.y;
         }
      }
      
      private function _finishGame() : void
      {
         if(this.m_heightMeter.getHeight() >= 20)
         {
            gameBridge.result = gameResult.SUCCESS;
         }
         else
         {
            gameBridge.result = gameResult.FAILURE;
         }
         gameBridge.rank = this.m_result.getRank();
         this.m_phase = -1;
         this.m_count = 24;
      }
      
      private function _openTitleDialog(param1:int) : void
      {
         if(this.m_errorDialog != null || this.m_titleDialog != null)
         {
            return;
         }
         this.m_titleDialog = new ExitDialog(this.startMc,null,DialogBase.MOTION_WINDOW);
         this.m_phase = param1;
         this.m_FontSettingMgr.change(this.startMc.mesMc.mes2Mc,MessageMgr.ID_HELP_MES0,false);
         this.m_FontSettingMgr.change(this.startMc.okMc.rulestart_MC,MessageMgr.ID_PROMISE_START,false);
         this.m_FontSettingMgr.change(this.startMc.cancelMc.rulefont_MC,MessageMgr.ID_PROMISE_LOOK,false);
      }
      
      private function _pauseOut() : void
      {
         --this.m_pauseCount;
         this.pauseMc.blackMc.alpha = 0.025 * this.m_pauseCount;
         if(this.m_pauseCount == 0)
         {
            this._timerPause(true);
            this._popPhase();
            this.pauseMc.visible = false;
         }
      }
      
      private function _mouseUp(param1:MouseEvent) : void
      {
         if(this.bMouseDrag == true)
         {
            this.md_count = getTimer() - this.md_start;
            this._dropPoice();
         }
      }
      
      private function _phaseError() : void
      {
         if(this.m_errorDialog.isExit() == true)
         {
            this.m_errorDialog.release();
            this.m_errorDialog = null;
            gameBridge.result = gameResult.ABORT;
            gameBridge.closeGame();
            this.m_phase = -1;
         }
      }
      
      private function _preLoad() : void
      {
         if(loaderInfo.url == null)
         {
            return;
         }
         var _loc1_:* = loaderInfo.bytesLoaded;
         var _loc2_:* = loaderInfo.bytesTotal;
         var _loc3_:* = Math.min(100,int(_loc1_ / _loc2_ * 100) / 2);
         this.loadImageMc.percentage = _loc3_;
         if(_loc1_ >= _loc2_ && _loc2_ > 4)
         {
            comDefine.DebugPrint("preLoading OK");
            gotoAndStop("loading");
            this.m_phase = phasePreInit;
         }
      }
      
      private function _dropPoice() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Poice = null;
         if(this.m_poice != null)
         {
            if(this.m_poice.getOrgSize() > this.m_PokeLikeSize - LIKE_RANGE && this.m_poice.getOrgSize() < this.m_PokeLikeSize + LIKE_RANGE)
            {
               this._playEffect(EFFECT_HEART);
            }
            this.m_screen.MoveScreen.removeChild(this.m_poice);
            if(this.m_poiceAdd >= CircumFerenceMin)
            {
               this.m_poice.click();
               _loc1_ = false;
               for each(_loc2_ in this.m_aPoice)
               {
                  if(_loc2_.isDrop(this.m_poice) == true)
                  {
                     _loc1_ = true;
                     break;
                  }
               }
               if(_loc1_ == true)
               {
                  if(this.m_poice.isSolid())
                  {
                     this.m_poice.resetSolid();
                  }
                  this.m_aDropPoice.push(this.m_poice);
                  this.m_screen.DropScreen.addChild(this.m_poice);
               }
               else
               {
                  this.m_aPoice.push(this.m_poice);
                  this.m_screen.PoiceScreen.addChild(this.m_poice);
                  this._printPoiceNum();
               }
               if(this.m_useBarrel != null)
               {
                  this.m_useBarrel.moveOut();
               }
               this.m_useBarrel = null;
               this.mouseClearMc.visible = true;
               if(this.m_sePoiceGetChannel != null)
               {
                  this.m_sePoiceGetChannel.stop();
                  this.m_sePoiceGetChannel = null;
               }
            }
            if(this.m_bGiudeEnd == true)
            {
               this.m_guideMode = 1;
               this.m_screen.guideSelectMc.visible = false;
               this.m_screen.guideMoveMc.visible = false;
               this.m_screen.guideDropMc.visible = false;
            }
            else if(this.m_guideMode == 0)
            {
               this.m_screen.guideSelectMc.mes01Mc.visible = true;
               this.m_screen.guideSelectMc.mes02Mc.visible = false;
               this.m_screen.guideSelectMc.visible = true;
               this.m_screen.guideMoveMc.visible = false;
               this.m_screen.guideDropMc.visible = false;
            }
            this.guideCheckMc.visible = false;
            this.m_poice = null;
            this.bMouseDrag = false;
         }
      }
      
      private function _pushPhase(param1:int) : void
      {
         this.m_phaseBack.push(this.m_phase);
         this.m_phase = param1;
      }
      
      private function _onPoi(param1:MouseEvent) : void
      {
      }
      
      private function _popPhase() : void
      {
         this.m_phase = this.m_phaseBack[this.m_phaseBack.length - 1];
         this.m_phaseBack.pop();
      }
      
      private function _enterFrame(param1:Event) : void
      {
         comDefine.mouse();
         switch(this.m_phase)
         {
            case phasePreLoad:
               this._preLoad();
               break;
            case phasePreInit:
               this._preInitialize();
               break;
            case phaseLoad:
               this._loading();
               break;
            case phaseFadeIn:
               this._fadeIn();
               break;
            case phaseSeed:
               this._seed();
               break;
            case phaseInit:
               this._gameInit();
               break;
            case phaseTitle:
               this._title();
               break;
            case phaseHelp:
               this._help();
               break;
            case phaseLikeSize:
               this._likeSize();
               break;
            case phaseCount:
               this._count();
               break;
            case phaseStart:
               this._start();
               break;
            case phaseRun:
               this._run();
               break;
            case phaseTimeUp:
               this._timeUp();
               break;
            case phaseScrollDown:
               this._scrollDown();
               break;
            case phaseScrollUp:
               this._scrollUp();
               break;
            case phaseResultIn:
               this._resultIn();
               break;
            case phaseResult:
               this._result();
               break;
            case phaseExit:
               this._exitGame();
               break;
            case phaseExitDialog:
               this._exitDialog();
               break;
            case phaseHelpDialog:
               this._helpDialog();
               break;
            case phasePauseIn:
               this._pauseIn();
               break;
            case phasePauseOut:
               this._pauseOut();
               break;
            case phaseError:
               this._phaseError();
         }
         if(this.m_mainBGMChannel != null)
         {
            if(this.m_mainBGMFade == true && this.m_mainBGMVolume > 0)
            {
               this.m_mainBGMVolume = Math.max(this.m_mainBGMVolume - 0.03,0);
            }
            else if(this.m_mainBGMFade == false && this.m_mainBGMVolume < 1)
            {
               this.m_mainBGMVolume = Math.min(this.m_mainBGMVolume + 0.015,1);
            }
            if(this.m_mainBGMVolume != this.m_mainBGMTrans.volume)
            {
               this.m_mainBGMTrans.volume = this.m_mainBGMVolume;
               this.m_mainBGMChannel.soundTransform = this.m_mainBGMTrans;
            }
         }
      }
      
      private function _collisionCheck() : void
      {
         var _loc1_:Poice = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Poice = null;
         var _loc5_:Vec2 = null;
         for each(_loc1_ in this.m_aPoice)
         {
            _loc1_.resetAccel();
         }
         _loc2_ = 0;
         while(_loc2_ < this.m_aPoice.length - 1)
         {
            _loc1_ = this.m_aPoice[_loc2_] as Poice;
            _loc3_ = _loc2_ + 1;
            while(_loc3_ < this.m_aPoice.length)
            {
               _loc4_ = this.m_aPoice[_loc3_] as Poice;
               _loc5_ = _loc1_.getReflection(_loc4_);
               if(_loc5_ != null)
               {
                  if(_loc1_.size < _loc4_.size)
                  {
                     _loc1_.addAccel(_loc5_);
                     _loc4_.addAccel(_loc5_.GetScale(-(_loc1_.size / _loc4_.size)));
                  }
                  else
                  {
                     _loc1_.addAccel(_loc5_.GetScale(_loc4_.size / _loc1_.size));
                     _loc4_.addAccel(_loc5_.GetScale(-1));
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ < this.m_aPoice.length - 1)
         {
            _loc1_ = this.m_aPoice[_loc2_] as Poice;
            _loc3_ = _loc2_ + 1;
            while(_loc3_ < this.m_aPoice.length)
            {
               _loc4_ = this.m_aPoice[_loc3_] as Poice;
               _loc1_.overRevision(_loc4_);
               _loc3_++;
            }
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ < this.m_aPoice.length)
         {
            if(this.m_aPoice[0].overRevision(this.m_aPoice[_loc2_]) == true)
            {
            }
            _loc2_++;
         }
         for each(_loc1_ in this.m_aPoice)
         {
            _loc1_.commitAccel();
         }
      }
      
      private function pauseGameHandler(param1:Event) : void
      {
         ++this.m_pauseCheck;
         if(this.m_phase < phasePause)
         {
            this._cusorEnable(false);
            this.pauseMc.blackMc.alpha = 0;
            this._pushPhase(phasePauseIn);
            this._timerPause(false);
            this.m_pauseCount = 0;
            this.pauseMc.visible = true;
            this.m_mainBGMFade = true;
         }
      }
      
      private function _selectSeed() : void
      {
         if(this.m_bStandalone == true)
         {
            gotoAndStop("init");
            this.m_seedMgr.setSeedNo(28);
            this.m_phase = phaseInit;
            this.m_tween = new Tween(this.m_statusMc,"x",Strong.easeOut,this.m_statusMc.x,895,24);
            this.m_twLikeSize = new Tween(this.m_poiceNumMc,"y",Strong.easeOut,this.m_poiceNumMc.y,POICENUM_POS_Y - this.m_screen.y,24);
            return;
         }
         this.m_seedMgr.initialize();
         this.m_phase = phaseSeed;
      }
      
      internal function rootUrl(param1:String) : *
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         while(param1.indexOf("/..") != -1)
         {
            _loc2_ = int(param1.indexOf("/../"));
            _loc3_ = param1.substr(0,_loc2_);
            _loc4_ = int(_loc3_.lastIndexOf("/"));
            param1 = _loc5_ = param1.substr(0,_loc4_) + param1.substr(_loc2_ + 3,param1.length);
         }
         return param1;
      }
      
      private function _initialize() : void
      {
         var _loc1_:MovieClip = null;
         this.exitMc.visible = false;
         this.helpMc.visible = false;
         this.ErrorMc.visible = false;
         this.resultMc.visible = false;
         this.exitMesMc.visible = false;
         this.m_FontSettingMgr.change(this.exitBtnMc.exitMes,MessageMgr.ID_EXITGAME,false);
         this.m_FontSettingMgr.change(this.exitMc.okMc.okbtnfont_MC,MessageMgr.ID_OK,false);
         this.m_FontSettingMgr.change(this.exitMc.cancelMc.canselbtnfont_MC,MessageMgr.ID_CANCEL,false);
         this.m_FontSettingMgr.change(this.resultMc.okMc.okbtnfont_MC,MessageMgr.ID_OK,false);
         this.m_FontSettingMgr.change(this.m_statusMc.timename_MC,MessageMgr.ID_STATUS_TIMENAME,false);
         this.m_FontSettingMgr.change(this.m_statusMc.heightname_MC,MessageMgr.ID_HEIGHTNAME,false);
         this.m_FontSettingMgr.change(this.m_statusMc.heightMc.topMC,MessageMgr.ID_NUM0,false,0);
         this.m_FontSettingMgr.change(this.m_statusMc.heightMc.dotMC,MessageMgr.ID_DOT,false,0);
         this.m_FontSettingMgr.change(this.m_statusMc.heightMc.bottomMC,MessageMgr.ID_NUM00,false,0);
         this.m_FontSettingMgr.change(this.m_statusMc.cmname_MC,MessageMgr.ID_CM,false);
         this.m_FontSettingMgr.change(this.m_statusMc.eat_MC,MessageMgr.ID_NUM0,false);
         this.m_FontSettingMgr.change(this.m_statusMc.eatslashMC,MessageMgr.ID_SLASH,false);
         this.m_FontSettingMgr.change(this.m_statusMc.eatm_MC,MessageMgr.ID_NUM0,false);
         this.m_FontSettingMgr.change(this.m_statusMc.numbername_MC,MessageMgr.ID_NUM_KO,false);
         this.m_FontSettingMgr.change(this.m_statusMc.pokename_me_MC,MessageMgr.ID_STATUS_POKE_ME_NAME,false);
         this.m_FontSettingMgr.change(this.m_statusMc.likeSizeMc,MessageMgr.ID_LIKE_SIZE_TITLE,false);
         this.m_FontSettingMgr.change(this.resultMc.textMc.resulttitle_MC,MessageMgr.ID_RESULT_TITLE,true);
         this.m_FontSettingMgr.change(this.resultMc.textMc.resultheightfont_MC,MessageMgr.ID_HEIGHTNAME,true);
         this.m_FontSettingMgr.change(this.resultMc.textMc.resultdownfont_MC,MessageMgr.ID_COLORNAME,true);
         this.m_FontSettingMgr.change(this.resultMc.textMc.resultALLfont_MC,MessageMgr.ID_RESULT_TOTALNAME,true);
         this.m_FontSettingMgr.change(this.resultMc.textMc.resultcmfont_MC,MessageMgr.ID_CM,true);
         this.m_FontSettingMgr.change(this.resultMc.textMc.resultnumberfont2_MC,MessageMgr.ID_NUM_KO,true);
         this.m_FontSettingMgr.change(this.resultMc.textMc.resultpointfont_MC,MessageMgr.ID_RESULY_POINT,true);
         this.m_FontSettingMgr.change(this.resultMc.textMc.resultpointfont3_MC,MessageMgr.ID_RESULY_POINT,true);
         _loc1_ = comDefine.getTextMc(this.resultMc.textMc.resultXpointfont_MC);
         this.m_FontSettingMgr.change(_loc1_,MessageMgr.ID_RESULT_MAG,true);
         _loc1_ = comDefine.getTextMc(this.resultMc.textMc.resultXpointfont2_MC);
         this.m_FontSettingMgr.change(_loc1_,MessageMgr.ID_RESULT_MAG,true);
         this.m_FontSettingMgr.change(this.resultMc.numMc.resultpointcm_MC.topMC,MessageMgr.ID_NUM0,true,0);
         this.m_FontSettingMgr.change(this.resultMc.numMc.resultpointcm_MC.dotMC,MessageMgr.ID_DOT,true,0);
         this.m_FontSettingMgr.change(this.resultMc.numMc.resultpointcm_MC.bottomMC,MessageMgr.ID_NUM00,true,0);
         this.m_FontSettingMgr.change(this.resultMc.numMc.resultheightpoint_MC,MessageMgr.ID_NUM0,true);
         _loc1_ = comDefine.getTextMc(this.resultMc.numMc.resultfallpoint_MC);
         this.m_FontSettingMgr.change(_loc1_.topMC,MessageMgr.ID_NUM0,true,0);
         this.m_FontSettingMgr.change(_loc1_.dotMC,MessageMgr.ID_DOT,true,0);
         this.m_FontSettingMgr.change(_loc1_.bottomMC,MessageMgr.ID_NUM00,true,0);
         this.m_FontSettingMgr.change(this.resultMc.numMc.resultpointeat_MC,MessageMgr.ID_NUM0,true,0);
         this.m_FontSettingMgr.change(this.resultMc.numMc.resultpointeatm_MC,MessageMgr.ID_NUM0,true,0);
         _loc1_ = comDefine.getTextMc(this.resultMc.numMc.resultXpoint_MC);
         this.m_FontSettingMgr.change(_loc1_.topMC,MessageMgr.ID_NUM0,true,0);
         this.m_FontSettingMgr.change(_loc1_.dotMC,MessageMgr.ID_DOT,true,0);
         this.m_FontSettingMgr.change(_loc1_.bottomMC,MessageMgr.ID_NUM00,true,0);
         this.m_FontSettingMgr.change(this.resultMc.numMc.resultallpoint_MC,MessageMgr.ID_NUM0,true,0);
         this.m_FontSettingMgr.change(this.resultMc.numMc.slashMc,MessageMgr.ID_SLASH,true);
         this.m_FontSettingMgr.change(this.scr.guideSelectMc.mes01Mc.mesMc,MessageMgr.ID_GUIDE_SELECT,false);
         this.m_FontSettingMgr.change(this.scr.guideSelectMc.mes02Mc.mesMc,MessageMgr.ID_GUIDE_BUTTON,false);
         this.m_FontSettingMgr.change(this.scr.guideMoveMc.mesMc,MessageMgr.ID_GUIDE_MOVE,false);
         this.m_FontSettingMgr.change(this.scr.guideDropMc.mesMc,MessageMgr.ID_GUIDE_DOWN,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.fallname_MC,MessageMgr.ID_COLORNAME,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.xname3_MC,MessageMgr.ID_X,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.xname4_MC,MessageMgr.ID_X,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.xname5_MC,MessageMgr.ID_X,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.poice1Mc.numMc,MessageMgr.ID_NUM0,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.poice2Mc.numMc,MessageMgr.ID_NUM0,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.poice3Mc.numMc,MessageMgr.ID_NUM0,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.numbername3_MC,MessageMgr.ID_NUM_KO,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.numbername4_MC,MessageMgr.ID_NUM_KO,false);
         this.m_FontSettingMgr.change(this.m_poiceNumMc.numbername5_MC,MessageMgr.ID_NUM_KO,false);
         var _loc2_:Number = Number(this.ErrorMc.mesMc.mes2Mc.textMC.height);
         this.m_FontSettingMgr.change(this.ErrorMc.mesMc.mes2Mc,MessageMgr.ID_ERROR,false);
         this.ErrorMc.mesMc.mes2Mc.textMC.y -= (this.ErrorMc.mesMc.mes2Mc.textMC.height - _loc2_) / 2;
         this.m_FontSettingMgr.change(this.ErrorMc.okMc.okbtnfont_MC,MessageMgr.ID_OK,false);
         this.m_FontSettingMgr.change(this.exitMc.mesMc.mes3Mc,MessageMgr.ID_EXIT_MESSAGE_TOP,false);
         var _loc3_:* = MessageMgr.getInstance().getMessage(MessageMgr.ID_EXIT_MESSAGE_TOP);
         _loc3_ += "\n" + gameBridge.encountPokemonName;
         if(comDefine.nLanguage == "de")
         {
            _loc3_ += " ";
         }
         _loc3_ += MessageMgr.getInstance().getMessage(MessageMgr.ID_EXIT_MESSAGE_END);
         FontSetting.setText(this.exitMc.mesMc.mes3Mc.textMC,_loc3_,false);
         if(gameBridge.encountPokemonName != null)
         {
            this.m_FontSettingMgr.changeString(this.m_statusMc.pokename_you_MC,gameBridge.encountPokemonName,false);
         }
         var _loc4_:* = PokemonBridge.createRenderer();
         if(_loc4_)
         {
            _loc4_.loadToArea(gameBridge.myPokemonId,gameBridge.myFormId,54,54);
            this.m_statusMc.pokeMeMc.addChild(_loc4_.display);
            _loc4_.shadowOpacity = 0;
            _loc4_.display.x = -27;
            _loc4_.display.y = -27;
         }
         _loc4_ = PokemonBridge.createRenderer();
         if(_loc4_)
         {
            _loc4_.loadToArea(gameBridge.encountPokemonId,gameBridge.encountFormId,54,54);
            this.m_statusMc.pokeYouMc.addChild(_loc4_.display);
            _loc4_.shadowOpacity = 0;
            _loc4_.display.x = -27;
            _loc4_.display.y = -27;
         }
         this.m_bInit = true;
      }
      
      private function _createButton(param1:MovieClip, param2:Function) : *
      {
         this.m_aButton.push(new easyButton(param1,param2));
      }
      
      private function _fontSetting(param1:MovieClip, param2:int, param3:Boolean, param4:Number = -1) : void
      {
         var _loc8_:TextFormat = null;
         var _loc5_:TextField = param1.textMC;
         var _loc6_:* = param1.width;
         var _loc7_:* = param1.height;
         if(param4 != -1)
         {
            _loc8_ = _loc5_.defaultTextFormat;
            _loc8_.letterSpacing = param4;
            _loc5_.defaultTextFormat = _loc8_;
         }
         param1.scaleX = _loc6_ / param1.width;
         param1.scaleY = _loc7_ / param1.height;
      }
      
      private function _result() : void
      {
         if(this.m_result.isEnable() == false)
         {
            this.m_result.close();
            this.m_count = 30;
            this.resultMc.visible = false;
            this.m_mainBGMFade = true;
            this.m_phase = phaseExit;
         }
      }
      
      private function _seed() : void
      {
         if(this.m_seedMgr.isSelect() == true)
         {
            gotoAndStop("init");
            this.m_phase = phaseInit;
            this.m_tween = new Tween(this.m_statusMc,"x",Strong.easeOut,this.m_statusMc.x,895,24);
            this.m_twLikeSize = new Tween(this.m_poiceNumMc,"y",Strong.easeOut,this.m_poiceNumMc.y,POICENUM_POS_Y - this.m_screen.y,24);
         }
         else if(this.m_seedMgr.isError() == true)
         {
            this.m_errorDialog = new DialogBase(this.ErrorMc,this.dialogBackMc);
            this.m_phase = phaseError;
            this.m_helpBtn.enable(false);
            this.m_exitBtn.enable(false);
         }
      }
      
      private function _barrelPos(param1:TweenEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Barrel = null;
         if(this.m_prevPos != this.m_screen.y)
         {
            _loc2_ = BARREL_POS_Y;
            for each(_loc3_ in this.m_aBarrel)
            {
               _loc3_.setPos(_loc2_ - this.m_screen.y);
               _loc2_ += 96;
            }
            this.m_prevPos = this.m_screen.y;
            this.m_statusMc.y = STATUS_POS_Y - this.m_screen.y;
            this.m_poiceNumMc.y = POICENUM_POS_Y - this.m_screen.y;
            this.m_screen.guideSelectMc.y = GUIDE_SEL_POS_Y - this.m_screen.y;
            this.m_screen.guideMoveMc.y = GUIDE_DROP_POS_Y - this.m_screen.y;
            this.m_screen.guideDropMc.y = GUIDE_DROP_POS_Y - this.m_screen.y;
         }
         if(this.m_MituHunny.getMovieClip().topMc.hunnyMc.currentFrame == 1)
         {
            if(this.m_aLineMc.length != 0)
            {
               this.m_hunnyPos = HUNNY_POS_Y + this.m_aLineMc[this.m_aLineMc.length - 1].getPos();
            }
            this.m_hunnyMc.y = this.m_hunnyPos - this.m_screen.y;
         }
      }
      
      private function _timerPause(param1:Boolean) : void
      {
         var _loc2_:Barrel = null;
         var _loc4_:Boolean = false;
         var _loc3_:int = this._getPhaseStack();
         if(param1 == false)
         {
            switch(_loc3_)
            {
               case phaseCount:
                  this.m_countDown.m_lpMovieClip.count.stop();
                  break;
               case phaseRun:
                  this.m_timer.Pause(false);
            }
            for each(_loc2_ in this.m_aBarrel)
            {
               _loc2_.enable(false);
            }
         }
         else
         {
            _loc4_ = false;
            switch(_loc3_)
            {
               case phaseCount:
                  this.m_countDown.m_lpMovieClip.count.play();
                  _loc4_ = true;
                  break;
               case phaseRun:
                  this.m_timer.Pause(true);
                  _loc4_ = true;
            }
            if(_loc4_ == true)
            {
               for each(_loc2_ in this.m_aBarrel)
               {
                  _loc2_.enable(true);
               }
            }
         }
      }
      
      private function _title() : void
      {
         if(this.m_titleDialog.isEnable() == false)
         {
            if(this.m_titleDialog.isExit() == true)
            {
               this._selectSeed();
            }
            else
            {
               this._openHelpDialog(phaseHelp);
            }
            this.m_titleDialog.release();
            this.m_titleDialog = null;
         }
      }
      
      private function _barrelCheck() : void
      {
         var _loc1_:Boolean = false;
         if(this.m_useBarrel != null)
         {
            if(this.m_poice != null)
            {
               if(this.m_useBarrel.isMouseOver() == true)
               {
                  this.md_count = getTimer() - this.md_start;
               }
            }
            if(this.m_useBarrel.isMouseOver() == false)
            {
               this.m_cursor.gotoAndStop(1);
               if(this.m_guideMode == 0)
               {
                  this.m_screen.guideSelectMc.mes01Mc.visible = true;
                  this.m_screen.guideSelectMc.mes02Mc.visible = false;
               }
               this.m_useBarrel.moveOut();
               if(this.m_poice != null)
               {
                  if(this.m_poiceAdd < CircumFerenceMin)
                  {
                     this.m_poiceAdd = CircumFerenceMin;
                  }
                  if(this.m_guideMode == 0)
                  {
                     if(this.m_guideCount < 60)
                     {
                        _loc1_ = true;
                        this.m_guideCount = 61;
                     }
                  }
               }
               if(this.m_sePoiceGetChannel != null)
               {
                  this.m_sePoiceGetChannel.stop();
                  this.m_sePoiceGetChannel = null;
               }
            }
         }
         if(this.m_poice != null)
         {
            if(this.m_poiceAdd <= CircumFerenceMin)
            {
               this._changePoiceSize(this.md_count / 40);
               if(this.m_guideMode == 0)
               {
                  this.m_guideCount = Math.min(61,this.m_guideCount + 1);
                  if(this.m_guideCount == 60)
                  {
                     _loc1_ = true;
                  }
               }
            }
         }
         if(_loc1_ && this.m_guideMode == 0)
         {
            this.m_screen.guideSelectMc.visible = false;
            this.m_screen.guideMoveMc.visible = true;
            this.guideCheckMc.visible = true;
         }
      }
      
      private function _onKeyUP(param1:KeyboardEvent) : void
      {
         var _loc2_:Poice = null;
         if(param1.keyCode == 96)
         {
            this.m_debugDisplay = this.m_debugDisplay == false;
            this.m_screen.frontMc.visible = this.m_debugDisplay == false;
            for each(_loc2_ in this.m_aPoice)
            {
               _loc2_.debugDisplayMode(this.m_debugDisplay);
            }
            this.m_timer.Pause(this.m_timer.isEnable() == false);
         }
      }
      
      private function _start() : void
      {
         this.m_timer = this.m_statusMc.MeterMc as CircleTimer;
         this.m_timer.Start(TIMER,this._timeOut);
         this.m_screen.guideSelectMc.visible = true;
         this.m_screen.guideSelectMc.mes01Mc.visible = true;
         this.m_screen.guideSelectMc.mes02Mc.visible = false;
         this.m_phase = phaseRun;
      }
      
      private function _startResult() : void
      {
         gotoAndStop("result");
         this.m_result.print(this.resultMc.numMc,this.m_heightMeter.getHeight(),this.m_likeNum,this.m_aPoice.length - 1,this.m_aPoiceNum);
         this.m_result.open(this.resultMc,this.dialogBackMc);
         if(this.m_aPoice.length > 2)
         {
            FontSetting.setText(this.resultMc.textMc.resultnumberfont2_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KOS),true);
         }
         else
         {
            FontSetting.setText(this.resultMc.textMc.resultnumberfont2_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KO),true);
         }
         this.m_phase = phaseResultIn;
      }
      
      private function restartGameHandler(param1:Event) : void
      {
         if(this.m_pauseCheck)
         {
            --this.m_pauseCheck;
         }
         if(this.m_phase >= phasePause)
         {
            this.m_mainBGMFade = false;
            this.m_phase = phasePauseOut;
         }
      }
      
      private function _mouseDown(param1:int, param2:LoadSwfMovieClip, param3:MouseEvent) : void
      {
         if(this.m_phase != phaseRun)
         {
            return;
         }
         if(this.bMouseDrag == false && this.m_useBarrel != null)
         {
            this.bMouseDrag = true;
            this.md_start = getTimer();
            this.m_poice = new Poice(param1,param2);
            this.m_poice.setFric(this.m_useBarrel.fric_top,this.m_useBarrel.fric_side);
            this.m_poiceAdd = 0;
            this.m_cursorPos.x = param3.stageX;
            this.m_cursorPos.y = param3.stageY;
            this._setCursorPos();
            this.m_cursor.play();
            this.m_screen.MoveScreen.addChild(this.m_poice);
            this.m_poice.debugDisplayMode(this.m_debugDisplay);
            this.m_guideCount = 0;
            this.m_bGiudeEnd = false;
         }
      }
      
      private function _initLoad() : void
      {
         var _loc1_:String = this.rootUrl(this.loaderInfo.url);
         comDefine.g_Dir = _loc1_.slice(0,_loc1_.lastIndexOf("/") + 1);
         comDefine.DebugPrint("g_Dir : " + comDefine.g_Dir);
         this.m_poiceDataMgr = new PoiceDataMgr();
         comDefine.DebugPrint("new seedMgr");
         this.m_seedMgr = new seedMgr(this._treasureMc);
         comDefine.DebugPrint("new HeightMeter");
         this.m_heightMeter = new HeightMeter();
         comDefine.DebugPrint("new Result");
         this.m_result = new Result();
         this.m_aLineMc = new Array();
         this.m_exitBtn = new easyButton(this.exitBtnMc,this._exitDialogFunc);
         this.m_helpBtn = new easyButton(this.helpBtnMc,this._helpDialogFunc);
         this.exitMc.visible = false;
         comDefine.DebugPrint("loadSwf  " + comDefine.g_Dir + "count.swf");
         this.m_countDown = new LoadSwfMovieClip();
         this.m_countDown.LoadSwf(comDefine.g_Dir + "count.swf");
         comDefine.DebugPrint("loadPokemonImage " + comDefine.g_Dir + "mituhani.swf");
         this._loadPokemonImage();
         addChild(this.m_seedMgr);
         comDefine.DebugPrint("new SeTimeUp");
         this.m_seTimeUp = new SeTimeUp();
         this.m_PokeLikeSize = Math.random() * 30 + 30;
         this.m_screen = this.scr;
         this.m_statusMc = this.scr.statusMc;
         this.m_poiceNumMc = this.scr.poiceNumMc;
         this.m_guideMode = 0;
         this.m_bLoad = true;
      }
      
      private function _timeUp() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Poice = null;
         this._collisionCheck();
         this._collisionCheck();
         this._dropMove();
         this._dropMove();
         this._deleteCheck();
         if(this.m_count != 0)
         {
            --this.m_count;
            _loc1_ = false;
            for each(_loc2_ in this.m_aPoice)
            {
               if(_loc1_ == false)
               {
                  _loc1_ = true;
               }
               else if(_loc2_.isSolid() == false)
               {
                  return;
               }
            }
         }
         this._screenMove();
         if(this.m_aDropPoice.length != 0 || this.m_count > 210)
         {
            return;
         }
         this.m_heightMeter.commit();
         this.m_heightMeter.print(this.m_statusMc.heightMc);
         this.m_screen.guideSelectMc.visible = false;
         this.m_screen.guideMoveMc.visible = false;
         this.m_screen.guideDropMc.visible = false;
         this.m_scroll.enable(false);
         this.m_scroll.Scroll(this.m_screenHeight);
         this.m_phase = phaseScrollDown;
      }
      
      private function _playEffect(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         switch(param1)
         {
            case EFFECT_HEART:
               _loc2_ = new effecHeart();
               break;
            case EFFECT_POOR:
               _loc2_ = new effecPoor();
         }
         _loc2_.x = this.m_hunnyMc.x + this.m_hunnyMc.width / 2;
         _loc2_.y = this.m_hunnyMc.y;
         this.m_screen.addChildAt(_loc2_,this.m_screen.getChildIndex(this.m_hunnyMc) + 1);
      }
      
      private function _exitGame() : void
      {
         --this.m_count;
         if(this.m_count > 0)
         {
            return;
         }
         this._finishGame();
         gameBridge.finishGame();
      }
      
      private function _likeSize() : void
      {
         this.helpMc.visible = false;
         this._countStart();
      }
      
      private function _gameInit() : void
      {
         var _loc1_:Barrel = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:PoiceData = null;
         var _loc5_:Number = NaN;
         var _loc6_:TextField = null;
         var _loc7_:String = null;
         var _loc8_:LineEffect = null;
         if(this.m_bGameInit == false)
         {
            this.m_scroll = new ScreenScroll(this,this._barrelPos);
            stage.addEventListener(MouseEvent.CLICK,this._clickHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP,this._mouseUp);
            stage.addEventListener(MouseEvent.MOUSE_MOVE,this._mouseMove);
            this.m_bGameInit = true;
            this.m_aBarrel = new Array();
            _loc2_ = this.m_poiceDataMgr.getPoiceData(this.m_seedMgr.getSeedNo());
            _loc3_ = 0;
            while(_loc3_ < 3)
            {
               _loc1_ = new Barrel(_loc2_[_loc3_],this._mouseOver,this._mouseDown,this._mouseUp,this._mouseCursor);
               this.m_FontSettingMgr.change(_loc1_.adhesion_MC,MessageMgr.ID_BARREL_FRIC,false);
               this.m_FontSettingMgr.change(_loc1_.scale_MC,MessageMgr.ID_BARREL_TIME,false);
               if(comDefine.nLanguage == "ja")
               {
                  _loc6_ = _loc1_.adhesion_MC.textMC as TextField;
                  _loc7_ = _loc6_.htmlText;
                  _loc6_.htmlText = _loc7_.replace("\"11\"","\"9\"");
                  ++_loc6_.y;
                  _loc6_ = _loc1_.scale_MC.textMC as TextField;
                  _loc7_ = _loc6_.htmlText;
                  _loc6_.htmlText = _loc7_.replace("\"11\"","\"9\"");
                  ++_loc6_.y;
               }
               this.m_aBarrel.push(_loc1_);
               _loc3_++;
            }
            this.m_cursor = this.scr.poiMc;
            this.m_cursorPos = new Vec2();
            this.m_mainBGM = new mainBGM();
            this.m_mainBGMChannel = null;
            this.m_mainBGMFade = false;
            this.m_mainBGMVolume = 1;
            this.m_sePoiceGet = new SeIceGet();
            this.m_sePoiceGetChannel = null;
            this._initLikePoiceNum(this.m_poiceNumMc.poice1Mc,0);
            this._initLikePoiceNum(this.m_poiceNumMc.poice2Mc,1);
            this._initLikePoiceNum(this.m_poiceNumMc.poice3Mc,2);
            this._barrelPos(null);
            for each(_loc1_ in this.m_aBarrel)
            {
               _loc1_.x = -160;
               _loc1_.setChild(this.scr,this.m_screen.getChildIndex(this.m_screen.mouseMc) + 1);
               _loc1_.moveOut();
            }
            this.m_cursor.stop();
            this.m_aPoice = new Array();
            this.m_aDropPoice = new Array();
            this.m_plate = new Plate();
            this.m_screen.addChild(this.m_plate);
            this.m_plate.setPos(this.m_screen.frontMc.x + this.m_screen.frontMc.width / 2,this.m_screen.frontMc.y - 12);
            this.m_aPoice.push(this.m_plate);
            _loc4_ = this.m_poiceDataMgr.getPoiceData(64)[0];
            this.m_likePoice = new Poice(0,_loc4_.LoadTexture());
            this.m_screenHeight = this.m_screen.y;
            this.m_screenPos = this.m_screen.y;
            this.m_recHeight = LINE_RANGE;
            _loc5_ = this.m_screenHeight - this.m_screen.frontMc.height;
            while(this.m_screen.y + this.m_recHeight < 0)
            {
               _loc8_ = new LineEffect(this.m_hunnyMc,this.m_MituHunny.getMovieClip().topMc.hunnyMc);
               _loc8_.clearLineEnable(this.m_recHeight == LINE_RANGE);
               this.m_screen.addChildAt(_loc8_,this.m_screen.getChildIndex(this.m_screen.PlateMc));
               _loc8_.y = -(this.m_recHeight * 10 + _loc5_) + SCROLL_MARGIN - 10;
               this.m_aLineMc.push(_loc8_);
               this.m_recHeight += LINE_RANGE;
            }
            this._cusorEnable(false);
            this.helpMc.visible = false;
            this.resultMc.visible = false;
            this.ErrorMc.visible = false;
            this.resultMc.textMc.addChild(this.m_result);
            gotoAndStop("help");
         }
         if(this.m_likePoice.isLoad())
         {
            this.m_likePoice.Addition(this.m_PokeLikeSize);
            this.m_likePoice.visible = true;
            this.m_likePoice.y = 2;
            this.m_statusMc.likeMc.addChild(this.m_likePoice);
         }
         if(this.m_tween.isPlaying == false)
         {
            this._startLikeSize();
         }
      }
      
      private function _mouseOver(param1:Barrel, param2:MouseEvent) : void
      {
         this.m_cursor.play();
         if(this.m_guideMode == 0)
         {
            this.m_screen.guideSelectMc.mes01Mc.visible = false;
            this.m_screen.guideSelectMc.mes02Mc.visible = true;
         }
         if(this.m_poice != null)
         {
            if(this.m_useBarrel == param1)
            {
               this.m_useBarrel.moveIn();
            }
            this.md_start = getTimer() - this.md_count;
         }
         else
         {
            if(this.m_useBarrel != null)
            {
               this.m_useBarrel.moveOut();
            }
            this.m_useBarrel = param1;
            param1.moveIn();
         }
      }
      
      private function _exitDialog() : void
      {
         if(this.m_exitDialog.isEnable() == false)
         {
            if(this.m_exitDialog.isExit() == false)
            {
               this.m_mainBGMFade = false;
               this._timerPause(true);
               this._popPhase();
               this.m_helpBtn.enable(true);
               this.m_exitBtn.enable(true);
            }
            else
            {
               gameBridge.result = gameResult.ABORT;
               gameBridge.closeGame();
               this.m_phase = -1;
            }
            this.m_exitDialog.release();
            this.m_exitDialog = null;
         }
      }
      
      private function _helpDialog() : void
      {
         if(this.m_helpDialog.isEnable() == false)
         {
            this._timerPause(true);
            this._popPhase();
            this.m_helpBtn.enable(true);
            this.m_exitBtn.enable(true);
            this.m_helpDialog.release();
            this.m_helpDialog = null;
         }
      }
      
      private function _printPoiceNum() : void
      {
         var _loc2_:Poice = null;
         var _loc1_:int = 0;
         this.m_aPoiceNum[0] = 0;
         this.m_aPoiceNum[1] = 0;
         this.m_aPoiceNum[2] = 0;
         for each(_loc2_ in this.m_aPoice)
         {
            if(_loc2_.getOrgSize() > this.m_PokeLikeSize - LIKE_RANGE && _loc2_.getOrgSize() < this.m_PokeLikeSize + LIKE_RANGE)
            {
               _loc1_++;
            }
            ++this.m_aPoiceNum[_loc2_.type - 1];
         }
         this._setLikePoiceNum();
         this.m_likeNum = _loc1_;
         FontSetting.setText(this.m_statusMc.eat_MC.textMC,_loc1_.toString(),false);
         FontSetting.setText(this.m_statusMc.eatm_MC.textMC,(this.m_aPoice.length - 1).toString(),false);
         if(this.m_aPoice.length > 2)
         {
            FontSetting.setText(this.m_statusMc.numbername_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KOS),false);
         }
         else
         {
            FontSetting.setText(this.m_statusMc.numbername_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KO),false);
         }
      }
      
      private function removedFromStageHandler(param1:Event = null) : void
      {
         var _loc2_:Barrel = null;
         var _loc3_:LineEffect = null;
         removeEventListener(Event.ENTER_FRAME,this._enterFrame);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this.guideCheckMc.removeEventListener(MouseEvent.MOUSE_OVER,this._onGuideMouse);
         this.guideCheckMc.removeEventListener(MouseEvent.MOUSE_OUT,this._onGuideMouse);
         this.mouseClearMc.removeEventListener(MouseEvent.MOUSE_OVER,this._mouseClear);
         this.scr.removeEventListener(MouseEvent.MOUSE_OVER,this._onScreenMouse);
         this.scr.removeEventListener(MouseEvent.MOUSE_OUT,this._offScreenMouse);
         if(this.m_bInit == true)
         {
            gameBridge.removeEventListener(gameBridgeEvent.PAUSE_GAME,this.pauseGameHandler);
            gameBridge.removeEventListener(gameBridgeEvent.RESTART_GAME,this.restartGameHandler);
         }
         if(this.m_bGameInit == true)
         {
            stage.removeEventListener(MouseEvent.CLICK,this._clickHandler);
            stage.removeEventListener(MouseEvent.MOUSE_UP,this._mouseUp);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this._mouseMove);
         }
         if(this.m_exitBtn != null)
         {
            this.m_exitBtn.release();
         }
         if(this.m_helpBtn != null)
         {
            this.m_helpBtn.release();
         }
         this._releaseButton();
         for each(_loc2_ in this.m_aBarrel)
         {
            _loc2_.release();
         }
         for each(_loc3_ in this.m_aLineMc)
         {
            _loc3_.release();
         }
         if(this.m_scroll != null)
         {
            this.m_scroll.release();
         }
         if(this.m_timer != null)
         {
            this.m_timer.release();
         }
         if(this.m_titleDialog != null)
         {
            this.m_titleDialog.release();
         }
         if(this.m_helpDialog != null)
         {
            this.m_helpDialog.release();
         }
         if(this.m_seedMgr != null)
         {
            this.m_seedMgr.release();
         }
         if(this.m_exitDialog != null)
         {
            this.m_exitDialog.release();
         }
         if(this.m_helpDialog != null)
         {
            this.m_helpDialog.release();
         }
         if(this.m_errorDialog != null)
         {
            this.m_errorDialog.release();
         }
         this.m_FontSettingMgr.release();
         Mouse.cursor = MouseCursor.AUTO;
         comDefine.mouseEnable(true);
      }
      
      private function _setLikePoiceNum() : *
      {
         FontSetting.setText(this.m_poiceNumMc.poice1Mc.numMc.textMC,String(this.m_aPoiceNum[0]),false);
         if(this.m_aPoiceNum[0] > 1)
         {
            FontSetting.setText(this.m_poiceNumMc.numbername3_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KOS),false);
         }
         else
         {
            FontSetting.setText(this.m_poiceNumMc.numbername3_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KO),false);
         }
         FontSetting.setText(this.m_poiceNumMc.poice2Mc.numMc.textMC,String(this.m_aPoiceNum[1]),false);
         if(this.m_aPoiceNum[1] > 1)
         {
            FontSetting.setText(this.m_poiceNumMc.numbername4_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KOS),false);
         }
         else
         {
            FontSetting.setText(this.m_poiceNumMc.numbername4_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KO),false);
         }
         FontSetting.setText(this.m_poiceNumMc.poice3Mc.numMc.textMC,String(this.m_aPoiceNum[2]),false);
         if(this.m_aPoiceNum[2] > 1)
         {
            FontSetting.setText(this.m_poiceNumMc.numbername5_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KOS),false);
         }
         else
         {
            FontSetting.setText(this.m_poiceNumMc.numbername5_MC.textMC,MessageMgr.getInstance().getMessage(MessageMgr.ID_NUM_KO),false);
         }
      }
      
      private function _scrollUp() : void
      {
         if(this.m_scroll.isScroll() == false)
         {
            this._startResult();
         }
      }
      
      private function _getPhaseStack() : int
      {
         return this.m_phaseBack[this.m_phaseBack.length - 1];
      }
      
      private function _resultIn() : void
      {
         if(this.m_result.isOpen() == true)
         {
            if(this.m_heightMeter.getHeight() >= 20)
            {
               this.m_seResult = new SeResult();
               this.m_seResult.play(0,1);
            }
            this.m_phase = phaseResult;
         }
      }
      
      private function _run() : void
      {
         this._collisionCheck();
         this._collisionCheck();
         this._dropMove();
         this._dropMove();
         this._deleteCheck();
         this._screenMove();
         this._barrelCheck();
         this._setCursorPos();
      }
      
      private function _offGuideMouse(param1:MouseEvent) : void
      {
         this._offScreenMouse(param1);
         if(this.m_guideMode == 0)
         {
            this.m_screen.guideDropMc.visible = false;
            this.m_screen.guideMoveMc.visible = true;
         }
      }
      
      private function _fadeIn() : void
      {
         this.m_count -= 5;
         this.loadMc.alpha = this.m_count / 100;
         if(this.m_count == 0)
         {
            this.loadMc.visible = false;
            this._openTitleDialog(phaseTitle);
         }
      }
      
      private function _openHelpDialog(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         if(this.m_exitDialog != null || this.m_helpDialog != null || this.m_errorDialog != null)
         {
            return;
         }
         this.m_helpDialog = new DialogBase(this.helpMc,this.dialogBackMc);
         this.m_phase = param1;
         this._pushPhase(phaseHelpDialog);
         comDefine.loadExchange(this.helpMc.playimage_MC);
         this.m_FontSettingMgr.change(this.helpMc.playex_MC.titleMC,MessageMgr.ID_HELP_TITLE,false);
         this.m_FontSettingMgr.change(this.helpMc.playex_MC.help0MC,MessageMgr.ID_HELP_MES0,false);
         _loc2_ = comDefine.getTextMc(this.helpMc.playex_MC.help2MC);
         this.m_FontSettingMgr.change(_loc2_,MessageMgr.ID_HELP_MES2,false);
         this.m_FontSettingMgr.change(this.helpMc.playex_MC.help3MC,MessageMgr.ID_HELP_MES3,false);
         this.m_FontSettingMgr.change(this.helpMc.playex_MC.help4MC,MessageMgr.ID_HELP_MES4,false);
         this.m_FontSettingMgr.change(this.helpMc.playex_MC.help5MC,MessageMgr.ID_HELP_MES5,false);
         this.m_FontSettingMgr.change(this.helpMc.playex_MC.help6MC,MessageMgr.ID_HELP_MES6,false);
         this.m_FontSettingMgr.change(this.helpMc.okMc.okbtnfont_MC,MessageMgr.ID_RETURN,false);
         this._timerPause(false);
         this.m_helpBtn.enable(false);
         this.m_exitBtn.enable(false);
      }
      
      private function _screenMove() : void
      {
         var _loc6_:Poice = null;
         var _loc7_:LineEffect = null;
         var _loc1_:Number = this.m_screenHeight;
         var _loc2_:Number = this.m_screenHeight - this.m_screen.frontMc.height;
         var _loc3_:Number = 0;
         var _loc4_:Boolean = false;
         var _loc5_:Number = _loc2_;
         for each(_loc6_ in this.m_aPoice)
         {
            if(_loc6_.isSolid() == true)
            {
               if(_loc6_.y - _loc6_.size - SCROLL_MARGIN < -_loc1_)
               {
                  _loc1_ = -(_loc6_.y - _loc6_.size - SCROLL_MARGIN);
               }
               if(-_loc6_.y + _loc6_.size - _loc2_ + SCROLL_MARGIN > _loc3_)
               {
                  _loc3_ = -_loc6_.y + _loc6_.size - _loc2_ + SCROLL_MARGIN;
                  _loc4_ = true;
               }
            }
         }
         if(_loc1_ > this.m_screenHeight)
         {
            this.m_scroll.Scroll(_loc1_);
            this.m_screenPos = _loc1_;
         }
         if(_loc4_ == true)
         {
            this.m_heightMeter.setHeight(_loc3_ / 10);
         }
         this.m_heightMeter.print(this.m_statusMc.heightMc);
         if(this.m_heightMeter.getNow() >= this.m_recHeight)
         {
            _loc1_ = -(this.m_recHeight * 10 + _loc2_) + SCROLL_MARGIN - 10;
            this.m_recPos = _loc1_;
            _loc7_ = this.m_aLineMc[Math.floor(this.m_recHeight / LINE_RANGE) - 1];
            _loc7_.startMove(_loc1_,this.m_recHeight);
            this.m_recHeight += LINE_RANGE;
         }
         else if(this.m_heightMeter.getNow() < this.m_recHeight - LINE_RANGE && this.m_aLineMc.length > 0)
         {
            this.m_recHeight -= LINE_RANGE;
            _loc7_ = this.m_aLineMc[Math.floor(this.m_recHeight / LINE_RANGE) - 1];
            _loc7_.remove();
         }
      }
   }
}

