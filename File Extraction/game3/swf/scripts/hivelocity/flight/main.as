package hivelocity.flight
{
   import as3.hivelocity.flight.events.flightEvent;
   import as3.hivelocity.flight.events.mainBtnEvent;
   import as3.hivelocity.flight.utility.fpsMeasurement;
   import bfp.*;
   import bfp.common.FontManager;
   import bfp.common.PokemonBridge;
   import bfp.common.pokemonLoader;
   import bfp.tpc.pdw.loading.PDWLoading;
   import caurina.transitions.Tweener;
   import common.*;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import hivelocity.flight.object.distanceLine;
   import hivelocity.flight.object.objcloud;
   import hivelocity.flight.object.objectMap;
   import hivelocity.flight.object.objenergy;
   import hivelocity.flight.popup.failBord;
   import hivelocity.flight.popup.gameBack;
   import hivelocity.flight.popup.scoreBoard;
   import hivelocity.flight.sound.soundController;
   import hivelocity.flight.status.energyBox;
   import hivelocity.flight.status.flightMeter;
   import hivelocity.flight.status.flightTimer;
   import hivelocity.flight.status.scoreBox;
   import hivelocity.flight.status.speedGauge;
   
   public class main extends MovieClip
   {
      
      internal static const BASE_SPEED:Number = 4;
      
      internal static const GAME_START_SPEED:Number = 0;
      
      internal static const GAME_ADJUST_SPEED_MAX:Number = 7;
      
      internal static const GAME_ADJUST_SPEED_MIN:Number = 1;
      
      internal static const STAGE_WIDTH:uint = 1003;
      
      internal static const STAGE_HEIGHT:uint = 505;
      
      internal static const LAYER_CHARA:uint = 1;
      
      internal static const LAYER_CLOUD:uint = 2;
      
      internal static const LAYER_BG:uint = 3;
      
      internal static const LAYER_ITEM:uint = 4;
      
      internal static const LAYER_DISTANCE:uint = 5;
      
      internal static const GAME_MAX_METER:uint = 1000;
      
      internal static const GAME_STAGE_WIDTH:uint = 31500;
      
      internal static const GAME_STAGE_HEIGHT:uint = 480;
      
      internal static const GAME_SPLIT_CLOUD_COLUMN:uint = 140;
      
      internal static const GAME_SPLIT_CLOUD_ROW:uint = 120;
      
      internal static const GAME_SPLIT_ENERGY_COLUMN:uint = 140;
      
      internal static const GAME_SPLIT_ENERGY_ROW:uint = 120;
      
      internal static const CLOUD_BASE_SPEED:Number = 2;
      
      internal static const CLOUD_VISIBLE_P:Number = 0.4;
      
      internal static const CLOUD_PATTEM:uint = 4;
      
      internal static const ENERGY_BASE_SPEED:Number = 2;
      
      internal static const ENERGY_VISIBLE_P:Number = 0.5;
      
      internal static const ENERGY_PATTEM:uint = 4;
      
      internal static const ENERGY_SPEED_DOWN:Number = 1;
      
      internal static const ENERGY_BASE_POINT:uint = 300;
      
      internal static const BACKGROUND_AJUST:Number = 0.7;
      
      internal static const ENERGY_TYPE_LEAF:uint = 1;
      
      internal static const ENERGY_TYPE_FIRE:uint = 2;
      
      internal static const ENERGY_TYPE_WATER:uint = 3;
      
      internal static const ENERGY_TYPE_THUNDER:uint = 4;
      
      internal static const OPENING_MOVE:uint = 120;
      
      internal static const SPEED_UP:String = "up";
      
      internal static const SPEED_DOWN:String = "down";
      
      internal static const GAME_TIME:uint = 120;
      
      internal static const SMALL_SIZE:uint = 54;
      
      internal static const MIDDLE_SIZE:uint = 134;
      
      internal static const LARGE_SIZE:uint = 182;
      
      internal static const AOUT_UP_SPEED:Number = 0.003;
      
      public var goal_blink:MovieClip;
      
      public var topTitle:flightTitle;
      
      public var poseIcon_mc:MovieClip;
      
      public var pokemon_me_mc:MovieClip;
      
      public var underBar_mc:MovieClip;
      
      public var failBord:hivelocity.flight.popup.failBord;
      
      public var btnGameBack_mc:mbackBtn;
      
      public var gameBack_mc:gameBack;
      
      public var meter_mc:flightMeter;
      
      public var item:MovieClip;
      
      public var mapEnergyArrTxt:TextField;
      
      public var pause_mc:pause;
      
      public var header_mc:MovieClip;
      
      public var chara:MovieClip;
      
      public var scoreBox:hivelocity.flight.status.scoreBox;
      
      public var flag_mc:flagCursor_mc;
      
      public var scoreBoard:hivelocity.flight.popup.scoreBoard;
      
      public var distance:MovieClip;
      
      public var goal_2_mc:MovieClip;
      
      public var bg:MovieClip;
      
      public var enePointText:TextField;
      
      public var btnGameHint_mc:gameHint;
      
      public var count_mc:MovieClip;
      
      public var pokemon_enemy_mc:MovieClip;
      
      public var flightTimer:hivelocity.flight.status.flightTimer;
      
      public var energyBox:hivelocity.flight.status.energyBox;
      
      public var speed:MovieClip;
      
      public var goal_1_mc:MovieClip;
      
      public var speedGauge:hivelocity.flight.status.speedGauge;
      
      public var cloud:MovieClip;
      
      public var addLayerSpeedup:MovieClip;
      
      public var mapCloudArrTxt:TextField;
      
      public var mapArrTxt:TextField;
      
      private var _traceFlg:Boolean;
      
      private var _flightGameFlg:Boolean;
      
      private var _character:character;
      
      private var _background:background;
      
      private var _cloud:objcloud;
      
      private var _energy:objenergy;
      
      private var _cloudPositionArr:Array;
      
      private var _cloudSplitNum:int;
      
      private var _hitCloudNum:int;
      
      private var _hitCloudFlg:Boolean;
      
      private var _cloudDownSpeed:Number;
      
      private var _cloudResetSpeed:Number;
      
      private var _hitCloudObj:Object;
      
      private var _energyPositionArr:Array;
      
      private var _energySplitNum:int;
      
      private var _hitEnergyNum:int;
      
      private var _hitEnergyFlg:Boolean;
      
      private var _comboNum:int;
      
      private var _energyBasePoint:uint;
      
      private var _addScoreIcon:addScoreIcon;
      
      private var _addSpeedIcon:addSpeedIcon;
      
      private var loading_wait:Number;
      
      private var _loading_wait:Number = 0;
      
      private var _loading:PDWLoading;
      
      private var _islocked:Boolean;
      
      private var _retryFlg:Boolean;
      
      private var _gameAdjustSpeed:Number;
      
      private var _loadingFlg:Boolean;
      
      private var _pauseWinOpenFlg:Boolean = false;
      
      private var _headerArr:Array;
      
      private var _fooderArr:Array;
      
      private var _gameOverFlg:Boolean;
      
      private var _gamePokemonID:uint;
      
      private var _myPokemonID:uint;
      
      private var _encountPokemonID:uint;
      
      private var _goalPokemonID:uint;
      
      private var _myPokemonName:String = "";
      
      private var _encountPokemonName:String = "";
      
      private var _goalPokemonName:String;
      
      private var _gamePokemon:pokemonLoader;
      
      private var _myPokemon:pokemonLoader;
      
      private var _encountPokemon:pokemonLoader;
      
      private var _goalPokemon:pokemonLoader;
      
      private var _myformID:Number;
      
      private var _encountformID:Number;
      
      private var _objMap:objectMap;
      
      private var _gameStartFlg:Boolean;
      
      private var _speedMaxFlg:Boolean = false;
      
      private var _goalFlg:Boolean = false;
      
      private var _countFlg:Boolean = false;
      
      private var _countDownFlg:Boolean = true;
      
      private var _openingFlg:Boolean = false;
      
      private var _closeWinOpenFlg:Boolean = false;
      
      private var _mainPauseWinOpen:Boolean = false;
      
      private var _timeup:timeup;
      
      private var _goalText:goal;
      
      private var _speedup:speedup;
      
      private var _distanceLine_200:distanceLine;
      
      private var _distanceLine_400:distanceLine;
      
      private var _distanceLine_600:distanceLine;
      
      private var _distanceLine_800:distanceLine;
      
      private var _distanceFlg_200:Boolean;
      
      private var _distanceFlg_400:Boolean;
      
      private var _distanceFlg_600:Boolean;
      
      private var _distanceFlg_800:Boolean;
      
      private var _fps:fpsMeasurement;
      
      private var _rooturl:String = "";
      
      private var _baseurl:String = "";
      
      private var _debugMode:Boolean = false;
      
      private var _connectTest:Boolean = false;
      
      private var _soundController:soundController;
      
      private var _brigdePauseFlg:Boolean = false;
      
      public var _langCode:String;
      
      public function main()
      {
         super();
         addFrameScript(0,this.frame1,5,this.frame6);
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         this._traceFlg = true;
         this._islocked = false;
         this._loadingFlg = false;
         this._gameOverFlg = false;
         this._gameStartFlg = false;
         if(!this._debugMode)
         {
            this.getPokemonId();
         }
         if(this._connectTest)
         {
            FontManager.standalone("./font.swf");
         }
         this._langCode = gameBridge.langCode;
         if(this._langCode == null)
         {
            this._langCode = "ja";
         }
      }
      
      public function moveLangFrame(param1:MovieClip) : void
      {
         if(this._langCode != null)
         {
            param1.gotoAndStop("_" + this._langCode);
         }
         else
         {
            param1.gotoAndStop("_ko");
         }
      }
      
      public function get getCharaPosition() : Point
      {
         var _loc1_:Point = new Point();
         return this._character.getCharaPosition;
      }
      
      private function rootUrl(param1:*, param2:*) : *
      {
         var _loc3_:* = param1.split("/");
         var _loc4_:* = _loc3_.length - param2;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         _loc3_.splice(_loc4_);
         return _loc3_.join("/");
      }
      
      private function addedToStageHandler(param1:Event = null) : void
      {
         this._rooturl = this.rootUrl(this.loaderInfo.url,4);
         stage.stageFocusRect = false;
         this.addEventListener(flightEvent.WAIT_FRAME,this.__init,false,0,true);
      }
      
      private function loadingMain(param1:flightEvent = null) : void
      {
         this._loading = new AssetPDWLoading();
         addChild(this._loading);
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler,false,0,true);
      }
      
      private function loadingAnimeComp(param1:flightEvent) : void
      {
         this._loadingFlg = true;
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         var _loc2_:* = root.loaderInfo.bytesLoaded;
         var _loc3_:* = root.loaderInfo.bytesTotal;
         var _loc4_:* = _loc2_ / _loc3_ * 100;
         this._loading_wait += 2;
         if(_loc4_ <= this._loading_wait)
         {
            this._loading.percentage = _loc4_;
            if(_loc2_ >= _loc3_)
            {
               removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
               this.gamePause();
               this.loadingBarFadeOut();
            }
         }
         else
         {
            this._loading.percentage = this._loading_wait;
         }
      }
      
      private function loadingBarFadeOut(param1:Boolean = false) : void
      {
         var _loc2_:Number = 0.7;
         var _loc3_:String = "easeInBack";
         var _loc4_:Function = this.loadingBarFadeOut;
         var _loc5_:MovieClip = this;
         if(!param1)
         {
            Tweener.addTween(_loc5_,{
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this._loading.away();
            this.topTitle.titleOpen();
         }
      }
      
      private function getPokemonId() : void
      {
         if(this._connectTest)
         {
            this._gamePokemonID = 279;
            this._myPokemonID = 25;
            this._encountPokemonID = 255;
            this._goalPokemonID = 270;
            this._encountPokemonName = "アチャモ";
            this._myformID = 1;
            this._encountformID = 1;
         }
         else
         {
            this._myPokemonID = gameBridge.myPokemonId;
            this._encountPokemonID = gameBridge.encountPokemonId;
            this._goalPokemonID = 270;
            this._encountPokemonName = gameBridge.encountPokemonName;
            this._myformID = gameBridge.myFormId;
            this._encountformID = gameBridge.encountFormId;
            if(this._encountPokemonName == null)
            {
               this._encountPokemonName = "";
            }
         }
      }
      
      private function loadPokemonSwf() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(!this._debugMode)
         {
            _loc2_ = PokemonBridge.createRenderer();
            _loc1_ = SMALL_SIZE;
            if(_loc2_)
            {
               _loc2_.loadToArea(this._myPokemonID,this._myformID,_loc1_,_loc1_);
               this["pokemon_me_mc"]["myPokemon_mc"].addChild(_loc2_.display);
               _loc2_.shadowOpacity = 0;
               _loc2_.display.x -= _loc1_ / 2;
               _loc2_.display.y -= _loc1_ / 2;
            }
            _loc3_ = PokemonBridge.createRenderer();
            _loc1_ = SMALL_SIZE;
            if(_loc3_)
            {
               _loc3_.loadToArea(this._encountPokemonID,this._encountformID,_loc1_,_loc1_);
               this["pokemon_enemy_mc"]["encountPokemon_mc"].addChild(_loc3_.display);
               _loc3_.shadowOpacity = 0;
               _loc3_.display.x -= _loc1_ / 2;
               _loc3_.display.y -= _loc1_ / 2;
            }
         }
      }
      
      internal function pokeStateLoadCompleteHandler(param1:Event) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.pokeStateLoadCompleteHandler);
      }
      
      private function fontset() : void
      {
         switch(this._langCode)
         {
            case "ja":
               FontManager.lang_code = FontManager.LANG_CODE_JA;
               this._myPokemonName = "キミ";
               break;
            case "ko":
               FontManager.lang_code = FontManager.LANG_CODE_KO;
               this._myPokemonName = "너";
               break;
            case "de":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._myPokemonName = "Du";
               break;
            case "en":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._myPokemonName = "You";
               break;
            case "es":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._myPokemonName = "Tú";
               break;
            case "fr":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._myPokemonName = "VOUS";
               break;
            case "it":
               FontManager.lang_code = FontManager.LANG_CODE_EN;
               this._myPokemonName = "Tu";
               break;
            default:
               FontManager.lang_code = FontManager.LANG_CODE_JA;
               this._myPokemonName = "キミ";
         }
         if(this._langCode != null)
         {
            try
            {
               FontManager.setAutoFontText(this.pokemon_me_mc.pokemon_name,this._myPokemonName,true);
               FontManager.setAutoFontText(this.pokemon_enemy_mc.encountPokemonName,this._encountPokemonName,true);
            }
            catch($e:Error)
            {
            }
         }
      }
      
      private function getPokemonImage(param1:int) : void
      {
         var _loc2_:* = PokemonBridge.createRenderer();
         if(_loc2_)
         {
            _loc2_.loadToArea(this._gamePokemonID,param1,150,150);
            addChild(_loc2_.display);
            _loc2_.shadowOpacity = 0;
            _loc2_.display.x = 200 * (param1 + 1);
            _loc2_.display.y = 200 * (param1 + 1);
         }
      }
      
      private function tracer(param1:*) : void
      {
         if(this._traceFlg)
         {
         }
      }
      
      private function __init(param1:flightEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         this.fontset();
         this.loadPokemonSwf();
         this._objMap = new objectMap();
         this._gameOverFlg = false;
         this.removeEventListener(flightEvent.WAIT_FRAME,this.__init);
         this._gameAdjustSpeed = (BASE_SPEED + (BASE_SPEED * GAME_ADJUST_SPEED_MAX - BASE_SPEED * GAME_ADJUST_SPEED_MIN) * GAME_START_SPEED) / BASE_SPEED;
         this._flightGameFlg = true;
         stage.focus = this;
         stage.stageFocusRect = false;
         this.addEventListener(KeyboardEvent.KEY_UP,this.gamePauseWinOpen,false,0,true);
         this.speedGauge.setGaugeMax = BASE_SPEED * GAME_ADJUST_SPEED_MAX;
         this.speedGauge.setGaugeMin = BASE_SPEED * GAME_ADJUST_SPEED_MIN;
         this._background = new background();
         this._background.setTraceFlg = this._traceFlg;
         this._background.setBgBaseSpeed = BASE_SPEED * BACKGROUND_AJUST;
         this._background.addEventListener(flightEvent.BG_MOVE,this.setFlightGauge,false,0,true);
         this._background.addEventListener(flightEvent.GAME_OPENING_BG,this.gameStartAnime,false,0,true);
         this.stageSetObject(this._background,LAYER_BG);
         this._character = new character();
         this._character.setTraceFlg = this._traceFlg;
         this._character.stageW = STAGE_WIDTH;
         this._character.stageH = STAGE_HEIGHT;
         this._character.addEventListener(flightEvent.CHARA_MOVE,this.charaHitTest,false,0,true);
         this.stageSetObject(this._character,LAYER_CHARA);
         this._character.setSpeedIconLayer = this["speed"];
         this._hitCloudNum = -1;
         this._hitCloudFlg = false;
         this._cloud = new objcloud();
         this._cloudSplitNum = 0;
         this._cloud.setTraceFlg = this._traceFlg;
         this._cloud.setSplitColumn = GAME_SPLIT_CLOUD_COLUMN;
         this._cloud.setSplitRow = GAME_SPLIT_CLOUD_ROW;
         this._cloud.setPattam = CLOUD_PATTEM;
         this._cloud.setCloudVisibleArea = STAGE_WIDTH;
         this._cloud.addEventListener(flightEvent.CLOUD_CHANGE,this.setCloud,false,0,true);
         this.stageSetObject(this._cloud,LAYER_CLOUD);
         this._cloudPositionArr = [];
         this._cloudPositionArr = this._objMap.getCloudMapArr;
         this.setCloud();
         this._comboNum = 0;
         this._hitEnergyNum = -1;
         this._hitEnergyFlg = false;
         this._energy = new objenergy();
         this._energySplitNum = 0;
         this._energy.setTraceFlg = this._traceFlg;
         this._energy.setSplitColumn = GAME_SPLIT_ENERGY_COLUMN;
         this._energy.setSplitRow = GAME_SPLIT_ENERGY_ROW;
         this._energy.setPattam = ENERGY_PATTEM;
         this._energy.setEnergyVisibleArea = STAGE_WIDTH;
         this._energy.addEventListener(flightEvent.ENERGY_CHANGE,this.setEnergy,false,0,true);
         this.stageSetObject(this._energy,LAYER_ITEM);
         this._energyPositionArr = [];
         this._energyPositionArr = this._objMap.getEnergyMapArr;
         this.setEnergy();
         this.loadingMain();
         this.topTitle.addEventListener(flightEvent.GAME_TITLE_CLOSE,this.gameStartOpening,false,0,true);
         this.topTitle.addEventListener(flightEvent.GAME_START_CLICK,this.gameStartClick,false,0,true);
         this.topTitle.setLangCode = this._langCode;
         this.flightTimer.addEventListener(flightEvent.GAME_TIME_UP,this.gameOver,false,0,true);
         this.flightTimer.setGameTime = GAME_TIME;
         this.flightTimer.setLangCode = this._langCode;
         this.scoreBoard.addEventListener(flightEvent.GAME_RETRY,this.retryGame,false,0,true);
         this.scoreBoard.addEventListener(flightEvent.GAME_FINISH,this.finishGame,false,0,true);
         this.scoreBoard.setLangCode = this._langCode;
         this.failBord.addEventListener(flightEvent.GAME_FINISH,this.finishGame,false,0,true);
         this.energyBox.addEventListener(flightEvent.ENERGY_COMBO,this.setEnergyCombo,false,0,true);
         this.pause_mc.addEventListener(flightEvent.PAUSE_CANCEL,this.gameStart,false,0,true);
         this.count_mc.addEventListener(flightEvent.COUNT_FINISH,this.gameStart,false,0,true);
         this.btnGameBack_mc.addEventListener(mainBtnEvent.BTN_GAME_BACK,this.gameBackWinOpen,false,0,true);
         this.btnGameHint_mc.addEventListener(mainBtnEvent.BTN_GAME_PAUSE,this.__gameHint,false,0,true);
         this.gameBack_mc.addEventListener(flightEvent.GAME_BACK_CANCEL,this.gameBackCancel,false,0,true);
         this.gameBack_mc.addEventListener(flightEvent.GAME_BACK_OK,this.gameClose,false,0,true);
         this.gameBack_mc.setLangCode = this._langCode;
         this.goal_1_mc.visible = false;
         this.goal_2_mc.visible = false;
         this.pause_mc.visible = false;
         this.gameBack_mc.visible = false;
         this.btnGameHint_mc.isLocked = false;
         this.meter_mc.setMeterMax = GAME_MAX_METER;
         this.meter_mc.setGameWidthMax = GAME_STAGE_WIDTH;
         this._distanceFlg_200 = false;
         this._distanceFlg_400 = false;
         this._distanceFlg_600 = false;
         this._distanceFlg_800 = false;
         if(this._retryFlg)
         {
            this.countStart();
         }
         else
         {
            this._headerArr = [];
            this._headerArr.push(this.flightTimer);
            this._headerArr.push(this.scoreBox);
            this._headerArr.push(this.header_mc);
            this._headerArr.push(this.poseIcon_mc);
            _loc2_ = 0;
            while(_loc2_ < this._headerArr.length)
            {
               this._headerArr[_loc2_].alpha = 0;
               this._headerArr[_loc2_].y -= OPENING_MOVE;
               _loc2_++;
            }
            this._fooderArr = [];
            this._fooderArr.push(this.speedGauge);
            this._fooderArr.push(this.energyBox);
            this._fooderArr.push(this.underBar_mc);
            this._fooderArr.push(this.pokemon_me_mc);
            this._fooderArr.push(this.pokemon_enemy_mc);
            this._fooderArr.push(this.meter_mc);
            _loc3_ = 0;
            while(_loc3_ < this._fooderArr.length)
            {
               this._fooderArr[_loc3_].alpha = 0;
               this._fooderArr[_loc3_].y += OPENING_MOVE;
               _loc3_++;
            }
            this.underBar_mc.alpha = 0;
         }
         if(this._debugMode)
         {
            this._encountPokemonName = "";
         }
         if(!this._debugMode && this._encountPokemonName != null || this._encountPokemonName != "")
         {
            FontManager.setAutoFontText(this["pokemon_enemy_mc"]["encountPokemonName"],this._encountPokemonName,false);
         }
         this._fps = new fpsMeasurement();
         addChild(this._fps);
         this._fps.measurement();
         gameBridge.addEventListener(gameBridgeEvent.PAUSE_GAME,this.pauseGameHandler,false,0,true);
         gameBridge.addEventListener(gameBridgeEvent.RESTART_GAME,this.restartGameHandler,false,0,true);
         this.setSpeed();
         this._soundController = new soundController();
         if(gameBridge.pauseFlag)
         {
            this._soundController.playSilentBGM("opening",0);
         }
         else
         {
            this._soundController.playBGM("opening",0);
            this._soundController.bgmFadeIn(1000);
         }
         if(this._debugMode)
         {
            _loc4_ = this._objMap.getShuffleResultArr;
            this["mapArrTxt"].text = "シャッフル後の配列 [" + String(_loc4_) + "]";
         }
      }
      
      private function stageSetObject(param1:*, param2:uint) : void
      {
         var _loc3_:MovieClip = null;
         switch(param2)
         {
            case LAYER_CHARA:
               _loc3_ = this["chara"];
               break;
            case LAYER_CLOUD:
               _loc3_ = this["cloud"];
               break;
            case LAYER_ITEM:
               _loc3_ = this["item"];
               break;
            case LAYER_BG:
               _loc3_ = this["bg"];
               break;
            case LAYER_DISTANCE:
               _loc3_ = this["distance"];
         }
         _loc3_.addChild(param1 as MovieClip);
      }
      
      private function charaHitTest(param1:flightEvent = null) : void
      {
         var _loc5_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Point = new Point();
         _loc4_ = this._character.getCharaPosition;
         _loc2_ = this._cloud.getCloudObjArr;
         _loc3_ = this._energy.getEnergyObjArr;
         var _loc6_:Object = this._character.getHitAreaMc;
         _loc5_ = false;
         var _loc7_:int = 0;
         while(_loc7_ < _loc2_.length)
         {
            if(_loc2_[_loc7_].obj != null)
            {
               if(_loc6_.hitTestObject(_loc2_[_loc7_].obj.cloudHitArea))
               {
                  if(this._hitCloudNum != _loc7_ && this._hitCloudObj == null)
                  {
                     this._hitCloudObj = {};
                     this._hitCloudObj = _loc2_[_loc7_];
                     this._hitCloudObj.hitFlg = true;
                     this._cloudDownSpeed = this._gameAdjustSpeed - this._gameAdjustSpeed * 0.4;
                     this._cloudResetSpeed = this._gameAdjustSpeed;
                     this.setSpeedCloud(this._cloudDownSpeed,true);
                     this._character.setActionAddCloud();
                  }
                  this._hitCloudNum = _loc7_;
                  this._hitCloudFlg = true;
                  _loc5_ = true;
               }
            }
            _loc7_++;
         }
         if(this._hitCloudFlg == false && _loc5_ == false)
         {
            if(this._gameAdjustSpeed <= Math.round(GAME_ADJUST_SPEED_MAX / 5 * 3) + 0.55)
            {
               this._gameAdjustSpeed += AOUT_UP_SPEED;
            }
         }
         else
         {
            this._gameAdjustSpeed -= AOUT_UP_SPEED * 6;
         }
         this.setSpeed();
         if(this._hitCloudFlg == true && _loc5_ == false)
         {
            this._hitCloudFlg = false;
            this._hitCloudNum = -1;
            this._hitCloudObj.hitFlg = false;
            this._hitCloudObj = null;
            this.setSpeedCloud(this._cloudResetSpeed,false);
            this._character.removeActionCloud();
            _loc8_ = 0;
            while(_loc8_ < _loc2_.length)
            {
               if(_loc2_[_loc8_].obj != null)
               {
                  _loc2_[_loc8_].obj.kumo.gotoAndPlay(1);
               }
               _loc8_++;
            }
         }
         if(!this._character.getThunderHitFlg)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc3_.length)
            {
               if(_loc3_[_loc9_].obj != null)
               {
                  if(Boolean(_loc6_.hitTestObject(_loc3_[_loc9_].obj.energyHitArea_mc)) && (Boolean(_loc3_[_loc9_].flg) && Boolean(!_loc3_[_loc9_].getFlg)))
                  {
                     if(this._hitEnergyNum != _loc9_)
                     {
                        this.setEnergyPoint(_loc3_[_loc9_].type);
                        this._energy.eneGetAction(_loc9_,_loc3_[_loc9_].type);
                     }
                  }
               }
               _loc9_++;
            }
         }
      }
      
      private function setSpeed() : void
      {
         if(GAME_ADJUST_SPEED_MIN > this._gameAdjustSpeed)
         {
            this._gameAdjustSpeed = GAME_ADJUST_SPEED_MIN;
         }
         if(GAME_ADJUST_SPEED_MAX < this._gameAdjustSpeed)
         {
            this._gameAdjustSpeed = GAME_ADJUST_SPEED_MAX;
         }
         this._background.setBgSpeed = BASE_SPEED * this._gameAdjustSpeed;
         this._cloud.setCloudSpeed = CLOUD_BASE_SPEED * this._gameAdjustSpeed;
         this._energy.setEnergySpeed = ENERGY_BASE_SPEED * this._gameAdjustSpeed;
         this.speedGauge.setSpeed = BASE_SPEED * this._gameAdjustSpeed;
         this._character.setSpeed = BASE_SPEED * this._gameAdjustSpeed;
         if(this._distanceFlg_200)
         {
            this._distanceLine_200.setSpeed = CLOUD_BASE_SPEED * this._gameAdjustSpeed;
         }
         if(this._distanceFlg_400)
         {
            this._distanceLine_400.setSpeed = CLOUD_BASE_SPEED * this._gameAdjustSpeed;
         }
         if(this._distanceFlg_600)
         {
            this._distanceLine_600.setSpeed = CLOUD_BASE_SPEED * this._gameAdjustSpeed;
         }
         if(this._distanceFlg_800)
         {
            this._distanceLine_800.setSpeed = CLOUD_BASE_SPEED * this._gameAdjustSpeed;
         }
         this.setCharaSpeed();
         if(this._gameAdjustSpeed >= GAME_ADJUST_SPEED_MAX)
         {
            if(!this._speedMaxFlg)
            {
               this._speedMaxFlg = true;
               this.speedGauge.max_blink.gotoAndPlay("loop");
            }
         }
         else
         {
            this._speedMaxFlg = false;
            this.speedGauge.max_blink.gotoAndStop(1);
         }
      }
      
      private function setSpeedCloud(param1:Number, param2:Boolean) : void
      {
         this._background.setBgSpeed = BASE_SPEED * param1;
         this._energy.setEnergySpeed = ENERGY_BASE_SPEED * param1;
         this._cloud.setCloudSpeed = CLOUD_BASE_SPEED * param1;
         this._character.setSpeed = BASE_SPEED * param1;
         if(this._distanceFlg_200)
         {
            this._distanceLine_200.setSpeed = CLOUD_BASE_SPEED * param1;
         }
         if(this._distanceFlg_400)
         {
            this._distanceLine_400.setSpeed = CLOUD_BASE_SPEED * param1;
         }
         if(this._distanceFlg_600)
         {
            this._distanceLine_600.setSpeed = CLOUD_BASE_SPEED * param1;
         }
         if(this._distanceFlg_800)
         {
            this._distanceLine_800.setSpeed = CLOUD_BASE_SPEED * param1;
         }
         this.setCharaSpeed();
      }
      
      private function setCharaSpeed() : void
      {
         var _loc1_:Number = BASE_SPEED * this._gameAdjustSpeed / (BASE_SPEED * GAME_ADJUST_SPEED_MAX) * 100;
         var _loc2_:uint = 50;
         var _loc3_:uint = 80;
         if(_loc1_ >= _loc2_ && _loc1_ <= _loc3_)
         {
            this._character.setCharaSpeed(1);
         }
         else if(_loc1_ > _loc3_)
         {
            this._character.setCharaSpeed(2);
         }
         else
         {
            this._character.removeCharaSpeed();
         }
      }
      
      private function setEnergyPoint(param1:uint) : void
      {
         var _loc2_:Point = new Point();
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         this.energyBox.setEnergy = param1;
         if(param1 != ENERGY_TYPE_THUNDER)
         {
            this._soundController.playSound("coinGet");
            _loc3_ = this._energyBasePoint;
            if(this._gameAdjustSpeed >= GAME_ADJUST_SPEED_MAX)
            {
               _loc3_ *= 1.5;
               _loc4_ = true;
            }
            this.scoreBox.setGamePoint = _loc3_;
            _loc2_ = this._character.getCharaPosition;
            this._addScoreIcon = new addScoreIcon();
            this.addChild(this._addScoreIcon);
            this._addScoreIcon.setAddScore(_loc2_.x + this._character.getHitAreaMc.width / 2,_loc2_.y,BASE_SPEED * this._gameAdjustSpeed,_loc4_,1);
            this._addScoreIcon.addEventListener(flightEvent.ADD_SCORE_REMOVE,this.addScoreIconRemove,false,0,true);
         }
         else
         {
            if(this._gameAdjustSpeed >= ENERGY_SPEED_DOWN)
            {
               this._gameAdjustSpeed -= ENERGY_SPEED_DOWN;
               this.setSpeed();
            }
            this._soundController.playSound("speedDown");
            this._character.setActionAddSpeed(SPEED_DOWN);
            this._character.setActionAddThunder();
            this._character.addEventListener(flightEvent.ADD_THUNDER_REMOVE,this.removeThunderAction,false,0,true);
            this._energy.seThunderFlg = true;
         }
      }
      
      private function gameStartClick(param1:flightEvent) : void
      {
         this.topTitle.removeEventListener(flightEvent.GAME_START_CLICK,this.gameStartOpening);
         this._countFlg = true;
      }
      
      private function gameStartOpening(param1:flightEvent = null) : void
      {
         if(this._debugMode)
         {
            this._energyBasePoint = int(this.enePointText.text);
         }
         else
         {
            this._energyBasePoint = ENERGY_BASE_POINT;
         }
         this._background.y -= 300;
         this.topTitle.titleDown();
         this._background.opening();
      }
      
      private function gameStartAnime(param1:flightEvent = null, param2:Boolean = false) : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:Number = 0.4;
         var _loc4_:String = "easeOutBack";
         var _loc5_:Function = this.gameStartAnime;
         if(!param2)
         {
            this._openingFlg = true;
            this.removeChild(this.topTitle);
            this._character.opening();
            _loc7_ = 0;
            while(_loc7_ < this._headerArr.length)
            {
               _loc6_ = this._headerArr[_loc7_];
               Tweener.addTween(_loc6_,{
                  "alpha":1,
                  "y":_loc6_.y + OPENING_MOVE,
                  "time":_loc3_,
                  "transition":_loc4_
               });
               _loc7_++;
            }
            _loc8_ = 0;
            while(_loc8_ < this._fooderArr.length - 1)
            {
               _loc6_ = this._fooderArr[_loc8_];
               Tweener.addTween(_loc6_,{
                  "alpha":1,
                  "y":_loc6_.y - OPENING_MOVE,
                  "time":_loc3_,
                  "transition":_loc4_
               });
               _loc8_++;
            }
            _loc6_ = this._fooderArr[this._fooderArr.length - 1];
            Tweener.addTween(_loc6_,{
               "alpha":1,
               "y":_loc6_.y - OPENING_MOVE,
               "time":_loc3_,
               "transition":_loc4_
            });
            _loc6_ = this;
            Tweener.addTween(_loc6_,{
               "time":_loc3_,
               "delay":0.8,
               "transition":_loc4_,
               "onComplete":_loc5_,
               "onCompleteParams":[null,true]
            });
         }
         else if(!this.gameBack_mc.visible)
         {
            this.countStart();
         }
      }
      
      private function setGoalAnime(param1:Boolean = false) : void
      {
         var _loc2_:Number = 2.5;
         var _loc3_:String = "easeOutQuad";
         var _loc4_:Function = this.setGoalAnime;
         var _loc5_:MovieClip = this.goal_1_mc;
         var _loc6_:MovieClip = this.goal_2_mc;
         var _loc7_:Number = this.goal_1_mc.x;
         var _loc8_:Number = this.goal_2_mc.x;
         if(!param1)
         {
            this.btnGameHint_mc.isLocked = false;
            this.btnGameBack_mc.isLocked = false;
            _loc5_.visible = true;
            _loc6_.visible = true;
            _loc5_.x = _loc7_ - 200;
            _loc6_.x = _loc8_ - 200;
            _loc5_.alpha = 0.5;
            _loc6_.alpha = 0.5;
            Tweener.addTween(_loc5_,{
               "x":_loc7_,
               "alpha":1,
               "time":_loc2_,
               "transition":_loc3_
            });
            Tweener.addTween(_loc6_,{
               "x":_loc8_,
               "alpha":1,
               "time":_loc2_,
               "transition":_loc3_,
               "onComplete":_loc4_,
               "onCompleteParams":[true]
            });
         }
         else
         {
            this._goalText = new goal();
            this.addChild(this._goalText);
            this._goalText.x = STAGE_WIDTH / 2;
            this._goalText.y = STAGE_HEIGHT / 2;
            this._goalText.gotoAndPlay("open");
            this._goalText.addEventListener(flightEvent.GOAL_ANIME_FIN,this.goalTextHandler,false,0,true);
            this.goal_blink.gotoAndPlay("go");
         }
      }
      
      private function setEnergyCombo(param1:flightEvent) : void
      {
         var _loc4_:Point = null;
         var _loc2_:int = int(param1.addpoint);
         var _loc3_:Boolean = false;
         ++this._comboNum;
         if(this._gameAdjustSpeed >= GAME_ADJUST_SPEED_MAX)
         {
            _loc2_ *= 1.5;
            _loc3_ = true;
         }
         this.scoreBox.setGamePoint = _loc2_;
         if(this._gameAdjustSpeed < GAME_ADJUST_SPEED_MAX)
         {
            this.speedupOpen();
         }
         this._gameAdjustSpeed += param1.addspeed;
         this.setSpeed();
         _loc4_ = new Point();
         _loc4_ = this._character.getCharaPosition;
         this._addScoreIcon = new addScoreIcon();
         this.addChild(this._addScoreIcon);
         this._addScoreIcon.setAddScore(_loc4_.x + this._character.getHitAreaMc.width / 2,_loc4_.y,BASE_SPEED * this._gameAdjustSpeed,_loc3_,param1.addtype);
         this._addScoreIcon.addEventListener(flightEvent.ADD_SCORE_REMOVE,this.addScoreIconRemove,false,0,true);
         param1.stopPropagation();
      }
      
      private function setCloud(param1:flightEvent = null) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._cloudSplitNum < GAME_STAGE_WIDTH * (CLOUD_BASE_SPEED * GAME_ADJUST_SPEED_MAX) / GAME_SPLIT_CLOUD_COLUMN && this._flightGameFlg)
         {
            this._cloud.setCloudPositionArr = this._cloudPositionArr[this._cloudSplitNum];
            ++this._cloudSplitNum;
            if(this._debugMode)
            {
               _loc2_ = this._objMap.getShuffleResultArr;
               _loc3_ = Math.floor(this._cloudSplitNum / 20);
               _loc4_ = int(_loc2_[int(_loc3_)]);
               this["mapCloudArrTxt"].text = "今の雲のMAP番号 [" + _loc4_ + "]";
            }
         }
      }
      
      private function setEnergy(param1:flightEvent = null) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._energySplitNum < GAME_STAGE_WIDTH * (ENERGY_BASE_SPEED * GAME_ADJUST_SPEED_MAX) / GAME_SPLIT_ENERGY_COLUMN && this._flightGameFlg)
         {
            this._energy.setEnergyPositionArr = this._energyPositionArr[this._energySplitNum];
            ++this._energySplitNum;
            if(this._debugMode)
            {
               _loc2_ = this._objMap.getShuffleResultArr;
               _loc3_ = Math.floor(this._energySplitNum / 20);
               _loc4_ = int(_loc2_[_loc3_]);
               this["mapEnergyArrTxt"].text = "今のエネルギーのMAP番号 [" + _loc4_ + "]";
            }
         }
      }
      
      private function addScoreIconRemove(param1:flightEvent = null) : void
      {
         var _loc2_:* = param1.target;
         _loc2_.removeEventListener(flightEvent.ADD_SCORE_REMOVE,this.addScoreIconRemove);
         this.removeChild(_loc2_);
         param1.stopPropagation();
      }
      
      private function removeThunderAction(param1:flightEvent) : void
      {
         this._energy.seThunderFlg = false;
         this._character.removeEventListener(flightEvent.ADD_THUNDER_REMOVE,this.removeThunderAction);
         param1.stopPropagation();
      }
      
      private function setFlightGauge(param1:flightEvent = null) : void
      {
         var _loc5_:uint = 0;
         stage.stageFocusRect = false;
         stage.focus = this;
         param1.stopPropagation();
         var _loc2_:* = Math.floor(this._background.getTotalDictance * BACKGROUND_AJUST);
         this.meter_mc.setGamePosition = _loc2_;
         var _loc3_:String = "";
         var _loc4_:int = GAME_MAX_METER - this.meter_mc.getMeter;
         if(_loc4_ >= 200 && _loc4_ < 201)
         {
            if(!this._distanceFlg_200)
            {
               this._distanceFlg_200 = true;
               _loc3_ = "distanceFlag_200";
               this._distanceLine_200 = new distanceLine();
               this._distanceLine_200.name = _loc3_;
               this._distanceLine_200.flag_mc.gotoAndStop(1);
               this._distanceLine_200.flag_mc.d_200.gotoAndStop("_" + this._langCode);
               this._distanceLine_200.setSpeed = CLOUD_BASE_SPEED * this._gameAdjustSpeed;
               this._distanceLine_200.setGameStageWidth = STAGE_WIDTH;
               this.stageSetObject(this._distanceLine_200,LAYER_DISTANCE);
               this._distanceLine_200.addEventListener(flightEvent.DISTANCE_LINE_REMOVE,this.destanceLineRemove,false,0,true);
               this.meter_mc.blink_mc.gotoAndPlay("go");
            }
         }
         else if(_loc4_ >= 400 && _loc4_ < 401)
         {
            if(!this._distanceFlg_400)
            {
               this._distanceFlg_400 = true;
               _loc3_ = "distanceFlag_400";
               this._distanceLine_400 = new distanceLine();
               this._distanceLine_400.name = _loc3_;
               this._distanceLine_400.flag_mc.gotoAndStop(2);
               this._distanceLine_400.flag_mc.d_400.gotoAndStop("_" + this._langCode);
               this._distanceLine_400.setGameStageWidth = STAGE_WIDTH;
               this._distanceLine_400.setSpeed = CLOUD_BASE_SPEED * this._gameAdjustSpeed;
               this.stageSetObject(this._distanceLine_400,LAYER_DISTANCE);
               this._distanceLine_400.addEventListener(flightEvent.DISTANCE_LINE_REMOVE,this.destanceLineRemove,false,0,true);
               this.meter_mc.blink_mc.gotoAndPlay("go");
            }
         }
         else if(_loc4_ >= 600 && _loc4_ < 601)
         {
            if(!this._distanceFlg_600)
            {
               this._distanceFlg_600 = true;
               _loc3_ = "distanceFlag_600";
               this._distanceLine_600 = new distanceLine();
               this._distanceLine_600.name = _loc3_;
               this._distanceLine_600.flag_mc.gotoAndStop(3);
               this._distanceLine_600.flag_mc.d_600.gotoAndStop("_" + this._langCode);
               this._distanceLine_600.setSpeed = CLOUD_BASE_SPEED * this._gameAdjustSpeed;
               this._distanceLine_600.setGameStageWidth = STAGE_WIDTH;
               this.stageSetObject(this._distanceLine_600,LAYER_DISTANCE);
               this._distanceLine_600.addEventListener(flightEvent.DISTANCE_LINE_REMOVE,this.destanceLineRemove,false,0,true);
               this.meter_mc.blink_mc.gotoAndPlay("go");
            }
         }
         else if(_loc4_ >= 800 && _loc4_ < 801)
         {
            if(!this._distanceFlg_800)
            {
               this._distanceFlg_800 = true;
               _loc3_ = "distanceFlag_800";
               this._distanceLine_800 = new distanceLine();
               this._distanceLine_800.name = _loc3_;
               this._distanceLine_800.flag_mc.gotoAndStop(4);
               this._distanceLine_800.flag_mc.d_800.gotoAndStop("_" + this._langCode);
               this._distanceLine_800.setSpeed = CLOUD_BASE_SPEED * this._gameAdjustSpeed;
               this._distanceLine_800.setGameStageWidth = STAGE_WIDTH;
               this.stageSetObject(this._distanceLine_800,LAYER_DISTANCE);
               this._distanceLine_800.addEventListener(flightEvent.DISTANCE_LINE_REMOVE,this.destanceLineRemove,false,0,true);
               this.meter_mc.blink_mc.gotoAndPlay("go");
            }
         }
         this.setFps();
         if(_loc2_ >= GAME_STAGE_WIDTH && this._flightGameFlg)
         {
            this._islocked = false;
            this._character.goalAction();
            this.gameStop();
            this.goalVisit();
         }
      }
      
      private function destanceLineRemove(param1:flightEvent = null) : void
      {
         var _loc2_:* = param1.target;
         if(_loc2_.name == "distanceFlag_200")
         {
            this._distanceFlg_200 = false;
         }
         if(_loc2_.name == "distanceFlag_400")
         {
            this._distanceFlg_400 = false;
         }
         if(_loc2_.name == "distanceFlag_600")
         {
            this._distanceFlg_600 = false;
         }
         if(_loc2_.name == "distanceFlag_800")
         {
            this._distanceFlg_800 = false;
         }
         _loc2_.removeEventListener(flightEvent.DISTANCE_LINE_REMOVE,this.destanceLineRemove);
         this["distance"].removeChild(_loc2_);
         param1.stopPropagation();
      }
      
      private function setFps() : void
      {
         this.flightTimer.setFps = this._fps.getFps;
         this._background.setFps = this._fps.getFps;
         this._energy.setFps = this._fps.getFps;
         this._cloud.setFps = this._fps.getFps;
         if(this._distanceFlg_200)
         {
            this._distanceLine_200.setFps = this._fps.getFps;
         }
         if(this._distanceFlg_400)
         {
            this._distanceLine_400.setFps = this._fps.getFps;
         }
         if(this._distanceFlg_600)
         {
            this._distanceLine_600.setFps = this._fps.getFps;
         }
         if(this._distanceFlg_800)
         {
            this._distanceLine_800.setFps = this._fps.getFps;
         }
      }
      
      private function goalVisit() : void
      {
         if(!this._gameOverFlg)
         {
            this._goalFlg = true;
            this.setGoalAnime();
         }
      }
      
      private function speedupOpen() : void
      {
         this._speedup = new speedup();
         this.addLayerSpeedup.addChild(this._speedup);
         this._speedup.x = STAGE_WIDTH / 2;
         this._speedup.y = STAGE_HEIGHT / 2 + 180;
         this._speedup.addEventListener(flightEvent.SPEED_UP_ANIME_FIN,this.speedupClose,false,0,true);
         this._speedup.gotoAndPlay("open");
      }
      
      private function speedupClose(param1:flightEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.removeEventListener(flightEvent.SPEED_UP_ANIME_FIN,this.speedupClose);
         this.addLayerSpeedup.removeChild(this._speedup);
         this._speedup = null;
      }
      
      private function scoreBoardOpen(param1:flightEvent = null) : void
      {
         this._background.stopmove();
         this._character.stopControl();
         this._cloud.stopmove();
         this._energy.stopmove();
         this.flightTimer.timerStop();
         if(this._distanceFlg_200)
         {
            this._distanceLine_200.stopmove();
         }
         if(this._distanceFlg_400)
         {
            this._distanceLine_400.stopmove();
         }
         if(this._distanceFlg_600)
         {
            this._distanceLine_600.stopmove();
         }
         if(this._distanceFlg_800)
         {
            this._distanceLine_800.stopmove();
         }
         this._cloud.reset();
         this.scoreBoard.setGoalTime = this.flightTimer.getGameTimer;
         this.scoreBoard.setGoalScore = this.scoreBox.getGameScore;
         this.scoreBoard.setComboNum = this._comboNum;
         this.scoreBoard.scoreBoardWinOpen();
      }
      
      private function failBoardOpen(param1:flightEvent = null) : void
      {
         this._background.stopmove();
         this._character.stopControl();
         this._cloud.stopmove();
         this._energy.stopmove();
         this.flightTimer.timerStop();
         if(this._distanceFlg_200)
         {
            this._distanceLine_200.stopmove();
         }
         if(this._distanceFlg_400)
         {
            this._distanceLine_400.stopmove();
         }
         if(this._distanceFlg_600)
         {
            this._distanceLine_600.stopmove();
         }
         if(this._distanceFlg_800)
         {
            this._distanceLine_800.stopmove();
         }
         this.failBord.failBoardWinOpen();
      }
      
      private function removedFromStageHandler(param1:Event = null) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      private function __gameHint(param1:mainBtnEvent) : void
      {
         if(!this._closeWinOpenFlg)
         {
            if(!this._gameOverFlg && this._countFlg && this._islocked)
            {
               if(!this._goalFlg)
               {
                  if(!this._pauseWinOpenFlg)
                  {
                     this.gamePause("pause");
                  }
               }
            }
         }
      }
      
      private function gameBackWinOpen(param1:mainBtnEvent = null) : void
      {
         if(!this._pauseWinOpenFlg)
         {
            if(this._encountPokemonName != null)
            {
               this.gameBack_mc.setEncountPokemon = this._encountPokemonName;
            }
            else
            {
               this._encountPokemonName = "";
            }
            this.gamePause("close");
         }
      }
      
      private function gamePauseWinOpen(param1:KeyboardEvent = null) : void
      {
         if(!this._closeWinOpenFlg)
         {
            if(!this._gameOverFlg && this._countFlg && this._islocked)
            {
               if(!this._goalFlg)
               {
                  if(param1.keyCode == Keyboard.SPACE)
                  {
                     if(!this._pauseWinOpenFlg)
                     {
                        this._soundController.playSound("space");
                        this.gamePause("pause");
                     }
                  }
               }
            }
         }
      }
      
      private function pauseGameHandler(param1:Event) : void
      {
         this._brigdePauseFlg = false;
         this._countDownFlg = false;
         if(this.topTitle)
         {
            this.topTitle.gamePause();
         }
         if(!this._gameOverFlg && this._countFlg)
         {
            if(!this._goalFlg)
            {
               if(this._pauseWinOpenFlg || this._closeWinOpenFlg)
               {
                  this._mainPauseWinOpen = false;
               }
               else
               {
                  this._mainPauseWinOpen = true;
               }
               param1.stopPropagation();
               this._brigdePauseFlg = true;
               this._islocked = true;
               this.gamePause("pause");
            }
            else
            {
               this._soundController.bgmFadeOut(1000);
            }
         }
         else
         {
            this._soundController.bgmFadeOut(1000);
         }
      }
      
      private function restartGameHandler(param1:Event) : void
      {
         param1.stopPropagation();
         if(this.topTitle)
         {
            this.topTitle.gameRestart();
         }
         this._countDownFlg = true;
         if(this._pauseWinOpenFlg || this._closeWinOpenFlg)
         {
            if(this._mainPauseWinOpen)
            {
               this._soundController.bgmFadeIn(2000);
               this.gameStart();
            }
            this._mainPauseWinOpen = false;
         }
         else if(this._gameStartFlg && !this._gameOverFlg)
         {
            if(!this._goalFlg)
            {
               this._soundController.bgmFadeIn(2000);
               this.btnGameBack_mc.isLocked = true;
               this.gameStart();
            }
            else
            {
               this._soundController.bgmFadeIn(2000);
               this._brigdePauseFlg = false;
            }
         }
         else if(!this._gameStartFlg)
         {
            this._soundController.bgmFadeIn(2000);
            this.btnGameBack_mc.isLocked = true;
            if(this._countFlg)
            {
               this.count_mc.play();
            }
            this.gameStart();
         }
         else
         {
            if(this._gameOverFlg)
            {
               this._soundController.bgmFadeIn(2000);
            }
            this._brigdePauseFlg = false;
         }
      }
      
      private function gameStart(param1:flightEvent = null) : void
      {
         if(!this._gameStartFlg)
         {
            if(this._countFlg)
            {
               if(param1 != null)
               {
                  if(param1.type == flightEvent.COUNT_FINISH)
                  {
                     this.topTitle.visible = false;
                     this.count_mc.removeEventListener(flightEvent.COUNT_FINISH,this.gameStart);
                     this.btnGameHint_mc.isLocked = true;
                     this._soundController.playBGM("main");
                     this._gameStartFlg = true;
                     this.removeChild(this.count_mc);
                  }
                  else if(param1.type == flightEvent.PAUSE_CANCEL)
                  {
                     this.count_mc.play();
                     this._countDownFlg = true;
                     this._character.playAction();
                  }
               }
               else
               {
                  this._character.playAction();
               }
            }
            else if(this._openingFlg)
            {
               this._character.playAction();
               this.countStart();
            }
         }
         else
         {
            this._soundController.bgmFadeIn(2000);
         }
         if(this._pauseWinOpenFlg)
         {
            if(param1 != null)
            {
            }
            if(param1 != null && param1.type == flightEvent.PAUSE_CANCEL)
            {
               this._pauseWinOpenFlg = false;
            }
            if(param1 != null && param1.type == flightEvent.GAME_BACK_CANCEL)
            {
               this._closeWinOpenFlg = false;
            }
         }
         if(this._gameStartFlg && !this._pauseWinOpenFlg && !this._closeWinOpenFlg)
         {
            this._character.start();
            this["flag_mc"].setFlag(true);
            this._background.start();
            this._cloud.start();
            this._energy.start();
            this.flightTimer.timerStart();
            if(this._distanceFlg_200)
            {
               this._distanceLine_200.start();
            }
            if(this._distanceFlg_400)
            {
               this._distanceLine_400.start();
            }
            if(this._distanceFlg_600)
            {
               this._distanceLine_600.start();
            }
            if(this._distanceFlg_800)
            {
               this._distanceLine_800.start();
            }
         }
         if(this._brigdePauseFlg)
         {
            if(this._pauseWinOpenFlg)
            {
               this.pause_mc.winClose();
            }
            if(this._closeWinOpenFlg)
            {
               this.gameBack_mc.winClose();
            }
            this._brigdePauseFlg = false;
         }
         else
         {
            this.gameBack_mc.visible = false;
            this.pause_mc.visible = false;
            this._pauseWinOpenFlg = false;
            this._closeWinOpenFlg = false;
         }
         this.btnGameBack_mc.isLocked = true;
         this._brigdePauseFlg = false;
         this._islocked = true;
      }
      
      private function countStart(param1:flightEvent = null) : void
      {
         stage.focus = this;
         this._soundController.bgmFadeOut(800,true);
         this["flag_mc"].setFlag(true);
         this._islocked = true;
         this.topTitle.removeEventListener(flightEvent.GAME_TITLE_CLOSE,this.gameStartOpening);
         this.count_mc.visible = true;
         if(!this._countDownFlg)
         {
            this.count_mc.stop();
         }
         else if(!this._pauseWinOpenFlg)
         {
            this.count_mc.gotoAndPlay("countStart");
         }
      }
      
      private function gameStop() : void
      {
         this["flag_mc"].setFlag(false);
         this._flightGameFlg = false;
         this.flightTimer.timerStop();
      }
      
      private function gameBackCancel(param1:flightEvent = null) : *
      {
         if(this._gameStartFlg)
         {
            this._soundController.bgmFadeIn(2000);
         }
         else if(!this._countFlg)
         {
            this._soundController.bgmFadeIn(2000);
         }
         this.btnGameBack_mc.isLocked = true;
         this._closeWinOpenFlg = false;
         if(this._gameStartFlg && !this._gameOverFlg)
         {
            if(!this._goalFlg)
            {
               this.gameStart();
            }
         }
         else if(!this._gameStartFlg)
         {
            if(this._countFlg)
            {
               this.count_mc.play();
            }
            this.gameStart();
         }
      }
      
      private function gamePause(param1:String = "") : void
      {
         if(this._islocked || param1 == "close")
         {
            if(param1 == "pause")
            {
               if(!this._pauseWinOpenFlg && !this._closeWinOpenFlg)
               {
                  this._pauseWinOpenFlg = true;
                  this.pause_mc.visible = true;
                  this.pause_mc.winOpen();
               }
            }
            else if(param1 == "close")
            {
               if(!this._closeWinOpenFlg && !this._pauseWinOpenFlg)
               {
                  this._closeWinOpenFlg = true;
                  this.gameBack_mc.visible = true;
                  this.gameBack_mc.winOpen();
                  this._islocked = false;
                  this.btnGameBack_mc.isLocked = false;
               }
            }
            else
            {
               this.pause_mc.visible = true;
               this.gameBack_mc.visible = true;
               this._islocked = false;
            }
            this._soundController.bgmFadeOut(1000);
            this["flag_mc"].setFlag(false);
            if(!this._gameStartFlg && this._countFlg)
            {
               this.count_mc.stop();
            }
            this._background.stopmove();
            this._character.stopmove();
            this._cloud.stopmove();
            this._energy.stopmove();
            this.flightTimer.timerStop();
            if(this._distanceFlg_200)
            {
               this._distanceLine_200.stopmove();
            }
            if(this._distanceFlg_400)
            {
               this._distanceLine_400.stopmove();
            }
            if(this._distanceFlg_600)
            {
               this._distanceLine_600.stopmove();
            }
            if(this._distanceFlg_800)
            {
               this._distanceLine_800.stopmove();
            }
         }
      }
      
      private function gameOver(param1:flightEvent = null) : void
      {
         if(!this._goalFlg)
         {
            this._character.cloudStop();
            this.btnGameHint_mc.isLocked = false;
            this.btnGameBack_mc.isLocked = false;
            this._gameOverFlg = true;
            this._timeup = new timeup();
            this.addChild(this._timeup);
            this._timeup.x = STAGE_WIDTH / 2;
            this._timeup.y = STAGE_HEIGHT / 2;
            this._timeup.gotoAndPlay("open");
            this._timeup.addEventListener(flightEvent.TIME_UP_ANIME_FIN,this.timeupHandler,false,0,true);
            this["flag_mc"].setFlag(false);
            this._background.stopmove();
            this._character.stopControl();
            this._cloud.stopmove();
            this._energy.stopmove();
            this.flightTimer.timerStop();
            if(this._distanceFlg_200)
            {
               this._distanceLine_200.stopmove();
            }
            if(this._distanceFlg_400)
            {
               this._distanceLine_400.stopmove();
            }
            if(this._distanceFlg_600)
            {
               this._distanceLine_600.stopmove();
            }
            if(this._distanceFlg_800)
            {
               this._distanceLine_800.stopmove();
            }
            this._fps.reset();
            removeChild(this._fps);
         }
      }
      
      private function timeupHandler(param1:flightEvent) : void
      {
         this._timeup.removeEventListener(flightEvent.TIME_UP_ANIME_FIN,this.timeupHandler);
         removeChild(this._timeup);
         this._timeup = null;
         this.speedGauge.max_blink.gotoAndStop(1);
         this.failBoardOpen();
      }
      
      private function goalTextHandler(param1:flightEvent) : void
      {
         this._goalText.removeEventListener(flightEvent.GOAL_ANIME_FIN,this.goalTextHandler);
         removeChild(this._goalText);
         this._goalText = null;
         this.speedGauge.max_blink.gotoAndStop(1);
         this.scoreBoardOpen();
      }
      
      private function gameClose(param1:flightEvent = null) : void
      {
         var _timer:Timer;
         var $e:flightEvent = param1;
         this.gameReset();
         if(this._gameOverFlg)
         {
            gameBridge.result = gameResult.FAILURE;
         }
         else
         {
            gameBridge.result = gameResult.ABORT;
         }
         gameBridge.rank = 0;
         this._soundController.closeBGM();
         _timer = new Timer(1000,1);
         _timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.timerCompleteHandler_gameClose,false,0,true);
         _timer.start();
         if(this._fps)
         {
            this._fps.reset();
            try
            {
               removeChild(this._fps);
            }
            catch(e:*)
            {
            }
         }
      }
      
      private function gameReset() : void
      {
         var _loc1_:MovieClip = null;
         this._islocked = false;
         this._background.reset();
         this._character.reset();
         this._cloud.reset();
         this._energy.reset();
         this.flightTimer.reset();
         this.energyBox.reset();
         this.speedGauge.reset();
         this.scoreBox.reset();
         this.scoreBoard.reset();
         this.removeEventListener(KeyboardEvent.KEY_UP,this.gamePauseWinOpen);
         this._background.removeEventListener(flightEvent.BG_MOVE,this.setFlightGauge);
         this._character.removeEventListener(flightEvent.CHARA_MOVE,this.charaHitTest);
         this._cloud.removeEventListener(flightEvent.CLOUD_CHANGE,this.setCloud);
         this.scoreBoard.removeEventListener(flightEvent.GAME_FINISH,this.finishGame);
         this.energyBox.removeEventListener(flightEvent.ENERGY_COMBO,this.setEnergyCombo);
         this.scoreBoard.removeEventListener(flightEvent.GAME_RETRY,this.gameReset);
         this.pause_mc.removeEventListener(flightEvent.PAUSE_CANCEL,this.gameStart);
         this.flightTimer.removeEventListener(flightEvent.GAME_TIME_UP,this.gameOver);
         this.btnGameBack_mc.removeEventListener(mainBtnEvent.BTN_GAME_BACK,this.gameBackWinOpen);
         this.gameBack_mc.removeEventListener(flightEvent.GAME_BACK_CANCEL,this.gameBackCancel);
         this.gameBack_mc.removeEventListener(flightEvent.GAME_BACK_OK,this.gameClose);
         gameBridge.removeEventListener(gameBridgeEvent.PAUSE_GAME,this.pauseGameHandler);
         gameBridge.removeEventListener(gameBridgeEvent.RESTART_GAME,this.restartGameHandler);
         this.pause_mc.reset();
         this.gameBack_mc.reset();
         _loc1_ = this._character;
         while(_loc1_.numChildren > 0)
         {
            _loc1_.removeChildAt(0);
         }
         _loc1_ = this["chara"];
         while(_loc1_.numChildren > 0)
         {
            _loc1_.removeChildAt(0);
         }
         _loc1_ = this["cloud"];
         while(_loc1_.numChildren > 0)
         {
            _loc1_.removeChildAt(0);
         }
         _loc1_ = this["item"];
         while(_loc1_.numChildren > 0)
         {
            _loc1_.removeChildAt(0);
         }
         _loc1_ = this["bg"];
         while(_loc1_.numChildren > 0)
         {
            _loc1_.removeChildAt(0);
         }
         _loc1_ = this["distance"];
         while(_loc1_.numChildren > 0)
         {
            _loc1_.removeChildAt(0);
         }
         if(this._retryFlg)
         {
            this.__init();
         }
         else
         {
            while(this.numChildren > 0)
            {
               this.removeChildAt(0);
            }
         }
      }
      
      private function retryGame(param1:flightEvent = null) : void
      {
         this._retryFlg = true;
         this.gameReset();
      }
      
      private function finishGame(param1:flightEvent = null) : void
      {
         var _loc2_:Timer = new Timer(1000,1);
         if(!this._debugMode)
         {
            this._retryFlg = false;
            this.gameReset();
            gameBridge.result = gameResult.SUCCESS;
            gameBridge.rank = this.setRank(this.scoreBoard.getTotalScore);
            this._soundController.closeBGM();
            _loc2_.addEventListener(TimerEvent.TIMER_COMPLETE,this.timerCompleteHandler_gameClose,false,0,true);
            _loc2_.start();
         }
         else
         {
            this.gameReset();
            this._soundController.closeBGM();
            _loc2_.addEventListener(TimerEvent.TIMER_COMPLETE,this.timerCompleteHandler_gameClose,false,0,true);
            _loc2_.start();
         }
      }
      
      private function setRank(param1:int) : uint
      {
         var _loc7_:uint = 0;
         var _loc2_:int = 55000;
         var _loc3_:int = 50000;
         var _loc4_:int = 45000;
         var _loc5_:int = 30000;
         var _loc6_:int = 0;
         if(this._gameOverFlg)
         {
            _loc7_ = 0;
         }
         else if(_loc2_ <= param1)
         {
            _loc7_ = 1;
         }
         else if(_loc3_ <= param1)
         {
            _loc7_ = 2;
         }
         else if(_loc4_ <= param1)
         {
            _loc7_ = 3;
         }
         else if(_loc5_ <= param1)
         {
            _loc7_ = 4;
         }
         else if(_loc5_ > param1)
         {
            _loc7_ = 5;
         }
         return _loc7_;
      }
      
      private function timerCompleteHandler(param1:Event) : void
      {
         gameBridge.finishGame();
      }
      
      private function timerCompleteHandler_gameClose(param1:Event) : void
      {
         gameBridge.closeGame();
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame6() : *
      {
         stop();
         dispatchEvent(new flightEvent(flightEvent.WAIT_FRAME));
         this.pause_mc.visible = false;
      }
   }
}

