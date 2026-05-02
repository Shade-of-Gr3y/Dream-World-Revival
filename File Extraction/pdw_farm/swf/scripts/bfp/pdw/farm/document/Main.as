package bfp.pdw.farm.document
{
   import bfp.PDWBridge;
   import bfp.PDWBridgeEvent;
   import bfp.PDWHomeData;
   import bfp.common.FontManager;
   import bfp.common.Logger;
   import bfp.common.PokemonBridge;
   import bfp.pdw.common_y.JSONLoader;
   import bfp.pdw.common_y.MistContainer;
   import bfp.pdw.farm.*;
   import bfp.pdw.farm.cursor.*;
   import bfp.pdw.farm.field.*;
   import bfp.pdw.farm.menu.*;
   import bfp.pdw.farm.net.*;
   import bfp.pdw.farm.objects.*;
   import bfp.pdw.farm.panel.*;
   import bfp.pdw.farm.ui.*;
   import bfp.pdw.farm.une.*;
   import bfp.pdw.farm.water.*;
   import bfp.pokemon.liby.event.CustomEvent;
   import caurina.transitions.*;
   import caurina.transitions.properties.*;
   import com.flashdynamix.utils.SWFProfiler;
   import flash.display.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class Main extends MovieClip
   {
      
      public var main:MovieClip;
      
      public var debugItemBoxArea:MovieClip;
      
      public var panelArea:MovieClip;
      
      public var panelCover:MovieClip;
      
      public var blurCoverArea:MovieClip;
      
      private var mainMC:MovieClip;
      
      private var panelMC:MovieClip;
      
      private var titleTxt:TextField;
      
      private var data:FarmData;
      
      private var bridge:FarmBridge;
      
      private var filePath:FarmFilePath;
      
      private var uneWorldObj:UneWorld;
      
      private var arrowBtnUnitObj:ArrowBtnUnit;
      
      private var sprinkingInfoBoxObj:SprinklerInfoBox;
      
      private var backHomeBtnObj:BackHomeBtn;
      
      private var cursorObj:Cursor;
      
      private var digdaAreaObj:DigdaArea;
      
      private var pokemonAreaObj:PokemonFiledArea;
      
      private var titleTxtUnitObj:TitleTxtUnit;
      
      private var menuCoverObj:MenuCover;
      
      private var mistContainerObj:MistContainer;
      
      private var itemPanelObj:ItemPanel;
      
      private var plantFinishPanelObj:PlantFinishPanel;
      
      private var harvestFinishPanelObj:HarvestFinishPanel;
      
      private var noNutsAlertPanelObj:NoNutsAlertPanel;
      
      private var addFurrowAlertPanelObj:AddFurrowAlertPanel;
      
      private var panelCoverObj:PanelCover;
      
      private var detailPanelObj:DetailPanel;
      
      private var fukidashiPanelObj:FukidashiPanel;
      
      private var pokemonStatusPanelObj:PokemonStatusPanel;
      
      private var dialogPanelObj:DialogPanel;
      
      private var panelCtrObj:PanelCtr;
      
      private var cursorCtrObj:CursorCtr;
      
      private var fieldCtrObj:FieldCtr;
      
      private var menuCtrObj:MenuCtr;
      
      private var apiCtrObj:APICtr;
      
      private var loadCheckObj:LoadCheck;
      
      private var loadCtrObj:LoadCtr;
      
      private var pokemonNum:Number = 0;
      
      private var pokemonTotalNum:Number = 11;
      
      private var tutorialDelayTime:Number = 0;
      
      private var tutorialTimer:Timer;
      
      private var isTutorial:Boolean = false;
      
      private var debugLogInObj:*;
      
      private var dLoader:Loader;
      
      public function Main()
      {
         super();
         addFrameScript(0,this.initFrameScript);
      }
      
      private function initFrameScript() : *
      {
         this.data = FarmData.getInstance();
         this.bridge = FarmBridge.getInstance();
         this.filePath = FarmFilePath.getInstance();
         ColorShortcuts.init();
         DisplayShortcuts.init();
         FilterShortcuts.init();
         this.blendMode = BlendMode.LAYER;
         if(String(this.parent) == "[object Stage]")
         {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            this.data.isAlone = true;
         }
         this.data.basePath = loaderInfo.url.substring(0,loaderInfo.url.lastIndexOf("/")) + "/";
         this.filePath.basePath = this.data.basePath;
         this.loadCheckObj = new LoadCheck();
         this.loadCtrObj = new LoadCtr();
         this.mainMC = this.main;
         this.panelMC = this.panelArea;
         this.uneWorldObj = new UneWorld(this.mainMC.uneWorldUnit,this.mainMC.fukidashiArea);
         this.arrowBtnUnitObj = new ArrowBtnUnit(this.mainMC.arrowBtnUnit);
         this.digdaAreaObj = new DigdaArea(this.mainMC.digdaArea);
         this.pokemonAreaObj = new PokemonFiledArea(this.mainMC.frontArea,this.mainMC.backArea,this.mainMC.pokeFukidashiArea);
         this.titleTxtUnitObj = new TitleTxtUnit(this.mainMC.titleTxt);
         this.mistContainerObj = new MistContainer(this.mainMC.mistContainer);
         this.cursorObj = new Cursor(this.mainMC.cursorArea,this.mainMC.cursorOverArea);
         this.sprinkingInfoBoxObj = new SprinklerInfoBox(this.mainMC.sprinkingInfoBox);
         this.backHomeBtnObj = new BackHomeBtn(this.mainMC.backHomeBtn);
         this.menuCoverObj = new MenuCover(this.mainMC.menuCover);
         this.itemPanelObj = new ItemPanel(this.panelMC.itemBox);
         this.plantFinishPanelObj = new PlantFinishPanel(this.panelMC.plantFinishPanel);
         this.harvestFinishPanelObj = new HarvestFinishPanel(this.panelMC.harvestFinishPanel);
         this.addFurrowAlertPanelObj = new AddFurrowAlertPanel(this.panelMC.addFurrowAlertPanel);
         this.panelCoverObj = new PanelCover(this.panelCover);
         this.detailPanelObj = new DetailPanel(this.panelMC.detailPanel);
         this.pokemonStatusPanelObj = new PokemonStatusPanel(this.panelMC.pokemonStatusPanel);
         this.noNutsAlertPanelObj = new NoNutsAlertPanel(this.panelMC.noNutsAlertPanel);
         this.fieldCtrObj = new FieldCtr(this.uneWorldObj,this.arrowBtnUnitObj,this.digdaAreaObj,this.pokemonAreaObj);
         this.cursorCtrObj = new CursorCtr(this.cursorObj);
         this.panelCtrObj = new PanelCtr(this.itemPanelObj,this.plantFinishPanelObj,this.harvestFinishPanelObj,this.noNutsAlertPanelObj,this.addFurrowAlertPanelObj,this.panelCoverObj,this.detailPanelObj,this.pokemonStatusPanelObj);
         this.menuCtrObj = new MenuCtr(this.backHomeBtnObj,this.sprinkingInfoBoxObj,this.menuCoverObj);
         this.apiCtrObj = new APICtr();
         this.tutorialTimer = new Timer(280,1);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         if(this.data.isAlone)
         {
         }
      }
      
      private function onDLoaderLoadComplete(param1:Event) : *
      {
         this.dLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onDLoaderLoadComplete);
         this.alone();
      }
      
      private function alone() : *
      {
         PokemonBridge.first_flag = 1;
         this.loadFont();
      }
      
      private function loadFont() : *
      {
         var _loc1_:Loader = new Loader();
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFontLoadComplete);
         _loc1_.load(new URLRequest(this.data.basePath + "../../theme/assets/common/font.swf"));
      }
      
      private function onFontLoadComplete(param1:Event) : *
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.onFontLoadComplete);
         var _loc3_:Loader = _loc2_.loader;
         FontManager.init();
         var _loc4_:Loader = new Loader();
         _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onItemBoxLoadComplete);
         _loc4_.load(new URLRequest(this.data.basePath + "takarabako.swf"));
      }
      
      private function onItemBoxLoadComplete(param1:Event) : *
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.onItemBoxLoadComplete);
         var _loc3_:Loader = _loc2_.loader;
         this.debugItemBoxArea.addChild(_loc3_);
         PokemonBridge.addEventListener(PokemonBridge.RENDER_LOADED,this.onPokemonLoaded);
         PokemonBridge.POKEMONPATH = this.data.basePath + "../../theme/assets/global/parts/pokemon/scaled/";
         PokemonBridge.standalone(this.data.basePath + "theme/assets/common/poke.swf");
      }
      
      private function onPokemonLoaded(param1:Event) : *
      {
         PokemonBridge.removeEventListener(PokemonBridge.RENDER_LOADED,this.onPokemonLoaded);
         this.startAloneMode();
      }
      
      private function startAloneMode() : *
      {
         this.debugLogInObj = this.dLoader.content;
         this.addChild(this.debugLogInObj);
         this.debugLogInObj.addEventListener(this.debugLogInObj.ON_LOG_IN,this.onDebugLogIn);
         this.debugLogInObj.addEventListener(this.debugLogInObj.ON_LOG_IN_ERROR,this.onDebugLogInError);
         this.debugLogInObj.addEventListener(this.debugLogInObj.ON_FRIEND_LOG_IN,this.onDebugFriendLogIn);
      }
      
      private function onDebugLogIn(param1:Event) : *
      {
         PDWHomeData.currentHomeType = PDWHomeData.HOME_MINE;
         var _loc2_:* = this.debugLogInObj.getPokemonNo();
         if(_loc2_ != -1)
         {
            PDWHomeData.myPokemonNo = _loc2_;
         }
         else
         {
            PDWHomeData.myPokemonNo = Math.ceil(Math.random() * 493);
         }
         this.startPGL();
      }
      
      private function onDebugLogInError(param1:Event) : *
      {
      }
      
      private function onDebugFriendLogIn(param1:Event) : *
      {
         var _loc2_:* = param1.currentTarget;
         PDWHomeData.currentHomeType = PDWHomeData.HOME_FRIEND;
         PDWHomeData.anotherMemberSaveDataId = _loc2_.friendID;
         this.startPGL();
      }
      
      private function startPGL() : *
      {
         var _loc1_:JSONLoader = new JSONLoader();
         _loc1_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onPGLStartJSONLoadComplete);
         _loc1_.load(this.filePath.getPGLStartAPI());
      }
      
      private function onPGLStartJSONLoadComplete(param1:CustomEvent) : *
      {
         var _loc2_:* = param1.obj;
         PDWHomeData.myMemberSaveDataId = Number(_loc2_.member.member_savedata_id);
         PokemonBridge.token = _loc2_.token;
         this.startPDW();
      }
      
      private function startPDW() : *
      {
         var _loc1_:JSONLoader = new JSONLoader();
         _loc1_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onPDWStartJsonLoadComplete);
         _loc1_.load(this.filePath.getPDWStartAPI());
      }
      
      private function onPDWStartJsonLoadComplete(param1:CustomEvent) : *
      {
         var _loc2_:JSONLoader = new JSONLoader();
         _loc2_.addEventListener(JSONLoader.ON_JSON_LOAD_COMPLETE,this.onHomeDataJsonLoadComplete);
         if(PDWHomeData.currentHomeType == PDWHomeData.HOME_FRIEND)
         {
            _loc2_.load(this.filePath.getFriendHomeDataAPI(),URLRequestMethod.POST,{"friend_member_savedata_id":PDWHomeData.anotherMemberSaveDataId});
         }
         else
         {
            _loc2_.load(this.filePath.getHomeDataAPI());
         }
      }
      
      private function onHomeDataJsonLoadComplete(param1:CustomEvent) : *
      {
         var _loc2_:* = param1.obj;
         PDWHomeData.myPokemonFormNo = 0;
         PDWHomeData.myPoint = 500;
         PDWHomeData.myPokemonSex = 0;
         SWFProfiler.init(stage,this);
         this.onAddToStage(null);
      }
      
      private function onAddToStage(param1:Event) : *
      {
         Logger.log("");
         Logger.log("");
         Logger.log("=======================================");
         Logger.log("はたけ　スタート");
         Logger.log("=======================================");
         this.tabChildren = false;
         this.tabEnabled = false;
         this.mistContainerObj.run();
         PDWBridge.currentHelp = PDWBridge.HELP_HOME_ORCHARD;
         this.data.isLoaded = false;
         if(!this.data.isAlone)
         {
            this.data.pokemonID = PDWHomeData.myPokemonNo;
            this.data.pokemonFormID = PDWHomeData.myPokemonFormNo;
            switch(PDWHomeData.currentHomeType)
            {
               case PDWHomeData.HOME_MINE:
                  this.data.isFriendMode = false;
                  this.data.currentHomeType = PDWHomeData.currentHomeType;
                  Logger.log("はたけ　自分");
                  break;
               case PDWHomeData.HOME_FRIEND:
                  this.data.isFriendMode = true;
                  this.data.currentHomeType = PDWHomeData.currentHomeType;
                  Logger.log("はたけ　フレンド");
                  break;
               case PDWHomeData.HOME_CELEBLITY:
                  this.data.isFriendMode = true;
                  this.data.currentHomeType = PDWHomeData.currentHomeType;
                  Logger.log("はたけ　芸能人");
            }
         }
         else
         {
            this.data.pokemonID = PDWHomeData.myPokemonNo;
            this.data.pokemonFormID = 0;
            this.data.isFriendMode = false;
            PDWHomeData.anotherMemberSaveDataId = 80;
         }
         this.data.myPoint = PDWHomeData.myPoint;
         this.panelCtrObj.run();
         this.apiCtrObj.run();
         this.titleTxtUnitObj.run();
         PDWBridge.showConnecting();
         this.loadCheckObj.addEventListener("onLoadCheckFinish",this.onLoadCheckFinish);
         this.loadCheckObj.startCheck();
         this.loadCtrObj.run();
      }
      
      private function onLoadCheckFinish(param1:CustomEvent) : *
      {
         PDWBridge.showConnecting(false);
         this.startContent();
      }
      
      private function startContent() : *
      {
         this.fieldCtrObj.run();
         this.cursorCtrObj.run();
         this.menuCtrObj.run();
         this.tutorialDelayTime = getTimer();
         this.isTutorial = false;
         this.tutorialTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTutorialTimerComplete);
         this.tutorialTimer.reset();
         this.tutorialTimer.start();
         PDWBridge.addEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.onTutorialComplete);
         PDWBridge.tutorial(PDWBridge.TUTORIAL_HOME_ORCHARD);
         if(this.data.isAlone)
         {
            this.onTutorialComplete(null);
         }
      }
      
      private function onTutorialComplete(param1:Event) : *
      {
         this.isTutorial = false;
         PDWBridge.removeEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.onTutorialComplete);
         this.tutorialTimer.stop();
         this.menuCtrObj.show();
         this.fieldCtrObj.show();
         if(this.data.isUneIncreaseAnime)
         {
            PokemonBridge.tag("pdw.farm_digda");
            this.bridge.showCover();
         }
      }
      
      private function onTutorialTimerComplete(param1:TimerEvent) : *
      {
         PDWBridge.removeEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.onTutorialComplete);
         this.isTutorial = true;
         this.tutorialTimer.stop();
         PDWBridge.addEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.onTutorialComplete2);
         this.menuCtrObj.show();
         this.fieldCtrObj.show(0,true);
      }
      
      private function onTutorialComplete2(param1:Event) : *
      {
         PDWBridge.removeEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.onTutorialComplete2);
         if(this.data.isUneIncreaseAnime)
         {
            PokemonBridge.tag("pdw_farm_digda");
            this.bridge.showCover();
            this.fieldCtrObj.isTutorial = false;
            this.fieldCtrObj.startUneIncreaseAnime();
         }
      }
      
      private function onRemovedFromStage(param1:Event) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         this.stopContent();
         this.resetContent();
         this.data.isLoaded = false;
         _loc2_ = 0;
         while(_loc2_ < this.data.sprinklerList.length)
         {
            if(this.data.sprinklerList.iconLoader != undefined)
            {
               if(this.data.sprinklerList.iconLoader.content != null)
               {
                  this.data.sprinklerList.iconLoader.unloadAndStop();
               }
               this.data.sprinklerList.iconLoader = null;
            }
            _loc2_++;
         }
         this.data.sprinklerList = [];
         _loc2_ = 0;
         while(_loc2_ < this.data.uneParamList.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this.data.uneParamList[_loc2_].length)
            {
               if(this.data.uneParamList[_loc2_][_loc3_].naeLoader != null)
               {
                  if(this.data.uneParamList[_loc2_][_loc3_].naeLoader.content != null)
                  {
                     this.data.uneParamList[_loc2_][_loc3_].naeLoader.unloadAndStop();
                  }
                  this.data.uneParamList[_loc2_][_loc3_].naeLoader = null;
               }
               if(this.data.uneParamList[_loc2_][_loc3_].btnLoader != null)
               {
                  if(this.data.uneParamList[_loc2_][_loc3_].btnLoader.content != null)
                  {
                     this.data.uneParamList[_loc2_][_loc3_].btnLoader.unloadAndStop();
                  }
                  this.data.uneParamList[_loc2_][_loc3_].btnLoader = null;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         this.data.uneParamList = [];
         if(this.data.digdaLoader != null)
         {
            if(this.data.digdaLoader.content != null)
            {
               this.data.digdaLoader.unloadAndStop();
            }
            this.data.digdaLoader = null;
         }
         if(this.data.pokemonLoader != null)
         {
            if(this.data.pokemonLoader.content != null)
            {
               this.data.pokemonLoader.unloadAndStop();
            }
            this.data.pokemonLoader = null;
         }
         if(this.data.selectSprinklerData.imgLoader != null)
         {
            if(this.data.selectSprinklerData.imgLoader.content != null)
            {
               this.data.selectSprinklerData.imgLoader.unloadAndStop();
            }
            this.data.selectSprinklerData.imgLoader = null;
         }
         if(this.data.selectSprinklerData.iconLoader != null)
         {
            if(this.data.selectSprinklerData.iconLoader.content != null)
            {
               this.data.selectSprinklerData.iconLoader.unloadAndStop();
            }
            this.data.selectSprinklerData.iconLoader = null;
         }
         this.data.selectSprinklerData = {};
      }
      
      private function resetContent() : *
      {
         PDWBridge.removeEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.onTutorialComplete);
         PDWBridge.removeEventListener(PDWBridgeEvent.TUTORIAL_COMPLETE,this.onTutorialComplete2);
         this.fieldCtrObj.reset();
         this.cursorCtrObj.reset();
         this.panelCtrObj.reset();
         this.menuCtrObj.reset();
         this.loadCtrObj.reset();
         this.apiCtrObj.reset();
         this.mistContainerObj.reset();
         this.titleTxtUnitObj.reset();
      }
      
      private function stopContent() : *
      {
         this.fieldCtrObj.stop();
         this.cursorCtrObj.stop();
         this.panelCtrObj.stop();
         this.menuCtrObj.stop();
         this.loadCtrObj.stop();
         this.apiCtrObj.stop();
         this.mistContainerObj.stop();
         this.titleTxtUnitObj.stop();
      }
   }
}

